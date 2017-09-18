Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15732047F
	for <e@80x24.org>; Mon, 18 Sep 2017 00:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbdIRAha (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 20:37:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54328 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751254AbdIRAh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 20:37:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D309DA7954;
        Sun, 17 Sep 2017 20:37:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gWOYQa47DTk8
        T0cT9DIGJsS4lts=; b=EbLA14Ub84Y1cqi0lDBD0CmjIQftU+2kjm5csHwjakIN
        FGp+pW+FN0q8FnTe3xzmbUqGnc2/atC/2xnWsh5quH1w9eyAtU07sALEieSNqaNm
        GcUpDx0DcGlgFC/Hf3i6j/626wuD28wRept7ZJmjq6+iPFAzDh6ly88HKT2GUKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VCKgke
        wnf+Tzjr3XdiYjE95SwthM2tYcGO4t33dlT8rTs5ehQzewhkVFBbgFvOwCpLWtwR
        LRlEa3gaJmkcItC745e23mxpsBe3LdhtbGGXaBeu5Gg+F1O6x9+01vNBUTnvrQsG
        750+ut4AuLfnycRCz/zCzgumGLq5TJswEoqJc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA29DA7951;
        Sun, 17 Sep 2017 20:37:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CB96A7950;
        Sun, 17 Sep 2017 20:37:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        <xmqqefr6uolr.fsf@gitster.mtv.corp.google.com>
        <5c86b55e-20f6-df8e-b01f-66876c3a5f46@alum.mit.edu>
Date:   Mon, 18 Sep 2017 09:37:25 +0900
In-Reply-To: <5c86b55e-20f6-df8e-b01f-66876c3a5f46@alum.mit.edu> (Michael
        Haggerty's message of "Sun, 17 Sep 2017 12:24:34 +0200")
Message-ID: <xmqqfubku9iy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8BC99126-9C09-11E7-B4C9-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> *sigh* of course you're right. I should know better than to "fire off a
> quick fix to the mailing list".
>
> I guess the two proposals that are still in the running for rescuing
> this macro are Jonathan's and G=C3=A1bor's. I have no strong preference
> either way.

If somebody is writing this outisde a macro as a one-shot thing, the
most natural and readable way I would imagine would be

	if (the list is empty)
        	;
	else
		for (each item in the list)
			work on item

I would think.  That "work on item" part may not be a single
expression statement and instead be a compound statement inside a
pair of braces {}.  Making a shorter version, i.e.

	if (!the list is empty)
		for (each item in the list)
			work on item

into a macro probably has syntax issues around cascading if/else
chain, e.g.

	if (condition caller cares about)
		for_each_string_list_item() {
			do this thing
		}
	else
		do something else

would expand to

	if (condition caller cares about)
		if (!the list is empty)
			for (each item in the list) {
				do this thing
			}
	else
		do something else

which is wrong.  But I couldn't think of a way to break the longer
one with the body of the macro in the "else" clause in a similar
way.  An overly helpful compiler might say

	if (condition caller cares about)
		if (the list is empty)
			;
		else
			for (each item in the list) {
				do this thing
			}
	else
		do something else

that it wants a pair of {} around the then-clause of the outer if;
if we can find a way to squelch such warnings only with this
construct that comes from the macro, then this solution may be ideal.

If we cannot do that, then

	for (item =3D (list)->items; /* could be NULL */
	     (list)->items && item < (list)->items + (list)->nr;
	     item++)
		work on item

may be an obvious way to write it without any such syntax worries,
but I am unclear how a "undefined behaviour" contaminate the code
around it.  My naive reading of the termination condition of the
above is:

	"(list)->items &&" clearly means that (list)->items is not
	NULL in what follows it, i.e. (list->items + (list)->nr
	cannot be a NULL + 0, so we are not allowed to make demon
	fly out of your nose.

but I wonder if this alternative reading is allowed:

	(list)->items is not assigned to in this expression and is
	used in a subexpression "(list)->items + (list)->nr" here;
	for that subexpression not to be "undefined", it cannot be
	NULL, so we can optimize out "do this only (list)->items is
	not NULL" part.

which takes us back to where we started X-<.  So I dunno.

I am hoping that this last one is not allowed and we can use the
"same condition is checked every time we loop" version that hides
the uglyness inside the macro.
