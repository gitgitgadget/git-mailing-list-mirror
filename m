From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-tree: chomp leading directories when run from a subdirectory
Date: Sat, 24 Dec 2005 01:44:59 -0800
Message-ID: <7voe36u8v8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 10:45:13 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq5xd-00037M-88
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 10:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbVLXJpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 04:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbVLXJpE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 04:45:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61142 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422645AbVLXJpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 04:45:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224094307.ZEQS17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 04:43:07 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14012>

When run from a subdirectory, even though we filtered the output
based on where we were using pathspec, we wrote out the
repository relative paths, not subtree relative paths.  This
changes things so that it shows only the current subdirectory
relative paths.

For example, in Documentation subdirectory of git itself, this
used to be the case:

    $ git-ls-tree --name-only HEAD | grep how
    Documentation/git-show-branch.txt
    Documentation/git-show-index.txt
    Documentation/howto-index.sh
    Documentation/howto

But now it does this instead:

    $ git-ls-tree --name-only HEAD | grep how
    git-show-branch.txt
    git-show-index.txt
    howto-index.sh
    howto

There are two things to keep in mind.

1. This shows nothing.

   $ git-ls-tree --name-only HEAD ../ppc/

   This is to make things consistent with ls-files, which
   refuses relative path that goes uplevel.

2. These show things in full repository relative paths.  In this
   case, paths outside the current subdirectory are also shown.

   $ git-ls-tree --name-only --full-name HEAD | grep how
   Documentation/git-show-branch.txt
   Documentation/git-show-index.txt
   Documentation/howto-index.sh
   Documentation/howto

   $ git-ls-tree --name-only --full-name HEAD ../ppc/
   ppc/sha1.c
   ppc/sha1.h
   ppc/sha1ppc.S

The flag --full-name gives the same behaviour as 1.0, so it
ought to be the default if we really care about the backward
compatibility, but in practice no Porcelain runs ls-tree from a
subdirectory yet, and without --full-name is more human
friendly, so hopefully the default being not --full-name would
be acceptable.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This should be the same as what Linus did earlier, only that
   I lost the patch X-<.  My vague recollection says that that
   one did not have --full-name to match what ls-files does,
   though.

   Obviously the "'checkout [--|tree] path' from subdirectory"
   patch needs to pass --full-name to ls-tree if we are going to
   do this.

 ls-tree.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

a69dd585fca9ab7fc4a07f7563f6cdb106e3ffed
diff --git a/ls-tree.c b/ls-tree.c
index dae377d..d585b6f 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -15,9 +15,11 @@ static int line_termination = '\n';
 #define LS_NAME_ONLY 8
 static int ls_options = 0;
 const char **pathspec;
+static int chomp_prefix = 0;
+static const char *prefix;
 
 static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] <tree-ish> [path...]";
+	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] [--full-name] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -49,7 +51,8 @@ static int show_recursive(const char *ba
 	}
 }
 
-static int show_tree(unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
+static int show_tree(unsigned char *sha1, const char *base, int baselen,
+		     const char *pathname, unsigned mode, int stage)
 {
 	int retval = 0;
 	const char *type = "blob";
@@ -65,21 +68,28 @@ static int show_tree(unsigned char *sha1
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
 
+	if (chomp_prefix &&
+	    (baselen < chomp_prefix || memcmp(prefix, base, chomp_prefix)))
+		return 0;
+
 	if (!(ls_options & LS_NAME_ONLY))
 		printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
-	write_name_quoted(base, baselen, pathname, line_termination, stdout);
+	write_name_quoted(base + chomp_prefix, baselen - chomp_prefix,
+			  pathname,
+			  line_termination, stdout);
 	putchar(line_termination);
 	return retval;
 }
 
 int main(int argc, const char **argv)
 {
-	const char *prefix;
 	unsigned char sha1[20];
 	char *buf;
 	unsigned long size;
 
 	prefix = setup_git_directory();
+	if (prefix && *prefix)
+		chomp_prefix = strlen(prefix);
 	while (1 < argc && argv[1][0] == '-') {
 		switch (argv[1][1]) {
 		case 'z':
@@ -100,6 +110,10 @@ int main(int argc, const char **argv)
 				ls_options |= LS_NAME_ONLY;
 				break;
 			}
+			if (!strcmp(argv[1]+2, "full-name")) {
+				chomp_prefix = 0;
+				break;
+			}
 			/* otherwise fallthru */
 		default:
 			usage(ls_tree_usage);
-- 
1.0.GIT
