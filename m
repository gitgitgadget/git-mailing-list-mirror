Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E1C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 00:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiAVA6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 19:58:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50694 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiAVA6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 19:58:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E90EB186840;
        Fri, 21 Jan 2022 19:58:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AiISK/fgQKye
        sLYtRS9tPW+WmTsJ8dm7Q9tTlAR/YUc=; b=nODiwGHVccxHlsXesSXigZxN6IdT
        JEhBk42NWOsJnJnHKXoAL/XraQHlXYS0kqsWkCcuILsztZ3ffk8MqgYYrnBM6fyH
        1LLadQQ9Np3KJc0rGtrKWmtR/FHYjUWWwusWSVhSKvlwBpTB5wuQOAlIAzCqECO3
        1eH8sDCW5MMLBeQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1A5318683F;
        Fri, 21 Jan 2022 19:58:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B5FA18683E;
        Fri, 21 Jan 2022 19:58:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: [PATCH] checkout: avoid BUG() when hitting a broken repository
References: <YemTGQZ97vAPUPY0@pobox.com>
        <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
        <xmqqlez8d2e6.fsf@gitster.g>
Date:   Fri, 21 Jan 2022 16:58:30 -0800
In-Reply-To: <xmqqlez8d2e6.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        21 Jan 2022 16:45:21 -0800")
Message-ID: <xmqqbl04d1s9.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6ADF81E8-7B1E-11EC-B1D2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, taking the two earlier comments from me together...

I _think_ I was the one who spotted the funny skip_prefix() whose
result was not used, and suggested this unrelated check, during the
review.  Sorry about that.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----

Subject: [PATCH] checkout: avoid BUG() when hitting a broken repository

When 9081a421 (checkout: fix "branch info" memory leaks, 2021-11-16)
cleaned up existing memory leaks, we added an unrelated sanity check
to ensure that a local branch is truly local and not a symref to
elsewhere that dies with BUG() otherwise.  This was misguided in two
ways.  First of all, such a tightening did not belong to a leak-fix
patch.  And the condition it detected was *not* a bug in our program
but a problem in user data, where warning() or die() would have been
more appropriate.

As the condition is not fatal (the result of computing the local
branch name in the code that is involved in the faulty check is only
used as a textual label for the commit), let's revert the code to
the original state, i.e. strip "refs/heads/" to compute the local
branch name if possible, and otherwise leave it NULL.  The consumer
of the information in merge_working_tree() is prepared to see NULL
in there and act accordingly.

cf. https://bugzilla.redhat.com/show_bug.cgi?id=3D2042920

Reported-by: Petr =C5=A0pl=C3=ADchal <psplicha@redhat.com>
Reported-by: Todd Zullinger <tmz@pobox.com>
Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c         |  3 ---
 t/t2018-checkout-branch.sh | 13 +++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 43d0275187..1fb34d537d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1094,9 +1094,6 @@ static int switch_branches(const struct checkout_op=
ts *opts,
 		const char *p;
 		if (skip_prefix(old_branch_info.path, prefix, &p))
 			old_branch_info.name =3D xstrdup(p);
-		else
-			BUG("should be able to skip past '%s' in '%s'!",
-			    prefix, old_branch_info.path);
 	}
=20
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 93be1c0eae..5dda5ad4cb 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -85,6 +85,19 @@ test_expect_success 'setup' '
 	git branch -m branch1
 '
=20
+test_expect_success 'checkout a branch without refs/heads/* prefix' '
+	git clone --no-tags . repo-odd-prefix &&
+	(
+		cd repo-odd-prefix &&
+
+		origin=3D$(git symbolic-ref refs/remotes/origin/HEAD) &&
+		git symbolic-ref refs/heads/a-branch "$origin" &&
+
+		git checkout -f a-branch &&
+		git checkout -f a-branch
+	)
+'
+
 test_expect_success 'checkout -b to a new branch, set to HEAD' '
 	test_when_finished "
 		git checkout branch1 &&
--=20
2.35.0-rc2-150-gc312dde8e9

