From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-cache/tree compatible output for show-diff (take 2).
Date: Tue, 26 Apr 2005 16:45:09 -0700
Message-ID: <7vy8b5ksqi.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
	<7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
	<7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
	<7vd5shm94l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:41:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQZgZ-00030f-Cs
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 01:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVDZXqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVDZXqx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:46:53 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:32440 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261850AbVDZXpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 19:45:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426234511.RRPB1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 19:45:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vd5shm94l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 16:05:46 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch changes the output format of the show-diff command to
match that of the diff-cache/tree commands.  One type of record
it can produce that diff-cache/tree do not is of this form:

    U path <record-terminator>

This is emitted once per unmerged path, no matter how many
unmerged stages there are.  The diff-tree-helper program is also
taught about this and warns about such input records.

The -z flag has the same meaning as diff-cache/tree commands;
the output records are terminated with a NUL instead of a '\n'.
Just like diff-cache takes a meaningless -r flag, it also
ignores a -r.

The previous default behaviour of getting patch output can be
obtained by specifying a -p flag.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree-helper.c |   27 ++++++++++++++++---------
show-diff.c        |   57 +++++++++++++++++++++++++++++++++++++----------------
2 files changed, 58 insertions(+), 26 deletions(-)

--- k/diff-tree-helper.c
+++ l/diff-tree-helper.c
@@ -44,6 +44,9 @@ static int parse_oneside_change(const ch
 	return 0;
 }
 
