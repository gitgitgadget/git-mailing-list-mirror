Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BB7420987
	for <e@80x24.org>; Thu, 29 Sep 2016 17:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbcI2RTl (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:19:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62562 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933853AbcI2RTj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:19:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECA6041473;
        Thu, 29 Sep 2016 13:19:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AmBElmoQEnoCfvJr86mZNo214Lo=; b=YXdJk7
        3w6j4FiuZIi8YDzUy5Dr5e9fUVYfPXSWvtXHqW3GaabXqImYitTOYklBQ+afXyUy
        Yblw1SRFTju7kMmeCjOhtNCldxsueZsWIqRQK+0ZNX7xaU1Uk3TGreMESDIdtS+u
        byEAcWRn0NaStzulygwlSTE45KAj5Qt4gDuSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U9keI8gsINvFIlcll1CrnFF2DBjZi4HV
        CcnvpRZlHOni34N+llSlOzU3k7DLAKF6dzzm4s62BpHdfC4zAJbMl/GtfZFbA94Q
        aWVKR0/0UkftDum/4xDYtScVbawQ6XjCOZzM7r8iZBOtnJQzGWve3nfWZv6Q8Ci6
        IirMqS9pEPA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E20C641471;
        Thu, 29 Sep 2016 13:19:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66B3341470;
        Thu, 29 Sep 2016 13:19:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
        <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
        <2242637D-4C3B-4AF2-8BE4-823B3E1745D5@gmail.com>
        <20160929130322.562ng4t2ktk6qzok@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 10:19:35 -0700
In-Reply-To: <20160929130322.562ng4t2ktk6qzok@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 09:03:22 -0400")
Message-ID: <xmqqbmz6hbdk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5F8B580-8668-11E6-ACDD-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> $ git rev-parse --disambiguate-list=b2e1
>> b2e1196 tag v2.8.0-rc1
>> b2e11d1 tree
>> b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
>> b2e1759 blob
>> b2e18954 blob
>> b2e1895c blob
>
> I think the "right" way to do this is pipe the list of sha1s into
> another git commit which can format them however you want.
> Unfortunately, there isn't a single command that does a great job:
>
>   - "cat-file --batch-check" can show you the sha1 and type, but it
>     won't abbreviate sha1s, and it won't show you commit/tag information
>
>   - "log --stdin --no-walk" will format the commit however you like, but
>     skips the trees and blobs entirely, and the tag can only be seen via
>     "%d"
>
>   - "for-each-ref" has flexible formatting, too, but wants to format
>     refs, not objects (and doesn't read from stdin).

    - "name-rev" is used to give "describe --contains", and can read
      from its standard input, but has no format customization.
      Another downside of it is that it only wants to see
      committishes.

> IMHO that is a sign that our formatting tools aren't as good as they
> could be (I think the right tool is cat-file, but it should be able to
> do all of the formatting that the other commands can do).
>
> Of course if you really just want human-readable output, then:
>
>   $ git cat-file -e b2e1
>   error: short SHA1 b2e1 is ambiguous
>   hint: The candidates are:
>   hint:   b2e1196 tag v2.8.0-rc1
>   hint:   b2e11d1 tree
>   hint:   b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
>   hint:   b2e1759 blob
>   hint:   b2e18954 blob
>   hint:   b2e1895c blob
>   fatal: Not a valid object name b2e1
>
> is pretty easy.

Yes.  I think adding this to rev-parse that is meant for machines is
probably a mistake, as this "hint" machinery's output will become
even more human friendly over time as we gain experience.

 - If the hypothetical "--disambiguate-list" option wants to produce
   machine parseable output for scripts, it would mean its output
   (and whatgver the reading script can do based on its output for
   humans) will become less useful for humans over time.

 - If the hypothetical "--disambiguate-list" option only wants to
   replicate the human readable output that is designed to be
   improved over time and expects its output _not_ to be interpreted
   by scripts but merely be relayed, then why aren't these scripts
   just invoking the commands that already gives the "hint:" output
   and showing that directly to humans in the first place?

> That being said, I don't mind if somebody wanted to do a rev-parse
> option on top of my series. The formatting code is already split into
> its own function.

So let's not go there.
