Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB4E2022A
	for <e@80x24.org>; Sat,  5 Nov 2016 04:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbcKEElK (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 00:41:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65153 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750703AbcKEElK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 00:41:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C12684CFC8;
        Sat,  5 Nov 2016 00:41:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VrZx1PEU7Sj2VeFU6LSE2jmLM+4=; b=LdFxCW
        GAagjiyJKUNLpQPjQ8QhAH2gT8E8+l9arfegzt/twb5mtquVpjMR2rPNz3UvCP/8
        PkyUQw05MgNRDSmeOw9Rykj0RzsSABp5PCa/kj+wDEn0jS/Mdu6AkDpYwqdYazT8
        D93P2w1W6tTLpZ0anOM43p8r9Mm3POjrv9IBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DJgIi60tK3LyR9ZS3sI1Ex4KVbWrulOa
        a1j++fBnQD0nhAZv212KJWWeXLNbVWOme8VZxqR1QY+nr7HOe2WKF71nqYsU4FMk
        DTBCA5pudeC4eZqmJBkNzW3iyOy1d7vO5fCnbo+7dYj6XFlAInmKq9blUkf3CtEt
        I+nlLA9UfDU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8E964CFC7;
        Sat,  5 Nov 2016 00:41:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22C924CFC6;
        Sat,  5 Nov 2016 00:41:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Regarding "git log" on "git series" metadata
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
        <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
Date:   Fri, 04 Nov 2016 21:41:06 -0700
In-Reply-To: <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 4 Nov 2016 15:49:07 -0400")
Message-ID: <xmqq60o2edy5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 119C712A-A312-11E6-A0D4-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 04, 2016 at 12:19:55PM -0700, Jacob Keller wrote:
>
>> I agree with your assessment here. The main difficulty in implementing
>> gitrefs is to ensure that they actually do get picked up by
>> reachability checks to prevent dropping commits. I'm not sure how easy
>> this is, but I would much rather we go this route rather than
>> continuing along with the hack. This seems like the ideal solution,
>> since it solves the entire problem and doesn't need more hacks bolted
>> on.
>
> I think the main complication is that the reachability rules are used
> during object transfer. So you'd probably want to introduce some
> protocol extension to say "I understand gitrefs", so that when one side
> says "I have sha1 X and its reachable objects", we know whether they are
> including gitrefs there. And likewise receivers with
> transfer.fsckObjects may complain about the new gitref tree mode
> (fortunately a new object type shouldn't be needed).

Quite honestly I do not think backward compatibility here matters.
When gitlinks were introduced, a repository that was created with
gitlink capable version of Git would have failed "git fsck" that is
not gitlink aware, and I think this new "link with reachability" is
the same deal.  No existing implemention understands a tree entry
whose mode bits are 140000 or whatever new bit pattern we would
assign to this thing.  You have to wait until both ends understand
the new thing, and that is perfectly OK.

Besides, I think the point of having this discussion is that Josh
did a good prototyping work of "git series" to discover what he can
do in that area of "keeping track of history of history" and what
operations are useful, without wasting time on mucking with the
object model and traversal machinery that are available to him.  

Now his prototyping is at the point where he knows at least one
enhancement to the core that would help him to redo the prototype in
the right way.  And I do not mind helping him from the core side.
