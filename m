Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA552021E
	for <e@80x24.org>; Tue, 15 Nov 2016 20:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933638AbcKOU5Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 15:57:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63682 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752308AbcKOU5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 15:57:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A509A4ECD0;
        Tue, 15 Nov 2016 15:57:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/VXBbinc2oqbYRGB75NhK7SNE40=; b=sZmv2Z
        mwjjmo9YPyUJwVowHnKB1JlAXTWZkELjkxJK/1+p6r4dXuJTFk+l36XrxHpjwu9X
        emstT77zx4gn+jMFUaD4yDaT7nPkLKDcEzP8ki6PlMgIXjtrilj7/2h4zuEoiAui
        XEA1Bz1SsDyg4n8U3bNJ9Q/FRcxErKXkkd9Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d5LBDpbWKJRpjPOtwRH+bUL8aLMJxQw/
        mtTK0o+dfrREVrVZuiQDzO3HMpffSpfHdSkOW6WkZaUUoVWx3dcEHqOK9rlk7r3d
        wrsjVyfOk7AGfMjIp8HLCV67oX2sU9hGhaR/MC07gKtxzM9W7Jy8IG8mU7EmTp5W
        ZGFUdKyN4H8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D3E14ECCF;
        Tue, 15 Nov 2016 15:57:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1557C4ECCE;
        Tue, 15 Nov 2016 15:57:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re* [PATCH v7 00/17] port branch.c to use ref-filter's printing options
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <xmqqbmxgtqxv.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 15 Nov 2016 12:57:20 -0800
In-Reply-To: <xmqqbmxgtqxv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 15 Nov 2016 12:43:08 -0800")
Message-ID: <xmqq7f84tqa7.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A88DFB4-AB76-11E6-8E3E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Something like this needs to go before that step.

This time with a log message and an additional test.  The second
paragraph of the proposed log message is written expecting that this
patch will come before your "branch: use ref-filter printing APIs",
which I think is a good place to avoid breakage in the series.

-- >8 --
Subject: [PATCH] for-each-ref: do not segv with %(HEAD) on an unborn branch

The code to flip between "*" and " " prefixes depending on what
branch is checked out used in --format='%(HEAD)' did not consider
that HEAD may resolve to an unborn branch and dereferenced a NULL.

This will become a lot easier to trigger as the codepath will now be
shared with "git branch [--list]".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ref-filter.c             | 2 +-
 t/t3203-branch-output.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 944671af5a..c71d7360d2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1318,7 +1318,7 @@ static void populate_value(struct ref_array_item *ref)
 
 			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 						  sha1, NULL);
-			if (!strcmp(ref->refname, head))
+			if (head && !strcmp(ref->refname, head))
 				v->s = "*";
 			else
 				v->s = " ";
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d8edaf27e9..1a8dbca8c8 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -37,6 +37,14 @@ test_expect_success 'git branch --list shows local branches' '
 	test_cmp expect actual
 '
 
+test_expect_success 'same, but on an unborn branch' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan naster &&
+	git branch --list >actual &&
+	sed -e "s/\* /  /" expect >expect-unborn &&
+	test_cmp expect-unborn actual
+'
+
 cat >expect <<'EOF'
   branch-one
   branch-two
-- 
2.11.0-rc1-154-gcd2a643dcd

