Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62641F859
	for <e@80x24.org>; Tue,  9 Aug 2016 16:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbcHIQk5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 12:40:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932229AbcHIQkx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 12:40:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 32A8634EF3;
	Tue,  9 Aug 2016 12:40:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Tqw5T4umbdK9xWwz+yo5cSyJZA=; b=F1E5Ji
	VRVLnSB2CfVXjXvC9RVm+6Ng54ycHVHgdhfcEV380wVSiVMYWFlRhNaI80dSEkfZ
	ofyF0IYpaJX993qCZRvZbcfNxZMjCl+t1fymy4/StdOHLbPq1hnxAtJRxdwGuWTG
	T9GCTLke3AcIRhW8RJJ1ivcVxkSlEp7HlipVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nW6HHqNAOEzw7r6DZrHLatU442h9eYI4
	EgNMDYpWM6cRZKIPk5AwZFYieU+eat4wVwe29B/Jiz3Ob91iNT8ctFRNojvN7Sae
	lvSdAvKDF7W3najMcVDMERmNbiLJ2zxAmn6LQbqudL5n1JE6NonEtRUB+t/sB7+n
	C+THO5sFg3E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A50634EF2;
	Tue,  9 Aug 2016 12:40:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5CDD34EF1;
	Tue,  9 Aug 2016 12:40:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com
Subject: Re: [PATCHv3 9/9] submodule--helper: use parallel processor correctly.
References: <20160809040811.21408-1-sbeller@google.com>
	<20160809040811.21408-12-sbeller@google.com>
Date:	Tue, 09 Aug 2016 09:40:49 -0700
In-Reply-To: <20160809040811.21408-12-sbeller@google.com> (Stefan Beller's
	message of "Mon, 8 Aug 2016 21:08:11 -0700")
Message-ID: <xmqq37mddhf2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08A67004-5E50-11E6-ACE1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When implementing the die() in 665b35ecc (2016-06-09, "submodule--helper:
> initial clone learns retry logic"), I considered this condition to be
> a severe condition, which should lead to an immediate abort as we do not
> trust ourselves any more. However the queued messages in `err` are valuable
> so let's not toss them out by immediately dieing, but a graceful return.

I think you'll be rerolling this series at least once (if only to
correct for 6/9), so perhaps split this fix into a preparatory fix
that can go earlier to 'next' and further that the remainder of the
series depend on?

>
> Another thing to note: The error message itself was missleading. A return
> value of 0 doesn't indicate the passed in `ce` is not a submodule any more,
> but just that we do not consider cloning it any more.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index fc14843..3e40f99 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -815,8 +815,12 @@ static int update_clone_get_next_task(struct child_process *child,
>  	if (index < suc->failed_clones_nr) {
>  		int *p;
>  		ce = suc->failed_clones[index];
> -		if (!prepare_to_clone_next_submodule(ce, child, suc, err))
> -			die("BUG: ce was a submodule before?");
> +		if (!prepare_to_clone_next_submodule(ce, child, suc, err)) {
> +			suc->current ++;

s/current /current/;

> +			strbuf_addf(err, "BUG: submodule considered for cloning,"
> +				    "doesn't need cloning any more?\n");
> +			return 0;
> +		}
>  		p = xmalloc(sizeof(*p));
>  		*p = suc->current;
>  		*idx_task_cb = p;
