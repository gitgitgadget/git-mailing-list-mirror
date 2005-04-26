From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add -r flag to show-diff for diff-cache/diff-tree like
 output.
Date: Tue, 26 Apr 2005 15:27:09 -0700
Message-ID: <7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
	<7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:23:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYRf-0002t2-8q
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVDZW1b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVDZW1b
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:27:31 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51665 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261811AbVDZW1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 18:27:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426222710.QDOT19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 18:27:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 25 Apr 2005 18:38:05 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds a new option -r (rational) to show-diff command, to
produce diff-cache/diff-tree compatible output.  When -r is
specified, show-diff simply skips unmerged entries.  This makes
the following thee behave quite similarly: 

    show-diff  -r -z
    diff-cache -r -z [--cached] <tree-or-commit>
    diff-tree  -r -z <tree-or-commit> <tree-or-commit>

When -z (machine readable) is used, it implies rational.  In
addition to terminating each output record with NUL instead of
'\n', machine readable format also may output lines of the form:

    U filename <NUL>

to show that there are unmerged entries, once per path (this is
to help scripts so that they do not have to run "sed | uniq" on
output from "show-files --unmerged", just to get the list of
unmerged files).

The earlier machine readable output format had another form:

    X filename <NUL>

to show deleted files.  This has been removed; these paths now
give the diff-cache compatible "-<mode> <sha1> <path>" output.

I resisted the temptation to change those tabs between columns
into spaces.  Linus, what do you think?  I do not think Cogito
cares and changing them into spaces would certainly make them
more readable by humans.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

show-diff.c |   44 +++++++++++++++++++++++++++++++++-----------
1 files changed, 33 insertions(+), 11 deletions(-)

--- k/show-diff.c
+++ l/show-diff.c
@@ -6,7 +6,8 @@
 #include "cache.h"
 #include "diff.h"
 
-static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";
+static const char *show_diff_usage =
+"show-diff [-q] [-s] [-r] [-z] [paths...]";
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
 {
@@ -23,10 +24,17 @@ static int matches_pathspec(struct cache
 	return 0;
 }
 
+static void show_file(int pfx, struct cache_entry *ce, int NUL_terminate)
+{
+	printf("%c%o\t%s\t%s\t%s%c", pfx, ntohl(ce->ce_mode), "blob",
+	       sha1_to_hex(ce->sha1), ce->name, NUL_terminate ? 0 : '\n');
+}
+
 int main(int argc, char **argv)
 {
 	int silent = 0;
 	int silent_on_nonexisting_files = 0;
+	int rational = 0;
 	int machine_readable = 0;
 	int reverse = 0;
 	int entries = read_cache();
@@ -39,8 +47,12 @@ int main(int argc, char **argv)
 			silent_on_nonexisting_files = silent = 1;
 		else if (!strcmp(argv[1], "-q"))
 			silent_on_nonexisting_files = 1;
+		else if (!strcmp(argv[1], "-r"))
+			/* diff-cache and diff-tree compatible */
+			rational = 1;
 		else if (!strcmp(argv[1], "-z"))
-			machine_readable = 1;
+			/* machine readable implies rational */
+			rational = machine_readable = 1;
 		else
 			usage(show_diff_usage);
 		argv++; argc--;
@@ -64,11 +76,16 @@ int main(int argc, char **argv)
 			continue;
 
 		if (ce_stage(ce)) {
+			/* machine-readble == rational in most cases,
+			 * but rational does not care about unmerged.
+			 * In some cases we want the list of unmerged
+			 * files and running sort -u on show-files -z
+			 * --unmerged for that is a pain.
+			 */
 			if (machine_readable)
 				printf("U %s%c", ce->name, 0);
-			else
-				printf("%s: Unmerged\n",
-				       ce->name);
+			else if (!rational)
+				printf("%s: unmerged\n", ce->name);
 			while (i < entries &&
 			       !strcmp(ce->name, active_cache[i]->name))
 				i++;
@@ -79,8 +96,10 @@ int main(int argc, char **argv)
 		if (stat(ce->name, &st) < 0) {
 			if (errno == ENOENT && silent_on_nonexisting_files)
 				continue;
-			if (machine_readable)
-				printf("X %s%c", ce->name, 0);
+			if (rational) {
+				/* deleted */
+				show_file('-', ce, machine_readable);
+			}
 			else {
 				printf("%s: %s\n", ce->name, strerror(errno));
 				if (errno == ENOENT)
@@ -91,10 +110,13 @@ int main(int argc, char **argv)
 		changed = cache_match_stat(ce, &st);
 		if (!changed)
 			continue;
-		if (!machine_readable)
-			printf("%s: %s\n", ce->name, sha1_to_hex(ce->sha1));
-		else {
-			printf("%s %s%c", sha1_to_hex(ce->sha1), ce->name, 0);
+		if (rational) {
+			static char *no_sha1_hex = 
+				"0000000000000000000000000000000000000000";
+			printf("*%o->%o\t%s\t%s->%s\t%s%c",
+			       ntohl(ce->ce_mode), st.st_mode,
+			       "blob", sha1_to_hex(ce->sha1), no_sha1_hex,
+			       ce->name, (machine_readable ? 0 : '\n'));
 			continue;
 		}
 		if (silent)

