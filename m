Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94665202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 04:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbdJ3EoJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 00:44:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65155 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751798AbdJ3EoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 00:44:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C39C95399;
        Mon, 30 Oct 2017 00:44:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AWozu/en7P0UHr9nwQ6TIWIqOps=; b=kZB1iP
        x6u0T86MtcWAz70tnvl8qrWTJzaHLuxeIqlDCeWXPyibHjGqqgf0law834yfbvK/
        Yj+IFtD7AK8FCzAqd76jDbVbd+caCNMnBjjLvMl33dPRU1PfZd+0Os87PXzu21R1
        PytJyxXMlCW06C8ugblKYA7IIFFJTdo9dwins=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WWTYmlOIZPOZB0nR7pZTUFGxVrxszeWW
        1C+VXODu3lW4hxEIg/muA3H84ImB+7NPQpS1ZdDaXdTquhb8h5X73SBAxfVX6piG
        jtz8bvWKUFY+nrK29mQIE/ooEBXP8Z+s8/nQD9Ix/HJ8BRkwCZSf7sZzMY846QY5
        LBG+ZPAu6I0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4478995398;
        Mon, 30 Oct 2017 00:44:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDEB495397;
        Mon, 30 Oct 2017 00:44:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/7] files_transaction_prepare(): don't leak flags to packed transaction
References: <cover.1509183413.git.mhagger@alum.mit.edu>
        <b8e61183ad5d5c046a9eff75ea0401cf2c2567c6.1509183413.git.mhagger@alum.mit.edu>
Date:   Mon, 30 Oct 2017 13:44:06 +0900
In-Reply-To: <b8e61183ad5d5c046a9eff75ea0401cf2c2567c6.1509183413.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Sat, 28 Oct 2017 11:49:50 +0200")
Message-ID: <xmqq60ax6y95.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6FA89E8-BD2C-11E7-8E95-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The files backend uses `ref_update::flags` for several internal flags.
> But those flags have no meaning to the packed backend. So when adding
> updates for the packed-refs transaction, only use flags that make
> sense to the packed backend.
>
> `REF_NODEREF` is part of the public interface, and it's logically what
> we want, so include it. In fact it is actually ignored by the packed
> backend (which doesn't support symbolic references), but that's its
> own business.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 2bd54e11ae..fadf1036d3 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2594,8 +2594,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  
>  			ref_transaction_add_update(
>  					packed_transaction, update->refname,
> -					update->flags & ~REF_HAVE_OLD,
> -					&update->new_oid, &update->old_oid,
> +					REF_HAVE_NEW | REF_NODEREF,
> +					&update->new_oid, NULL,

Hmph, so we earlier passed all flags except HAVE_OLD down, which
meant that update->flags that this transaction for packed backend
does not have to see are given to it nevertheless.  The new way the
parameter is prepared does nto depend on update->flags at all, so
that is about "don't leak flags".

That much I can understand.  But it is not explained why (1) we do
not pass old_oid anymore and (2) we do give HAVE_NEW.  

Presumably the justification for (1) is something like "because we
are not passing HAVE_OLD, we shouldn't have been passing old_oid at
all---it was a harmless bug because lack of HAVE_OLD made the callee
ignore old_oid" and (2) is "we need to pass HAVE_NEW, and we have
been always passing HAVE_NEW because update->flags at this point is
guaranteed to have it" or something like that?



>  					NULL);
>  		}
>  	}
