From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Clean termination of remote-helpers (was Re: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 14:33:19 +0200
Message-ID: <vpqd3flzrow.fsf_-_@bauges.imag.fr>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 14:33:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyjz1-00029D-Ir
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 14:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab1HaMdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 08:33:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33002 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169Ab1HaMdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 08:33:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7VCWd42006328
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 14:32:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qyjyq-0006yk-1h; Wed, 31 Aug 2011 14:33:20 +0200
In-Reply-To: <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Fri, 26 Aug 2011 19:11:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 31 Aug 2011 14:32:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VCWd42006328
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315398760.61156@knL3ngIZqwEsQ7VVAs8zAw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180463>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +BEGIN { $| = 1 };
> +if (!eof(STDIN)) {
> +	# Wait for Git to terminate. If we don't, git fetch
> +	# (transport-helper.c's sendline function) will try to write
> +	# to our stdin, which will be closed, and git fetch will be
> +	# killed. That's probably a bug in transport-helper.c, but in
> +	# the meantime ...
> +	sleep .1;
> +};

I was expecting this part to be more controversial, so I'm just
repeating it to draw more attention ;-).

I just found a "cleaner" way to terminate, but I still don't find it
really satisfactory:

# Inform Git that we're done, otherwise Git won't close it's stdin,
# and the next loop will be infinite.
close(STDOUT);
# Flush stdin before we terminate. If we don't, git fetch
# (transport-helper.c's sendline function) will try to write to our
# stdin, which may be closed, and git fetch will be killed. That's
# probably a bug in transport-helper.c, but in the meantime ...
while (<STDIN>) {};

This seems reliable (just did 100+ imports without crash).

If I comment-out the "close(STDOUT)", then the while loop is indeed
infinite. If I comment-out the "while (<STDIN>) {};", then the import
unreliably fails (for example, I just did 10 clones of a 1-page wiki,
and got one failure). No error message, just a non-zero exit status, and
in the case of "clone", the newly created repository is deleted before
the command terminates.

With debug activated in transport-helper.c, the last messages are just:

Debug: Disconnecting.
Debug: Remote helper: -> 

and gdb says:

Program received signal SIGPIPE, Broken pipe.
0xb7fe2424 in __kernel_vsyscall ()
(gdb) bt
#0  0xb7fe2424 in __kernel_vsyscall ()
#1  0xb7e66ff3 in __write_nocancel () at ../sysdeps/unix/syscall-template.S:82
#2  0x0811dc08 in xwrite (fd=8, buf=0x81bd840, len=1) at wrapper.c:137
#3  0x0811dc67 in write_in_full (fd=8, buf=0x81bd840, count=1) at wrapper.c:169
#4  0x08115035 in sendline (helper=0x81a2d00, buffer=0xbfffe674) at transport-helper.c:41
#5  0x081158f3 in disconnect_helper (transport=0x81a2cc0) at transport-helper.c:231
#6  release_helper (transport=0x81a2cc0) at transport-helper.c:324
#7  0x08111f1d in transport_disconnect (transport=0x81a2cc0) at transport.c:1144
#8  0x08061711 in cmd_clone (argc=3, argv=0xbfffeb58, prefix=0x0) at builtin/clone.c:739
#9  0x0804ba27 in run_builtin (argc=<value optimized out>, argv=<value optimized out>) at git.c:308
#10 handle_internal_command (argc=<value optimized out>, argv=<value optimized out>) at git.c:466
#11 0x0804bc33 in run_argv (argc=3, argv=0xbfffeb58) at git.c:512
#12 main (argc=3, argv=0xbfffeb58) at git.c:585

Any idea how to fix this?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
