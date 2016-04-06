From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/11] rerere: gc and clear
Date: Wed,  6 Apr 2016 16:05:32 -0700
Message-ID: <1459983935-25267-9-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
 <1459983935-25267-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwWb-0008WV-92
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbcDFXGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:06:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752574AbcDFXFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 378DF5373B;
	Wed,  6 Apr 2016 19:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mxGx
	/4vUatOIxMD8q8Bqu+7wdQ0=; b=Gz+KYVCFI+fhH2oblzD+W55pA5OZtKrw+O4t
	7UYxFQlnHH2/M4XUrGm6piehpRm9aw7p1x1jovPbkXrL1yZeOJCNENoaZwuJqd7k
	m7/+CRx/nOan6edctUX6+mk4GqHZzICX/DgelVyEnnvfBmO5nRYYYly20DeDYuYH
	uNx43GU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=h6N+1d
	0eIGk5in5pF//b5ZIqJc62DwGP30CiIVu12vnbNxIW8hyj42tIzz4UksHtsjn2bz
	WKCmZ3kkupVuCUfDx2/eG8enUNfbKxSYxuvjJzHGGQY/z3rX61ebFT0SHLZ4G7+J
	55ayK7eraQmXAN8XgWT4cNbiWfiXeSw7dXL+A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FDE15373A;
	Wed,  6 Apr 2016 19:05:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9072253739;
	Wed,  6 Apr 2016 19:05:50 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459983935-25267-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1B0A6E3C-FC4C-11E5-9D75-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290898>

Adjust "git rerere gc" and "git rerere clear" to the new world order
with rerere database with multiple variants for the same shape of
conflicts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c          | 87 ++++++++++++++++++++++++++++++-------------------------
 t/t4200-rerere.sh | 81 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 123 insertions(+), 45 deletions(-)

diff --git a/rerere.c b/rerere.c
index 353227c..3d4dd33 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1081,29 +1081,16 @@ int rerere_forget(struct pathspec *pathspec)
  * Garbage collection support
  */
 
