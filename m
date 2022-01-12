Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA52C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbiALSwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:52:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51252 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbiALSvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:51:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE69F159A16;
        Wed, 12 Jan 2022 13:51:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+V77dUwz/5Va5hmbVk9ueyQWf00LilNK6jBhKS
        aD3RM=; b=SqE8CpEKwlLwsat04BvEpcTnxl841SLyZDE7LMi5nnOpbVA7gC6W1r
        Ut1LE27102Go2X0Kk1dGmXskRPp3Cn2MCgHUpNwl0CRrafziMuiJA+F8GiZyjueJ
        2UPiz6avj0GM01sQRO6aLrXOh1/+5BCIJx2m8lJe6Z3Lpi927bwIs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D54BA159A14;
        Wed, 12 Jan 2022 13:51:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5101A159A12;
        Wed, 12 Jan 2022 13:51:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
        <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
        <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
        <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com>
Date:   Wed, 12 Jan 2022 10:51:41 -0800
In-Reply-To: <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com> (Phillip Wood's
        message of "Tue, 11 Jan 2022 18:57:06 +0000")
Message-ID: <xmqqv8yovlc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEBE335C-73D8-11EC-A2CD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm not sure I want to go with your extra changes. I've left some
> comments on them below
>
>> @@ -488,12 +499,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>>  	else if (starts_with(p, "@@ ") ||
>>  		 (hunk == &file_diff->head &&
>>  		  (skip_prefix(p, "deleted file", &deleted)))) {
>> -		if (marker == '-' || marker == '+')
>> -			/*
>> -			 * Should not happen; previous hunk did not end
>> -			 * in a context line? Handle it anyway.
>> -			 */
>> +			hunk->splittable_into++;
>> +		/*
>> +		 * Should not increment "splittable_into";
>> +		 * previous hunk did not end in a context
>> +		 * line? Handle it anyway.
>> +		 */
>> +		complete_file(marker, &hunk->splittable_into);
>>   		ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
>>  			   file_diff->hunk_alloc);
>
> I deliberately left this alone as I think we should probably make this
> BUG() out instead of silently accepting an invalid diff.

As we are reading our own output, I agree that such a data error is
a BUG().

In any case, a helper to see if the file ended without post-context
is one thing, and a helper that specify what happens after we are
done with a single file, before we move on top the next file or
after processing the last file, is another thing.  The latter may be
able to make use of the former, but the latter may want to do more
than that in the future.

As complete_file() is about finalizing the processing we have done
to the current file, it should be used for that purpose, and nothing
else, I think the hunk I see at
https://github.com/git/git/commit/c082176f8c5a1fc1c8b2a93991ca28fd63aae73a
(reproduced below) is simply a nonsense.

Stepping back a bit, though, is this helper really finalizing the
current file, or is it finalizing the current hunk?  If it were the
latter, then its use in the hunk I called "nonsense" above actually
makes perfect sense.  There may not be anything other than finalizing
the last hunk when we see the end of a file right now, so we may not
need to add a finalize_file() helper right now, and when we need to
do something more than finalizing the last hunk, we may need to capture
the distinction by adding one.

diff --git i/add-patch.c w/add-patch.c
index 89ffda32b2..6094290c86 100644
--- i/add-patch.c
+++ w/add-patch.c
@@ -578,8 +578,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			    (int)(eol - (plain->buf + file_diff->head.start)),
 			    plain->buf + file_diff->head.start);
 
-		if ((marker == '-' || marker == '+') && *p == ' ')
-			hunk->splittable_into++;
+		if (*p == ' ')
+			complete_file(marker, &hunk->splittable_into);
 		if (marker && *p != '\\')
 			marker = *p;
 

