Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB4820899
	for <e@80x24.org>; Thu, 17 Aug 2017 19:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbdHQTjJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 15:39:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63084 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752632AbdHQTjI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 15:39:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AACEAA78B;
        Thu, 17 Aug 2017 15:39:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xZPXTG15j8vOzytZJezbdICWb+0=; b=o8nTst
        HOMojd9vT7gLD7JNisi7XLzsUYomXwjWBKdjwxFNe5EqXOOe2g/+xUlYw1DB2Kpt
        h5NXggpNiXtJu+zpfdudKQnuV7JDXRG8uIviVxBSPyTfFjQSJvOtSlL24ibt6utZ
        h611ELHliNSKigFl15m+y+OL6gUNtFdHuW8OE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hl/UcCTF/YpVq5F9OLEAH1/0ZsG6BM0g
        N7zyTRbhLZ3rSJLoGSoQ90luMOcZ+3HCc6NK1bm/tH6QnGRNoiJRF2sWsPnfDFyL
        Z3xwFEk/hgV7gQNqphzEazi0E+G1YPbxcXkB1eZ1I4FVuiKLQlSE6FXqZXoRcYXW
        YDtpQHhRtHk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67FC4AA78A;
        Thu, 17 Aug 2017 15:39:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3A98AA786;
        Thu, 17 Aug 2017 15:38:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Carlsson\, Magnus" <Magnus.Carlsson@arris.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
References: <1502960406180.9006@arris.com> <1502960572292.1402@arris.com>
        <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
Date:   Thu, 17 Aug 2017 12:38:58 -0700
In-Reply-To: <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 17 Aug 2017 05:28:54 -0400")
Message-ID: <xmqq1soagf1p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B74FB5C6-8383-11E7-820F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   # no tags, we just populate FETCH_HEAD because of the bare URL
>   git fetch ../parent
>
>   # this does fetch tags, because we're storing the result according to
>   # the configured refspec ("refs/heads/*:refs/remotes/origin/*").
>   git fetch origin

The above two look good.

>   # this doesn't fetch tags, as the main command is "just" populating
>   # FETCH_HEAD. But then our logic for "hey, we fetched the ref for
>   # refs/remotes/origin/master, so let's update it on the side" kicks
>   # in. And we end up updating FETCH_HEAD _and_ the tracking branch, but
>   # not the tags. Weird.
>   git fetch origin master

Yes, it looks weird, but I suspect that it is probably more correct
not to fetch tags in this case.  I wonder if it would be a solution
not to do the "on the side" thing---after all the user didn't tell
us to update refs/remotes/origin/master with this command line.

Then not following tags will be in line with all of the above
reasoning above.

>   # and this one does fetch tags, because we have a real destination.
>   git fetch origin master:foo

Yup, that is expected.

> So what I'd say is:
>
>   1. Definitely these defaults are under-documented. I couldn't find
>      them anywhere in git-fetch(1).

Yup.

>   2. If we continue to follow the "are we storing any refs" rule for the
>      default, possibly it should expand to "did we store anything,
>      including opportunistic tracking-ref updates".

That also is a workable way to make things consistent.
