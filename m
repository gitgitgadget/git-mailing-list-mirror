From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] merge-base: "--reflog" mode finds fork point from reflog entries
Date: Thu, 24 Oct 2013 12:11:24 -0700
Message-ID: <1382641884-14756-3-git-send-email-gitster@pobox.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
 <1382641884-14756-1-git-send-email-gitster@pobox.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 21:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZQK0-0003Uj-Vv
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 21:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111Ab3JXTLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 15:11:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021Ab3JXTLc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 15:11:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24AF24D06A;
	Thu, 24 Oct 2013 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UVU5
	Emqcz73hmMbWtiQg462AraA=; b=NJP5vRrGjbFmItD+QDWxLcEHFh2bocPlZN3x
	znmdeW05LwCWYnKWVNImrGkggpazzFpqlJnr0xJ6g0pHRThtgMQRzRJla2Za96Hf
	2bcC57rhNX6VIfya8aloTnqgnb7jHM2aVx/7Q0Fi6pO9GqMnlOBVLksuUdt+qSgg
	AxAg8p0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	xVLUHwqZZz6NAaxqlaAaESvIPnOiLoTgKki8vlUJfZ+A5fPgtv7zzdRZ7d+z7oyZ
	1oSWsS3R/dQl7+UMC4G/eqMwszdJt8y35zC8qmBDcinr27I/A8c+y0F1Zs/trJ0u
	7QtfPTmy3JRo2UiT+BbLvW8BWLUJW73D5azXKTXOGxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19F854D068;
	Thu, 24 Oct 2013 19:11:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B9D84D05F;
	Thu, 24 Oct 2013 19:11:31 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.1-799-g1c32b8d
In-Reply-To: <1382641884-14756-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 17618A78-3CE0-11E3-8428-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236611>

The "git pull --rebase" command computes the fork point of the
branch being rebased using the reflog entries of the "base" branch
(typically a remote-tracking branch) the branch's work was based on,
in order to cope with the case in which the "base" branch has been
rewound and rebuilt.  For example, if the history looked like this:

                     o---B1
                    /
    ---o---o---B2--o---o---o---Base
            \
	     B3
	      \
	       Derived

where the current tip of the "base" branch is at Base, but earlier
fetch observed that its tip used to be B3 and then B2 and then B1
before getting to the current commit, and the branch being rebased
on top of the latest "base" is based on commit B3, it tries to find
B3 by going through the output of "git rev-list --reflog base" (i.e.
Base, B1, B2, B3) until it finds a commit that is an ancestor of the
current tip "Derived".

Internally, we have get_merge_bases_many() that can compute this
with one-go.  We would want a merge-base between Derived and a
fictitious merge commit that would result by merging all the
historical tips of "base".  When such a commit exist, we should get
a single result, which exactly match one of the reflog entries of
"base".

Teach "git merge-base" a new mode, "--reflog", to compute exactly
that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-base.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t6010-merge-base.sh | 27 ++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index d39c910..7b9bc15 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "commit.h"
+#include "refs.h"
 #include "parse-options.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
@@ -27,6 +28,7 @@ static const char * const merge_base_usage[] = {
 	N_("git merge-base [-a|--all] --octopus <commit>..."),
 	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
+	N_("git merge-base --reflog <ref> [<commit>]"),
 	NULL
 };
 
@@ -85,6 +87,73 @@ static int handle_is_ancestor(int argc, const char **argv)
 		return 1;
 }
 
+struct rev_collect {
+	struct commit **commit;
+	int nr;
+	int alloc;
+};
+
+static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+				  const char *ident, unsigned long timestamp,
+				  int tz, const char *message, void *cbdata_)
+{
+	struct rev_collect *revs = cbdata_;
+	struct commit *commit = lookup_commit(nsha1);
+	if (commit) {
+		ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
+		revs->commit[revs->nr++] = commit;
+	}
+	return 0;
+}
+
+static int handle_reflog(int argc, const char **argv)
+{
+	unsigned char sha1[20];
+	char *refname;
+	const char *commitname;
+	struct rev_collect revs;
+	struct commit *derived;
+	struct commit_list *bases;
+	int i;
+
+	switch (dwim_ref(argv[0], strlen(argv[0]), sha1, &refname)) {
+	case 0:
+		die("No such ref: '%s'", argv[0]);
+	case 1:
+		break; /* good */
+	default:
+		die("Ambiguous refname: '%s'", argv[0]);
+	}
+
+	commitname = (argc == 2) ? argv[1] : "HEAD";
+	if (get_sha1(commitname, sha1))
+		die("Not a valid object name: '%s'", commitname);
+
+	derived = lookup_commit_reference(sha1);
+	memset(&revs, 0, sizeof(revs));
+	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
+
+	bases = get_merge_bases_many(derived, revs.nr, revs.commit, 0);
+
+	/*
+	 * There should be one and only one merge base, when we found
+	 * a common ancestor among reflog entries.
+	 */
+	if (!bases || bases->next)
+		return 1;
+
+	/* And the found one must be one of the reflog entries */
+	for (i = 0; i < revs.nr; i++)
+		if (&bases->item->object == &revs.commit[i]->object)
+			break; /* found */
+	if (revs.nr <= i)
+		return 1; /* not found */
+
+	printf("%s\n", sha1_to_hex(bases->item->object.sha1));
+	free_commit_list(bases);
+	return 0;
+}
+
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
 {
 	struct commit **rev;
@@ -100,6 +169,8 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 			    N_("list revs not reachable from others"), 'r'),
 		OPT_CMDMODE(0, "is-ancestor", &cmdmode,
 			    N_("is the first one ancestor of the other?"), 'a'),
+		OPT_CMDMODE(0, "reflog", &cmdmode,
+			    N_("find where <commit> forked from reflog of <ref>"), 'g'),
 		OPT_END()
 	};
 
@@ -120,6 +191,12 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	if (cmdmode == 'r' || cmdmode == 'o')
 		return handle_octopus(argc, argv, cmdmode == 'r', show_all);
 
+	if (cmdmode == 'g') {
+		if (argc < 1 || 2 < argc)
+			usage_with_options(merge_base_usage, options);
+		return handle_reflog(argc, argv);
+	}
+
 	if (argc < 2)
 		usage_with_options(merge_base_usage, options);
 
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index f80bba8..3a1abee 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -230,4 +230,31 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
 	test_cmp expected.sorted actual.sorted
 '
 
+test_expect_success 'using reflog to find the fork point' '
+	git reset --hard &&
+	git checkout -b base $E &&
+	(
+		for count in 1 2 3 4 5
+		do
+			git commit --allow-empty -m "Base commit #$count" &&
+			git rev-parse HEAD >expect$count &&
+			git checkout -B derived &&
+			git commit --allow-empty -m "Derived #$count" &&
+			git rev-parse HEAD >derived$count &&
+			git checkout base &&
+			count=$(( $count + 1 )) || exit 1
+		done
+
+		for count in 1 2 3 4 5
+		do
+			git merge-base --reflog base $(cat derived$count) >actual &&
+			test_cmp expect$count actual || exit 1
+		done
+
+		# check defaulting to HEAD
+		git merge-base --reflog base >actual &&
+		test_cmp expect5 actual
+	)
+'
+
 test_done
-- 
1.8.4.1-799-g1c32b8d
