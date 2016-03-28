From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/11] rerere: gc and clear
Date: Mon, 28 Mar 2016 15:42:19 -0700
Message-ID: <1459204942-26601-9-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
 <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:43:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfsG-0005OR-8I
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbcC1Wmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:51 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755486AbcC1Wmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D45C4FFC1;
	Mon, 28 Mar 2016 18:42:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hg+I
	Te59GOb6byERQ2dyStFdZq4=; b=AySXrT6oK9pg+Kmwma/V50nQEk+UXFpUzHTQ
	JN7baz8NOi4KT16IiqYaANnMPMj1hcIUD76SItgAxhYtXcbi8mJIEvEb9rDfhNbk
	bHPRJ41Ic50mw103HkbtlFOrexrumATdCU697U8pOUfpKVqCnk9emwJ0bGBDpEiz
	xTMn2oE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fMdlo+
	RjItdWjunmNSGAL3OfPwGbv1jwZDz7yK5ko7gpGqd1oyrlFFneluk+53ok+zAURU
	6JW2/3Rvk2tjCVgF0xd4LPAURPgKwYYEVOxmVaKDA+TWu1FMOZg9kj4AuMX2+xC9
	8L5dIsHmO3LWFXusuokSPUcVMrxqhLs6m2Z1U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 244154FFC0;
	Mon, 28 Mar 2016 18:42:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 845084FFBF;
	Mon, 28 Mar 2016 18:42:37 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5F001BD6-F536-11E5-B279-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290079>

Adjust "git rerere gc" and "git rerere clear" to the new world order
with rerere database with multiple variants for the same shape of
conflicts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * New in v2; a preview appeared on $gmane/288454

 rerere.c          | 87 ++++++++++++++++++++++++++++++-------------------------
 t/t4200-rerere.sh | 82 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 123 insertions(+), 46 deletions(-)

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
index b1bda20..647ea6f 100755
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
 
@@ -441,10 +474,9 @@ test_expect_success 'multiple identical conflicts' '
 	# - six.1 replaces these 7s with 6.1
 	# - six.2 replaces these 7s with 6.2
 
-	test_must_fail git merge six.1 &&
+	merge_conflict_resolve &&
 
 	# Check that rerere knows that file1 and file2 have conflicts
-
 	printf "%s\n" file1 file2 >expect &&
 	git ls-files -u | sed -e "s/^.*	//" | sort -u >actual &&
 	test_cmp expect actual &&
@@ -452,19 +484,43 @@ test_expect_success 'multiple identical conflicts' '
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
@@ -477,7 +533,19 @@ test_expect_success 'multiple identical conflicts' '
 	concat_insert short 6.1 6.2 >file1.expect &&
 	concat_insert long 6.1 6.2 >file2.expect &&
 	test_cmp file1.expect file1 &&
-	test_cmp file2.expect file2
+	test_cmp file2.expect file2 &&
+
+	# Pretend again
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
2.8.0-215-g046a488
