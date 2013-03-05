From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] push: --follow-tags
Date: Tue,  5 Mar 2013 14:47:19 -0800
Message-ID: <1362523639-30566-5-git-send-email-gitster@pobox.com>
References: <1362523639-30566-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 23:48:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD0eP-00053O-Jz
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 23:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab3CEWrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 17:47:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052Ab3CEWra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 17:47:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD974AD7A
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AM9Q
	QMXIic5OiwYQrCafnUpE7Bo=; b=uqx233ZQA7wpZ0dy0VKWgu+9BO1OorwBjihV
	+52bzinkYxtEfSUNxlngRXtKSQ1DXjczXNe7t6W9Z+xMKuCyz6Qxh7fdFvYHydGj
	4TAGc90rpWITK/a+ic8jJTwEhoG+fDADXWMZN6DBqeJkP03gpM7nGrmfOfVl71SS
	xM4jdIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=X1Sl4c
	Fkb2y9RRsX3XS0TgQN+kGtRFJetiTcaVLyWk1DVXGXT0dBKMaVXsFzgalD5MYDhi
	9PXVE2Z2u1S1xl+rqYJK9i0/38kOAhMSoqpXw3EeZ1umrS/9LBYr82TD2Qg3/Y2K
	+AMo+nAbDWZg+o1Zq/IiYYZDwp1K4m31tGw7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A04BCAD79
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0250AD69 for
 <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:28 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc2-194-g549a9ef
In-Reply-To: <1362523639-30566-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A8456782-85E6-11E2-A7A8-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217492>

The new option "--follow-tags" tells "git push" to push annotated
tags that are missing from the other side and that can be reached by
the history that is otherwise pushed out.

For example, if you are using the "simple", "current", or "upstream"
push, you would ordinarily push the history leading to the commit at
your current HEAD and nothing else.  With this option, you would
also push all annotated tags that can be reached from that commit to
the other side.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-push.txt |  8 +++-
 builtin/push.c             |  2 +
 remote.c                   | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 remote.h                   |  3 +-
 t/t5516-fetch-push.sh      | 73 ++++++++++++++++++++++++++++++++++
 transport.c                |  2 +
 transport.h                |  1 +
 7 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 8b637d3..40377ba 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
 	   [<repository> [<refspec>...]]
 
@@ -111,6 +111,12 @@ no `push.default` configuration variable is set.
 	addition to refspecs explicitly listed on the command
 	line.
 
+--follow-tags::
+	Push all the refs that would be pushed without this option,
+	and also push annotated tags in `refs/tags` that are missing
+	from the remote but are pointing at committish that are
+	reachable from the refs being pushed.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index db9ba30..34a8271 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -399,6 +399,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BIT(0, "prune", &flags, N_("prune locally removed refs"),
 			TRANSPORT_PUSH_PRUNE),
+		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
+			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_END()
 	};
 
diff --git a/remote.c b/remote.c
index ca1f8f2..f035af3 100644
--- a/remote.c
+++ b/remote.c
@@ -1195,6 +1195,101 @@ static struct ref **tail_ref(struct ref **head)
 	return tail;
 }
 
