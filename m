Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A878120986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbcJDV3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:29:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753488AbcJDV3u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:29:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2129E43466;
        Tue,  4 Oct 2016 17:29:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aCdzlGMzKXkkyjOmND0yIBS7JWg=; b=jqYxlp
        fmh6fhjvGcP3Y5TYWuFyaAW0RUfFUcvw/37W2g3FYNnVgbuymCIjaJroZg6kYmd8
        63UeeRNC+fNZ2gZqnrWAtr7Q9eyDvANzHp9li/yXfGwsRw9tIfTwgZ9icDsZUtLv
        snGTF6r/x6oBX7MYsUr/qRakbaUSkd/dumPGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lskJcUBuiNmWMNwVsSDf/i1B/HlPSemm
        4Df7ih+vhG4mIHiR+y1oy4b3Al2orecoIjET1BwnGte3rHgpyHpmRbFnY7QsSfxn
        3bX6woVb4syyDVHu7G5eMhV6hduzNdXVt1kp1ulIbgZgzp30OdIlX8jDOg3cqVB5
        vxLa0ciH8fI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19DB143465;
        Tue,  4 Oct 2016 17:29:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91CF443464;
        Tue,  4 Oct 2016 17:29:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 12/18] alternates: use a separate scratch space
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203551.tmqp5rll6nqkewxz@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 14:29:46 -0700
In-Reply-To: <20161003203551.tmqp5rll6nqkewxz@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 16:35:51 -0400")
Message-ID: <xmqqk2dnssz9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD64CC3A-8A79-11E6-98AF-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  extern struct alternate_object_database {
>  	struct alternate_object_database *next;
> +
>  	char *name;
> -	char base[FLEX_ARRAY]; /* more */
> +	char *scratch;
> +
> +	char path[FLEX_ARRAY];
>  } *alt_odb_list;

It is not wrong per-se, but I am a bit surprised to see that the
code keeps FLEX_ARRAY _and_ uses a separate malloc'ed area pointed
at by the scratch pointer.

Loss of "compare only up to the location 'name' points at" makes the
users of the struct that want only the directory path certainly a
lot simpler and easier to follow.

Thanks.
