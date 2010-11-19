From: Jeff King <peff@peff.net>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 12:54:24 -0500
Message-ID: <20101119175424.GA13276@sigill.intra.peff.net>
References: <20101117095233.GA23817@basil.fritz.box>
 <20101117101516.GA12416@burratino>
 <20101117143855.GA1987@sigill.intra.peff.net>
 <20101117154829.GE23656@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 18:54:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJVAR-0001F6-Hg
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 18:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab0KSRya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 12:54:30 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35242 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab0KSRy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 12:54:29 -0500
Received: (qmail 26509 invoked by uid 111); 19 Nov 2010 17:54:28 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 17:54:28 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 12:54:24 -0500
Content-Disposition: inline
In-Reply-To: <20101117154829.GE23656@basil.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161772>

On Wed, Nov 17, 2010 at 04:48:29PM +0100, Andi Kleen wrote:

> On Wed, Nov 17, 2010 at 09:38:55AM -0500, Jeff King wrote:
> > On Wed, Nov 17, 2010 at 04:15:16AM -0600, Jonathan Nieder wrote:
> > Andi, I would be curious to hear which asciidoc and docbook-xsl versions
> > you are using.
> 
> I see this with the git rpms in opensuse 11.3 which I didn't build.
> But presumably it's built with asciidoc 8.4.5-5.1 and 1.75.2-7.1

Thanks. I think technically that is a bug in opensuse's packaging, as
they are not setting the right knobs for their version. However, I think
these days we can make it easier for them. Perhaps it is time to apply
this:

-- >8 --
Subject: [PATCH] docs: default to more modern toolset

When the ASCIIDOC8 and ASCIIDOC_NO_ROFF knobs were built,
many people were still on asciidoc 7 and using older
versions of docbook-xsl. These days, even the almost
2-year-old Debian stable needs these knobs turned.

So let's turn them by default. The new knobs ASCIIDOC7 and
ASCIIDOC_ROFF can be used to get the old behavior if people
are on older systems.

Signed-off-by: Jeff King <peff@peff.net>
---
These defaults work on Debian stable and further. It sounds like
opensuse 11.3, too. I don't know about Fedora, but I suspect they are at
least as far along as Debian stable.

RHEL5 has asciidoc8, but docbook-xsl 1.69, which means it still needs
ASCIIDOC_ROFF enabled. RHEL6 is just out last week. So we are
technically breaking at least RHEL5 people (along with anybody with
ancient systems) until they tweak their knobs.

However, I think it is worth it to avoid the hassle for the vast
majority of people on modern systems.

 Documentation/Makefile           |   23 ++++++++---------------
 Documentation/RelNotes/1.7.4.txt |    4 ++++
 INSTALL                          |    5 +++--
 Makefile                         |   10 +++++-----
 config.mak.in                    |    2 +-
 configure.ac                     |   12 ++++++------
 6 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e117bc4..36989b7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -63,35 +63,28 @@ endif
 
 #
 # For asciidoc ...
-#	-7.1.2,	no extra settings are needed.
-#	8.0-,	set ASCIIDOC8.
+#	-7.1.2,	set ASCIIDOC7
+#	8.0-,	no extra settings are needed
 #
 
 #
 # For docbook-xsl ...
-#	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
-#	1.69.0,		no extra settings are needed?
+#	-1.68.1,	no extra settings are needed?
+#	1.69.0,		set ASCIIDOC_ROFF?
 #	1.69.1-1.71.0,	set DOCBOOK_SUPPRESS_SP?
-#	1.71.1,		no extra settings are needed?
+#	1.71.1,		set ASCIIDOC_ROFF?
 #	1.72.0,		set DOCBOOK_XSL_172.
-#	1.73.0-,	set ASCIIDOC_NO_ROFF
+#	1.73.0-,	no extra settings are needed
 #
 
-#
-# If you had been using DOCBOOK_XSL_172 in an attempt to get rid
-# of 'the ".ft C" problem' in your generated manpages, and you
-# instead ended up with weird characters around callouts, try
-# using ASCIIDOC_NO_ROFF instead (it works fine with ASCIIDOC8).
-#
-
-ifdef ASCIIDOC8
+ifndef ASCIIDOC7
 ASCIIDOC_EXTRA += -a asciidoc7compatible -a no-inline-literal
 endif
 ifdef DOCBOOK_XSL_172
 ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
 MANPAGE_XSL = manpage-1.72.xsl
 else
