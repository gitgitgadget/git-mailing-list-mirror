Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E692018E
	for <e@80x24.org>; Sat, 13 Aug 2016 15:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbcHMP7b (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 11:59:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752617AbcHMP7b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 11:59:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C95CE33186;
	Sat, 13 Aug 2016 11:59:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mA4MNCBpekgMvUfcHGGohIJtCes=; b=qHdK47
	571cngppHANDlguoaxhrFwxNvn7hTQY1MIlKT5D13DPk7lNYUk5dsN5Gq6Z7pvGL
	q6zpoP996xoBDgJQqTeH90yZ3wbHC61e0eti12phdymDWOJpPAOwJVxQvDrZRd1f
	nrYvVrw+SUgWXy6jv9gSLX7OV0MZ8Ytg1bWAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cWjYNX3PUIuKuqcz9uyEZmrugpHKoNGa
	UsjoduGkzvC7/vPhIrBnpOiE4dXAyFmE/A9sHzq7UTxpG3PTDjkK48SjZvfY6+yr
	EdMIh6kNSX1kGvjFXv8nc8ByH+mYCeaC9LPhbwc6Dx68S6yinKQLukPLvR8ZgOQ+
	WgV8zgG5ftg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0F5333185;
	Sat, 13 Aug 2016 11:59:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F25DB33184;
	Sat, 13 Aug 2016 11:59:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
	<20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
	<e4232cba-aae8-8426-c730-7914bb750363@alum.mit.edu>
	<20160813085904.lykoihh4v2lf4yuj@sigill.intra.peff.net>
Date:	Sat, 13 Aug 2016 08:59:25 -0700
In-Reply-To: <20160813085904.lykoihh4v2lf4yuj@sigill.intra.peff.net> (Jeff
	King's message of "Sat, 13 Aug 2016 04:59:05 -0400")
Message-ID: <xmqqoa4wu0bm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA820A9E-616E-11E6-80D0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So assuming everything I just said isn't complete bollocks, I think we
> can move to a future where nobody uses the compaction heuristic. And
> there are three ways to deal with that:
>
>   1. The knob and feature stay. It might be useful for somebody who
>      wants to experiment in the future.
>
>   2. The knob and feature go away completely. It was an experiment, but
>      now we have something more useful.
>
>   3. The feature goes away, but the knob stays as noop, or maybe as an
>      alias for the indent heuristic, just because we did ship a version
>      that accepts "--compaction-heuristic", and maybe somebody somewhere
>      put it in a script?
>
> I think I'd be in favor of (2).

I am all for (2) [*1*]

This and the previous "take a blank line as a hint" are both
heuristics.  As long as the resulting code does not tax runtime
performance visibly and improves the resulting output 99% of the
time, there is no reason to leave end-users a knob.  "Among 9 hunks
in this patch that touch hello.c, 7 are made much more readable but
2 are worse" cannot even be helped with a command line option.


[Footnote]

*1* I am also strongly against (3), if only to teach people a
    lesson ;-).
