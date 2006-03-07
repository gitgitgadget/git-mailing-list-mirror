From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] ls-tree: add --abbrev[=<n>] option
Date: Tue, 7 Mar 2006 05:52:02 -0800
Message-ID: <20060307135202.GA17891@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Mar 07 14:52:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGcbm-0005xn-QT
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 14:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWCGNwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 08:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCGNwG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 08:52:06 -0500
Received: from hand.yhbt.net ([66.150.188.102]:13994 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751221AbWCGNwF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 08:52:05 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D02F42DC033;
	Tue,  7 Mar 2006 05:52:02 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  7 Mar 2006 05:52:02 -0800
To: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17335>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 Documentation/git-ls-tree.txt |    9 ++++++++-
 ls-tree.c                     |   19 +++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

24fa229085e3090eea54adbb18e906fed8a63a40
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index b92a8b2..b30b766 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -8,7 +8,9 @@ git-ls-tree - Lists the contents of a tr
 
 SYNOPSIS
 --------
-'git-ls-tree' [-d] [-r] [-t] [-z] [--name-only] [--name-status] <tree-ish> [paths...]
+'git-ls-tree' [-d] [-r] [-t] [-z]
+	[--name-only] [--name-status] [--full-name] [--abbrev=[<n>]]
+	<tree-ish> [paths...]
 
 DESCRIPTION
 -----------
@@ -40,6 +42,11 @@ OPTIONS
 --name-status::
 	List only filenames (instead of the "long" output), one per line.
 
+--abbrev[=<n>]::
+	Instead of showing the full 40-byte hexadecimal object
+	lines, show only handful hexdigits prefix.
+	Non default number of digits can be specified with --abbrev=<n>.
+
 paths::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
diff --git a/ls-tree.c b/ls-tree.c
index d005643..97f09bd 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -13,13 +13,14 @@ static int line_termination = '\n';
 #define LS_TREE_ONLY 2
 #define LS_SHOW_TREES 4
 #define LS_NAME_ONLY 8
+static int abbrev = 0;
 static int ls_options = 0;
 const char **pathspec;
 static int chomp_prefix = 0;
 static const char *prefix;
 
 static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] [--full-name] <tree-ish> [path...]";
+	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -73,7 +74,9 @@ static int show_tree(unsigned char *sha1
 		return 0;
 
 	if (!(ls_options & LS_NAME_ONLY))
-		printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
+		printf("%06o %s %s\t", mode, type,
+				abbrev ? find_unique_abbrev(sha1,abbrev)
+					: sha1_to_hex(sha1));
 	write_name_quoted(base + chomp_prefix, baselen - chomp_prefix,
 			  pathname,
 			  line_termination, stdout);
@@ -113,6 +116,18 @@ int main(int argc, const char **argv)
 				chomp_prefix = 0;
 				break;
 			}
+			if (!strncmp(argv[1]+2, "abbrev=",7)) {
+				abbrev = strtoul(argv[1]+9, NULL, 10);
+				if (abbrev && abbrev < MINIMUM_ABBREV)
+					abbrev = MINIMUM_ABBREV;
+				else if (abbrev > 40)
+					abbrev = 40;
+				break;
+			}
+			if (!strcmp(argv[1]+2, "abbrev")) {
+				abbrev = DEFAULT_ABBREV;
+				break;
+			}
 			/* otherwise fallthru */
 		default:
 			usage(ls_tree_usage);
-- 
1.2.4.g76f4
