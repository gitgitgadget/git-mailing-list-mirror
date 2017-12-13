Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171AB1F406
	for <e@80x24.org>; Wed, 13 Dec 2017 01:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbdLMBGs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 20:06:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61558 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752872AbdLMBGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 20:06:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20983C5D4E;
        Tue, 12 Dec 2017 20:06:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nb1tnxm7Aa5IvVkD8L6RFKG8OMo=; b=LQnxy9
        zmC6eqHc2+Nuu3hJ+pmAFz1t1RTUr2APPucdjJIRBhhsUJllE8Uc+8hB9aR6TrNq
        RgY5f1wp7Vh8CTgpm8lEZzn4lgKXb7V1issVKnKs/1NBBVNXkQBrCkVojNv+N8jG
        07o86fIrYXjDM5b/N5S5kLMCVGNp+WuS3Go2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ahub9rz848BtCALfoudIQ7ZHt6Plw36j
        xcXSafH4ZvGNT+nwaafgbirFkvVTCsnVWpHmsQgDyZJiv8lCNN+S2k9Rp5pyTbcE
        8dgUMwrB/Y/aNNsdgAkawl8Ab4cuamKzO4vHMIrfqpDdAn/PFd7RpUePG+XfVkkB
        4ujTyta1d3Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18624C5D4D;
        Tue, 12 Dec 2017 20:06:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D76FC5D4C;
        Tue, 12 Dec 2017 20:06:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v4 00/34] Add directory rename detection to git
References: <20171129014237.32570-1-newren@gmail.com>
Date:   Tue, 12 Dec 2017 17:06:45 -0800
In-Reply-To: <20171129014237.32570-1-newren@gmail.com> (Elijah Newren's
        message of "Tue, 28 Nov 2017 17:42:03 -0800")
Message-ID: <xmqqh8svxwpm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3FF12E0-DFA1-11E7-B2A6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This patchset introduces directory rename detection to merge-recursive.

The use of negated form of test_i18ngrep in these patches are all
wrong.  Because the helper must say "even though the string does not
match (does match), the test expects it to match (does not match),
and we know that expectation won't hold simply because we are under
poison build", so negating the result of test_i18ngrep won't work.
Instead, you would tell test_i18ngrep that we do not expect it to
find matching lines.

Even with the attached, test #70 will still fail because you have a
construct that greps in output of test_i18ngrep.  That won't work
under poison build, because the output of test_i18ngrep won't have
the string you are looking for under poison build.

We may probably want to redirect the output of underlying grep to
/dev/null in test_i18ngrep to make this kind of misuse easier to
spot.

 t/t6043-merge-rename-directories.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index f64c7d273b..8f58f08ed2 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -554,7 +554,7 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
 		git rev-parse >expect \
 			O:z/b O:z/c B:x/d &&
 		test_cmp expect actual &&
-		! test_i18ngrep "CONFLICT.*directory rename split" out
+		test_i18ngrep ! "CONFLICT.*directory rename split" out
 	)
 '
 
@@ -705,7 +705,7 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
 		test_cmp expect actual &&
 
 		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
-	! test_i18ngrep CONFLICT.*rename/rename.*y/d
+		test_i18ngrep ! CONFLICT.*rename/rename.*y/d
 	)
 '
 
@@ -3146,7 +3146,7 @@ test_expect_failure '10e-check: Does git complain about untracked file that is n
 		echo random >z/c &&
 
 		git merge -s recursive B^0 >out 2>err &&
-	! test_i18ngrep "following untracked working tree files would be overwritten by merge" err &&
+		test_i18ngrep ! "following untracked working tree files would be overwritten by merge" err &&
 
 		test 3 -eq $(git ls-files -s | wc -l) &&
 		test 0 -eq $(git ls-files -u | wc -l) &&
