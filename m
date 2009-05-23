From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Fri, 22 May 2009 18:06:06 -0700
Message-ID: <7vhbzc4oht.fsf@alter.siamese.dyndns.org>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
	<p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil>
	<p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil>
	<7vskiw4ooe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat May 23 03:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7fgn-00080T-IG
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 03:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449AbZEWBGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 21:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755732AbZEWBGJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 21:06:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57767 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbZEWBGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 21:06:08 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090523010609.OZP20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Fri, 22 May 2009 21:06:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id up691b00F4aMwMQ04p693h; Fri, 22 May 2009 21:06:09 -0400
X-Authority-Analysis: v=1.0 c=1 a=4ueMqUMRleoA:10 a=_0s4GiiSMUIA:10
 a=wPbFoDc_tLs7cH0PRwIA:9 a=8VNEoTQEucAXUYWVKZrNfL8QNuYA:4
X-CM-Score: 0.00
In-Reply-To: <7vskiw4ooe.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 22 May 2009 18\:02\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119756>

By the way, with the attached patch, I seem to be able to compile
everything more or less cleanly on OpenSolaris (200811).

In git-compat-util.h, we do

    #define _XOPEN_SOURCE 600
    #define _XOPEN_SOURCE_EXTENDED 1

and their /usr/include/sys/feature_tests.h has this nice table:

    Feature Test Macro				     Specification
    ------------------------------------------------  -------------
    _XOPEN_SOURCE                                         XPG3
    _XOPEN_SOURCE && _XOPEN_VERSION = 4                   XPG4
    _XOPEN_SOURCE && _XOPEN_SOURCE_EXTENDED = 1           XPG4v2
    _XOPEN_SOURCE = 500                                   XPG5
    _XOPEN_SOURCE = 600  (or POSIX_C_SOURCE=200112L)      XPG6

Later in the same header, compilation with -c99 is made to fail if _XPG6 is
not set, like this:

    #if defined(_STDC_C99) && (defined(__XOPEN_OR_POSIX) && !defined(_XPG6))
    #error "Compiler or options invalid for pre-UNIX 03 X/Open applications \
            and pre-2001 POSIX applications"
    #elif ...

The problem is that they check things in an order that is inconvenient for
us.  When they see _XOPEN_SOURCE_EXTENDED, they declare that we are XPG4v2
regardless of the value of _XOPEN_SOURCE.

It also appears that we do not need OLD_ICONV anymore, as our Makefile
suggests for older releases.

It would be nice if people with older Solaris can check if I am not
breaking things for them...

 Makefile          |    4 +++-
 git-compat-util.h |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fdb39fa..e7fc399 100644
--- a/Makefile
+++ b/Makefile
@@ -701,7 +701,9 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
-	OLD_ICONV = UnfortunatelyYes
+	ifneq ($(uname_R),5.11)
+		OLD_ICONV = UnfortunatelyYes
+	endif
 	ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index c7cf2d5..4236647 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -41,8 +41,10 @@
 
 #if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#ifndef __sun__
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
+#endif
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
