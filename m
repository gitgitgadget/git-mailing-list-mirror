Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93785CA0FE4
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347096AbjIAQnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbjIAQnS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:43:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA8810F1
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:43:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43CFA1A3CD6;
        Fri,  1 Sep 2023 12:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=T5b0Of8vwKl36K1xDsOfIJDvjBXV4TbP5Vfj1B
        zfeIs=; b=LYiyPTQJt2cOhUBISmKfJJZCzGEqZpKUvajEwQgJV8XFamXLqzetli
        ikP7A40nRRmqCeaTPIFssNxey8Zj3ZUSJfJvQOyiDJj1W39/1MJvcjgeLVreXkop
        y5dxauwIzNGao0ieyJ9fANhKO8wVqsZpMFe57P5j2qfXo56aDT10E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B6D51A3CD5;
        Fri,  1 Sep 2023 12:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CEB91A3CD4;
        Fri,  1 Sep 2023 12:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
In-Reply-To: <20230901142624.12063-1-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Fri, 1 Sep 2023 19:54:54 +0530")
References: <20230901142624.12063-1-five231003@gmail.com>
Date:   Fri, 01 Sep 2023 09:43:07 -0700
Message-ID: <xmqqa5u5rgis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1A3321E-48E6-11EE-9B2B-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Atoms like "raw" and "contents" have a ":size" option which can be used
> to know the size of the data. Since these atoms have the cmp_type
> FIELD_STR, they are sorted alphabetically from 'a' to 'z' and '0' to
> '9'. Meaning, even when the ":size" option is used and what we
> ultimatlely have is numbers, we still sort alphabetically.

There are other cmp_types already defined, like ULONG and TIME.  How
are they used and affect the comparison?  Naively, :size sounds like
a good candidate to compare as ULONG, as it cannot be negative even
though 0 is a valid size.

I understand and agree with the motivation, but the implementation
looks puzzling.

> diff --git a/ref-filter.c b/ref-filter.c
> index 1bfaf20fbf..5d7bea5f23 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -932,7 +932,13 @@ struct atom_value {
>  	ssize_t s_size;
>  	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
>  		       struct strbuf *err);
> -	uintmax_t value; /* used for sorting when not FIELD_STR */
> +
> +	/*
> +	 * Used for sorting when not FIELD_STR or when FIELD_STR but the
> +	 * sort should be numeric and not alphabetic.
> +	 */
> +	uintmax_t value;

This does not explain why we cannot make <anything>:size FIELD_ULONG
for <anything> that is of FIELD_STR type, though.  IOW, why such a
strange "when FIELD_STR but the sort should be numeric" is needed?
If you have a <size>, shouldn't it always be numeric?

IOW, when you notice that you need to set, say, u.contents.option of
an atom to C_LENGTH, shouldn't you set cmp_type of the atom to
FIELD_ULONG, somewhere in contents_atom_parser() and friends, and
everything should naturally follow, no?

It seems that support for other cmp_types are incomplete in the
current code.  There are FIELD_ULONG and FIELD_TIME defined, but
they do not appear to be used in any way, so the cmp_ref_sorting()
would need to be updated to make it actually pay attention to the
cmp_type and perform numeric comparison.

> @@ -1883,8 +1890,10 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
>  			v->s = strbuf_detach(&sb, NULL);
>  		} else if (atom->u.contents.option == C_BODY_DEP)
>  			v->s = xmemdupz(bodypos, bodylen);
> -		else if (atom->u.contents.option == C_LENGTH)
> -			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
> +		else if (atom->u.contents.option == C_LENGTH) {
> +			v->value = (uintmax_t)strlen(subpos);
> +			v->s = xstrfmt("%"PRIuMAX, v->value);
> +		}

We should take a note that all of these v->value are *per* *item*
that will be sorted.

> @@ -2986,7 +2996,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>  		cmp_detached_head = 1;
>  	} else if (s->sort_flags & REF_SORTING_VERSION) {
>  		cmp = versioncmp(va->s, vb->s);
> -	} else if (cmp_type == FIELD_STR) {
> +	} else if (cmp_type == FIELD_STR && !va->value && !vb->value) {

Two refs may point at an empty object with zero length, i.e.  for
them, !v->value is true, and another ref may point at a non-empty
object.  The two empty refs are compared with an algorithm different
from the algorithm used to compare the empty ref and the non-empty
ref.  Isn't this broken as a comparison function to be given to
QSORT(), which must be transitive (e.g. if A < B and B < C, then it
should be guaranteed that A < C and you do not have to compare A and
C)?

IOW, the choice of the comparison algorithm should not depend on an
attribute (like value or s) that is specific to the item being
compared.  Things like cmp_type that is defined at the used_atom
lefvel to make the sorting function stable, I would think.
