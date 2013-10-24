From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] merge-base: "--reflog" mode finds fork point from reflog entries
Date: Thu, 24 Oct 2013 15:21:53 -0700
Message-ID: <xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 25 00:22:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZTI1-0001EN-I9
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 00:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab3JXWV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 18:21:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab3JXWV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 18:21:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D4774D3BC;
	Thu, 24 Oct 2013 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0IizlTR8lm5hUgtpXP+H1f3oBs=; b=vbjvhA
	qlPJtwCy8dD/s4jjcJEadyofisg8luvY9+9KRG9TEddifLeKIEXto33dmkPjy8rE
	TBs3ziHidZTJ28X2BBTAU6xpYOmQpPTp7XPyDRHF2i4Nz3e01/HZ+FQllp1rMzfi
	/7jAVa/ywvZQIUgeHoYnI9gNCgHA/s6WRdbBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eHq8QKIya0Nunk5+cC6SQiYwv/lshCUl
	32Y7sUJufkzs9Zy4jylW1jpyF5SogMOGbHndNEPLu1FsANCricEpld+KSBgbjwcR
	2EuAA64yr0NDtCXDugEtNmtGolkKkQrmsf8Umt1Lx8Yy/LwKqkQPsPjTPYhPxomN
	993ORfEdlG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 208434D3BB;
	Thu, 24 Oct 2013 22:21:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 528C94D3B3;
	Thu, 24 Oct 2013 22:21:55 +0000 (UTC)
In-Reply-To: <xmqqwql2l3ln.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Oct 2013 15:13:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B0A2E0B4-3CFA-11E3-A2EC-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236634>

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

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With updated tests, based on conversation with Eric Sunshine

 builtin/merge-base.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t6010-merge-base.sh | 25 +++++++++++++++++
 2 files changed, 102 insertions(+)

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
index f80bba8..d5e76a6 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -230,4 +230,29 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
 	test_cmp expected.sorted actual.sorted
 '
 
+test_expect_success 'using reflog to find the fork point' '
+	git reset --hard &&
+	git checkout -b base $E &&
+
+	for count in 1 2 3 4 5
+	do
+		git commit --allow-empty -m "Base commit #$count" &&
+		git rev-parse HEAD >expect$count &&
+		git checkout -B derived &&
+		git commit --allow-empty -m "Derived #$count" &&
+		git rev-parse HEAD >derived$count &&
+		git checkout base || break
+	done &&
+
+	for count in 1 2 3 4 5
+	do
+		git merge-base --reflog base $(cat derived$count) >actual &&
+		test_cmp expect$count actual || break
+	done &&
+
+	# check defaulting to HEAD
+	git merge-base --reflog base >actual &&
+	test_cmp expect5 actual
+'
+
 test_done
-- 
1.8.4.1-799-g1c32b8d