-/*
- * Note that this is not reentrant but is used only one-at-a-time
- * so it does not matter right now.
- */
-static struct rerere_id *dirname_to_id(const char *name)
-{
-	static struct rerere_id id;
-	id.collection = find_rerere_dir(name);
-	return &id;
-}
-
-static time_t rerere_created_at(const char *dir_name)
+static time_t rerere_created_at(struct rerere_id *id)
 {
 	struct stat st;
-	struct rerere_id *id = dirname_to_id(dir_name);
 
 	return stat(rerere_path(id, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
-static time_t rerere_last_used_at(const char *dir_name)
+static time_t rerere_last_used_at(struct rerere_id *id)
 {
 	struct stat st;
-	struct rerere_id *id = dirname_to_id(dir_name);
 
 	return stat(rerere_path(id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
@@ -1113,15 +1100,28 @@ static time_t rerere_last_used_at(const char *dir_name)
  */
 static void unlink_rr_item(struct rerere_id *id)
 {
-	unlink(rerere_path(id, "thisimage"));
-	unlink(rerere_path(id, "preimage"));
-	unlink(rerere_path(id, "postimage"));
-	/*
-	 * NEEDSWORK: what if this rmdir() fails?  Wouldn't we then
-	 * assume that we already have preimage recorded in
-	 * do_plain_rerere()?
-	 */
-	rmdir(rerere_path(id, NULL));
+	unlink_or_warn(rerere_path(id, "thisimage"));
+	remove_variant(id);
+	id->collection->status[id->variant] = 0;
+}
+
+static void prune_one(struct rerere_id *id, time_t now,
+		      int cutoff_resolve, int cutoff_noresolve)
+{
+	time_t then;
+	int cutoff;
+
+	then = rerere_last_used_at(id);
+	if (then)
+		cutoff = cutoff_resolve;
+	else {
+		then = rerere_created_at(id);
+		if (!then)
+			return;
+		cutoff = cutoff_noresolve;
+	}
+	if (then < now - cutoff * 86400)
+		unlink_rr_item(id);
 }
 
 void rerere_gc(struct string_list *rr)
@@ -1129,8 +1129,8 @@ void rerere_gc(struct string_list *rr)
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
 	struct dirent *e;
-	int i, cutoff;
-	time_t now = time(NULL), then;
+	int i;
+	time_t now = time(NULL);
 	int cutoff_noresolve = 15;
 	int cutoff_resolve = 60;
 
@@ -1142,25 +1142,32 @@ void rerere_gc(struct string_list *rr)
 		die_errno("unable to open rr-cache directory");
 	/* Collect stale conflict IDs ... */
 	while ((e = readdir(dir))) {
+		struct rerere_dir *rr_dir;
+		struct rerere_id id;
+		int now_empty;
+
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
-
-		then = rerere_last_used_at(e->d_name);
-		if (then) {
-			cutoff = cutoff_resolve;
-		} else {
-			then = rerere_created_at(e->d_name);
-			if (!then)
-				continue;
-			cutoff = cutoff_noresolve;
+		rr_dir = find_rerere_dir(e->d_name);
+		if (!rr_dir)
+			continue; /* or should we remove e->d_name? */
+
+		now_empty = 1;
+		for (id.variant = 0, id.collection = rr_dir;
+		     id.variant < id.collection->status_nr;
+		     id.variant++) {
+			prune_one(&id, now, cutoff_resolve, cutoff_noresolve);
+			if (id.collection->status[id.variant])
+				now_empty = 0;
 		}
-		if (then < now - cutoff * 86400)
+		if (now_empty)
 			string_list_append(&to_remove, e->d_name);
 	}
 	closedir(dir);
-	/* ... and then remove them one-by-one */
+
+	/* ... and then remove the empty directories */
 	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(dirname_to_id(to_remove.items[i].string));
+		rmdir(git_path("rr-cache/%s", to_remove.items[i].string));
 	string_list_clear(&to_remove, 0);
 }
 
@@ -1177,8 +1184,10 @@ void rerere_clear(struct string_list *merge_rr)
 
 	for (i = 0; i < merge_rr->nr; i++) {
 		struct rerere_id *id = merge_rr->items[i].util;
-		if (!has_rerere_resolution(id))
+		if (!has_rerere_resolution(id)) {
 			unlink_rr_item(id);
+			rmdir(rerere_path(id, NULL));
+		}
 	}
 	unlink_or_warn(git_path("MERGE_RR"));
 }
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b1bda20..a85fc7d 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -412,6 +412,39 @@ concat_insert () {
 	cat early && printf "%s\n" "$@" && cat late "$last"
 }
 
+count_pre_post () {
+	find .git/rr-cache/ -type f -name "preimage*" >actual &&
+	test_line_count = "$1" actual &&
+	find .git/rr-cache/ -type f -name "postimage*" >actual &&
+	test_line_count = "$2" actual
+}
+
+test_expect_success 'rerere gc' '
+	find .git/rr-cache -type f >original &&
+	xargs test-chmtime -172800 <original &&
+
+	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
+	find .git/rr-cache -type f >actual &&
+	test_cmp original actual &&
+
+	git -c gc.rerereresolved=5 -c gc.rerereunresolved=0 rerere gc &&
+	find .git/rr-cache -type f >actual &&
+	test_cmp original actual &&
+
+	git -c gc.rerereresolved=0 -c gc.rerereunresolved=0 rerere gc &&
+	find .git/rr-cache -type f >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+merge_conflict_resolve () {
+	git reset --hard &&
+	test_must_fail git merge six.1 &&
+	# Resolution is to replace 7 with 6.1 and 6.2 (i.e. take both)
+	concat_insert short 6.1 6.2 >file1 &&
+	concat_insert long 6.1 6.2 >file2
+}
+
 test_expect_success 'multiple identical conflicts' '
 	git reset --hard &&
 
@@ -441,7 +474,7 @@ test_expect_success 'multiple identical conflicts' '
 	# - six.1 replaces these 7s with 6.1
 	# - six.2 replaces these 7s with 6.2
 
-	test_must_fail git merge six.1 &&
+	merge_conflict_resolve &&
 
 	# Check that rerere knows that file1 and file2 have conflicts
 
@@ -452,19 +485,43 @@ test_expect_success 'multiple identical conflicts' '
 	git rerere status | sort >actual &&
 	test_cmp expect actual &&
 
-	# Resolution is to replace 7 with 6.1 and 6.2 (i.e. take both)
-	concat_insert short 6.1 6.2 >file1 &&
-	concat_insert long 6.1 6.2 >file2 &&
-
 	git rerere remaining >actual &&
 	test_cmp expect actual &&
 
+	count_pre_post 2 0 &&
+
+	# Pretend that the conflicts were made quite some time ago
+	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
+
+	# Unresolved entries have not expired yet
+	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
+	count_pre_post 2 0 &&
+
+	# Unresolved entries have expired
+	git -c gc.rerereresolved=5 -c gc.rerereunresolved=1 rerere gc &&
+	count_pre_post 0 0 &&
+
+	# Recreate the conflicted state
+	merge_conflict_resolve &&
+	count_pre_post 2 0 &&
+
+	# Clear it
+	git rerere clear &&
+	count_pre_post 0 0 &&
+
+	# Recreate the conflicted state
+	merge_conflict_resolve &&
+	count_pre_post 2 0 &&
+
 	# We resolved file1 and file2
 	git rerere &&
 	>expect &&
 	git rerere remaining >actual &&
 	test_cmp expect actual &&
 
+	# We must have recorded both of them
+	count_pre_post 2 2 &&
+
 	# Now we should be able to resolve them both
 	git reset --hard &&
 	test_must_fail git merge six.1 &&
@@ -477,7 +534,19 @@ test_expect_success 'multiple identical conflicts' '
 	concat_insert short 6.1 6.2 >file1.expect &&
 	concat_insert long 6.1 6.2 >file2.expect &&
 	test_cmp file1.expect file1 &&
-	test_cmp file2.expect file2
+	test_cmp file2.expect file2 &&
+
+	# Pretend that the resolutions are old again
+	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
+
+	# Resolved entries have not expired yet
+	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
+
+	count_pre_post 2 2 &&
+
+	# Resolved entries have expired
+	git -c gc.rerereresolved=1 -c gc.rerereunresolved=5 rerere gc &&
+	count_pre_post 0 0
 '
 
 test_done
-- 
2.8.1-273-ga2cd0f9
