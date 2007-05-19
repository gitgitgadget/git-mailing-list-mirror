From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v2] Add an option to git-ls-tree to display also the size of blob
Date: Sat, 19 May 2007 22:08:11 +0200
Message-ID: <200705192208.11905.jnareb@gmail.com>
References: <11792246701367-git-send-email-jnareb@gmail.com> <200705160119.10802.jnareb@gmail.com> <7vps51hacw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 01:07:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpY1J-0004Xc-J5
	for gcvg-git@gmane.org; Sun, 20 May 2007 01:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826AbXESXHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 19:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759940AbXESXHZ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 19:07:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62805 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757826AbXESXHX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 19:07:23 -0400
Received: by ug-out-1314.google.com with SMTP id 44so809941uga
        for <git@vger.kernel.org>; Sat, 19 May 2007 16:07:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=Y/Gz0ljmwipqHG/ee36Zx+/n3Jhb6pW/xQNPK4xREPdcFCFeXx7nfaGhrQVUFli5KG8UyljYqDu61kmr2mbFH1g32Kh8eLeyecGzt3SEYtYeMoj1Q4kF2TMBljofNV89jxX3SS/jBqcvGnHQDWTJ33PfCwCYna9lzo3ZXcTA2Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=BGtsQ8JZYVvLD0lkaViWuRvl/TUFhtVJJSTAMWpwa0SEazUFUZWCyoOgXHh8gz5ZA13qmFin2Lb0YMx2hkncdAw6qFndkbK8GUF5Qn1Mvu4beFeIofRwol4mWU4xrs5nOF0szifU/TUyWdZDKC93Fs9+WuR4thmsy46Eo0OYnuU=
Received: by 10.67.93.7 with SMTP id v7mr2177371ugl.1179616041954;
        Sat, 19 May 2007 16:07:21 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e8sm12110510muf.2007.05.19.16.07.19;
        Sat, 19 May 2007 16:07:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vps51hacw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47781>

Add -l/--long option to git-ls-tree command, which displays
object size of a blob entry.  Object size is placed after
object id (left-justified with minimum width of 7 characters).
For non-blob entries `-' is used.

Rationale: for non-blob entries size of an object has no much
meaning, and is not very interesting.  Moreover, in planned
pack v4 tree objects would be constructed on demand, so tree
size would need to be calculated... although isn't object size
stored in the header?

While at it, cleanup whitespace: tabs are for indent, spaces are
for align.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I hope this addresses concerns mentioned in this thread: the
alternate name --size for -l/--long option, and showing size
for tree (and commit/submodule) objects.

 Documentation/git-ls-tree.txt |   14 +++++++++++++-
 builtin-ls-tree.c             |   39 +++++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 7899394..ad7f1b9 100644
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
 
@@ -36,6 +36,10 @@ OPTIONS
 	Show tree entries even when going to recurse them. Has no effect
 	if '-r' was not passed. '-d' implies '-t'.
 
+-l::
+--long::
+	Show object size of blob (file) entries.
+
 -z::
 	\0 line termination on output.
 
@@ -65,6 +69,14 @@ Output Format
 When the `-z` option is not used, TAB, LF, and backslash characters
 in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
 
+When the `-l` option is used, format changes to
+
+        <mode> SP <type> SP <object> SP <object size> TAB <file>
+
+Object size identified by <object> is given in bytes, and right-justified
+with minimum width of 7 characters.  Object size is given only for blobs
+(file) entries; for other entries `-` character is used in place of size.
+
 
 Author
 ------
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 1cb4dca..1d2dc40 100644
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
@@ -92,13 +94,27 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 	    (baselen < chomp_prefix || memcmp(ls_tree_prefix, base, chomp_prefix)))
 		return 0;
 
-	if (!(ls_options & LS_NAME_ONLY))
-		printf("%06o %s %s\t", mode, type,
-				abbrev ? find_unique_abbrev(sha1,abbrev)
-					: sha1_to_hex(sha1));
+	if (!(ls_options & LS_NAME_ONLY)) {
+		if (ls_options & LS_SHOW_SIZE) {
+			if (!strcmp(type, blob_type)) {
+				sha1_object_info(sha1, &size);
+				printf("%06o %s %s %7lu\t", mode, type,
+				       abbrev ? find_unique_abbrev(sha1, abbrev)
+				              : sha1_to_hex(sha1),
+				       size);
+			} else
+				printf("%06o %s %s %7c\t", mode, type,
+				       abbrev ? find_unique_abbrev(sha1, abbrev)
+				              : sha1_to_hex(sha1),
+				       '-');
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
@@ -126,12 +142,19 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
+			if (!strcmp(argv[1]+2, "long")) {
+				ls_options |= LS_SHOW_SIZE;
+				break;
+			}
 			if (!strcmp(argv[1]+2, "full-name")) {
 				chomp_prefix = 0;
 				break;
-- 
1.5.1.4
