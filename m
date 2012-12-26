From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] merge-tree: fix d/f conflicts
Date: Wed, 26 Dec 2012 15:03:40 -0800
Message-ID: <1356563020-13919-6-git-send-email-gitster@pobox.com>
References: <1356563020-13919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 00:04:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To01G-0007FV-6O
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 00:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab2LZXD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 18:03:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab2LZXDx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 18:03:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A3CBA32F
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ghHy
	LghoHChxmhjESj4rHFgUAgk=; b=AtZQkoiPmXgaM3pha6duCpCZul2xx9bdbp0S
	aDQZV1YYDL4nLAADWG6KqayMpeQYzVLFxJlUofvnqdd5e/jKIvN9++kgYopO4tyJ
	SStmicJ0uAIJ7L0ATwQfPORQOFZvp89eqpFuPW2xAhrnSzlHMdprFQ0I34bdaXX5
	7M4llHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=E3iwiF
	/EKDoMVQutDXqnSzBByKadZ6GQeHa4KBQN1O/3H1f2URod5Oj1IE5/rlmzAaGqjZ
	WdA1IyhUiZW2+oBzJjrIe2h2gjOLqwR3sNeDCJBNNlfB8anlVXD/q2HjObYT16xy
	UXI49SsE3q/MarD+XVrETohM81XxTTctoGWFs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB626A32D
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35B76A32C for
 <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:52 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc3.356.g686f81c
In-Reply-To: <1356563020-13919-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8404881A-4FB0-11E2-8D3A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212167>

The previous commit documented two known breakages revolving around
a case where one side flips a tree into a blob (or vice versa),
where the original code simply gets confused and feeds a mixture of
trees and blobs into either the recursive merge-tree (and recursing
into the blob will fail) or three-way merge (and merging tree contents
together with blobs will fail).

Fix it by feeding trees (and only trees) into the recursive
merge-tree machinery and blobs (and only blobs) into the three-way
content level merge machinery separately; when this happens, the
entire merge has to be marked as conflicting at the structure level.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-tree.c  | 72 ++++++++++++++++++++++++++++-----------------------
 t/t4300-merge-tree.sh |  4 +--
 2 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 5704d51..e0d0b7d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -25,7 +25,7 @@ static void add_merge_entry(struct merge_list *entry)
 	merge_result_end = &entry->next;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base);
+static void merge_trees_recursive(struct tree_desc t[3], const char *base, int df_conflict);
 
 static const char *explanation(struct merge_list *entry)
 {
@@ -190,41 +190,35 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
 	add_merge_entry(final);
 }
 
-static int unresolved_directory(const struct traverse_info *info, struct name_entry n[3])
+static void unresolved_directory(const struct traverse_info *info, struct name_entry n[3],
+				 int df_conflict)
 {
 	char *newbase;
 	struct name_entry *p;
 	struct tree_desc t[3];
 	void *buf0, *buf1, *buf2;
 
-	p = n;
-	if (!p->mode) {
-		p++;
-		if (!p->mode)
-			p++;
+	for (p = n; p < n + 3; p++) {
+		if (p->mode && S_ISDIR(p->mode))
+			break;
 	}
-	if (!S_ISDIR(p->mode))
-		return 0;
-	/*
-	 * NEEDSWORK: this is broken. The path can originally be a file
-	 * and then one side may have turned it into a directory, in which
-	 * case we return and let the three-way merge as if the tree were
-	 * a regular file.  If the path that was originally a tree is
-	 * now a file in either branch, fill_tree_descriptor() below will
-	 * die when fed a blob sha1.
-	 */
+	if (n + 3 <= p)
+		return; /* there is no tree here */
 
 	newbase = traverse_path(info, p);
-	buf0 = fill_tree_descriptor(t+0, n[0].sha1);
-	buf1 = fill_tree_descriptor(t+1, n[1].sha1);
-	buf2 = fill_tree_descriptor(t+2, n[2].sha1);
-	merge_trees(t, newbase);
+
+#define ENTRY_SHA1(e) (((e)->mode && S_ISDIR((e)->mode)) ? (e)->sha1 : NULL)
+	buf0 = fill_tree_descriptor(t+0, ENTRY_SHA1(n + 0));
+	buf1 = fill_tree_descriptor(t+1, ENTRY_SHA1(n + 1));
+	buf2 = fill_tree_descriptor(t+2, ENTRY_SHA1(n + 2));
+#undef ENTRY_SHA1
+
+	merge_trees_recursive(t, newbase, df_conflict);
 
 	free(buf0);
 	free(buf1);
 	free(buf2);
 	free(newbase);
-	return 1;
 }
 
 
@@ -247,18 +241,26 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 {
 	struct merge_list *entry = NULL;
+	int i;
+	unsigned dirmask = 0, mask = 0;
+
+	for (i = 0; i < 3; i++) {
+		mask |= (1 << 1);
+		if (n[i].mode && S_ISDIR(n[i].mode))
+			dirmask |= (1 << i);
+	}
+
+	unresolved_directory(info, n, dirmask && (dirmask != mask));
 
-	if (unresolved_directory(info, n))
+	if (dirmask == mask)
 		return;
 
-	/*
-	 * Do them in reverse order so that the resulting link
-	 * list has the stages in order - link_entry adds new
-	 * links at the front.
-	 */
-	entry = link_entry(3, info, n + 2, entry);
-	entry = link_entry(2, info, n + 1, entry);
-	entry = link_entry(1, info, n + 0, entry);
+	if (n[2].mode && !S_ISDIR(n[2].mode))
+		entry = link_entry(3, info, n + 2, entry);
+	if (n[1].mode && !S_ISDIR(n[1].mode))
+		entry = link_entry(2, info, n + 1, entry);
+	if (n[0].mode && !S_ISDIR(n[0].mode))
+		entry = link_entry(1, info, n + 0, entry);
 
 	add_merge_entry(entry);
 }
@@ -329,15 +331,21 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	return mask;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base)
+static void merge_trees_recursive(struct tree_desc t[3], const char *base, int df_conflict)
 {
 	struct traverse_info info;
 
 	setup_traverse_info(&info, base);
+	info.data = &df_conflict;
 	info.fn = threeway_callback;
 	traverse_trees(3, t, &info);
 }
 
+static void merge_trees(struct tree_desc t[3], const char *base)
+{
+	merge_trees_recursive(t, base, 0);
+}
+
 static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
 {
 	unsigned char sha1[20];
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 03e8fca..d0b2a45 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -254,7 +254,7 @@ EXPECTED
 	test_cmp expected actual
 '
 
-test_expect_failure 'turn file to tree' '
+test_expect_success 'turn file to tree' '
 	git reset --hard initial &&
 	rm initial-file &&
 	mkdir initial-file &&
@@ -274,7 +274,7 @@ test_expect_failure 'turn file to tree' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'turn tree to file' '
+test_expect_success 'turn tree to file' '
 	git reset --hard initial &&
 	mkdir dir &&
 	test_commit "add-tree" "dir/path" "AAA" &&
-- 
1.8.1.rc3.356.g686f81c
