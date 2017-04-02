Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA80820966
	for <e@80x24.org>; Sun,  2 Apr 2017 17:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdDBRfh (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 13:35:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56286 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750965AbdDBRfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 13:35:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B5D275B09;
        Sun,  2 Apr 2017 13:35:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=++VextczVlsOvMNe6lnS6xeZgYs=; b=B2Yvnc
        IYh9kicYxdX9YOU07v/8ozjPodGRzgfh5b6AF70j/k1hpWrz+XboNreOx+Z7UhYu
        hi2HNN0wvdRngNO+HAApSGKphGd3l+NXZefHFpfmzIANX/aczYLjBxPu/X3/yedC
        1AYWYKjerMSMJ6/vKBiEQedg4/ho9vL6pwe34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rK8a1hRuw4GahuCnIRzasX6N20QyWrh2
        QFmSD/feIANeUKivhI3RA7GXlq6gbd4jnSnk+Ck1Qf0N0u5ATnZhLVya1tJO+TvX
        0NL5rUqDmFsRim/FFcWS4fScDiCRdeS80zSWcz4E08T5xv0idZLTxKH9Gh1IbLPO
        ru0Gl1x2NBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4301975B08;
        Sun,  2 Apr 2017 13:35:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BE3175B07;
        Sun,  2 Apr 2017 13:35:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in "git am" when the body starts with spaces
References: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
        <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
        <CA+55aFwmNuvh_ABtnd_uxXv5HjEjN-+HMZGh_u1OjOCa4dbpmg@mail.gmail.com>
Date:   Sun, 02 Apr 2017 10:35:32 -0700
In-Reply-To: <CA+55aFwmNuvh_ABtnd_uxXv5HjEjN-+HMZGh_u1OjOCa4dbpmg@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 1 Apr 2017 12:03:44 -0700")
Message-ID: <xmqqinmmsoez.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6D1A79A-17CA-11E7-8167-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Mar 31, 2017 at 5:52 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The continuation logic is oddly complex, and I can't follow the logic.
>> But it is completely broken in how it thinks empty lines are somehow
>> "continuations".
>
> The attached patch seems to work for me. Comments?

We start at header_stage set to 1, keep skipping empty lines while
in that state, and we stay in that state as long as we see in-body
header (or a continuation of the in-body header we saw earlier).  We
get out of this state when we see a blank line after we are done
with the in-body headers.  Once header_stage is set to 0 with a
blank line, we don't do in-body headers (scissors will roll back the
whole thing and irrelevant to the analysis of correctness).

But you found that "keep skipping empty" done unconditionally is
wrong, because we may have already seen an in-body header and are
trying to see if the line is a continuation (in which case
check_inbody_header() would append to the previous) or another
in-body header (in which case again check_inbody_header() would use
it), or something else (in which case check_inbody_header() will
return false, we get out of header_stage=1 state and process this
line as the first line of the log message.  An empty line we see in
this state must trigger "we are no longer taking in-body header"
logic, too.

And that is exactly your patch does.  The change "feels" correct to
me.


>  mailinfo.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index a489d9d0f..68037758f 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -757,8 +757,13 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>  	assert(!mi->filter_stage);
>  
>  	if (mi->header_stage) {
> -		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
> +		if (!line->len || (line->len == 1 && line->buf[0] == '\n')) {
> +			if (mi->inbody_header_accum.len) {
> +				flush_inbody_header_accum(mi);
> +				mi->header_stage = 0;
> +			}
>  			return 0;
> +		}
>  	}
>  
>  	if (mi->use_inbody_headers && mi->header_stage) {
