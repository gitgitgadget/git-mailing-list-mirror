From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] blame: allow "blame file" in the middle of a conflicted
 merge
Date: Tue, 11 Sep 2012 14:44:47 -0700
Message-ID: <7vsjaofd4g.fsf_-_@alter.siamese.dyndns.org>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
 <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
 <7v1uibq8u9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 23:45:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBYGg-0000aq-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 23:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab2IKVow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 17:44:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab2IKVov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 17:44:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 643438AA7;
	Tue, 11 Sep 2012 17:44:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0TkFre0rGTf/Set+pluI0V1QpXI=; b=gECANw
	q6k8spvU4wmE15dO35P2HKoqtmNrRwo0jSAgEyqgYidPiAfs5LD1N/NjAaqPGTzJ
	RJKoyISwHZeqH7/KFXRQUv52rE2rH3ZTXA5v3gUweTiQrBR9XrlWdC3FwRmyB/oi
	keAyFTEY5efvxnWVdoMk69fwX3IoXFRZF+M9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GctBkWCaUIWHMdQXCmInrXYNAK1ltRUz
	HaXzh8C6/K8NoCoL6uBZcflGS21uP38T72dPxCgKPCZOXaO/dljy4/v9g9cugFB+
	HLu+oL61NFqQgcwlRV4n44Cgzj+vuXnJXU7XrzngaMvSwRy/87PjyGIZUAETE6Fv
	8y+R7WdZE1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ED088AA6;
	Tue, 11 Sep 2012 17:44:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 563508AA5; Tue, 11 Sep 2012
 17:44:49 -0400 (EDT)
In-Reply-To: <7v1uibq8u9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 09 Sep 2012 12:45:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E94343A6-FC59-11E1-AEFC-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205267>

"git blame file" has always meant "find the origin of each line of
the file in the history leading to HEAD, oh by the way, blame the
lines that are modified locally to the working tree".

This teaches "git blame" that during a conflicted merge, some
uncommitted changes may have come from the other history that is
being merged.

The verify_working_tree_path() function introduced in the previous
patch to notice a typo in the filename (primarily on case insensitive
filesystems) has been updated to allow a filename that does not exist
in HEAD (i.e. the tip of our history) as long as it exists one of the
commits being merged, so that a "we deleted, the other side modified"
case tracks the history of the file in the history of the other side.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a follow-up to the previous one that is on 'pu'.  I was
   pleasantly surprised that something generally useful came out of
   a patch to squelch corner case confusion that only happens on a
   case insensitive filesystem (iow, a case I do not particularly
   care deeply about ;-).

 builtin/blame.c                 | 93 ++++++++++++++++++++++++++++++-----------
 t/t8004-blame-with-conflicts.sh |  2 +-
 2 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 83683b8..449880e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2044,17 +2044,53 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static void verify_working_tree_path(unsigned char *head_sha1, const char *path)
+static void verify_working_tree_path(struct commit *work_tree, const char *path)
 {
-	unsigned char blob_sha1[20];
-	unsigned mode;
+	struct commit_list *parents;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
-		die("no such ref: HEAD");
-	if (get_tree_entry(head_sha1, path, blob_sha1, &mode))
-		die("no such path '%s' in HEAD", path);
-	if (sha1_object_info(blob_sha1, NULL) != OBJ_BLOB)
-		die("path '%s' in HEAD is not a blob", path);
+	for (parents = work_tree->parents; parents; parents = parents->next) {
+		const unsigned char *commit_sha1 = parents->item->object.sha1;
+		unsigned char blob_sha1[20];
+		unsigned mode;
+
+		if (!get_tree_entry(commit_sha1, path, blob_sha1, &mode) &&
+		    sha1_object_info(blob_sha1, NULL) == OBJ_BLOB)
+			return;
+	}
+	die("no such path '%s' in HEAD", path);
+}
+
+static struct commit_list **append_parent(struct commit_list **tail, const unsigned char *sha1)
+{
+	struct commit *parent;
+
+	parent = lookup_commit_reference(sha1);
+	if (!parent)
+		die("no such commit %s", sha1_to_hex(sha1));
+	return &commit_list_insert(parent, tail)->next;
+}
+
+static void append_merge_parents(struct commit_list **tail)
+{
+	int merge_head;
+	const char *merge_head_file = git_path("MERGE_HEAD");
+	struct strbuf line = STRBUF_INIT;
+
+	merge_head = open(merge_head_file, O_RDONLY);
+	if (merge_head < 0) {
+		if (errno == ENOENT)
+			return;
+		die("cannot open '%s' for reading", merge_head_file);
+	}
+
+	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
+		unsigned char sha1[20];
+		if (line.len < 40 || get_sha1_hex(line.buf, sha1))
+			die("unknown line in '%s': %s", merge_head_file, line.buf);
+		tail = append_parent(tail, sha1);
+	}
+	close(merge_head);
+	strbuf_release(&line);
 }
 
 /*
@@ -2067,6 +2103,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 {
 	struct commit *commit;
 	struct origin *origin;
+	struct commit_list **parent_tail, *parent;
 	unsigned char head_sha1[20];
 	struct strbuf buf = STRBUF_INIT;
 	const char *ident;
@@ -2074,19 +2111,38 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	int size, len;
 	struct cache_entry *ce;
 	unsigned mode;
-
-	verify_working_tree_path(head_sha1, path);
+	struct strbuf msg = STRBUF_INIT;
 
 	time(&now);
 	commit = xcalloc(1, sizeof(*commit));
-	commit->parents = xcalloc(1, sizeof(*commit->parents));
-	commit->parents->item = lookup_commit_reference(head_sha1);
 	commit->object.parsed = 1;
 	commit->date = now;
 	commit->object.type = OBJ_COMMIT;
+	parent_tail = &commit->parents;
+
+	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+		die("no such ref: HEAD");
+
+	parent_tail = append_parent(parent_tail, head_sha1);
+	append_merge_parents(parent_tail);
+	verify_working_tree_path(commit, path);
 
 	origin = make_origin(commit, path);
 
+	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
+	strbuf_addstr(&msg, "tree 0000000000000000000000000000000000000000\n");
+	for (parent = commit->parents; parent; parent = parent->next)
+		strbuf_addf(&msg, "parent %s\n",
+			    sha1_to_hex(parent->item->object.sha1));
+	strbuf_addf(&msg,
+		    "author %s\n"
+		    "committer %s\n\n"
+		    "Version of %s from %s\n",
+		    ident, ident, path,
+		    (!contents_from ? path :
+		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
+	commit->buffer = strbuf_detach(&msg, NULL);
+
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
 		const char *read_from;
@@ -2123,7 +2179,6 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	}
 	else {
 		/* Reading from stdin */
-		contents_from = "standard input";
 		mode = 0;
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
@@ -2167,16 +2222,6 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	 */
 	cache_tree_invalidate_path(active_cache_tree, path);
 
-	commit->buffer = xmalloc(400);
-	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
-	snprintf(commit->buffer, 400,
-		"tree 0000000000000000000000000000000000000000\n"
-		"parent %s\n"
-		"author %s\n"
-		"committer %s\n\n"
-		"Version of %s from %s\n",
-		sha1_to_hex(head_sha1),
-		ident, ident, path, contents_from ? contents_from : path);
 	return commit;
 }
 
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts.sh
index b4a260a..9c353ab 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -67,7 +67,7 @@ test_expect_success \
 '
 
 test_expect_success 'blame does not crash with conflicted file in stages 1,3' '
-	test_must_fail git blame file1
+	git blame file1
 '
 
 test_done
-- 
1.7.12.414.g1a62b7a
