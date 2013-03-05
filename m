From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] push: --follow-tag
Date: Mon, 04 Mar 2013 16:54:39 -0800
Message-ID: <7v6216wtrk.fsf@alter.siamese.dyndns.org>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 01:55:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCg9u-0001G0-I3
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 01:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758930Ab3CEAyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 19:54:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758440Ab3CEAym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 19:54:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BD09A923;
	Mon,  4 Mar 2013 19:54:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QqEkzuQAeVfsakE3Unvdb9+lPwQ=; b=bmYvZ3
	EbHYXdfGrFgSRsqyISptco5gZ8IBk6lAtEXyELrVgkgsEy5W79SjAlcAaiIdLfTt
	3c784Jaxts+JqvkHCKsQMYACeai+aTVYgmim0thVw2OdvXXD6mmrsTySvbi6q2nJ
	48hhQ9dp2+lSZIQ8eGk/ZFwewnaxxruQlnN6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cs+fe4IeIC7dfGKR/7HBolOqXcfOJi9+
	+N94OSEO7dFoaR7Pr0hlMvGatciLuRs19K3uNrkhn9C94lmXJ4oZKdSrYGaWjIWF
	PWVYqjanzXBcd4KWiI+diFfHUe7Y3Dy/qkcQkuzCOJ+EfRjBGM6ddl+LuqB6EEiY
	hnralQcbM/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 513EEA922;
	Mon,  4 Mar 2013 19:54:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 525E5A921; Mon,  4 Mar 2013
 19:54:41 -0500 (EST)
In-Reply-To: <7vd2vewu24.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 04 Mar 2013 16:48:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 434A52B4-852F-11E2-B5B2-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217422>

The new option "--follow-tag" tells "git push" to push tags that are
missing from the other side and that can be reached by the history
that is otherwise pushed out.  For example, if you are using the
"simple", "current", or "upstream" push, you would ordinarily push
the history leading to the commit at your current HEAD and nothing
else.  With this option, you would also push all tags that can be
reached from that commit to the other side.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The previous and this were built on 'maint', and may have
   trivial conflicts with 'master' and upwards.

   This is primarily to scratch my own itch; after tagging an rc or
   final release, I've been doing

   	git push k.org v1.8.2
        git push k.org

   and the first step can easily be forgotten.  With

	git push k.org --follow-tag

   I no longer should have to worry about that.  It will push out
   whatever would be pushed out without --follow-tag, and also tags
   that are missing from my k.org repository that point into the
   history being pushed out.

   I'd certainly need help with phrasing in the documentation, by
   the way.

 Documentation/git-push.txt |  8 +++-
 builtin/push.c             |  2 +
 remote.c                   | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 remote.h                   |  3 +-
 t/t5516-fetch-push.sh      | 73 ++++++++++++++++++++++++++++++++++++
 transport.c                |  2 +
 transport.h                |  1 +
 7 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 8b637d3..5020662 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--follow-tag] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
 	   [<repository> [<refspec>...]]
 
@@ -111,6 +111,12 @@ no `push.default` configuration variable is set.
 	addition to refspecs explicitly listed on the command
 	line.
 
+--follow-tag::
+	Push all the refs that would be pushed without this option,
+	and also push the refs under `refs/tags` that are missing
+	from the remote but are reachable from the refs that would
+	be pushed without this option.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index db9ba30..08e3db1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -399,6 +399,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BIT(0, "prune", &flags, N_("prune locally removed refs"),
 			TRANSPORT_PUSH_PRUNE),
+		OPT_BIT(0, "follow-tag", &flags, N_("push missing but relevant tags"),
+			TRANSPORT_PUSH_FOLLOW_TAG),
 		OPT_END()
 	};
 
diff --git a/remote.c b/remote.c
index ca1f8f2..4441944 100644
--- a/remote.c
+++ b/remote.c
@@ -1195,6 +1195,94 @@ static struct ref **tail_ref(struct ref **head)
 	return tail;
 }
 
+struct tips {
+	struct commit **tip;
+	int nr, alloc;
+};
+
+static void add_to_tips(struct tips *tips, struct ref *ref)
+{
+	struct commit *commit;
+
+	if (is_null_sha1(ref->new_sha1))
+		return;
+	commit = lookup_commit_reference_gently(ref->new_sha1, 1);
+	if (!commit)
+		return; /* not pushing a commit, which is not an error */
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
+	 * Collect everything we are going to send
+	 * and collect all tags they have.
+	 */
+	memset(&sent_tips, 0, sizeof(sent_tips));
+	for (ref = *dst; ref; ref = ref->next) {
+		if (ref->peer_ref &&
+		    !is_null_sha1(ref->peer_ref->new_sha1))
+			add_to_tips(&sent_tips, ref->peer_ref);
+		if (!prefixcmp(ref->name, "refs/tags/"))
+			string_list_append(&dst_tag, ref->name);
+	}
+	sort_string_list(&dst_tag);
+
+	/* Collect tags they do not have. */
+	for (ref = src; ref; ref = ref->next) {
+		if (prefixcmp(ref->name, "refs/tags/"))
+			continue;
+		if (string_list_has_string(&dst_tag, ref->name))
+			continue;
+		item = string_list_append(&src_tag, ref->name);
+		item->util = ref;
+	}
+	string_list_clear(&dst_tag, 0);
+
+	/*
+	 * At this point, src_tag lists tags that are missing from
+	 * dst, and sent_tips lists the tips we are pushing (or those
+	 * that we know they already have). An element in the src_tag
+	 * that is not an ancestor of any of the sent_tips need to be
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
@@ -1257,6 +1345,10 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	free_name:
 		free(dst_name);
 	}
+
+	if (flags & MATCH_REFS_FOLLOW_TAG)
+		add_missing_tags(src, dst, &dst_tail);
+
 	if (send_prune) {
 		/* check for missing refs on the remote */
 		for (ref = *dst; ref; ref = ref->next) {
diff --git a/remote.h b/remote.h
index 251d8fd..950ab5a 100644
--- a/remote.h
+++ b/remote.h
@@ -148,7 +148,8 @@ enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
 	MATCH_REFS_ALL 		= (1 << 0),
 	MATCH_REFS_MIRROR	= (1 << 1),
-	MATCH_REFS_PRUNE	= (1 << 2)
+	MATCH_REFS_PRUNE	= (1 << 2),
+	MATCH_REFS_FOLLOW_TAG	= (1 << 3)
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
index b9306ef..6e2f22d 100644
--- a/transport.c
+++ b/transport.c
@@ -1059,6 +1059,8 @@ int transport_push(struct transport *transport,
 			match_flags |= MATCH_REFS_MIRROR;
 		if (flags & TRANSPORT_PUSH_PRUNE)
 			match_flags |= MATCH_REFS_PRUNE;
+		if (flags & TRANSPORT_PUSH_FOLLOW_TAG)
+			match_flags |= MATCH_REFS_FOLLOW_TAG;
 
 		if (match_push_refs(local_refs, &remote_refs,
 				    refspec_nr, refspec, match_flags)) {
diff --git a/transport.h b/transport.h
index 4a61c0c..bbebfbc 100644
--- a/transport.h
+++ b/transport.h
@@ -104,6 +104,7 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
 #define TRANSPORT_PUSH_PRUNE 128
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
+#define TRANSPORT_PUSH_FOLLOW_TAG 1024
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
1.8.2-rc2-182-g857a7fa
