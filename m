Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021BC20899
	for <e@80x24.org>; Thu, 17 Aug 2017 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbdHQSDX (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 14:03:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57155 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753283AbdHQSDX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 14:03:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BDC2AFE8A;
        Thu, 17 Aug 2017 14:03:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hjGIdMSB9lBTG5f+wA8pJzv++ZU=; b=pwwXfP
        ODHeCkFY266uKKgTtAQpQ3GTlK97YRyud8a3ERRmYUw/Tlixc8ibPrj2aImfwi9e
        NF/tY/EpvzGk7//HS3gR5xzAefbjbuqOjIxNlhrmQlxyeJttRsAJG1yQNbgcoyN7
        JtqMczoCWRgJQqz0dEwa/8epau1o6yNDprQ2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ncc+buvglZ+dB/GeAfNoZtR/elskvXU6
        Pw7oEdg6JlTU6ltNDp+TU/dTRcFR/BwrpaB6eJA9Ex6WizSKBqBoQLAeHjAoNjfk
        Thtd1s+ST7lrJIFXmCIkwHvyGhI4RvDu17gxeHVJHeLwMOdhLvo0QChbpkcW94KK
        iMBy5qdYZcc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 937C5AFE89;
        Thu, 17 Aug 2017 14:03:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2BA6AFE87;
        Thu, 17 Aug 2017 14:03:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 17/19] Convert ref-filter to size_t
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
        <1502914591-26215-18-git-send-email-martin@mail.zuhause>
Date:   Thu, 17 Aug 2017 11:03:13 -0700
In-Reply-To: <1502914591-26215-18-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Wed, 16 Aug 2017 22:16:29 +0200")
Message-ID: <xmqqmv6ygjha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5724312A-8376-11E7-B72C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> -static char *copy_subject(const char *buf, unsigned long len)
> +static char *copy_subject(const char *buf, size_t len)
>  {
>  	char *r = xmemdupz(buf, len);
>  	int i;

This has the same "we are still iterating with 'int i' over an array
that can be 'size_t len' long" issue as I pointed out in 19/19.  The
remedy is similar, i.e.

	static char *copy_subject(const char *buf, size_t len)
	{
		char *ret = xmemdupz(buf, len);
		char *cp;

		for (cp = ret; cp < ret + len; cp++)
			if (*cp == '\n')
				*cp = ' ';
		return ret;
	}

which should come either before the whole series or after the series
settles, not inside this series.

I do also wonder if we want to do more for other control characters
(e.g. CR, HT, etc.) in this function, though.  That is totally outside
the scope of this series and should be done independently.

> @@ -898,7 +898,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
>  }
>  
>  /* See grab_values */
> -static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
> +static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
>  {
>  	int i;
>  	int wholen = strlen(who);

Shouldn't this also become size_t, I wonder?

I did not see anything fishy in the remaining parts I did not
comment on.

Thanks.