+struct tips {
+	struct commit **tip;
+	int nr, alloc;
+};
+
+static void add_to_tips(struct tips *tips, const unsigned char *sha1)
+{
+	struct commit *commit;
+
+	if (is_null_sha1(sha1))
+		return;
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (!commit || (commit->object.flags & TMP_MARK))
+		return;
+	commit->object.flags |= TMP_MARK;
+	ALLOC_GROW(tips->tip, tips->nr + 1, tips->alloc);
+	tips->tip[tips->nr++] = commit;
+}
+
+static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***dst_tail)
+{
+	struct string_list dst_tag = STRING_LIST_INIT_NODUP;
+	struct string_list src_tag = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+	struct ref *ref;
+	struct tips sent_tips;
+
+	/*
+	 * Collect everything we know they would have at the end of
+	 * this push, and collect all tags they have.
+	 */
+	memset(&sent_tips, 0, sizeof(sent_tips));
+	for (ref = *dst; ref; ref = ref->next) {
+		if (ref->peer_ref &&
+		    !is_null_sha1(ref->peer_ref->new_sha1))
+			add_to_tips(&sent_tips, ref->peer_ref->new_sha1);
+		else
+			add_to_tips(&sent_tips, ref->old_sha1);
+		if (!prefixcmp(ref->name, "refs/tags/"))
+			string_list_append(&dst_tag, ref->name);
+	}
+	clear_commit_marks_many(sent_tips.nr, sent_tips.tip, TMP_MARK);
+
+	sort_string_list(&dst_tag);
+
+	/* Collect tags they do not have. */
+	for (ref = src; ref; ref = ref->next) {
+		if (prefixcmp(ref->name, "refs/tags/"))
+			continue; /* not a tag */
+		if (string_list_has_string(&dst_tag, ref->name))
+			continue; /* they already have it */
+		if (sha1_object_info(ref->new_sha1, NULL) != OBJ_TAG)
+			continue; /* be conservative */
+		item = string_list_append(&src_tag, ref->name);
+		item->util = ref;
+	}
+	string_list_clear(&dst_tag, 0);
+
+	/*
+	 * At this point, src_tag lists tags that are missing from
+	 * dst, and sent_tips lists the tips we are pushing or those
+	 * that we know they already have. An element in the src_tag
+	 * that is an ancestor of any of the sent_tips needs to be
+	 * sent to the other side.
+	 */
+	if (sent_tips.nr) {
+		for_each_string_list_item(item, &src_tag) {
+			struct ref *ref = item->util;
+			struct ref *dst_ref;
+			struct commit *commit;
+
+			if (is_null_sha1(ref->new_sha1))
+				continue;
+			commit = lookup_commit_reference_gently(ref->new_sha1, 1);
+			if (!commit)
+				/* not pushing a commit, which is not an error */
+				continue;
+
+			/*
+			 * Is this tag, which they do not have, reachable from
+			 * any of the commits we are sending?
+			 */
+			if (!in_merge_bases_many(commit, sent_tips.nr, sent_tips.tip))
+				continue;
+
+			/* Add it in */
+			dst_ref = make_linked_ref(ref->name, dst_tail);
+			hashcpy(dst_ref->new_sha1, ref->new_sha1);
+			dst_ref->peer_ref = copy_ref(ref);
+		}
+	}
+	string_list_clear(&src_tag, 0);
+	free(sent_tips.tip);
+}
+
 /*
  * Given the set of refs the local repository has, the set of refs the
  * remote repository has, and the refspec used for push, determine
@@ -1257,6 +1352,10 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	free_name:
 		free(dst_name);
 	}
+
+	if (flags & MATCH_REFS_FOLLOW_TAGS)
+		add_missing_tags(src, dst, &dst_tail);
+
 	if (send_prune) {
 		/* check for missing refs on the remote */
 		for (ref = *dst; ref; ref = ref->next) {
diff --git a/remote.h b/remote.h
index 251d8fd..a0731f1 100644
--- a/remote.h
+++ b/remote.h
@@ -148,7 +148,8 @@ enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
 	MATCH_REFS_ALL 		= (1 << 0),
 	MATCH_REFS_MIRROR	= (1 << 1),
-	MATCH_REFS_PRUNE	= (1 << 2)
+	MATCH_REFS_PRUNE	= (1 << 2),
+	MATCH_REFS_FOLLOW_TAGS	= (1 << 3)
 };
 
 /* Reporting of tracking info */
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b5417cc..4ff2eb2 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -995,4 +995,77 @@ test_expect_success 'push --prune refspec' '
 	! check_push_result $the_first_commit tmp/foo tmp/bar
 '
 
+test_expect_success 'fetch follows tags by default' '
+	mk_test heads/master &&
+	rm -fr src dst &&
+	git init src &&
+	(
+		cd src &&
+		git pull ../testrepo master &&
+		git tag -m "annotated" tag &&
+		git for-each-ref >tmp1 &&
+		(
+			cat tmp1
+			sed -n "s|refs/heads/master$|refs/remotes/origin/master|p" tmp1
+		) |
+		sort -k 3 >../expect
+	) &&
+	git init dst &&
+	(
+		cd dst &&
+		git remote add origin ../src &&
+		git config branch.master.remote origin &&
+		git config branch.master.merge refs/heads/master &&
+		git pull &&
+		git for-each-ref >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push does not follow tags by default' '
+	mk_test heads/master &&
+	rm -fr src dst &&
+	git init src &&
+	git init --bare dst &&
+	(
+		cd src &&
+		git pull ../testrepo master &&
+		git tag -m "annotated" tag &&
+		git checkout -b another &&
+		git commit --allow-empty -m "future commit" &&
+		git tag -m "future" future &&
+		git checkout master &&
+		git for-each-ref refs/heads/master >../expect &&
+		git push ../dst master
+	) &&
+	(
+		cd dst &&
+		git for-each-ref >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push --follow-tag only pushes relevant tags' '
+	mk_test heads/master &&
+	rm -fr src dst &&
+	git init src &&
+	git init --bare dst &&
+	(
+		cd src &&
+		git pull ../testrepo master &&
+		git tag -m "annotated" tag &&
+		git checkout -b another &&
+		git commit --allow-empty -m "future commit" &&
+		git tag -m "future" future &&
+		git checkout master &&
+		git for-each-ref refs/heads/master refs/tags/tag >../expect
+		git push --follow-tag ../dst master
+	) &&
+	(
+		cd dst &&
+		git for-each-ref >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/transport.c b/transport.c
index b9306ef..9fe4aa3 100644
--- a/transport.c
+++ b/transport.c
@@ -1059,6 +1059,8 @@ int transport_push(struct transport *transport,
 			match_flags |= MATCH_REFS_MIRROR;
 		if (flags & TRANSPORT_PUSH_PRUNE)
 			match_flags |= MATCH_REFS_PRUNE;
+		if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
+			match_flags |= MATCH_REFS_FOLLOW_TAGS;
 
 		if (match_push_refs(local_refs, &remote_refs,
 				    refspec_nr, refspec, match_flags)) {
diff --git a/transport.h b/transport.h
index 4a61c0c..8c493f7 100644
--- a/transport.h
+++ b/transport.h
@@ -104,6 +104,7 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
 #define TRANSPORT_PUSH_PRUNE 128
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
+#define TRANSPORT_PUSH_FOLLOW_TAGS 1024
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
1.8.2-rc2-194-g549a9ef
