Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD2BC433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 22:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EAB20829
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 22:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0WRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:17:46 -0400
Received: from 0x63.nu ([109.74.10.199]:48802 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0WRp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 18:17:45 -0400
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1k0BRD-0008Aj-RG; Tue, 28 Jul 2020 00:17:39 +0200
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com> <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com> <xmqqk0yog1lg.fsf@gitster.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
Message-ID: <878sf4r4au.fsf@0x63.nu>
In-reply-to: <xmqqk0yog1lg.fsf@gitster.c.googlers.com>
Date:   Tue, 28 Jul 2020 00:17:39 +0200
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:

> Christian Couder <christian.couder@gmail.com> writes:
>> Yeah, in this case we are not sure if "Acked" or "aCKed" is the right
>> way to spell it.
>
> OK, so in short, the trailer subsystem matches the second level of
> the configuration variable name (e.g. "Acked") in a case insensitive
> way

From what I can understand it tries to match *both* on the second level
AND the value of .key (trailers.c:token_matches_item)

$ printf '\na: 1\nb: 2\nc: 3\n' | \
  git -c 'trailer.A.key=B' interpret-trailers
B: 1
B: 2
c: 3

and then uses the .key value when outputting the result (by calling
trailer.c:token_from_item)

I.e:
it gets "a: 1", tries to find configuration for that, and finds
trailer.A because "a" (case insenitively) matches conf.name, therefore
it outputs value of trailer.A.key + separator + "1"

then it gets "b: 1", and again finds trailer.A because "b" matches
conf.key.

> , and it does *not* normalize the case in the output.  The .key
> request is a mechanism to replace the matched key with the specified
> string, so there is *NO* case normalization in what Anders observed.

Hmm. Maybe the "matching" vs "outputting" makes it clearer.


Given configuration trailer.<NAME>.key=<KEY>

When printing a parsed trailer, e.g from pretty format "%(trailers)",
"git interpret-trailers" passthrough of existing trailers or addition of
a new trailer with --trailer: <KEY> is used in output. If <KEY> is not
configured the trailer token is output the same way as it was in input.

When finding a trailer, e.g for '--trailer x=y' or
trailer.<NAME>.where=before/after: matching is done against both
<NAME> and <KEY>.

When showing a single trailer with pretty format '%(trailers:key=X)' it
is matched against <KEY> only. (I guess one can see this as matching on
the formatted output).


> In other words,
>
>   $ printf '\naCKed: Zz\n' | \
>     git -c 'trailer.Acked.key=Rejected' interpret-trailers --parse
>
> would have emitted "Rejected: Zz".

Indeed.
