From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] document the diff driver textconv feature
Date: Fri, 24 Oct 2008 20:54:53 -0400
Message-ID: <20081025005452.GF23903@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 02:56:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtXRp-00047o-0M
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 02:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbYJYAy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 20:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbYJYAy4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 20:54:56 -0400
Received: from peff.net ([208.65.91.99]:3067 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbYJYAyz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 20:54:55 -0400
Received: (qmail 25899 invoked by uid 111); 25 Oct 2008 00:54:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 20:54:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 20:54:53 -0400
Content-Disposition: inline
In-Reply-To: <20081025004815.GA23851@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99090>

This patch also changes the term "custom diff driver" to
"external diff driver"; now that there are more facets of a
"custom driver" than just external diffing, it makes sense
to refer to the configuration of "diff.foo.*" as the "foo
diff driver", with "diff.foo.command" as the "external
driver for foo".

Signed-off-by: Jeff King <peff@peff.net>
---
Same as before.

 Documentation/gitattributes.txt |   66 +++++++++++++++++++++++++++++++--------
 1 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2694559..314e2d3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -213,10 +213,12 @@ with `crlf`, and then `ident` and fed to `filter`.
 Generating diff text
 ~~~~~~~~~~~~~~~~~~~~
 
-The attribute `diff` affects if 'git-diff' generates textual
-patch for the path or just says `Binary files differ`.  It also
-can affect what line is shown on the hunk header `@@ -k,l +n,m @@`
-line.
+The attribute `diff` affects how 'git' generates diffs for particular
+files. It can tell git whether to generate a textual patch for the path
+or to treat the path as a binary file.  It can also affect what line is
+shown on the hunk header `@@ -k,l +n,m @@` line, tell git to use an
+external command to generate the diff, or ask git to convert binary
+files to a text format before generating the diff.
 
 Set::
 
@@ -227,7 +229,8 @@ Set::
 Unset::
 
 	A path to which the `diff` attribute is unset will
-	generate `Binary files differ`.
+	generate `Binary files differ` (or a binary patch, if
+	binary patches are enabled).
 
 Unspecified::
 
@@ -238,21 +241,21 @@ Unspecified::
 
 String::
 
-	Diff is shown using the specified custom diff driver.
-	The driver program is given its input using the same
-	calling convention as used for GIT_EXTERNAL_DIFF
-	program.  This name is also used for custom hunk header
-	selection.
+	Diff is shown using the specified diff driver.  Each driver may
+	specify one or more options, as described in the following
+	section. The options for the diff driver "foo" are defined
+	by the configuration variables in the "diff.foo" section of the
+	git config file.
 
 
-Defining a custom diff driver
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Defining an external diff driver
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The definition of a diff driver is done in `gitconfig`, not
 `gitattributes` file, so strictly speaking this manual page is a
 wrong place to talk about it.  However...
 
-To define a custom diff driver `jcdiff`, add a section to your
+To define an external diff driver `jcdiff`, add a section to your
 `$GIT_DIR/config` file (or `$HOME/.gitconfig` file) like this:
 
 ----------------------------------------------------------------
@@ -328,6 +331,43 @@ patterns are available:
 - `tex` suitable for source code for LaTeX documents.
 
 
+Performing text diffs of binary files
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Sometimes it is desirable to see the diff of a text-converted
+version of some binary files. For example, a word processor
+document can be converted to an ASCII text representation, and
+the diff of the text shown. Even though this conversion loses
+some information, the resulting diff is useful for human
+viewing (but cannot be applied directly).
+
+The `textconv` config option is used to define a program for
+performing such a conversion. The program should take a single
+argument, the name of a file to convert, and produce the
+resulting text on stdout.
+
+For example, to show the diff of the exif information of a
+file instead of the binary information (assuming you have the
+exif tool installed):
+
+------------------------
+[diff "jpg"]
+	textconv = exif
+------------------------
+
+NOTE: The text conversion is generally a one-way conversion;
+in this example, we lose the actual image contents and focus
+just on the text data. This means that diffs generated by
+textconv are _not_ suitable for applying. For this reason,
+only `git diff` and the `git log` family of commands (i.e.,
+log, whatchanged, show) will perform text conversion. `git
+format-patch` will never generate this output. If you want to
+send somebody a text-converted diff of a binary file (e.g.,
+because it quickly conveys the changes you have made), you
+should generate it separately and send it as a comment _in
+addition to_ the usual binary diff that you might send.
+
+
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.6.0.3.523.g38597.dirty
