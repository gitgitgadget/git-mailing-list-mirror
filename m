From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Add an option to git-ls-tree to display also the size of object
Date: Tue, 15 May 2007 12:24:30 +0200
Message-ID: <11792246701367-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 12:20:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnu8O-0004RV-8f
	for gcvg-git@gmane.org; Tue, 15 May 2007 12:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbXEOKTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 06:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759141AbXEOKTy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 06:19:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:45218 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758000AbXEOKTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 06:19:53 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1542813uga
        for <git@vger.kernel.org>; Tue, 15 May 2007 03:19:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=hCQDXIKX5WIS0HMqLokxLx7JJbF+Y5NCYwhTDRCojP0S0659UAdmztlYAzU2NBESCytZ93SsWUMY59pm9N6tuRHPCOk9o4iZDf93jYNcZT3PLURSxZibPfIdn2Qi7zRFivBMZ8unx6I6cQ2SLTUo8oMCt7meL5v3bbhyJKesSXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=Gar1ojydfy/PxMdnHHbwmT/41jhmwv5BqwxYZdlzt1r2McZCj+j07u+eqpoB9OdYy23eZp1KG9Ez1twZJCFc2m7OTil4/QLBtmSuVl/l/kCb/ORgsMudILhZ8dK0Ie7p3m71Ww154pcn/nBS2ahZ9okTkwFCqdbO+vPMdm7rAIw=
Received: by 10.66.252.18 with SMTP id z18mr1873653ugh.1179224391619;
        Tue, 15 May 2007 03:19:51 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id k28sm1699431ugd.2007.05.15.03.19.50;
        Tue, 15 May 2007 03:19:50 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4FAOUHN002693;
	Tue, 15 May 2007 12:24:31 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4FAOUaR002692;
	Tue, 15 May 2007 12:24:30 +0200
X-Mailer: git-send-email 1.5.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47334>

Add -l/--long/--size option to git-ls-tree command, which displays
object size of an entry after object id (left-justified with minimum
width of 7 characters).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is to be used in 'tree' view in gitweb, controlled by the
%feature hash.

 Documentation/git-ls-tree.txt |   14 +++++++++++++-
 builtin-ls-tree.c             |   34 ++++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 7899394..367f9bb 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -9,7 +9,7 @@ git-ls-tree - List the contents of a tree object
 SYNOPSIS
 --------
 [verse]
-'git-ls-tree' [-d] [-r] [-t] [-z]
+'git-ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--full-name] [--abbrev=[<n>]]
 	    <tree-ish> [paths...]
 
@@ -36,6 +36,11 @@ OPTIONS
 	Show tree entries even when going to recurse them. Has no effect
 	if '-r' was not passed. '-d' implies '-t'.
 
+-l::
+--long::
+--size::
+	Show object size of entries.
+
 -z::
 	\0 line termination on output.
 
@@ -65,6 +70,13 @@ Output Format
 When the `-z` option is not used, TAB, LF, and backslash characters
 in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
 
+When the `-l` option is used, format changes to
+
+        <mode> SP <type> SP <object> SP <object size> TAB <file>
+
+Object size identified by <objest> is given in bytes, and left-justified
+with minimum width of 7 characters.
+
 
 Author
 ------
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 1cb4dca..0c2eef7 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -15,6 +15,7 @@ static int line_termination = '\n';
 #define LS_TREE_ONLY 2
 #define LS_SHOW_TREES 4
 #define LS_NAME_ONLY 8
+#define LS_SHOW_SIZE 16
 static int abbrev;
 static int ls_options;
 static const char **pathspec;
@@ -22,7 +23,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
+	"git-ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -55,10 +56,11 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 }
 
 static int show_tree(const unsigned char *sha1, const char *base, int baselen,
-		     const char *pathname, unsigned mode, int stage)
+                     const char *pathname, unsigned mode, int stage)
 {
 	int retval = 0;
 	const char *type = blob_type;
+	unsigned long size;
 
 	if (S_ISDIRLNK(mode)) {
 		/*
@@ -92,13 +94,21 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 	    (baselen < chomp_prefix || memcmp(ls_tree_prefix, base, chomp_prefix)))
 		return 0;
 
-	if (!(ls_options & LS_NAME_ONLY))
-		printf("%06o %s %s\t", mode, type,
-				abbrev ? find_unique_abbrev(sha1,abbrev)
-					: sha1_to_hex(sha1));
+	if (!(ls_options & LS_NAME_ONLY)) {
+		if (ls_options & LS_SHOW_SIZE) {
+			sha1_object_info(sha1, &size);
+			printf("%06o %s %s %7lu\t", mode, type,
+			       abbrev ? find_unique_abbrev(sha1, abbrev)
+			              : sha1_to_hex(sha1),
+			       size);
+		} else
+			printf("%06o %s %s\t", mode, type,
+			       abbrev ? find_unique_abbrev(sha1, abbrev)
+			              : sha1_to_hex(sha1));
+	}
 	write_name_quoted(base + chomp_prefix, baselen - chomp_prefix,
-			  pathname,
-			  line_termination, stdout);
+	                  pathname,
+	                  line_termination, stdout);
 	putchar(line_termination);
 	return retval;
 }
@@ -126,12 +136,20 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		case 't':
 			ls_options |= LS_SHOW_TREES;
 			break;
+		case 'l':
+			ls_options |= LS_SHOW_SIZE;
+			break;
 		case '-':
 			if (!strcmp(argv[1]+2, "name-only") ||
 			    !strcmp(argv[1]+2, "name-status")) {
 				ls_options |= LS_NAME_ONLY;
 				break;
 			}
+			if (!strcmp(argv[1]+2, "long") ||
+			    !strcmp(argv[1]+2, "size")) {
+				ls_options |= LS_SHOW_SIZE;
+				break;
+			}
 			if (!strcmp(argv[1]+2, "full-name")) {
 				chomp_prefix = 0;
 				break;
-- 
1.5.1.4
