From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Fri, 04 Aug 2006 13:06:33 -0700
Message-ID: <7vhd0si7ue.fsf@assigned-by-dhcp.cox.net>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
	<eb0554$1pu$1@sea.gmane.org> <7vejvwjp2l.fsf@assigned-by-dhcp.cox.net>
	<7vy7u4i8lm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 22:07:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G95wb-0006GA-LI
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 22:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWHDUGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 16:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161392AbWHDUGg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 16:06:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17793 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161361AbWHDUGf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 16:06:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804200634.OVYG6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 16:06:34 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vy7u4i8lm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 04 Aug 2006 12:50:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24831>

Junio C Hamano <junkio@cox.net> writes:

> (1) configure misdetects NO_OPENSSL.  The relevant parts are:
>
>         checking for SHA1_Init in -lssl... no
>         checking for SHA1_INIT in -lcrypto... no
>
>     but I've been building git on Cygwin without NO_OPENSSL (eh,
>     that's double negation -- what I mean is I've been building
>     git with -lssl just fine).  I think the function to check in
>     -lcrypto should be SHA1_Init, not SHA1_INIT (trivial patch
>     attached at the end).

I just noticed that this is not enough.  It does fix the
NO_OPENSSL problem, but I think the logic and test for ssl and
crypto in the original are the other way around.

NEEDS_SSL_WITH_CRYPTO means you cannot just say "-lcrypto" to
use SHA1 stuff, but need to say "-lcrypto -lssl", so the test
should say "if we can get away with -lcrypto, we are happy,
otherwise if we need -lssl, then say NEEDS_SSL_WITH_CRYPTO,
otherwise we cannot use OpenSSL so say NO_OPENSSL", or something
like that.

-- >8 --

diff --git a/configure.ac b/configure.ac
index 9ce00e9..fea18b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -154,8 +154,8 @@ AC_MSG_NOTICE([CHECKS for libraries])
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
-AC_CHECK_LIB([ssl], [SHA1_Init],[],
-[AC_CHECK_LIB([crypto], [SHA1_INIT],
+AC_CHECK_LIB([crypto], [SHA1_Init],[],
+[AC_CHECK_LIB([ssl], [SHA1_Init],
  [GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease)],
  [GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease)])])
 #
