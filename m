Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C88B1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdHCTxE (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 15:53:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57828 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751773AbdHCTxD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 15:53:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E016A6F20;
        Thu,  3 Aug 2017 15:52:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kXtvtNflAjsmUlBzv1DGZN+A+68=; b=clgZ6U
        sjehkImTqIDkHuUsTQFNm5muvrDWNQ9eFJRfMeIZIc1vcCrZ/Nn3gx9EqUuX2jY1
        iRoKWH348X0REkIcGgh3z05Kd7l18Q7tW4mmvBRd6DJgqeClcRFZxzq8piXKUj2o
        htKnj9vcGLHPjFTIOmwb07jMjT77R+JzgBrQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HaejLX0RTqIJ1YiBGXU29GYVUG6oct0Z
        mlw/dwgshKzF7LRyYrjxYxbb10jCJbzawQonmjYVHc7HH1khCcyov3T8DuXKGb20
        5iCtpajxRSagZj7jvWF0euAzoQpoE4YwMLmFzR+bYgkBAX1IkDgpv6+EwPe9bRUs
        5EEbY8QbFlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54E6DA6F1F;
        Thu,  3 Aug 2017 15:52:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 860BFA6F1E;
        Thu,  3 Aug 2017 15:52:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 14/40] external-odb: accept only blobs for now
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-15-chriscool@tuxfamily.org>
Date:   Thu, 03 Aug 2017 12:52:54 -0700
In-Reply-To: <20170803091926.1755-15-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 3 Aug 2017 11:19:00 +0200")
Message-ID: <xmqq7eykxwbt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57C0683E-7885-11E7-92FD-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> The mechanism to decide which blobs should be sent to which
> external object database will be very simple for now.
> If the external odb helper support any "put_*" instruction
> all the new blobs will be sent to it.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  external-odb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/external-odb.c b/external-odb.c
> index 82fac702e8..a4f8c72e1c 100644
> --- a/external-odb.c
> +++ b/external-odb.c
> @@ -124,6 +124,10 @@ int external_odb_put_object(const void *buf, size_t len,
>  {
>  	struct odb_helper *o;
>  
> +	/* For now accept only blobs */
> +	if (strcmp(type, "blob"))
> +		return 1;
> +

I somehow doubt that a policy decision like this should be made at
this layer.  Shouldn't it be encoded in the capability the other
side supports, or determined at runtime per each individual object
when a "put" is attempted (i.e. allow the other side to say "You
tell me that you want me to store an object of type X and size Y;
I cannot do that, sorry").

>  	external_odb_init();
>  
>  	for (o = helpers; o; o = o->next) {
