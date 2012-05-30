From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] docs: drop asciidoc7compatible flag
Date: Wed, 30 May 2012 06:22:42 -0400
Message-ID: <20120530102242.GB13341@sigill.intra.peff.net>
References: <20120530101758.GA13285@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 12:22:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZg3K-0008V6-2K
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 12:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab2E3KWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 06:22:47 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36183
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab2E3KWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 06:22:46 -0400
Received: (qmail 2896 invoked by uid 107); 30 May 2012 10:22:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 06:22:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 06:22:42 -0400
Content-Disposition: inline
In-Reply-To: <20120530101758.GA13285@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198791>

When we made the switch to supporting asciidoc 8 in 4c7100a
(Documentation: adjust to AsciiDoc 8, 2007-06-14), we were
able to leave most of the documentation intact by defining
asciidoc7compatible.

Since commit 6cf378f (docs: stop using asciidoc no-inline-literal,
2012-04-26), we don't support versions of asciidoc older
than 8.4.1, which is when inline literals were introduced.
Therefore there is not much point in keeping our
documentation compatible with asciidoc 7.

So we are now free to drop the asciidoc7compatible flag and
update the documentation itself to assume asciidoc8.
Fortunately, doing the latter is very easy; we weren't using
any of the constructs impacted by asciidoc7compatible, so
there are no changes to make.

The reason is somewhat subtle. The asciidoc7compatible
affects only super/sub-scripts ("^" and "~") and index
terms. We don't use the latter at all. Nor we do we use the
former, but we did have to protect them from accidental
expansion in constructs like "rev^1". However, all of our
uses of "~" and "^" are either in code blocks (which are
rendered literally), or inside backticks. Prior to 6cf378f,
backticks were not inline literals, and needed proper
quoting. But post-6cf378f, we don't have to worry whether we
are using the old or new rules, as those characters are not
interpreted at all in either case.

I verified that the result of "make install-html
install-man" is identical before and after this patch on
asciidoc 8.6.7.

Signed-off-by: Jeff King <peff@peff.net>
---
It's possible that other recent versions of asciidoc might not generate
identical output, or that asciidoc7compatible might change in the future
to include some as-yet-undiscovered incompatibility (though I find that
unlikely, as it has been several years now). But in that case, I think
this is still the right thing to do, and we should update to the proper
asciidoc8 syntax.

I tweaked the configure.ac to stop setting ASCIIDOC7, since it no longer
does anything. I believe this makes the whole version check a no-op,
except for the message that is printed. It might be worth actually
checking for asciidoc >= 8.4.1 in the configure script, but I will leave
that to the folks who care about autoconf (apparently there is a
dotted-version comparison function, but it was only in autoconf 2.53 or
higher, and I have no idea what we consider recent enough autoconf).

 Documentation/Makefile | 9 ---------
 Makefile               | 6 ------
 config.mak.in          | 1 -
 configure.ac           | 7 -------
 4 files changed, 23 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 14286cb..030e2c8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -66,12 +66,6 @@ endif
 -include ../config.mak
 
 #
-# For asciidoc ...
-#	-7.1.2,	set ASCIIDOC7
-#	8.0-,	no extra settings are needed
-#
-
-#
 # For docbook-xsl ...
 #	-1.68.1,	no extra settings are needed?
 #	1.69.0,		set ASCIIDOC_ROFF?
@@ -81,9 +75,6 @@ endif
 #	1.73.0-,	no extra settings are needed
 #
 
-ifndef ASCIIDOC7
-ASCIIDOC_EXTRA += -a asciidoc7compatible
-endif
 ifdef DOCBOOK_XSL_172
 ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
 MANPAGE_XSL = manpage-1.72.xsl
diff --git a/Makefile b/Makefile
index 96ebcf9..55943a9 100644
--- a/Makefile
+++ b/Makefile
@@ -203,8 +203,6 @@ all::
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
-# Define ASCIIDOC7 if you want to format documentation with AsciiDoc 7
-#
 # Define DOCBOOK_XSL_172 if you want to format man pages with DocBook XSL v1.72
 # (not v1.73 or v1.71).
 #
@@ -1834,10 +1832,6 @@ ifndef V
 endif
 endif
 
-ifdef ASCIIDOC7
-	export ASCIIDOC7
-endif
-
 ifdef NO_INSTALL_HARDLINKS
 	export NO_INSTALL_HARDLINKS
 endif
diff --git a/config.mak.in b/config.mak.in
index b2ba710..802d342 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -28,7 +28,6 @@ VPATH = @srcdir@
 export exec_prefix mandir
 export srcdir VPATH
 
-ASCIIDOC7=@ASCIIDOC7@
 NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
 NO_OPENSSL=@NO_OPENSSL@
 NO_CURL=@NO_CURL@
diff --git a/configure.ac b/configure.ac
index e125550..4e9012f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -437,21 +437,14 @@ if test -n "$ASCIIDOC"; then
 	AC_MSG_CHECKING([for asciidoc version])
 	asciidoc_version=`$ASCIIDOC --version 2>/dev/null`
 	case "${asciidoc_version}" in
-	asciidoc' '7*)
-		ASCIIDOC7=YesPlease
-		AC_MSG_RESULT([${asciidoc_version} > 7])
-		;;
 	asciidoc' '8*)
-		ASCIIDOC7=
 		AC_MSG_RESULT([${asciidoc_version}])
 		;;
 	*)
-		ASCIIDOC7=
 		AC_MSG_RESULT([${asciidoc_version} (unknown)])
 		;;
 	esac
 fi
-AC_SUBST(ASCIIDOC7)
 
 
 ## Checks for libraries.
-- 
1.7.11.rc0.12.g6048c92
