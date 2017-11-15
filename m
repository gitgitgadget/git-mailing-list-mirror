Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4320B201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 22:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758039AbdKOWOU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 17:14:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50796 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753923AbdKOWOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 17:14:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3E79B0EFE;
        Wed, 15 Nov 2017 17:14:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=seWxDoNoPD8bFOR0YzpDXkiQRvM=; b=AQGQkS
        WJkdVWCqJBdB5uXAROSormhHjXqrbbFqPNuvyVVFHcP39nrjPbzJa6Si8vNHvPfx
        5JXIZmKUog/8VLcyUZw6LZb3tRwoXEMONfVBnrqDpPxHtvBsBey3IWzthbA9DuYN
        CCG3MgXusjFZEencLFAfsq+TrdloE8YOoX4eY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dwdj5RSeA7g1fw+C5UX+TRyLbkuO56gN
        LqChS5LQak/nOFAj3O4EGro7Mden5WfVPL+A5E0+91oWiwdXAAiHkK+VOWALOrSa
        1oFO72G2LMxVIsBEB4Yy0BE02lAiJREYwNn6Zm/UZO5nL+32UOZe3e6oDClDgTd5
        9BsMn8492NA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCE14B0EFD;
        Wed, 15 Nov 2017 17:14:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4176FB0EFB;
        Wed, 15 Nov 2017 17:14:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH 3/4] branch: correctly reject refs/heads/{-dash,HEAD}
References: <20171013051132.3973-1-gitster@pobox.com>
        <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
        <0f8166ab-7955-aa78-7d32-0ec80944f007@gmail.com>
        <xmqq375g3nkf.fsf@gitster.mtv.corp.google.com>
        <bb3485d0-71bc-452e-e4b9-8a7d767753a5@gmail.com>
Date:   Thu, 16 Nov 2017 07:14:17 +0900
In-Reply-To: <bb3485d0-71bc-452e-e4b9-8a7d767753a5@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 15 Nov 2017 22:29:38 +0530")
Message-ID: <xmqqpo8jyyti.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52C44886-CA52-11E7-95CD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_check_branch_ref() is the central place where many codepaths
see if a proposed name is suitable for the name of a branch.  It was
designed to allow us to get stricter than the check_refname_format()
check used for refnames in general, and we already use it to reject
a branch whose name begins with a '-'.  The function gets a strbuf
and a string "name", and returns non-zero if the name is not
appropriate as the name for a branch.  When the name is good, it
places the full refname for the branch with the proposed name in the
strbuf before it returns.

However, it turns out that one caller looks at what is in the strbuf
even when the function returns an error.  Make the function populate
the strbuf even when it returns an error.  That way, when "-dash" is
given as name, "refs/heads/-dash" is placed in the strbuf when
returning an error to copy_or_rename_branch(), which notices that
the user is trying to recover with "git branch -m -- -dash dash" to
rename "-dash" to "dash".

While at it, use the same mechanism to also reject "HEAD" as a
branch name.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

    >> Are these two patches follow-up fixes (replacement of 3/3 plus an
    >> extra patch) to jc/branch-name-sanity topic?
    >
    > Yes, that's right.
    >
    >> Thanks for working on these.
    >
    > You're welcome. Please do be sure I haven't broken anything in
    > v2. These patches should cleanly apply on 'next', if they don't let me
    > know.

    OK, so here is a replacement for your replacement, based on an
    additional analysis I did while I was reviewing your changes.
    The final 4/4 is what you sent as [v2 2/2] (which was meant to
    be [v2 4/3]).  I think with these updates, the resulting 4-patch
    series is good for 'next'.

    Thanks again.

 sha1_name.c             | 14 ++++++++++++--
 t/t1430-bad-ref-name.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index c7c5ab376c..67961d6e47 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1332,9 +1332,19 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
 	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
-	if (name[0] == '-')
-		return -1;
+
+	/*
+	 * This splice must be done even if we end up rejecting the
+	 * name; builtin/branch.c::copy_or_rename_branch() still wants
+	 * to see what the name expanded to so that "branch -m" can be
+	 * used as a tool to correct earlier mistakes.
+	 */
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
+
+	if (*name == '-' ||
+	    !strcmp(sb->buf, "refs/heads/HEAD"))
+		return -1;
+
 	return check_refname_format(sb->buf, 0);
 }
 
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index e88349c8a0..c7878a60ed 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -331,4 +331,47 @@ test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
 	grep "fatal: invalid ref format: ~a" err
 '
 
+test_expect_success 'branch rejects HEAD as a branch name' '
+	test_must_fail git branch HEAD HEAD^ &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'checkout -b rejects HEAD as a branch name' '
+	test_must_fail git checkout -B HEAD HEAD^ &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'update-ref can operate on refs/heads/HEAD' '
+	git update-ref refs/heads/HEAD HEAD^ &&
+	git show-ref refs/heads/HEAD &&
+	git update-ref -d refs/heads/HEAD &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'branch -d can remove refs/heads/HEAD' '
+	git update-ref refs/heads/HEAD HEAD^ &&
+	git branch -d HEAD &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'branch -m can rename refs/heads/HEAD' '
+	git update-ref refs/heads/HEAD HEAD^ &&
+	git branch -m HEAD tail &&
+	test_must_fail git show-ref refs/heads/HEAD &&
+	git show-ref refs/heads/tail
+'
+
+test_expect_success 'branch -d can remove refs/heads/-dash' '
+	git update-ref refs/heads/-dash HEAD^ &&
+	git branch -d -- -dash &&
+	test_must_fail git show-ref refs/heads/-dash
+'
+
+test_expect_success 'branch -m can rename refs/heads/-dash' '
+	git update-ref refs/heads/-dash HEAD^ &&
+	git branch -m -- -dash dash &&
+	test_must_fail git show-ref refs/heads/-dash &&
+	git show-ref refs/heads/dash
+'
+
 test_done
-- 
2.15.0-358-g6c105002b3

