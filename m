From: Bruno Haible <bruno@clisp.org>
Subject: [PATCH] New whitespace checking category 'trailing-blank-line'
Date: Sun, 26 Jul 2009 11:45:37 +0200
Message-ID: <200907261145.38449.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 26 11:46:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV0J3-0002HI-U2
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 11:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbZGZJqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 05:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbZGZJqE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 05:46:04 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:53205 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZGZJqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 05:46:03 -0400
X-RZG-AUTH: :Ln4Re0+Ic/6oZXR1YgKryK8brksyK8dozXDwHXjf9hj/zDNRbP8446gMQQ==
X-RZG-CLASS-ID: mo00
Received: from linuix.haible.de
	(dslb-088-068-059-160.pools.arcor-ip.net [88.68.59.160])
	by post.strato.de (mrclete mo24) (RZmta 19.1)
	with ESMTP id v064a6l6Q9cGZE ; Sun, 26 Jul 2009 11:45:59 +0200 (MEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124113>

Hi,

In some GNU projects, there are file types for which trailing spaces in a line
are undesired, but for which trailing blank lines are normal. Such file types
are:
  - ChangeLog files,
  - modules descriptions in Gnulib,
  - also the README files in 20% of the projects.

Currently the user has to turn off the 'trailing-space' whitespace attribute
in order for 'git diff --check' to not complain about such files. This has
the drawback that trailing spaces are not detected.

Here is a proposed patch, to allow people to turn the check against trailing
blank lines independently from the whitespace-in-a-line checking. The default
behavior is not changed.


>From 049db23a38c92c734aae13788a5a9478ed587cfd Mon Sep 17 00:00:00 2001
From: Bruno Haible <bruno@clisp.org>
Date: Sun, 26 Jul 2009 11:08:41 +0200
Subject: [PATCH] New whitespace checking category 'trailing-blank-line'.

---
 Documentation/RelNotes-1.6.4.txt |    6 ++++++
 Documentation/config.txt         |    2 ++
 cache.h                          |    3 ++-
 diff.c                           |    2 +-
 ws.c                             |    6 ++++++
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes-1.6.4.txt b/Documentation/RelNotes-1.6.4.txt
index b3c0346..9ebcc3a 100644
--- a/Documentation/RelNotes-1.6.4.txt
+++ b/Documentation/RelNotes-1.6.4.txt
@@ -64,6 +64,12 @@ Updates since v1.6.3
    to avoid testing a commit that is too close to a commit that is
    already known to be untestable.
 
+ * In the configuration variable core.whitespace and in a 'whitespace'
+   attribute specified in .git/info/attributes or .gitattributes, a new
+   category of whitespace checking is recognized: "trailing-blank-line".
+   Previously this checking was part of "trailing-space"; now it can be
+   turned on or off separately.
+
  * "git cvsexportcommit" learned -k option to stop CVS keywords expansion
 
  * "git grep" learned -p option to show the location of the match using the
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6857d2f..e9221ba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -411,6 +411,8 @@ core.whitespace::
   part of the line terminator, i.e. with it, `trailing-space`
   does not trigger if the character before such a carriage-return
   is not a whitespace (not enabled by default).
+* `trailing-blank-line` treats blank lines at the end of the file as
+  an error (enabled by default).
 
 core.fsyncobjectfiles::
 	This boolean will enable 'fsync()' when writing object files.
diff --git a/cache.h b/cache.h
index e6c7f33..24ae981 100644
--- a/cache.h
+++ b/cache.h
@@ -968,7 +968,8 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 #define WS_SPACE_BEFORE_TAB	02
 #define WS_INDENT_WITH_NON_TAB	04
 #define WS_CR_AT_EOL           010
-#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
+#define WS_TRAILING_BLANK_LINE 020
+#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|WS_TRAILING_BLANK_LINE)
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/diff.c b/diff.c
index cd35e0c..6d1b07b 100644
--- a/diff.c
+++ b/diff.c
@@ -1704,7 +1704,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
 			      &xpp, &xecfg, &ecb);
 
-		if ((data.ws_rule & WS_TRAILING_SPACE) &&
+		if ((data.ws_rule & WS_TRAILING_BLANK_LINE) &&
 		    data.trailing_blanks_start) {
 			fprintf(o->file, "%s:%d: ends with blank lines.\n",
 				data.filename, data.trailing_blanks_start);
diff --git a/ws.c b/ws.c
index 59d0883..5f5a930 100644
--- a/ws.c
+++ b/ws.c
@@ -16,6 +16,7 @@ static struct whitespace_rule {
 	{ "space-before-tab", WS_SPACE_BEFORE_TAB, 0 },
 	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB, 0 },
 	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
+	{ "trailing-blank-line", WS_TRAILING_BLANK_LINE, 0 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -114,6 +115,11 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "indent with spaces");
 	}
+	if (ws & WS_TRAILING_BLANK_LINE) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "trailing blank line");
+	}
 	return strbuf_detach(&err, NULL);
 }
 
-- 
1.6.3.2
