From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: t5800-*.sh: Intermittent test failures
Date: Tue, 09 Aug 2011 19:30:12 +0100
Message-ID: <4E417CB4.50007@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: srabbelier@gmail.com, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 09 20:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqr64-0003Kx-N8
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 20:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab1HISbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 14:31:55 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:63029 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799Ab1HISbx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 14:31:53 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Qqr5j-0002Nh-bl; Tue, 09 Aug 2011 18:31:53 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179042>


I've noticed some intermittent test failures in t5800-*.sh on Linux
recently. The failures (test #7 onwards) are due to a git-push to a
remote, via the git-remote-test helper, hanging in git-fast-import.

git-bisect fingers the following commit:

    a515ebe9f1ac9bc248c12a291dc008570de505ca is the first bad commit
    commit a515ebe9f1ac9bc248c12a291dc008570de505ca
    Author: Sverre Rabbelier <srabbelier@gmail.com>
    Date:   Sat Jul 16 15:03:40 2011 +0200

        transport-helper: implement marks location as capability

        Now that the gitdir location is exported as an environment variable
        this can be implemented elegantly without requiring any explicit
        flushes nor an ad-hoc exchange of values.

        Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
        Acked-by: Jeff King <peff@peff.net>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

    :100644 100644 1ed7a5651ef5a2320c56856b5a1fe784e178ab23 e9c832bfd3da7db771cc2113
    027d3e590dc51d59 M      git-remote-testgit.py
    :100644 100644 0cfc9ae9059ce121b567406d7941b71cd54b961c 74c3122df1835c45a6b62120
    5fb18b4fc89af366 M      transport-helper.c

which didn't seem too likely at first, but it does reduce the size of the
fast-import stream (by moving the import/export marks filenames to the
command line). This could change the timings enough to cause the problem.

I set various environment variables (eg GIT_TRANSLOOP_DEBUG, GIT_DEBUG_TESTGIT etc)
in order to get some additional clues, in addition to looking at the stackframe
of all of the processes in the hung pipeline, which looks like:

    git(push)->git-remote-test->git(fast-import)->git-fast-import

The git-fast-import is hung in the read() syscall waiting for data which will
never arrive. This is because the git(fast-export) process, started by the above
git(push), executes (producing it's data on stdout) and completes successfully
and exits *before* the above git-fast-import process starts.

I haven't looked to see how the git(fast-export)/git-fast-import processes are
plumbed together, but there seems to be a synchronization problem somewhere ...

Unfortunately, I don't have time at the moment to finish debugging this, so I
was hoping someone who knows the code better than me could fix it up ...
Thanks! :-P

[I've included the stackframes (from the above pipeline) below in case it helps]

ATB,
Ramsay Jones


[git-fast-import]
(gdb) bt
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7dd6033 in read () from /lib/tls/i686/cmov/libc.so.6
#2  0xb7d774f8 in _IO_file_read () from /lib/tls/i686/cmov/libc.so.6
#3  0xb7d788c0 in _IO_file_underflow () from /lib/tls/i686/cmov/libc.so.6
#4  0xb7d78fbb in _IO_default_uflow () from /lib/tls/i686/cmov/libc.so.6
#5  0xb7d7a31d in __uflow () from /lib/tls/i686/cmov/libc.so.6
#6  0xb7d742a0 in getc () from /lib/tls/i686/cmov/libc.so.6
#7  0x0807e203 in strbuf_getwholeline (sb=0x80e348c, fp=0xb7e53420, term=10)
    at strbuf.c:361
#8  0x0807e262 in strbuf_getline (sb=0x80e348c, fp=0xb7e53420, term=10)
    at strbuf.c:376
#9  0x0804f681 in read_next_command () at fast-import.c:1853
#10 0x0805368b in main (argc=4, argv=0xbf8eac74) at fast-import.c:3295
(gdb)

[git(fast-import)]
(gdb) bt
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7dcf0b3 in __waitpid_nocancel () from /lib/tls/i686/cmov/libpthread.so.0
#2  0x08129706 in wait_or_whine (pid=6200, argv0=0x81e4070 "git-fast-import", 
    silent_exec_failure=1) at run-command.c:105
#3  0x0812a08f in finish_command (cmd=0xbfe42874) at run-command.c:415
#4  0x0812a0be in run_command (cmd=0xbfe42874) at run-command.c:423
#5  0x0812a1bf in run_command_v_opt (argv=0xbfe429dc, opt=8)
    at run-command.c:443
#6  0x0804c12d in execv_dashed_external (argv=0xbfe429dc) at git.c:489
#7  0x0804c192 in run_argv (argcp=0xbfe42950, argv=0xbfe42954) at git.c:507
#8  0x0804c321 in main (argc=4, argv=0xbfe429dc) at git.c:577
(gdb)

[git-remote-test]
(gdb) bt
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7f230b3 in __waitpid_nocancel () from /lib/tls/i686/cmov/libpthread.so.0
#2  0x080f8fc0 in posix_waitpid (self=0x0, args=0xb7d615ec)
    at ../Modules/posixmodule.c:5636
... [snipped as uninteresting!]
(gdb) 

[git(push)]
(gdb) bt
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7dde033 in read () from /lib/tls/i686/cmov/libc.so.6
#2  0xb7d7f4f8 in _IO_file_read () from /lib/tls/i686/cmov/libc.so.6
#3  0xb7d808c0 in _IO_file_underflow () from /lib/tls/i686/cmov/libc.so.6
#4  0xb7d80fbb in _IO_default_uflow () from /lib/tls/i686/cmov/libc.so.6
#5  0xb7d8231d in __uflow () from /lib/tls/i686/cmov/libc.so.6
#6  0xb7d7c2a0 in getc () from /lib/tls/i686/cmov/libc.so.6
#7  0x08138d6b in strbuf_getwholeline (sb=0xbfb662c8, fp=0x81e4760, term=10)
    at strbuf.c:361
#8  0x08138dca in strbuf_getline (sb=0xbfb662c8, fp=0x81e4760, term=10)
    at strbuf.c:376
#9  0x0813ffe3 in recvline_fh (helper=0x81e4760, buffer=0xbfb662c8)
    at transport-helper.c:51
#10 0x081400be in recvline (helper=0x81e44a0, buffer=0xbfb662c8)
    at transport-helper.c:64
#11 0x08141a6e in push_update_refs_status (data=0x81e44a0, 
    remote_refs=0x81e48e8) at transport-helper.c:652
#12 0x08141e80 in push_refs_with_export (transport=0x81e4450, 
    remote_refs=0x81e48e8, flags=0) at transport-helper.c:759
#13 0x08141f74 in push_refs (transport=0x81e4450, remote_refs=0x81e48e8, 
    flags=0) at transport-helper.c:783
#14 0x0813f846 in transport_push (transport=0x81e4450, refspec_nr=1, 
    refspec=0x81e43e8, flags=0, nonfastforward=0xbfb6642c) at transport.c:1044
#15 0x080a3bda in push_with_options (transport=0x81e4450, flags=0)
    at builtin/push.c:131
#16 0x080a3ea7 in do_push (repo=0x0, flags=0) at builtin/push.c:209
#17 0x080a4377 in cmd_push (argc=0, argv=0xbfb668c8, prefix=0x0)
    at builtin/push.c:265
#18 0x0804bf3f in run_builtin (p=0x81977b4, argc=1, argv=0xbfb668c8)
    at git.c:302
#19 0x0804c0a5 in handle_internal_command (argc=1, argv=0xbfb668c8)
    at git.c:460
#20 0x0804c185 in run_argv (argcp=0xbfb66840, argv=0xbfb66844) at git.c:504
#21 0x0804c321 in main (argc=1, argv=0xbfb668c8) at git.c:577
(gdb)
