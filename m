Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9271F855
	for <e@80x24.org>; Mon,  1 Aug 2016 20:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbcHAUZU (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 16:25:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752131AbcHAUZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 16:25:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD25B3147D;
	Mon,  1 Aug 2016 16:11:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zY8g0Bg/xRCPad78giOjwAitr2g=; b=Ggt51n
	OS8ha6kMWqy2ULdr9HhEwHyHvlhc+MGJK/ZwjwngBrGVVii9rU3esLQA7agBxeQc
	Ytx36uY0IQDzKwpkZ7o1N4SfzGHWMyqBCTq8T4qCDYVB8MEN3sV9XRyAxT3x/Uln
	SBx9lhul1GJLQjZ0IbkBaHlMKyX/YMbTPBPeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kw66YrpzgNjphGCA0PGlTetA4ScuTjFc
	2A4o/Frsl+iZ03vJ3TzZiabcsj1vfkAJJtX1s1DPxvj9EDk3/SUPdNaB/ZmgrvuF
	AAFzCZS1QTJxWWDxzgarpkCVvTE6U89iQzRIriKQd3vLsjWwNzctn38rrsvl/446
	0hYluUSJCOU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5F0B3147C;
	Mon,  1 Aug 2016 16:11:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B93431479;
	Mon,  1 Aug 2016 16:11:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-5-kcwillford@gmail.com>
	<xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608011055180.149069@virtualbox>
Date:	Mon, 01 Aug 2016 13:11:02 -0700
In-Reply-To: <alpine.DEB.2.20.1608011055180.149069@virtualbox> (Johannes
	Schindelin's message of "Mon, 1 Aug 2016 10:58:54 +0200 (CEST)")
Message-ID: <xmqqtwf4i71l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 139D88D0-5824-11E6-A41E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 29 Jul 2016, Junio C Hamano wrote:
>
>> Kevin Willford <kcwillford@gmail.com> writes:
>> 
>> >  static int patch_id_cmp(struct patch_id *a,
>> >  			struct patch_id *b,
>> > -			void *keydata)
>> > +			struct diff_options *opt)
>> >  {
>> > +	if (is_null_sha1(a->patch_id) &&
>> > +	    commit_patch_id(a->commit, opt, a->patch_id, 0))
>> > +		return error("Could not get patch ID for %s",
>> > +			oid_to_hex(&a->commit->object.oid));
>> > +	if (is_null_sha1(b->patch_id) &&
>> > +	    commit_patch_id(b->commit, opt, b->patch_id, 0))
>> > +		return error("Could not get patch ID for %s",
>> > +			oid_to_hex(&b->commit->object.oid));
>> >  	return hashcmp(a->patch_id, b->patch_id);
>> >  }
>> 
>> These error returns initially looks slightly iffy in that in general
>> the caller of any_cmp_fn() wants to know how a/b compares, but by
>> returning error(), it always says "a is smaller than b".
>
> I am to blame, as this is my design.
>
> And yes, it is kind of funny that we require a cmpfn that returns <0, ==0
> and >0 for comparisons, when hashmaps try to avoid any order.

Perhaps hashmap API needs fixing in the longer term not to call this
type hashmap_cmp_fn; instead it should lose cmp and say something
like hashmap_eq_fn or something.

> Do you want a note in the commit message about this "abuse" of a negative
> return value, or a code comment?

I do not think negative (or non-zero) return is an "abuse" at all.
It is misleading in the context of the function whose name has "cmp"
in it, but that is not the fault of this function, rather, the
breakage is more in the API that calls a function that wants to know
only equality a "cmp".  A in-code comment before the function name
may be appropriate:

        /*
         * hashmap API calls hashmap_cmp_fn, but it only wants
         * "does the key match the entry?" with 0 (matches) and
         * non-zero (does not match).
         */
        static int patch_id_match(const struct patch_id *ent,
                                  const struct patch_id *key,
                                  const void *keydata)
        {
                ...

