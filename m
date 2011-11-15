From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 11:22:48 +0100
Message-ID: <201111151122.48378.trast@student.ethz.ch>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com> <1319472131-3968-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>, <j6t@kdbg.org>,
	<peff@peff.net>, <rene.scharfe@lsrfire.ath.cx>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 11:22:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQGAM-00045g-CM
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 11:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab1KOKWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 05:22:54 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:10883 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586Ab1KOKWx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 05:22:53 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 15 Nov
 2011 11:22:49 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 15 Nov
 2011 11:22:51 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1319472131-3968-4-git-send-email-kusmabite@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185452>

Erik Faye-Lund wrote:
> The POSIX-function fork is not supported on Windows. Use our
> start_command API instead.
> 
> As this is the last call-site that depends on the fork-stub in
> compat/mingw.h, remove that as well.
> 
> Add an undocumented flag to git-archive that tells it that the
> action originated from a remote, so features can be disabled.
> Thanks to Jeff King for work on this part.
> 
> Remove the NOT_MINGW-prereq for t5000, as git-archive --remote
> now works.

I see valgrind failures bisecting to this commit, like so:

==19125== Syscall param execve(argv[i]) points to unaddressable byte(s)
==19125==    at 0x5303CB7: execve (in /lib64/libc-2.11.3.so)
==19125==    by 0x53045A5: execvpe (in /lib64/libc-2.11.3.so)
==19125==    by 0x4B183C: execv_git_cmd (exec_cmd.c:137)
==19125==    by 0x4F305E: start_command (run-command.c:277)
==19125==    by 0x47F5C9: cmd_upload_archive (upload-archive.c:98)
==19125==    by 0x4051F4: run_builtin (git.c:308)
==19125==    by 0x40538F: handle_internal_command (git.c:466)
==19125==    by 0x405556: main (git.c:553)
==19125==  Address 0x7feffe7d0 is not stack'd, malloc'd or (recently) free'd

when running 'make valgrind' in current master.  Let me know if you
need more information.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
