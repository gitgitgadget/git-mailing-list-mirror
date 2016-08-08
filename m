Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B4A2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbcHHRQg (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 13:16:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752125AbcHHRQg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 13:16:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D5C3F33442;
	Mon,  8 Aug 2016 13:16:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yhaICJ5XEo+2zJa1izJRdA/A8pg=; b=SoS3JL
	rl5wm9w+HfSdmRwHug54mYCwqBSNcsTiMCEzRA3Haw4Sjh9dbs53lwLpHpXshM3z
	cRVPxzpbmVKakzkHMcCcxXXh9dcqW221CpErq6WFGNkKdITiwFx+RfQuxArHVEIX
	AnjLr0CYCvDOxtd9aXoai4+pnDuQdIX3VCudc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ooy84alUtOEfmNRSWZI/0kAKpCxhnPKc
	g9WCCJVVadAyESckx07mH9U29T7aVU6S0r+aFyJjtx2jm+khmk17/dDyXBtxfyEZ
	X6We1HHcDl868sN6rw7uS31RYeh8Whun5SY6cbMDOM7wxxKFmNJSqU91w9CugMQQ
	FXK8I+9tgx8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCD1433441;
	Mon,  8 Aug 2016 13:16:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E28533440;
	Mon,  8 Aug 2016 13:16:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/7] pack-objects: use mru list when iterating over packs
References: <20160729040422.GA19678@sigill.intra.peff.net>
	<20160729041524.GG22408@sigill.intra.peff.net>
	<20160729054536.GA27343@sigill.intra.peff.net>
	<xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
	<20160808145042.uwrk2m6jq3m4li37@sigill.intra.peff.net>
	<xmqq8tw7gr82.fsf@gitster.mtv.corp.google.com>
	<20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net>
Date:	Mon, 08 Aug 2016 10:16:32 -0700
In-Reply-To: <20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 8 Aug 2016 12:51:28 -0400")
Message-ID: <xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB59E3E8-5D8B-11E6-8E7D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> It worries me a lot to lose the warning unconditionally, though.
>> That's the (only) coal-mine canary that lets us notice a problem
>> when we actually start hitting that last-ditch cycle breaking too
>> often.
>
> The dedicated cycle-detection will lose that warning, too (it doesn't
> touch that code, but it's effectively checking the same thing earlier).
>
> I agree it's unfortunate to lose. On the other hand, it is being lost
> because we are correctly handling the cycles, and there is nothing to
> warn about. So it ceases to be a problem, and starts being a normal,
> acceptable thing.

That unfortunately is beside the point.  The existing cycle breaking
was meant to be a last ditch effort to avoid producing a broken pack
(i.e. a suboptimal pack without cycle is better than unusable pack
with delta cycle), while letting us know that we found a case where
the remainder of the pack building machinery does not function well
without it (so that we know we broke something when we tweaked the
machinery without intending to break it).  Squelching the warnings
feels similar to "we see too many valgrind warnings, so let's stop
running valgrind"; I was hoping there would be a solution more like
"instead of not running, let's teach valgrind this and that codepath
is OK".
