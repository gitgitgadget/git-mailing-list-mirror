From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/4 v2] userdiff.c: add builtin fortran regex patterns
Date: Fri, 10 Sep 2010 11:18:14 -0500
Message-ID: <KtBylmXQLVPyA9SToc1FN6znL4kFcYiYuvLgq017oHm66wTCLQA6Tsi_ja4x5cfwDmaQJs2cGi4@cipher.nrlssc.navy.mil>
References: <6F7MXe3ksgGGsKBKvAOQG_pNROYqzpzjQTM_YARyO5d1RK6OVY8oLg@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Sep 10 18:18:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6JL-0004fM-OA
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab0IJQSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:18:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36545 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab0IJQSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:18:38 -0400
Received: by mail.nrlssc.navy.mil id o8AGIOAm016752; Fri, 10 Sep 2010 11:18:24 -0500
In-Reply-To: <6F7MXe3ksgGGsKBKvAOQG_pNROYqzpzjQTM_YARyO5d1RK6OVY8oLg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 10 Sep 2010 16:18:24.0190 (UTC) FILETIME=[CAF385E0:01CB5103]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155942>

From: Brandon Casey <drafnel@gmail.com>

This adds fortran xfuncname and wordRegex patterns to the list of builtin
patterns.  The intention is for the patterns to be appropriate for all
versions of fortran including 77, 90, 95.  The patterns can be enabled by
adding the diff=fortran attribute to the .gitattributes file for the
desired file glob.

This also adds a new macro named IPATTERN which is just like the PATTERNS
macro except it sets the REG_ICASE flag so that case will be ignored.

The test code in t4018 and the docs were updated as appropriate.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This version renames the iPATTERN macro to the all uppercase IPATTERN, and
is a replacement for the version in pu.


 Documentation/gitattributes.txt |    2 ++
 t/t4018-diff-funcname.sh        |    2 +-
 userdiff.c                      |   17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e5a27d8..fbf507a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -477,6 +477,8 @@ patterns are available:
 
 - `csharp` suitable for source code in the C# language.
 
+- `fortran` suitable for source code in the Fortran language.
+
 - `html` suitable for HTML/XHTML documents.
 
 - `java` suitable for source code in the Java language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index c8e1937..0a61b57 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,7 +32,7 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
-builtin_patterns="bibtex cpp csharp html java objc pascal php python ruby tex"
+builtin_patterns="bibtex cpp csharp fortran html java objc pascal php python ruby tex"
 for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
diff --git a/userdiff.c b/userdiff.c
index e552215..f9e05b5 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -9,7 +9,23 @@ static int drivers_alloc;
 
 #define PATTERNS(name, pattern, word_regex)			\
 	{ name, NULL, -1, { pattern, REG_EXTENDED }, word_regex }
+#define IPATTERN(name, pattern, word_regex)			\
+	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, word_regex }
 static struct userdiff_driver builtin_drivers[] = {
+IPATTERN("fortran",
+	 "!^([C*]|[ \t]*!)\n"
+	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
+	 "^[ \t]*((END[ \t]+)?(PROGRAM|MODULE|BLOCK[ \t]+DATA"
+		"|([^'\" \t]+[ \t]+)*(SUBROUTINE|FUNCTION))[ \t]+[A-Z].*)$",
+	 /* -- */
+	 "[a-zA-Z][a-zA-Z0-9_]*"
+	 "|\\.([Ee][Qq]|[Nn][Ee]|[Gg][TtEe]|[Ll][TtEe]|[Tt][Rr][Uu][Ee]|[Ff][Aa][Ll][Ss][Ee]|[Aa][Nn][Dd]|[Oo][Rr]|[Nn]?[Ee][Qq][Vv]|[Nn][Oo][Tt])\\."
+	 /* numbers and format statements like 2E14.4, or ES12.6, 9X.
+	  * Don't worry about format statements without leading digits since
+	  * they would have been matched above as a variable anyway. */
+	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][a-zA-Z0-9_]*)?"
+	 "|//|\\*\\*|::|[/<>=]="
+	 "|[^[:space:]]|[\x80-\xff]+"),
 PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
 	 "[^<>= \t]+|[^[:space:]]|[\x80-\xff]+"),
 PATTERNS("java",
@@ -101,6 +117,7 @@ PATTERNS("csharp",
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
+#undef IPATTERN
 
 static struct userdiff_driver driver_true = {
 	"diff=true",
-- 
1.7.2.1