-	ifdef ASCIIDOC_NO_ROFF
+	ifndef ASCIIDOC_ROFF
 	# docbook-xsl after 1.72 needs the regular XSL, but will not
 	# pass-thru raw roff codes from asciidoc.conf, so turn them off.
 	ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
diff --git a/Documentation/RelNotes/1.7.4.txt b/Documentation/RelNotes/1.7.4.txt
index 05e8a43..87629c6 100644
--- a/Documentation/RelNotes/1.7.4.txt
+++ b/Documentation/RelNotes/1.7.4.txt
@@ -32,6 +32,10 @@ Updates since v1.7.3
    git-only login over ssh as login shell, with custom set of
    commands.
 
+ * The documentation Makefile now assumes by default asciidoc 8 and
+   docbook-xsl >= 1.73. If you have older versions, you can set
+   ASCIIDOC7 and ASCIIDOC_ROFF, respectively.
+
 Also contains various documentation updates.
 
 
diff --git a/INSTALL b/INSTALL
index 10a1cba..16e45f1 100644
--- a/INSTALL
+++ b/INSTALL
@@ -122,8 +122,9 @@ Issues of note:
    Building and installing the pdf file additionally requires
    dblatex.  Version 0.2.7 with asciidoc >= 8.2.7 is known to work.
 
-   The documentation is written for AsciiDoc 7, but "make
-   ASCIIDOC8=YesPlease doc" will let you format with AsciiDoc 8.
+   The documentation is written for AsciiDoc 7, but by default
+   uses some compatibility wrappers to work on AsciiDoc 8. If you have
+   AsciiDoc 7, try "make ASCIIDOC7=YesPlease".
 
    Alternatively, pre-formatted documentation is available in
    "html" and "man" branches of the git repository itself.  For
diff --git a/Makefile b/Makefile
index 1f1ce04..9ddcae9 100644
--- a/Makefile
+++ b/Makefile
@@ -162,13 +162,13 @@ all::
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
-# Define ASCIIDOC8 if you want to format documentation with AsciiDoc 8
+# Define ASCIIDOC7 if you want to format documentation with AsciiDoc 7
 #
 # Define DOCBOOK_XSL_172 if you want to format man pages with DocBook XSL v1.72
 # (not v1.73 or v1.71).
 #
-# Define ASCIIDOC_NO_ROFF if your DocBook XSL escapes raw roff directives
-# (versions 1.72 and later and 1.68.1 and earlier).
+# Define ASCIIDOC_ROFF if your DocBook XSL does not escape raw roff directives
+# (versions 1.68.1 through v1.72).
 #
 # Define GNU_ROFF if your target system uses GNU groff.  This forces
 # apostrophes to be ASCII so that cut&pasting examples to the shell
@@ -1518,8 +1518,8 @@ ifndef V
 endif
 endif
 
-ifdef ASCIIDOC8
-	export ASCIIDOC8
+ifdef ASCIIDOC7
+	export ASCIIDOC7
 endif
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
diff --git a/config.mak.in b/config.mak.in
index a0c34ee..55dcd30 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -27,7 +27,7 @@ VPATH = @srcdir@
 export exec_prefix mandir
 export srcdir VPATH
 
-ASCIIDOC8=@ASCIIDOC8@
+ASCIIDOC7=@ASCIIDOC7@
 NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
 NO_OPENSSL=@NO_OPENSSL@
 NO_CURL=@NO_CURL@
diff --git a/configure.ac b/configure.ac
index cc55b6d..e9ca117 100644
--- a/configure.ac
+++ b/configure.ac
@@ -398,21 +398,21 @@ if test -n "$ASCIIDOC"; then
 	AC_MSG_CHECKING([for asciidoc version])
 	asciidoc_version=`$ASCIIDOC --version 2>/dev/null`
 	case "${asciidoc_version}" in
-	asciidoc' '8*)
-		ASCIIDOC8=YesPlease
+	asciidoc' '7*)
+		ASCIIDOC7=YesPlease
 		AC_MSG_RESULT([${asciidoc_version} > 7])
 		;;
-	asciidoc' '7*)
-		ASCIIDOC8=
+	asciidoc' '8*)
+		ASCIIDOC7=
 		AC_MSG_RESULT([${asciidoc_version}])
 		;;
 	*)
-		ASCIIDOC8=
+		ASCIIDOC7=
 		AC_MSG_RESULT([${asciidoc_version} (unknown)])
 		;;
 	esac
 fi
-AC_SUBST(ASCIIDOC8)
+AC_SUBST(ASCIIDOC7)
 
 
 ## Checks for libraries.
-- 
1.7.3.2.510.g24900
