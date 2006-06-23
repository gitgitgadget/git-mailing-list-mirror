From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Thu, 22 Jun 2006 17:22:41 -0700
Message-ID: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
References: <20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 02:22:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtZRi-0000AR-V5
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 02:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161350AbWFWAWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 20:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWFWAWn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 20:22:43 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8912 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030475AbWFWAWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 20:22:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623002242.UHPC554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 20:22:42 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060622235017.GH21864@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Jun 2006 01:50:17 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22388>

Petr Baudis <pasky@suse.cz> writes:

>> Eek.  It does not compile for me -- maybe there is more
>> dependencies that need to be listed in INSTALL file?
>> ...
>> Git.xs: In function 'XS_Git_xs_hash_object':
>> Git.xs:27: warning: ISO C90 forbids mixed declarations and code
>> Git.xs:44: warning: passing argument 1 of 'Perl_io_close' from incompatible pointer type
>> Git.xs:44: warning: passing argument 2 of 'Perl_io_close' makes pointer from integer without a cast
>> Git.xs:44: error: too few arguments to function 'Perl_io_close'
>
> Oops, sorry. Apparently, I've digged too deep and unleashed a monster of
> unstable API. Now I've finally discovered perlapio(1) and know I
> should've just called PerlIO_close(). Below comes a fixed patch, I
> didn't bother to bump the version number.

Thanks; it compiles now with a few more glitches.

            /usr/bin/perl /usr/share/perl/5.8/ExtUtils/xsubpp  \
                    -typemap /usr/share/perl/5.8/ExtUtils/typemap  Git.xs > Git.xsc && \
                    mv Git.xsc Git.c
            Please specify prototyping behavior for Git.xs (see perlxs manual)

Says xsubpp.

        cc -c  -I. -I.. -D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS \
                -DDEBIAN -fno-strict-aliasing -pipe -I/usr/local/include \
                -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 \
                -DVERSION=\"0.01\" -DXS_VERSION=\"0.01\" -fPIC \
                "-I/usr/lib/perl/5.8/CORE" -Wall
                -Wdeclaration-after-statement \
                -g -DSHA1_HEADER='<openssl/sha.h>' \
                -DGIT_VERSION=\"1.4.1.rc1.g01a1\" Git.c
        Git.xs: In function 'XS_Git_xs__execv_git_cmd':
        Git.xs:57: warning: passing argument 1 of 'free' discards qualifiers from pointer target type
        Git.xs: In function 'XS_Git_xs_hash_object':
        Git.xs:65: warning: ISO C90 forbids mixed declarations and code

I usually compile with -Wdeclaration-after-statement so I
probably get some more warnings than you saw; it probably is
primarily xsubpp's fault, but you could work it around by having
CODE block to be inside an extra set of braces {}.  Constness
reduction of free() is a bit annoying from the point of view of
the coder who has to cast away constness, so I won't be too
strict about that, but it would be nicer if we did not have to
see the warnings.

        rm -f blib/arch/auto/Git/Git.so
        cc  -shared -L/usr/local/lib Git.o  -o blib/arch/auto/Git/Git.so ../libgit.a	\
                   -lz -lcrypto  	\

        /usr/bin/ld: ../libgit.a(exec_cmd.o): relocation R_X86_64_32 against `a local symbol' can not be used when making a shared object; recompile with -fPIC
        ../libgit.a: could not read symbols: Bad value
        collect2: ld returned 1 exit status
        make[1]: *** [blib/arch/auto/Git/Git.so] Error 1

This is a real killer.  If we compile everything with -fPIC,
this goes away, but I do not think we want -fPIC for the core
level tools.  At least not until we are ready to do libgit.so.
