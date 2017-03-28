Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994621FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 17:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754999AbdC1R2B (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 13:28:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58550 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754120AbdC1R2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 13:28:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 442166FD50;
        Tue, 28 Mar 2017 13:27:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kmYTEohCy48mfBCnWSzF3pzRlGE=; b=f5Zz0l
        OVlApbpKEKOosviH7aY1c8ZrdJ2qfq2UW//7YoscppQTgC+Pzn5xAW2c2XRzir8Q
        o2ifGD+F5QIHAsPN5opoPjWX38NTxWOdFZ0e3jp7yBCkPWXHBNw8gvjf3n+UNLFj
        fRnDzUWI/2xJXBW6v3R+I+98PsyQAVPBQKTLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uh+FQx68GXp1zipBmPxe+Iev6uZnZdnv
        wq7BFwf65WHzyjD/y34EubZvxzYgQxw+MwsDNqz7xtwrtCGqSyJW37UsWLT34q2p
        dXXhoWrg2GTk+U6VcHhIaHOc7itCGLHSflv9Da62hiKBegHHvz+C5qQLkCrngmIs
        SaasXl1Mnkw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D0116FD4F;
        Tue, 28 Mar 2017 13:27:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CF9D6FD4E;
        Tue, 28 Mar 2017 13:27:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2 16/21] Make sha1_array_append take a struct object_id *
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
        <20170326160143.769630-17-sandals@crustytoothpaste.net>
Date:   Tue, 28 Mar 2017 10:27:41 -0700
In-Reply-To: <20170326160143.769630-17-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 26 Mar 2017 16:01:38 +0000")
Message-ID: <xmqq7f39e2gi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D98A36D8-13DB-11E7-8690-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Convert the callers to pass struct object_id by changing the function
> declaration and definition and applying the following semantic patch:
>
> @@
> expression E1, E2, E3;
> @@
> - sha1_array_append(E1, E2[E3].hash)
> + sha1_array_append(E1, E2 + E3)
>
> @@
> expression E1, E2;
> @@
> - sha1_array_append(E1, E2.hash)
> + sha1_array_append(E1, &E2)

I noticed something similar in the change to bisect.c while reading
the previous step, and I suspect that the above two rules leave
somewhat inconsistent and harder-to-read result.  Wouldn't it make
the result more readable if the former rule were

    -sha1_array_append(E1, E2[E3].hash)
    +sha1_array_append(E1, &E2[E3])


FWIW, the bit that made me read it twice in the previous step was
this change

-		strbuf_addstr(&joined_hexs, sha1_to_hex(array->sha1[i]));
+		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));

which I would have written &(array->oid[i]) instead.

After all, the original written by a human said E2[E3].hash (or
array->sha1[i]) because to the human's mind, E2 is a series of
things that can be indexed with an int E3, and even though 

    *(E2 + E3)
    E2[E3]
    E3[E2]

all mean the same thing, the human decided that E2[E3] is the most
natural way to express this particular reference to an item in the
array.  &E2[E3] would keep that intention by the original author
better than E2 + E3.

The above comment does not affect the correctness of the conversion,
but I think it would affect the readability of the resulting code.
