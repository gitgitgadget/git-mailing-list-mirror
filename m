Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9611B1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 15:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbcJNPiP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 11:38:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55439 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751061AbcJNPiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 11:38:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A546646188;
        Fri, 14 Oct 2016 11:37:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r5IARKuiQOhAdTJV68T7xzZ1JwU=; b=FJDzzF
        ZJWJclhPzcBQNvye5kKeqeB82/H2b8hkPK7mAVvWRFNqT5jix3xMiSMV/BVzcyu6
        Gr7UoQXeeug+fmYs91VTGsn0kphH3bl4N7GuzRrMw12j9uwnCfNzgsgYNdhf7cyM
        o5H4/sF9UpBtyQWZIQ0PcDpqXajFrh5Z29kbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kz9NNhuhJX7u6S4ZvqaBzSPMuoA/RACD
        pNWUuJ35TFU16aJieXOhvQU96/GwU9+pSPCjsF7tidu9MCBVytlztMNuCyr03aKD
        aECeHQqeYL9V+NcsrnBH3ERSMDXfJ0CxLTlhZ10WRJ4lvXpiF80JoTDqNUZZ2lp+
        3EytIq2+MMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D1B646187;
        Fri, 14 Oct 2016 11:37:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18B2746185;
        Fri, 14 Oct 2016 11:37:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, j6t@kdbg.org,
        jacob.keller@gmail.com
Subject: Re: [PATCHv3] attr: convert to new threadsafe API
References: <20161012224109.23410-1-sbeller@google.com>
        <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 14 Oct 2016 08:37:05 -0700
In-Reply-To: <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 12 Oct 2016 16:33:31 -0700")
Message-ID: <xmqq8ttr0wny.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 104A8BA8-9224-11E6-BDE7-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> *1* Would we need a wrapping struct around the array of results?

By the way, I do see a merit on the "check" side (tl;dr: but I do
not think "result" needs it, hence I do not see the need for the
"ugly" variants).

Take "archive" for example.  For each path, it wants to see the
attribute "export-ignore" to decide if it is to be omitted.  In
addition, the usual set of attributes used to smudge blobs into the
working tree representation are inspected by the convert.c API as
part of its implementation of convert_to_working_tree().  This
program has at least two sets of <"check", "result"> that are used
by two git_check_attr() callsites that are unaware of each other.

One of the optimizations we discussed is to trim down the attr-stack
(which caches the attributes read from .gitattributes files that are
in effect for the "last" directory that has the path for which
attrbiutes are queried for) by reading/keeping only the entries that
affect the attributes the caller is interested in.  But when there
are multiple callsites that are interested in different sets of
attributes, we obviously cannot do such an optimization without
taking too much cache-invalidation hit.  Because these callsites are
not unaware of each other, I do not think we can say "keep the
entries that affects the union of all active callsites" very easily,
even if it were possible.

But we could tie this cache to "check", which keeps a constant
subset of attributes that the caller is interested in (i.e. each
callsite would keep its own cache that is useful for its query).
While we are single-threaded, "struct git_attr_check" being a
wrapping struct around the array of "what attributes are of
interest?" is a good place to add that per-check attr-stack cache.
When we go multi-threaded, the attr-stack cache must become
per-thread, and needs to be moved to per-thread storage, and such a
per-thread storage would have multiple attr-stack, one per "check"
instance (i.e. looking up the attr-stack may have to say "who/what
thread am I?" to first go to the thread-local storage for the
current thread, where a table of pointers to attr-stacks is kept and
from there, index into that table to find the attr-stack that
corresponds to the particular "check").  We could use the address of
"check" as the key into this table, but "struct git_attr_check" that
wraps the array gives us another option to allocate a small
consecutive integer every time initl() creates a new "check" and use
it as the index into that attr-stack table, as that integer index
can be in the struct that wraps the array of wanted attributes.

	Note. none of the above is a suggestion to do the attr
	caching the way exactly described.  The above is primarily
	to illustrate how a wrapping struct may give us future
	flexibility without affecting a single line of code in the
	user of API.

It may turn out that we do not need to have anything other than the
array of wanted attributes in the "check" struct, but unlike
"result", "check" is shared across threads, and do not have to live
directly on the stack, so we can prepare for flexibility.

I do not foresee a similar need for wrapping struct for "result",
and given that we do want to keep the option of having them directly
on the stack, I am inclined to say we shouldn't introduce one.

If we were still to do the wrapping for result, I would say that
basing it around the FLEX_ARRAY idiom, i.e.

>         struct git_attr_result {
>                 int num_slots;
>                 const char *value[FLEX_ARRAY];
>         };

is a horrible idea.  It would be less horrible if it were

	struct git_attr_result {
		int num_slots;
		const char **value;
	};

then make the API user write via a convenience macro something like
this

	const char *result_values[NUM_ATTRS_OF_INTEREST];
	struct git_attr_result result = {
		ARRAY_SIZE(result_values), &result_values
	};                

instead.  That way, at least the side that implements git_check_attr()
would not have to be type-unsafe like the example of ugliness in the
message I am following-up on.
