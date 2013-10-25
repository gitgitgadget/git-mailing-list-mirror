From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] merge-base: teach "--fork-point" mode
Date: Fri, 25 Oct 2013 14:38:08 -0700
Message-ID: <xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
	<xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
	<526A19CA.9020609@viscovery.net>
	<xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 25 23:38:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZp5M-0002pU-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 23:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab3JYViU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 17:38:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab3JYViT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 17:38:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 371ED4DF51;
	Fri, 25 Oct 2013 21:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zEzbwGsjKS7xav2C0DsRZdYRS3w=; b=Gw0UtA
	e27hz9W3fb1pfR2ZHHQv2Wh5OEEsDnBYSnxIqyFo6zA7f6E9UYfLqAMN2TOnRuBI
	MJZEOQG7kgbtsApvTtBHnmmByW5+ftjnQyHpnGgsV6uSSI+1MU3s51CKCzQ75Z1d
	NE3Cv9Hly0BIyOOVhTT9CYQJNa4tiUH/evVho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JBsxHffMPsN5m/tKkj9zo62sdX1BOFhZ
	63IyQQYLqrSj6oh4VdQpOdFXBGTXZoGlTKqlQV+xG6jKHYincYcJ59rx6Ml41a4y
	HZD9VGiD/vCEc0Z6rzXyGcPg8vV/X2MvJQrTfvdmxnKJmdJNbQetiodVaS26rVvb
	Nta4HqDc2Gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2804A4DF50;
	Fri, 25 Oct 2013 21:38:18 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22EB94DF49;
	Fri, 25 Oct 2013 21:38:17 +0000 (UTC)
In-Reply-To: <xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 25 Oct 2013 09:53:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C270E976-3DBD-11E3-A352-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236716>

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

Teach "git merge-base" a new mode, "--fork-point", to compute
exactly that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > I'll send out a revamped version later today, updating not just the
 > test but the implementation.

 And here is the reroll. The test is back to use "exit 1 from a subshell"
 pattern to notice a breakage in the loop. I also rolled the "we can
 pick one more old commit from the reflog after it got expired"
 change John noticed into the logic.

 It also comes with a documentation update. The option is not called
 --reflog but --fork-point; naming a feature after what it does
 (i.e. it finds the fork point) is a lot more sensible than naming
 it after how it happens to do what it does (i.e. it does so by
 peeking into the reflog).

 Documentation/git-merge-base.txt |  35 ++++++++++++-
 builtin/merge-base.c             | 103 +++++++++++++++++++++++++++++++++++++++
 t/t6010-merge-base.sh            |  27 ++++++++++
 3 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 87842e3..b383766 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git merge-base' [-a|--all] --octopus <commit>...
 'git merge-base' --is-ancestor <commit> <commit>
 'git merge-base' --independent <commit>...
+'git merge-base' --fork-point <ref> [<commit>]
 
 DESCRIPTION
 -----------
@@ -24,8 +25,8 @@ that does not have any better common ancestor is a 'best common
 ancestor', i.e. a 'merge base'.  Note that there can be more than one
 merge base for a pair of commits.
 
-OPERATION MODE
---------------
+OPERATION MODES
+---------------
 
 As the most common special case, specifying only two commits on the
 command line means computing the merge base between the given two commits.
@@ -56,6 +57,11 @@ from linkgit:git-show-branch[1] when used with the `--merge-base` option.
 	and exit with status 0 if true, or with status 1 if not.
 	Errors are signaled by a non-zero status that is not 1.
 
+--fork-point::
+	Given a commit that is derived from possibly an earlier
+	incarnation of a ref, find an appropriate fork-point of the
+	derived history to rebase it on top of an updated base
+	history (see discussion on this mode below).
 
 OPTIONS
 -------
@@ -137,6 +143,31 @@ In modern git, you can say this in a more direct way:
 
 instead.
 
