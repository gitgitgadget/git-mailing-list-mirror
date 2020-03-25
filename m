Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF08C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B5A206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bx407KTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCYPcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:32:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55911 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgCYPcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:32:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41984BE112;
        Wed, 25 Mar 2020 11:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xgVVWQmhUjolfK29axxUc+XL/dk=; b=bx407K
        TQw+OGRvasQRluUQEKOjf85AwS5VMUCKxW+w+gfzpfLow2myh1X/IuoTFefCTHiL
        ttO1R8wDNwweKDV6Wjg8kqgIJad2c3N/eRfuKHyvZvohDa+kfrOZx57XUpdTenEa
        /0LuLQUKYjFbVeEL+t7T5PnT1pFRvEOOr0lK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1cS+SWbprG3twTW1QHkIQ1dnWMINHqc
        cZcdpv5oCiAZ2dByq1vgl8UrKQBMvF9mIjY26dgz7v0sUj4vfV9gPpikPvOaEvnU
        DptYB5A4Jgd1K9KNMkmAQ9H9dmEbGFjYUWupLTHCamI897O9EcnihxGOLdTrIiLv
        SjPxDq4fGKs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3933BBE111;
        Wed, 25 Mar 2020 11:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B557BE110;
        Wed, 25 Mar 2020 11:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 3/3] transport-helper: enforce atomic in push_refs_with_push
References: <20200322131815.11872-3-worldhello.net@gmail.com>
        <20200325143608.45141-4-zhiyou.jx@alibaba-inc.com>
Date:   Wed, 25 Mar 2020 08:32:13 -0700
In-Reply-To: <20200325143608.45141-4-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Wed, 25 Mar 2020 22:36:08 +0800")
Message-ID: <xmqq1rpgxxfm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE260530-6EAD-11EA-B48C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/transport-helper.c b/transport-helper.c
> index 20a7185ec4..ab3b52eb14 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -894,6 +894,21 @@ static int push_refs_with_push(struct transport *transport,
>  		case REF_STATUS_REJECT_STALE:
>  		case REF_STATUS_REJECT_ALREADY_EXISTS:
>  			if (atomic) {
> +				/* Mark other refs as failed */
> +				for (ref = remote_refs; ref; ref = ref->next) {
> +					if (!ref->peer_ref && !mirror)
> +						continue;
> +
> +					switch (ref->status) {
> +					case REF_STATUS_NONE:
> +					case REF_STATUS_OK:
> +					case REF_STATUS_EXPECTING_REPORT:
> +						ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> +						continue;
> +					default:
> +						break; /* do nothing */
> +					}
> +				}

OK, so this is more in line with the check done in send_pack() that
fails the push before we even send any pack data.  I wonder if it is
worth considering to move the logic of this loop into a helper
function so that this and the other one in 2/3 can call it and stay
in sync, something along the lines of

	void reject_push_to_other_refs(struct ref *ref, int mirror_mode)
	{
		for (; ref; ref = ref->next) {
			... one iteration of the above loop ...
		}
	}

Then the above part would become

		case REF_STATUS_REJECT_FOO:
			if (atomic)
				reject_push_to_other_refs(remote_refs, mirror);

and the part modified by 2/3 would also become

	static int atomic_push_failure(...)
	{
		reject_push_to_other_refs(remote_refs, args->send_mirror);
		return error("atomic push failed ...");
	}

I am not sure if it is better to keep 2/3 and 3/3 separate or make
them into a single step, but perhaps it is because I am not getting
the true reason why you made them separate in the first place.

Thanks.
