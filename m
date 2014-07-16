From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use commit_list_count() to count the members of commit_lists
Date: Thu, 17 Jul 2014 01:52:09 +0200
Message-ID: <53C71029.8060709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 01:52:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Yzo-0002Wb-6m
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 01:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbaGPXwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 19:52:20 -0400
Received: from mout.web.de ([212.227.15.3]:53694 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780AbaGPXwT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 19:52:19 -0400
Received: from [192.168.178.27] ([79.250.168.234]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MNtP9-1XDKgm2CnT-007XiV; Thu, 17 Jul 2014 01:52:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:9cdLtYRYtw7e4TyvsDzrhFxMprnONzb+e2hiEtjMdGcqxY4b5fT
 nchoFh/+adD9FkGGjpgxS++XD6Ibrje7AAGv1GfrzQ7T50QdVC8vK/xXUAcdwEF95WMxLPT
 Rp0sIMGO/SBCJBehqabR+K6ayq6GtsxV9MOqJOJoQ2WGRixuURIdxSDtSnA/6wQUaoDm5xT
 pqlr3LNYVQw/IoiURxwCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253718>

Call commit_list_count() instead of open-coding it repeatedly.

Signed-off-by: Rene Scharfe <l.s.r@web.de>

---
 builtin/blame.c        |  5 +----
 builtin/for-each-ref.c | 16 ++--------------
 commit.c               |  7 +------
 line-log.c             | 13 +------------
 pretty.c               |  7 +------
 5 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index c59e702..339a8d0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1371,11 +1371,8 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
 
 static int num_scapegoats(struct rev_info *revs, struct commit *commit)
 {
-	int cnt;
 	struct commit_list *l = first_scapegoat(revs, commit);
-	for (cnt = 0; l; l = l->next)
-		cnt++;
-	return cnt;
+	return commit_list_count(l);
 }
 
 /* Distribute collected unsorted blames to the respected sorted lists
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4135980..47bd624 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -283,18 +283,6 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 	}
 }
 
-static int num_parents(struct commit *commit)
-{
-	struct commit_list *parents;
-	int i;
-
-	for (i = 0, parents = commit->parents;
-	     parents;
-	     parents = parents->next)
-		i++;
-	return i;
-}
-
 /* See grab_values */
 static void grab_commit_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
 {
@@ -315,12 +303,12 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		}
 		if (!strcmp(name, "numparent")) {
 			char *s = xmalloc(40);
-			v->ul = num_parents(commit);
+			v->ul = commit_list_count(commit->parents);
 			sprintf(s, "%lu", v->ul);
 			v->s = s;
 		}
 		else if (!strcmp(name, "parent")) {
-			int num = num_parents(commit);
+			int num = commit_list_count(commit->parents);
 			int i;
 			struct commit_list *parents;
 			char *s = xmalloc(41 * num + 1);
diff --git a/commit.c b/commit.c
index f43970d..e9c40f7 100644
--- a/commit.c
+++ b/commit.c
@@ -987,12 +987,7 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 	}
 
 	/* There are more than one */
-	cnt = 0;
-	list = result;
-	while (list) {
-		list = list->next;
-		cnt++;
-	}
+	cnt = commit_list_count(result);
 	rslt = xcalloc(cnt, sizeof(*rslt));
 	for (list = result, i = 0; list; list = list->next)
 		rslt[i++] = list->item;
diff --git a/line-log.c b/line-log.c
index afcc98d..1008e72 100644
--- a/line-log.c
+++ b/line-log.c
@@ -766,17 +766,6 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 	}
 }
 
-static int count_parents(struct commit *commit)
-{
-	struct commit_list *parents = commit->parents;
-	int count = 0;
-	while (parents) {
-		count++;
-		parents = parents->next;
-	}
-	return count;
-}
-
 static void move_diff_queue(struct diff_queue_struct *dst,
 			    struct diff_queue_struct *src)
 {
@@ -1150,7 +1139,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	struct commit **parents;
 	struct commit_list *p;
 	int i;
-	int nparents = count_parents(commit);
+	int nparents = commit_list_count(commit->parents);
 
 	diffqueues = xmalloc(nparents * sizeof(*diffqueues));
 	cand = xmalloc(nparents * sizeof(*cand));
diff --git a/pretty.c b/pretty.c
index eb676d6..3a1da6f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1554,12 +1554,7 @@ static void pp_header(struct pretty_print_context *pp,
 		}
 
 		if (!parents_shown) {
-			struct commit_list *parent;
-			int num;
-			for (parent = commit->parents, num = 0;
-			     parent;
-			     parent = parent->next, num++)
-				;
+			unsigned num = commit_list_count(commit->parents);
 			/* with enough slop */
 			strbuf_grow(sb, num * 50 + 20);
 			add_merge_info(pp, sb, commit);
-- 
2.0.2