+Discussion on fork-point mode
+-----------------------------
+
+After working on the `topic` branch created with `git checkout -b
+topic origin/master`, the history of remote-tracking branch
+`origin/master` may have been rewound and rebuilt, leading to a
+history of this shape:
+
+			 o---B1
+			/
+	---o---o---B2--o---o---o---B (origin/master)
+		\
+		 B3
+		  \
+		   Derived (topic)
+
+where `origin/master` used to point at commits B3, B2, B1 and now it
+points at B, and your `topic` branch was stated on top of it back
+when `origin/master` was at B3. This mode uses the reflog of
+`origin/master` to finds B3 as the fork point, so that the `topic`
+can be rebased on top of the updated `origin/master` by:
+
+    $ fork_point=$(git merge-base --fork-point origin/master topic)
+    $ git rebase --onto origin/master $fork_point topic
+
 
 See also
 --------
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index d39c910..6a674e7 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,6 +1,9 @@
 #include "builtin.h"
 #include "cache.h"
 #include "commit.h"
+#include "refs.h"
+#include "diff.h"
+#include "revision.h"
 #include "parse-options.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
@@ -27,6 +30,7 @@ static const char * const merge_base_usage[] = {
 	N_("git merge-base [-a|--all] --octopus <commit>..."),
 	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
+	N_("git merge-base --fork-point <ref> [<commit>]"),
 	NULL
 };
 
@@ -85,6 +89,97 @@ static int handle_is_ancestor(int argc, const char **argv)
 		return 1;
 }
 
+struct rev_collect {
+	struct commit **commit;
+	int nr;
+	int alloc;
+	unsigned int initial : 1;
+};
+
+static void add_one_commit(unsigned char *sha1, struct rev_collect *revs)
+{
+	struct commit *commit;
+
+	if (is_null_sha1(sha1))
+		return;
+
+	commit = lookup_commit(sha1);
+	if (!commit ||
+	    (commit->object.flags & TMP_MARK) ||
+	    parse_commit(commit))
+		return;
+
+	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
+	revs->commit[revs->nr++] = commit;
+	commit->object.flags |= TMP_MARK;
+}
+
+static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+				  const char *ident, unsigned long timestamp,
+				  int tz, const char *message, void *cbdata)
+{
+	struct rev_collect *revs = cbdata;
+
+	if (revs->initial) {
+		revs->initial = 0;
+		add_one_commit(osha1, revs);
+	}
+	add_one_commit(nsha1, revs);
+	return 0;
+}
+
+static int handle_fork_point(int argc, const char **argv)
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
+	revs.initial = 1;
+	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
+
+	for (i = 0; i < revs.nr; i++)
+		revs.commit[i]->object.flags &= ~TMP_MARK;
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
@@ -100,6 +195,8 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 			    N_("list revs not reachable from others"), 'r'),
 		OPT_CMDMODE(0, "is-ancestor", &cmdmode,
 			    N_("is the first one ancestor of the other?"), 'a'),
+		OPT_CMDMODE(0, "fork-point", &cmdmode,
+			    N_("find where <commit> forked from reflog of <ref>"), 'f'),
 		OPT_END()
 	};
 
@@ -120,6 +217,12 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	if (cmdmode == 'r' || cmdmode == 'o')
 		return handle_octopus(argc, argv, cmdmode == 'r', show_all);
 
+	if (cmdmode == 'f') {
+		if (argc < 1 || 2 < argc)
+			usage_with_options(merge_base_usage, options);
+		return handle_fork_point(argc, argv);
+	}
+
 	if (argc < 2)
 		usage_with_options(merge_base_usage, options);
 
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index f80bba8..4f09db0 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -230,4 +230,31 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
 	test_cmp expected.sorted actual.sorted
 '
 
+test_expect_success 'using reflog to find the fork point' '
+	git reset --hard &&
+	git checkout -b base $E &&
+
+	(
+		for count in 1 2 3 4 5
+		do
+			git commit --allow-empty -m "Base commit #$count" &&
+			git rev-parse HEAD >expect$count &&
+			git checkout -B derived &&
+			git commit --allow-empty -m "Derived #$count" &&
+			git rev-parse HEAD >derived$count &&
+			git checkout base || exit 1
+		done
+
+		for count in 1 2 3 4 5
+		do
+			git merge-base --fork-point base $(cat derived$count) >actual &&
+			test_cmp expect$count actual || exit 1
+		done
+
+	) &&
+	# check that we correctly default to HEAD
+	git merge-base --fork-point base >actual &&
+	test_cmp expect5 actual
+'
+
 test_done
-- 
1.8.4.1-797-gda615de
