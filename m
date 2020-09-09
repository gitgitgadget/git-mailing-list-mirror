Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D12C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF5721D6C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h+xFWrzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIISgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:36:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58291 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIISgF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 14:36:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8126F6CC7;
        Wed,  9 Sep 2020 14:36:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M9dqTy/BwnSdB5Evzs6PBYY/SKc=; b=h+xFWr
        zgjIRt+k+YWy0vEN9dzR4fqrgjl4uAdiiVzjAhIhUSZaWtyhOR8o+PILzutCR7Oo
        yrdLL0VsXXG1VAhb3Tr4de9MHdQiD0IHqyovR7QBNQrZkBM/VI39uzPWw2aTVLQs
        75naZSqY84x3qU+iQcHIZDj2BH3fWQhXyy4NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RU03P2vFGJrCVxHCkecQDLywn0glsYdb
        OQ6T+cv0K5dXWBvU999CUiyXz6we6qSMBNARloBC+ZtTkHfaUx7NAAyxBw0ey1+v
        pt07OLpkltppO6h47+Bn4A7vUbZ/wIVdpsgDc/xo1lQuL17XkZfkJomq3q847nVX
        V/68ThR8tn8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D08E2F6CC4;
        Wed,  9 Sep 2020 14:36:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E0F8F6CC2;
        Wed,  9 Sep 2020 14:35:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        dstolee@microsoft.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] blame.c: replace instance of !oidcmp for oideq
References: <20200908211053.807194-1-eantoranz@gmail.com>
        <6b84f112-7e3f-3a78-3766-033fcf494464@gmail.com>
Date:   Wed, 09 Sep 2020 11:35:56 -0700
In-Reply-To: <6b84f112-7e3f-3a78-3766-033fcf494464@gmail.com> (Derrick
        Stolee's message of "Wed, 9 Sep 2020 08:39:56 -0400")
Message-ID: <xmqqmu1yvlv7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D7FE76E-F2CB-11EA-91A0-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/8/2020 5:10 PM, Edmundo Carmona Antoranz wrote:
>> 0906ac2b54b introduced a call to oidcmp() that should be
>> replaced by oideq() (the latter introduced in 14438c4).
>
> Short-OIDs on their own are not enough. Please use the
> format "abbreviated hash (subject, date)" as mentioned
> in my earlier reply:
>
> 0906ac2b (blame: use changed-path Bloom filters, 2020-04-16)
>
> 14438c4 (introduce hasheq() and oideq(), 2018-08-28)
>
> See Documentation/SubmittingPatches [1] for more information
> on this.
>
> [1] https://github.com/git/git/blob/3a238e539bcdfe3f9eb5010fd218640c1b499f7a/Documentation/SubmittingPatches#L144-L165

Thanks for saving me from having to say it ;-)

I've reworded these while queuing.  See below.

Note that I toned "should be replaced" down to "should have been".

I'd consider this kind of change falls into the "Yes, it would have
been better if it were written like so from the beginning, but it is
dubious that it is worth the engineering time and effort to go back
and change it spending reviewers' bandwidth" category.  I'll still
take this patch as it is a contribution from a new contributor,
though (it's like reviewing and queuing microproject---the cost in
such cases is not attributed to code churning alone, but it also
benefits onboarding).

Thanks.

-- >8 --
From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date: Tue, 8 Sep 2020 15:10:53 -0600
Subject: [PATCH] blame.c: replace instance of !oidcmp for oideq

0906ac2b (blame: use changed-path Bloom filters, 2020-04-16)
introduced a call to oidcmp() that should have been oideq(), which
was introduced in 14438c44 (introduce hasheq() and oideq(),
2018-08-28).

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 blame.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blame.c b/blame.c
index da7e28800e..a8abe86ae4 100644
--- a/blame.c
+++ b/blame.c
@@ -1352,8 +1352,8 @@ static struct blame_origin *find_origin(struct repository *r,
 	else {
 		int compute_diff = 1;
 		if (origin->commit->parents &&
-		    !oidcmp(&parent->object.oid,
-			    &origin->commit->parents->item->object.oid))
+		    oideq(&parent->object.oid,
+			  &origin->commit->parents->item->object.oid))
 			compute_diff = maybe_changed_path(r, origin, bd);
 
 		if (compute_diff)
-- 
2.28.0-558-g7a0184fd7b

