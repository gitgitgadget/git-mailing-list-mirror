From: Junio C Hamano <junkio@cox.net>
Subject: Re: speeding up cg-log -u
Date: Sat, 14 May 2005 01:13:16 -0700
Message-ID: <7vhdh6444j.fsf@assigned-by-dhcp.cox.net>
References: <20050514061914.GB14353@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 10:13:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWrmI-0006Ae-1o
	for gcvg-git@gmane.org; Sat, 14 May 2005 10:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVENINf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 04:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVENINf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 04:13:35 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24557 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262704AbVENINX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 04:13:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514081317.DVBX1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 04:13:17 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050514061914.GB14353@tumblerings.org> (Zack Brown's message
 of "Fri, 13 May 2005 23:19:14 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "ZB" == Zack Brown <zbrown@tumblerings.org> writes:

ZB> Would it be faster to handle this on the git side, telling git to only
ZB> retrieve the logs that match the specified query? If feasible, this might
ZB> speed up various web interfaces into git repositories.

Here are two places you can add a simple hook.  Implementation
of author_match() function is left as an exercise for you ;-).
Let us know if you get speed improvements, please.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
$ jit-diff
# - 9: (Anonymous snapshot)
# + (working tree)
--- a/cache.h
+++ b/cache.h
@@ -178,6 +178,7 @@ extern void *read_object_with_reference(
 const char *show_date(unsigned long time, int timezone);
 void parse_date(char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
+int author_match(struct commit *, const char *);
 
 static inline void *xmalloc(int size)
 {
--- a/rev-list.c
+++ b/rev-list.c
@@ -11,6 +11,7 @@ int main(int argc, char **argv)
 	unsigned long max_age = -1;
 	unsigned long min_age = -1;
 	int max_count = -1;
+	const char *author = NULL;
 
 	for (i = 1 ; i < argc; i++) {
 		char *arg = argv[i];
@@ -21,6 +22,8 @@ int main(int argc, char **argv)
 			max_age = atoi(arg + 10);
 		} else if (!strncmp(arg, "--min-age=", 10)) {
 			min_age = atoi(arg + 10);
+		} else if (!strncmp(arg, "--author=", 9)) {
+			author = arg + 9;
 		} else {
 			commit_arg = arg;
 		}
@@ -28,6 +31,7 @@ int main(int argc, char **argv)
 
 	if (!commit_arg || get_sha1(commit_arg, sha1))
 		usage("usage: rev-list [OPTION] commit-id\n"
+		      "  --author=author\n"
 		      "  --max-count=nr\n"
 		      "  --max-age=epoch\n"
 		      "  --min-age=epoch\n");
@@ -44,6 +48,8 @@ int main(int argc, char **argv)
 			continue;
 		if (max_age != -1 && (commit->date < max_age))
 			break;
+		if (!author_match(commit, author))
+			continue;
 		if (max_count != -1 && !max_count--)
 			break;
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
--- a/rev-tree.c
+++ b/rev-tree.c
@@ -64,7 +64,7 @@ void process_commit(unsigned char *sha1)
 }
 
 /*
- * Usage: rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id2>]
+ * Usage: rev-tree [--edges] [--author <author>] [--cache <cache-file>] <commit-id> [<commit-id2>]
  *
  * The cache-file can be quite important for big trees. This is an
  * expensive operation if you have to walk the whole chain of
@@ -75,6 +75,7 @@ int main(int argc, char **argv)
 	int i;
 	int nr = 0;
 	unsigned char sha1[MAX_COMMITS][20];
+	const char *author = NULL; 
 
 	/*
 	 * First - pick up all the revisions we can (both from
@@ -83,6 +84,11 @@ int main(int argc, char **argv)
 	for (i = 1; i < argc ; i++) {
 		char *arg = argv[i];
 
+		if (!strcmp(arg, "--author")) {
+			author = argv[++i];
+			continue;
+		}
+
 		if (!strcmp(arg, "--cache")) {
 			read_cache_file(argv[++i]);
 			continue;
@@ -98,7 +104,7 @@ int main(int argc, char **argv)
 			basemask |= 1<<nr;
 		}
 		if (nr >= MAX_COMMITS || get_sha1(arg, sha1[nr]))
-			usage("rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
+			usage("rev-tree [--edges] [--author <author>] [--cache <cache-file>] <commit-id> [<commit-id>]");
 		process_commit(sha1[nr]);
 		nr++;
 	}
@@ -125,6 +131,9 @@ int main(int argc, char **argv)
 		if (!interesting(commit))
 			continue;
 
+		if (!author_match(commit, author))
+			continue;
+
 		printf("%lu %s:%d", commit->date, sha1_to_hex(obj->sha1), 
 		       obj->flags);
 		p = commit->parents;



