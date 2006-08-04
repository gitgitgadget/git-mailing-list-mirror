From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Fri, 04 Aug 2006 12:50:13 -0700
Message-ID: <7vy7u4i8lm.fsf@assigned-by-dhcp.cox.net>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
	<eb0554$1pu$1@sea.gmane.org> <7vejvwjp2l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 21:50:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G95ga-0003UR-DC
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 21:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWHDTuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 15:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWHDTuQ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 15:50:16 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:22496 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932609AbWHDTuO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 15:50:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804195014.JFJD25430.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 15:50:14 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vejvwjp2l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 04 Aug 2006 12:09:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24829>

Junio C Hamano <junkio@cox.net> writes:

> Running generated configure script on Cygwin just updated
> reports NO_C99_FORMAT is needed.  This is consistent with what
> Johannes confirmed.

BTW, my copy of config.mak.autogen generated on Cygwin says:

	NO_D_INO_IN_DIRENT
        NO_D_TYPE_IN_DIRENT
        NO_C99_FORMAT
        NO_STRCASESTR
	NO_OPENSSL		???

The defaults in our Makefile are:

        NO_D_INO_IN_DIRENT
	NO_D_TYPE_IN_DIRENT
        NO_STRCASESTR
        NO_STRLCPY		???
        NEEDS_LIBICONV		???
        NO_C99_FORMAT
        NO_IPV6			???

(1) configure misdetects NO_OPENSSL.  The relevant parts are:

        checking for SHA1_Init in -lssl... no
        checking for SHA1_INIT in -lcrypto... no

    but I've been building git on Cygwin without NO_OPENSSL (eh,
    that's double negation -- what I mean is I've been building
    git with -lssl just fine).  I think the function to check in
    -lcrypto should be SHA1_Init, not SHA1_INIT (trivial patch
    attached at the end).

(2) NO_STRLCPY is detected to be available by configure.  I
    think we should update the default in Makefile.

(3) NEEDS_LIBICONV is found to be unnecessary by configure, but
    the link fails like this without it:

        builtin-mailinfo.o: In function `convert_to_utf8':
        /git/builtin-mailinfo.c:539: undefined reference to `_libiconv_open'
        /git/builtin-mailinfo.c:560: undefined reference to `_libiconv'
        /git/builtin-mailinfo.c:561: undefined reference to `_libiconv_close'
        collect2: ld returned 1 exit status

(4) NO_IPV6 is not detected yet -- you should be able to detect
    this by checking for "struct addrinfo".  The compilation
    fails like this on Cygwin:

        connect.c: In function `git_tcp_connect_sock':
        connect.c:361: error: storage size of 'hints' isn't known

(Z) When configure detects some NO_XXX is unneeded, currently
    there is no way for generated config.mak.autogen to override
    the default set in Makefile.  For example, NO_STRLCPY is set
    by Makefile, and the included config.mak.autogen does not
    say anything about it even though it knows strlcpy is
    usable.  It might be better to explicitly undef unneeded
    NO_XXX in config.mak.autogen?

-- >8 --
autoconf: typofix to detect SHA1_Init in -lcrypto

---
diff --git a/configure.ac b/configure.ac
index 9ce00e9..c6d76af 100644
--- a/configure.ac
+++ b/configure.ac
@@ -155,7 +155,7 @@ #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
 AC_CHECK_LIB([ssl], [SHA1_Init],[],
-[AC_CHECK_LIB([crypto], [SHA1_INIT],
+[AC_CHECK_LIB([crypto], [SHA1_Init],
  [GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease)],
  [GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease)])])
 #
