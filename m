From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 03:12:05 +0200
Message-ID: <20060623011205.GJ21864@pasky.or.cz>
References: <20060622220201.19132.67536.stgit@machine.or.cz> <7vlkrohj9p.fsf@assigned-by-dhcp.cox.net> <20060622235017.GH21864@pasky.or.cz> <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 03:12:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtaDW-0004wL-5i
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 03:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161473AbWFWBMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 21:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWFWBMH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 21:12:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58264 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932737AbWFWBMG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 21:12:06 -0400
Received: (qmail 9600 invoked by uid 2001); 23 Jun 2006 03:12:05 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22391>

Dear diary, on Fri, Jun 23, 2006 at 02:22:41AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> >> Eek.  It does not compile for me -- maybe there is more
> >> dependencies that need to be listed in INSTALL file?
> >> ...
> >> Git.xs: In function 'XS_Git_xs_hash_object':
> >> Git.xs:27: warning: ISO C90 forbids mixed declarations and code
> >> Git.xs:44: warning: passing argument 1 of 'Perl_io_close' from incompatible pointer type
> >> Git.xs:44: warning: passing argument 2 of 'Perl_io_close' makes pointer from integer without a cast
> >> Git.xs:44: error: too few arguments to function 'Perl_io_close'
> >
> > Oops, sorry. Apparently, I've digged too deep and unleashed a monster of
> > unstable API. Now I've finally discovered perlapio(1) and know I
> > should've just called PerlIO_close(). Below comes a fixed patch, I
> > didn't bother to bump the version number.
> 
> Thanks; it compiles now with a few more glitches.
> 
>             /usr/bin/perl /usr/share/perl/5.8/ExtUtils/xsubpp  \
>                     -typemap /usr/share/perl/5.8/ExtUtils/typemap  Git.xs > Git.xsc && \
>                     mv Git.xsc Git.c
>             Please specify prototyping behavior for Git.xs (see perlxs manual)
> 
> Says xsubpp.

It's harmless but can be fixed by:

diff --git a/perl/Git.xs b/perl/Git.xs
index 3799ee9..8ab84bb 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -17,6 +17,8 @@ #include "ppport.h"
 
 MODULE = Git		PACKAGE = Git		
 
+PROTOTYPES: DISABLE
+
 # /* TODO: xs_call_gate(). See Git.pm. */
 
 char *

>         cc -c  -I. -I.. -D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS \
>                 -DDEBIAN -fno-strict-aliasing -pipe -I/usr/local/include \
>                 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 \
>                 -DVERSION=\"0.01\" -DXS_VERSION=\"0.01\" -fPIC \
>                 "-I/usr/lib/perl/5.8/CORE" -Wall
>                 -Wdeclaration-after-statement \
>                 -g -DSHA1_HEADER='<openssl/sha.h>' \
>                 -DGIT_VERSION=\"1.4.1.rc1.g01a1\" Git.c
>         Git.xs: In function 'XS_Git_xs__execv_git_cmd':
>         Git.xs:57: warning: passing argument 1 of 'free' discards qualifiers from pointer target type
>         Git.xs: In function 'XS_Git_xs_hash_object':
>         Git.xs:65: warning: ISO C90 forbids mixed declarations and code
> 
> I usually compile with -Wdeclaration-after-statement so I
> probably get some more warnings than you saw; it probably is
> primarily xsubpp's fault, but you could work it around by having
> CODE block to be inside an extra set of braces {}.

Sure. Should I resend all the .xs-related patches with the code blocks
in {}, or will you add it at your side?

> Constness reduction of free() is a bit annoying from the point of view of
> the coder who has to cast away constness, so I won't be too
> strict about that, but it would be nicer if we did not have to
> see the warnings.

Sure, it should be trivial to fix.

>         rm -f blib/arch/auto/Git/Git.so
>         cc  -shared -L/usr/local/lib Git.o  -o blib/arch/auto/Git/Git.so ../libgit.a	\
>                    -lz -lcrypto  	\
> 
>         /usr/bin/ld: ../libgit.a(exec_cmd.o): relocation R_X86_64_32 against `a local symbol' can not be used when making a shared object; recompile with -fPIC
>         ../libgit.a: could not read symbols: Bad value
>         collect2: ld returned 1 exit status
>         make[1]: *** [blib/arch/auto/Git/Git.so] Error 1
> 
> This is a real killer.  If we compile everything with -fPIC,
> this goes away, but I do not think we want -fPIC for the core
> level tools.  At least not until we are ready to do libgit.so.

Hmm, I didn't get that; I guess that's x86-64 specific. :/ Do you have
any idea what the error actually means? Could the environ be a problem?
(Why aren't we calling just execv()?)

Also, is there any real problem with just using -fPIC?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
