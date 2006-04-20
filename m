From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff --stat: do not drop rename information.
Date: Wed, 19 Apr 2006 20:44:40 -0700
Message-ID: <7vzmig3o7r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 05:44:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWQ69-0007MN-Fd
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 05:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWDTDop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 23:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWDTDop
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 23:44:45 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:33270 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750872AbWDTDoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 23:44:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420034443.HCKM24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 23:44:43 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18956>

When a verbatim rename or copy is detected, we did not show
anything on the "diff --stat" for the filepair.  This makes it
to show the rename information.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * In git.git itself, with and without this patch:

        $ git-diff-tree --stat -M ba580ae
        ba580aeafb52921025de1efe1c50db34393f9907
         Makefile |    2 +-
         1 files changed, 1 insertions(+), 1 deletions(-)

        $ git-diff-tree --stat -M ba580ae
        ba580aeafb52921025de1efe1c50db34393f9907
         Makefile             |    2 +-
         diff.c => diff-lib.c |    0
         2 files changed, 1 insertions(+), 1 deletions(-)

   Since renames are rare, I think this is a good change.  We
   might want to do the same for "apply --stat" as well.

 diff-lib.c |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 81 insertions(+), 17 deletions(-)

9ea8da8f01d7fb2159a81edba9e5e7885e6b616e
diff --git a/diff-lib.c b/diff-lib.c
index 0a832c3..86d1417 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -201,7 +201,8 @@ struct diffstat_t {
 	int nr;
 	int alloc;
 	struct diffstat_file {
-		char *name;
+		char *name_a;
+		char *name_b;
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned int added, deleted;
@@ -209,7 +210,8 @@ struct diffstat_t {
 };
 
 static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
-		const char *name)
+					  char *name_a,
+					  char *name_b)
 {
 	struct diffstat_file *x;
 	x = xcalloc(sizeof (*x), 1);
@@ -219,7 +221,10 @@ static struct diffstat_file *diffstat_ad
 				diffstat->alloc * sizeof(x));
 	}
 	diffstat->files[diffstat->nr++] = x;
-	x->name = strdup(name);
+	x->name_a = strdup(name_a);
+	if (name_b)
+		name_b = strdup(name_b);
+	x->name_b = name_b;
 	return x;
 }
 
@@ -234,6 +239,54 @@ static void diffstat_consume(void *priv,
 		x->deleted++;
 }
 
+static char *find_common_pfx(const char *a, const char *b)
+{
+	const char *old = a;
+	const char *new = b;
+	char *name = NULL;
+	int common_length;
+	int len_a = strlen(a);
+	int len_b = strlen(b);
+
+	/* Find common prefix */
+	while (1) {
+		const char *slash_old, *slash_new;
+		slash_old = strchr(old, '/');
+		slash_new = strchr(new, '/');
+		if (!slash_old ||
+		    !slash_new ||
+		    slash_old - old != slash_new - new ||
+		    memcmp(old, new, slash_new - new))
+			break;
+		old = slash_old + 1;
+		new = slash_new + 1;
+	}
+	/* a thru old is the common prefix, and old and new
+	 * through the end of names are renames.
+	 * Either give
+	 * 	common{suffix-a => suffix-b}
+	 * or
+	 *      name-a => name-b
+	 * whichever is shorter.
+	 */
+	common_length = (old - a);
+	/*
+	  int squashed_len = (len_a + len_b - common_length + 6);
+	  int separate_len = (len_a + len_b) + 4;
+	*/
+	if (common_length < 2) {
+		/* no point squashing */
+		name = xmalloc(len_a + len_b + 5);
+		sprintf(name, "%s => %s", a, b);
+	}
+	else {
+		name = xmalloc(len_a + len_b - common_length + 7);
+		sprintf(name, "%.*s{%s => %s}",
+			common_length, a, old, new);
+	}
+	return name;
+}
+
 static const char pluses[] = "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
 static const char minuses[]= "----------------------------------------------------------------------";
 
@@ -249,8 +302,15 @@ static void show_stats(struct diffstat_t
 
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
-
-		len = strlen(file->name);
+		char *name = file->name_a;
+		if (file->name_b && strcmp(name, file->name_b)) {
+			name = find_common_pfx(name, file->name_b);
+			if (name != file->name_a) {
+				free(file->name_a);
+				file->name_a = name;
+			}
+		}
+		len = strlen(name);
 		if (max_len < len)
 			max_len = len;
 
@@ -261,7 +321,7 @@ static void show_stats(struct diffstat_t
 	}
 
 	for (i = 0; i < data->nr; i++) {
-		char *name = data->files[i]->name;
+		char *name = data->files[i]->name_a;
 		int added = data->files[i]->added;
 		int deleted = data->files[i]->deleted;
 
@@ -269,7 +329,7 @@ static void show_stats(struct diffstat_t
 			char *qname = xmalloc(len + 1);
 			quote_c_style(name, qname, NULL, 0);
 			free(name);
-			data->files[i]->name = name = qname;
+			data->files[i]->name_a = name = qname;
 		}
 
 		/*
@@ -305,6 +365,8 @@ static void show_stats(struct diffstat_t
 			printf(" %s%-*s |  Unmerged\n", prefix, len, name);
 			goto free_diffstat_file;
 		}
+		else if (data->files[i]->name_b)
+			;
 		else if (added + deleted == 0) {
 			total_files--;
 			goto free_diffstat_file;
@@ -325,7 +387,8 @@ static void show_stats(struct diffstat_t
 				len, name, added + deleted,
 				add, pluses, del, minuses);
 	free_diffstat_file:
-		free(data->files[i]->name);
+		free(data->files[i]->name_a);
+		free(data->files[i]->name_b);
 		free(data->files[i]);
 	}
 	free(data->files);
@@ -424,14 +487,15 @@ static void builtin_diff(const char *nam
 	return;
 }
 
-static void builtin_diffstat(const char *name_a, const char *name_b,
-		struct diff_filespec *one, struct diff_filespec *two,
-		struct diffstat_t *diffstat)
+static void builtin_diffstat(char *name_a, char *name_b,
+			     struct diff_filespec *one,
+			     struct diff_filespec *two,
+			     struct diffstat_t *diffstat)
 {
 	mmfile_t mf1, mf2;
 	struct diffstat_file *data;
 
-	data = diffstat_add(diffstat, name_a ? name_a : name_b);
+	data = diffstat_add(diffstat, name_a, name_b);
 
 	if (!one || !two) {
 		data->is_unmerged = 1;
@@ -992,10 +1056,10 @@ static void run_diff(struct diff_filepai
 }
 
 static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
-		struct diffstat_t *diffstat)
+			 struct diffstat_t *diffstat)
 {
-	const char *name;
-	const char *other;
+	char *name;
+	char *other;
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
@@ -1374,7 +1438,7 @@ static void diff_flush_patch(struct diff
 }
 
 static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
-		struct diffstat_t *diffstat)
+			    struct diffstat_t *diffstat)
 {
 	if (diff_unmodified_pair(p))
 		return;
@@ -1559,7 +1623,7 @@ void diff_flush(struct diff_options *opt
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			flush_one_pair(p, DIFF_FORMAT_DIFFSTAT, options,
-					diffstat);
+				       diffstat);
 		}
 		show_stats(diffstat);
 		free(diffstat);
-- 
1.3.0.g6057
