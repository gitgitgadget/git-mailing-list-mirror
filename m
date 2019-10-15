Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1541B1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 01:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfJOBxu (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 21:53:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62407 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfJOBxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 21:53:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B09979E25B;
        Mon, 14 Oct 2019 21:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IvMrNBu86+6u
        wK6pfGEdf3Hm0EM=; b=r/ReieJ3vpKx+kzec5rQO4j7pfxmIK9N59j8O+yXIWIg
        4Qw7Pt84bggBXD550du8awCwWihEHZc4ZGSMBW+pSZBkpoPz/UjVno8lhqobA+eV
        h+SIqLHxnG/SRQ2QRJsYwFhP4f6qpAf3v335ezhVNy2W0q0PjzdKsPWFmyes6SU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fRe1Sr
        5TY7W2PaIvS3ZaHYTWoJqD7l547NS+61CioiOHKBcbm+0xN76pZs5uhG5CzB9K5c
        oY5KzKOxl45JAW5EcXIOTEPx4y5QeNeg5Z7zTNf5GrP/UOYHFAcMuW1bAp+oOtM3
        AIF+2WXsLMQrJU8B/BSLLqdvnZYoeCm18Ygzo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A81AC9E25A;
        Mon, 14 Oct 2019 21:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7A649E257;
        Mon, 14 Oct 2019 21:53:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] http-push: simplify deleting a list item
References: <3739b392-ee45-98c2-c5fa-e4c36e585166@web.de>
Date:   Tue, 15 Oct 2019 10:53:42 +0900
In-Reply-To: <3739b392-ee45-98c2-c5fa-e4c36e585166@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 13 Oct 2019 14:49:17 +0200")
Message-ID: <xmqqtv8adba1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F03E252-EEEE-11E9-8590-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The first step for deleting an item from a linked list is to locate the
> item preceding it.  Be more careful in release_request() and handle an
> empty list.  This only has consequences for invalid delete requests
> (removing the same item twice, or deleting an item that was never added
> to the list), but simplifies the loop condition as well as the check
> after the loop.
>
> Once we found the item's predecessor in the list, update its next
> pointer to skip over the item, which removes it from the list.  In othe=
r
> words: Make the item's successor the successor of its predecessor.
> (At this point entry->next =3D=3D request and prev->next =3D=3D lock,
> respectively.)  This is a bit simpler and saves a pointer dereference.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  http-push.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Nice simplification.  I wonder how much longer we should be
maintaining this program, though;-)


Will queue.

>
> diff --git a/http-push.c b/http-push.c
> index 0353f9f514..822f326599 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -501,10 +501,10 @@ static void release_request(struct transfer_reque=
st *request)
>  	if (request =3D=3D request_queue_head) {
>  		request_queue_head =3D request->next;
>  	} else {
> -		while (entry->next !=3D NULL && entry->next !=3D request)
> +		while (entry && entry->next !=3D request)
>  			entry =3D entry->next;
> -		if (entry->next =3D=3D request)
> -			entry->next =3D entry->next->next;
> +		if (entry)
> +			entry->next =3D request->next;
>  	}
>
>  	free(request->url);
> @@ -981,7 +981,7 @@ static int unlock_remote(struct remote_lock *lock)
>  		while (prev && prev->next !=3D lock)
>  			prev =3D prev->next;
>  		if (prev)
> -			prev->next =3D prev->next->next;
> +			prev->next =3D lock->next;
>  	}
>
>  	free(lock->owner);
> --
> 2.23.0
