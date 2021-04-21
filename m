Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50FAC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E35B61448
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhDUXyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:54:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61969 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhDUXyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:54:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C951DC2EF0;
        Wed, 21 Apr 2021 19:53:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xEFgj8sZ0fEpHFmi+O0TxNctP7U=; b=uXUYlk
        eQqZXff20OLliMO9OwUou7cViLUNIdfTTtMO0yD+LgQ/p/fqDgm9nZfjPH0Guepb
        ekqu8E3n0uXaVDjk37c9LX4mjdcwqbrVwoiYNlueefsHVbkB1BR6EC1X2mVFAI+/
        cSUX+E82E3DHnMLKZS6U8aNYb+zQQ/7qKKvGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nzT20c8NEM5UVhKUcN0CpCXpE2AMtI9v
        CicolABjQ7GIPMW7fheaDA1zOBQXz1U/JXhaa/BWhXDry1cJKUqaqsbn/j38WNiK
        c9mJsDPPe7ylLwn4mjliRwalwyBetNzYUu5+V35FrNeq63S1f0uu53SDDKlsIvsa
        SYwx7g5Ef2Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8231C2EEF;
        Wed, 21 Apr 2021 19:53:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E085CC2EED;
        Wed, 21 Apr 2021 19:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, ross@skydio.com, abe@skydio.com,
        brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: silence errors for success cases
References: <20210421004733.22395-1-jerry@skydio.com>
        <xmqqtuo0z8mc.fsf@gitster.g>
Date:   Wed, 21 Apr 2021 16:53:29 -0700
In-Reply-To: <xmqqtuo0z8mc.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        20 Apr 2021 19:14:51 -0700")
Message-ID: <xmqqwnsvw5xi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5E52EBC-A2FC-11EB-8A0C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jerry Zhang <jerry@skydio.com> writes:
>
>> Certain invocations of "git apply --3way"
>> will print error messages even though git
>> is able to fall back on apply_fragments and
>> apply the patch successfully with a return
>> value of 0. To fix, return early from
>> try_threeway() in the following cases:
>
> I suspect that this is a recent breakage after we swapped the order
> of 3way fallback.  It used to be that we tried the straight
> application first (while suppressing the error messages) and then
> fell back on 3way (while fully exposing the error messages).

The other side of the coin is that we should say, before falling
back to non-3way codepath, that we saw 3way application failed, and
falling back to the straight patch, if we don't say so already with
the recent change, just like we used to say the opposite after seeing
the patch application to fail and then fell back to 3way.

In other words, we may have said, under the verbose mode, that we
are falling back to threeway only after seeing apply-fragments
failed, but if we are doing 3-way first, telling that we are doing
three-way application in try_threeway() function is actively wrong.
The message was there only because try_threeway() was a fallback and
sometimes did not happen even when the user asked to do --3way (hence
deserved a message).  Now we always try 3way first when the user asked,
the extra message should be given only after try_threeway() failed
and should talk about falling back to the straight application.

IOW, a fix something along this line, perhaps, is needed to complete
the "swap the order between 3way and direct application" series we
earlier worked on.


 apply.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git i/apply.c w/apply.c
index 8c5b29809b..6634305e9e 100644
--- i/apply.c
+++ w/apply.c
@@ -3570,7 +3570,7 @@ static int try_threeway(struct apply_state *state,
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to perform 3-way merge."));
 
-	if (state->apply_verbosity > verbosity_silent)
+	if (state->apply_verbosity > verbosity_silent && patch->direct_to_threeway)
 		fprintf(stderr, _("Performing three-way merge...\n"));
 
 	img = strbuf_detach(&buf, &len);
@@ -3637,6 +3637,9 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 		return -1;
 
 	if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
+		if (state->threeway && !patch->direct_to_threeway)
+			fprintf(stderr, _("Falling back to direct application...\n"));
+
 		/* Note: with --reject, apply_fragments() returns 0 */
 		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0)
 			return -1;




