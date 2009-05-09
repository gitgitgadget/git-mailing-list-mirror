From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/10] bisect: use new "struct argv_array" to prepare argv for
	"setup_revisions"
Date: Sat, 09 May 2009 17:55:41 +0200
Message-ID: <20090509155548.5387.51730.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p1k-00065t-TC
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZEIQDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbZEIQDo
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:44 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:36595 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbZEIQDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:40 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id EFC13940124;
	Sat,  9 May 2009 18:03:34 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id AEFD0940130;
	Sat,  9 May 2009 18:03:31 +0200 (CEST)
X-git-sha1: ff3020288ea77d24b6c65ffcde41c586ffc38524 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118664>

Because we will use other instances of this struct.

The "rev_argv_push" function is changed into 2 functions
"argv_array_push" and "argv_array_push_sha1" that take a "struct
argv_array *" as first argument. And these functions are used to
simplify "bisect_rev_setup".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   57 +++++++++++++++++++++++++++++----------------------------
 1 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7976cbf..8e34186 100644
--- a/bisect.c
+++ b/bisect.c
@@ -18,12 +18,16 @@ struct sha1_array {
 static struct sha1_array good_revs;
 static struct sha1_array skipped_revs;
 
-static const char **rev_argv;
-static int rev_argv_nr;
-static int rev_argv_alloc;
-
 static const unsigned char *current_bad_sha1;
 
+struct argv_array {
+	const char **argv;
+	int argv_nr;
+	int argv_alloc;
+};
+
+struct argv_array rev_argv;
+
 static const char *argv_diff_tree[] = {"diff-tree", "--pretty", NULL, NULL};
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
@@ -410,13 +414,19 @@ struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
-static void rev_argv_push(const unsigned char *sha1, const char *format)
+static void argv_array_push(struct argv_array *array, const char *string)
 {
-	struct strbuf buf = STRBUF_INIT;
+	ALLOC_GROW(array->argv, array->argv_nr + 1, array->argv_alloc);
+	array->argv[array->argv_nr++] = string;
+}
 
+static void argv_array_push_sha1(struct argv_array *array,
+				 const unsigned char *sha1,
+				 const char *format)
+{
+	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, format, sha1_to_hex(sha1));
-	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
-	rev_argv[rev_argv_nr++] = strbuf_detach(&buf, NULL);
+	argv_array_push(array, strbuf_detach(&buf, NULL));
 }
 
 static void sha1_array_push(struct sha1_array *array,
@@ -445,7 +455,7 @@ static int read_bisect_refs(void)
 	return for_each_ref_in("refs/bisect/", register_ref, NULL);
 }
 
-void read_bisect_paths(void)
+void read_bisect_paths(struct argv_array *array)
 {
 	struct strbuf str = STRBUF_INIT;
 	const char *filename = git_path("BISECT_NAMES");
@@ -460,8 +470,8 @@ void read_bisect_paths(void)
 
 		strbuf_trim(&str);
 		quoted = strbuf_detach(&str, NULL);
-		res = sq_dequote_to_argv(quoted, &rev_argv,
-					 &rev_argv_nr, &rev_argv_alloc);
+		res = sq_dequote_to_argv(quoted, &array->argv,
+					 &array->argv_nr, &array->argv_alloc);
 		if (res)
 			die("Badly quoted content in file '%s': %s",
 			    filename, quoted);
@@ -538,25 +548,16 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
-	/* argv[0] will be ignored by setup_revisions */
-	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
-	rev_argv[rev_argv_nr++] = xstrdup("bisect_rev_setup");
-
-	rev_argv_push(current_bad_sha1, "%s");
-
+	/* rev_argv.argv[0] will be ignored by setup_revisions */
+	argv_array_push(&rev_argv, xstrdup("bisect_rev_setup"));
+	argv_array_push_sha1(&rev_argv, current_bad_sha1, "%s");
 	for (i = 0; i < good_revs.sha1_nr; i++)
-		rev_argv_push(good_revs.sha1[i], "^%s");
-
-	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
-	rev_argv[rev_argv_nr++] = xstrdup("--");
-
-	read_bisect_paths();
-
-	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
-	rev_argv[rev_argv_nr++] = NULL;
-
-	setup_revisions(rev_argv_nr, rev_argv, revs, NULL);
+		argv_array_push_sha1(&rev_argv, good_revs.sha1[i], "^%s");
+	argv_array_push(&rev_argv, xstrdup("--"));
+	read_bisect_paths(&rev_argv);
+	argv_array_push(&rev_argv, NULL);
 
+	setup_revisions(rev_argv.argv_nr, rev_argv.argv, revs, NULL);
 	revs->limited = 1;
 }
 
-- 
1.6.3.rc1.112.g17e25