+#define PLEASE_WARN -1
+#define WARNED_OURSELVES -2
+ 
 static int parse_diff_tree_output(const char *buf,
 				  struct diff_spec *old,
 				  struct diff_spec *new,
@@ -52,6 +55,9 @@ static int parse_diff_tree_output(const 
 	int ch;
 
 	switch (*cp++) {
+	case 'U':
+		fprintf(stderr, "warning: unmerged path %s\n", cp+1);
+		return WARNED_OURSELVES;
 	case '+':
 		old->file_valid = 0;
 		return parse_oneside_change(cp, new, path);
@@ -61,7 +67,7 @@ static int parse_diff_tree_output(const 
 	case '*':
 		break;
 	default:
-		return -1;
+		return PLEASE_WARN;
 	}
 	
 	/* This is for '*' entries */
@@ -74,26 +80,26 @@ static int parse_diff_tree_output(const 
 		cp++;
 	}
 	if (strncmp(cp, "->", 2))
-		return -1;
+		return PLEASE_WARN;
 	cp += 2;
 	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
 		new->mode = (new->mode << 3) | (ch - '0');
 		cp++;
 	}
 	if (strncmp(cp, "\tblob\t", 6))
-		return -1;
+		return PLEASE_WARN;
 	cp += 6;
 	if (get_sha1_hex(cp, old->u.sha1))
-		return -1;
+		return PLEASE_WARN;
 	cp += 40;
 	if (strncmp(cp, "->", 2))
-		return -1;
+		return PLEASE_WARN;
 	cp += 2;
 	if (get_sha1_hex(cp, new->u.sha1))
-		return -1;
+		return PLEASE_WARN;
 	cp += 40;
 	if (*cp++ != '\t')
-		return -1;
+		return PLEASE_WARN;
 	strcpy(path, cp);
 	return 0;
 }
@@ -120,13 +126,16 @@ int main(int ac, char **av) {
 	/* the remaining parameters are paths patterns */
 
 	while (1) {
+		int status;
 		struct diff_spec old, new;
 		char path[PATH_MAX];
 		read_line(&sb, stdin, line_termination);
 		if (sb.eof)
 			break;
-		if (parse_diff_tree_output(sb.buf, &old, &new, path)) { 
-			fprintf(stderr, "cannot parse %s\n", sb.buf);
+		status = parse_diff_tree_output(sb.buf, &old, &new, path);
+		if (status) {
+			if (status == PLEASE_WARN)
+				fprintf(stderr, "cannot parse %s\n", sb.buf);
 			continue;
 		}
 		if (1 < ac && !matches_pathspec(path, av+1, ac-1))
--- k/show-diff.c
+++ l/show-diff.c
@@ -6,7 +6,8 @@
 #include "cache.h"
 #include "diff.h"
 
-static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";
+static const char *show_diff_usage =
+"show-diff [-q] [-s] [-r] [-z] [-p] [paths...]";
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
 {
@@ -23,24 +24,40 @@ static int matches_pathspec(struct cache
 	return 0;
 }
 
+static void show_file(int pfx, struct cache_entry *ce, int line_termination)
+{
+	printf("%c%o\t%s\t%s\t%s%c", pfx, ntohl(ce->ce_mode), "blob",
+	       sha1_to_hex(ce->sha1), ce->name, line_termination);
+}
+
 int main(int argc, char **argv)
 {
 	int silent = 0;
 	int silent_on_nonexisting_files = 0;
-	int machine_readable = 0;
+	int patch = 0;
+	int line_termination = '\n';
 	int reverse = 0;
 	int entries = read_cache();
 	int i;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if  (!strcmp(argv[1], "-R"))
-			reverse = 1;
+			patch = reverse = 1; /* works only for patch */
 		else if (!strcmp(argv[1], "-s"))
-			silent_on_nonexisting_files = silent = 1;
+			patch = silent_on_nonexisting_files = silent = 1;
 		else if (!strcmp(argv[1], "-q"))
-			silent_on_nonexisting_files = 1;
+			patch = silent_on_nonexisting_files = 1;
+		else if (!strcmp(argv[1], "-p")) {
+			patch = 1;
+			line_termination = '\n';
+		}
+		else if (!strcmp(argv[1], "-r"))
+			; /* diff-cache and diff-tree compatible
+			   * is the default now.
+			   */
 		else if (!strcmp(argv[1], "-z"))
-			machine_readable = 1;
+			/* makes sense only non-patch */
+			patch = line_termination = 0;
 		else
 			usage(show_diff_usage);
 		argv++; argc--;
@@ -64,11 +81,10 @@ int main(int argc, char **argv)
 			continue;
 
 		if (ce_stage(ce)) {
-			if (machine_readable)
-				printf("U %s%c", ce->name, 0);
+			if (patch)
+				printf("%s: unmerged\n", ce->name);
 			else
-				printf("%s: Unmerged\n",
-				       ce->name);
+				printf("U %s%c", ce->name, line_termination);
 			while (i < entries &&
 			       !strcmp(ce->name, active_cache[i]->name))
 				i++;
@@ -77,26 +93,33 @@ int main(int argc, char **argv)
 		}
  
 		if (stat(ce->name, &st) < 0) {
+			/* deleted */
 			if (errno == ENOENT && silent_on_nonexisting_files)
 				continue;
-			if (machine_readable)
-				printf("X %s%c", ce->name, 0);
-			else {
+			if (patch) {
 				printf("%s: %s\n", ce->name, strerror(errno));
 				if (errno == ENOENT)
 					show_diff_empty(ce, reverse);
 			}
+			else
+				show_file('-', ce, line_termination);
 			continue;
 		}
 		changed = cache_match_stat(ce, &st);
 		if (!changed)
 			continue;
-		if (!machine_readable)
-			printf("%s: %s\n", ce->name, sha1_to_hex(ce->sha1));
-		else {
-			printf("%s %s%c", sha1_to_hex(ce->sha1), ce->name, 0);
+		if (!patch) {
+			static char *no_sha1_hex = 
+				"0000000000000000000000000000000000000000";
+			printf("*%o->%o\t%s\t%s->%s\t%s%c",
+			       ntohl(ce->ce_mode), st.st_mode,
+			       "blob", sha1_to_hex(ce->sha1), no_sha1_hex,
+			       ce->name, line_termination);
 			continue;
 		}
+		else
+			printf("%s %s%c", sha1_to_hex(ce->sha1), ce->name,
+			       line_termination);
 		if (silent)
 			continue;
 

