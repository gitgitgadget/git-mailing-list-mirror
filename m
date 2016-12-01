Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D021E1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 17:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbcLAR7N (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 12:59:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51153 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751993AbcLAR7M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 12:59:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C8853895;
        Thu,  1 Dec 2016 12:59:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gov9pcpiEdmCjgZo1RY9NFmtlYw=; b=N8YbfF
        Jac10ZR6akUv5BgqYdnczqKIzWTuvXjAi+ZdP+EmCEEwzjLnys7oezxskSqqnKvk
        pX/yg15vPOGu/em+7pC3Ejr6rvrvAwanbn0FSa0OKTvvhhbFrhvF2UBA5gh1cKHN
        teIHJAYBqCEnEkt2S/7VueIMGXEJZSuPJJ6Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U9TuE6bhrJKzTNK0Ud9XJVzHxrtk/XZl
        j01XTbznUdEd67j7psoTa8cVwTCaXpmFgrEWv5l6rdt0N/WpQkW/pXvtwLoSU2ta
        U3E0m8YYLkGcl1Cl7GBerPHDtiVIIwdJlvVvm4J09InvUpqlGYCEU+aK4Jn2dO5D
        895TeHmR8sA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A4653894;
        Thu,  1 Dec 2016 12:59:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7203253893;
        Thu,  1 Dec 2016 12:59:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "git\@vger.kernel.org" <git@vger.kernel.org>
Cc:     neuling@dakosy.de, Stefan Beller <sbeller@google.com>
Subject: Re* git pull --rebase should use fast forward merge if possible
References: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
        <xmqqd1n0552i.fsf@gitster.mtv.corp.google.com>
        <xmqqtwgb52py.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYS=XWBpEBJsj95FV+j+HLxg=5xqwD73618t7ERYrKUfA@mail.gmail.com>
        <CAPc5daURyXO6-yaOWPhvvdS8Dr5psEEc8MVP4wQJ_AuxyZraRg@mail.gmail.com>
Date:   Thu, 01 Dec 2016 09:59:09 -0800
In-Reply-To: <CAPc5daURyXO6-yaOWPhvvdS8Dr5psEEc8MVP4wQJ_AuxyZraRg@mail.gmail.com>
        (Junio C. Hamano's message of "Wed, 29 Jun 2016 13:43:21 -0700")
Message-ID: <xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC70DC32-B7EF-11E6-9867-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> die_no_merge_candidates() would have triggered, I would imagine.
>
> Note that I won't be applying this without test updates and proper log message,
> so no need to worry about the style yet ;-)

This time with a bit of explanation in the log and a trivial test.

I am no longer sure if this is a good idea myself, though.  The
trivial case the new test covers is not interesting, even though it
may be worth protecting the behaviour with the test.  What's more
interesting to think about is what should happen in various corner
cases.  E.g. what should happen when there are local changes that
would conflict with the fast-forwarding?  what should happen if the
user has rebase.autostash set in such a case?  etc.

-- >8 --
Subject: [PATCH] pull: fast-forward "pull --rebase=true"

"git pull --rebase" always runs "git rebase" after fetching the
commit to serve as the new base, even when the new base is a
descendant of the current HEAD, i.e. we haven't done any work.

In such a case, we can instead fast-forward to the new base without
invoking the rebase process.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c  | 22 ++++++++++++++++++----
 t/t5520-pull.sh | 17 +++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index bf3fd3f9c8..2a41d415b2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -878,10 +878,24 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(*merge_heads.sha1, curr_head);
-	} else if (opt_rebase) {
-		if (merge_heads.nr > 1)
-			die(_("Cannot rebase onto multiple branches."));
+	}
+	if (opt_rebase && merge_heads.nr > 1)
+		die(_("Cannot rebase onto multiple branches."));
+
+	if (opt_rebase) {
+		struct commit_list *list = NULL;
+		struct commit *merge_head, *head;
+
+		head = lookup_commit_reference(orig_head);
+		commit_list_insert(head, &list);
+		merge_head = lookup_commit_reference(merge_heads.sha1[0]);
+		if (is_descendant_of(merge_head, list)) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			return run_merge();
+		}
 		return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
-	} else
+	} else {
 		return run_merge();
+	}
 }
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a0013ee32f..7887b6d97b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -237,6 +237,23 @@ test_expect_success '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success '--rebase fast forward' '
+	git reset --hard before-rebase &&
+	git checkout -b ff &&
+	echo another modification >file &&
+	git commit -m third file &&
+
+	git checkout to-rebase &&
+	git pull --rebase . ff &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse ff)" &&
+
+	# The above only validates the result.  Did we actually bypass rebase?
+	git reflog -1 >reflog.actual &&
+	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
+'
+
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
-- 
2.11.0-192-gbadfaabe38

