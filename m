Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA77D2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 19:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbcIST6d (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 15:58:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54902 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932373AbcIST6b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 15:58:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C06913FE9B;
        Mon, 19 Sep 2016 15:58:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3fCgilH0Hw5v6HGVLfEjVAd1ZRc=; b=VGuRXI
        hK/qUyN5n9En4Phy/1ZMqhsaJxOo3wvXRaDV7eRJHDyF7JxjDoOt8bunBvGBORUu
        YCsohbPW1+2/BeqoIW9rtTdjbi4iAWigmU/CJNAwJX5Rr/LQ2MtcuA8dckfIg0EQ
        EN8XK3wM0MZ9Ysna+OgyCwCUqCvCRtlDvrC2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DfgRWFx0JFccu6WAl+ebPjnN++QKNSpv
        xGIXC7GRqY2aj0tDIoU7SjDl/fYfz8uBjnf6KqfOMWPobU6kazJivQ+KGxk4VoLK
        /IZlBeuN+AKmTnJoCj9263ZBacUkBVjBXs3+73vaBNdYQSNE0HO9WHCROW23z6L6
        V+r3UDHSxE8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B85B63FE9A;
        Mon, 19 Sep 2016 15:58:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35DF83FE99;
        Mon, 19 Sep 2016 15:58:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Michael J Gruber" <git@drmicha.warpmail.net>,
        "Git List" <git@vger.kernel.org>
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
        <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
        <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>
        <989F47918A374EEF8C7FECD3CFC6767E@PhilipOakley>
Date:   Mon, 19 Sep 2016 12:58:27 -0700
In-Reply-To: <989F47918A374EEF8C7FECD3CFC6767E@PhilipOakley> (Philip Oakley's
        message of "Mon, 19 Sep 2016 20:31:55 +0100")
Message-ID: <xmqqintrek64.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F3BD9B2-7EA3-11E6-9BA5-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>>     Philip probably has a
>> confused notion that "rev-list A..B C..D" is somehow a union of set
>> A..B and C..D?
>
> That wasn't the issue. Though it does beg the question that it's the
> same as "rev-list D B ^A ^C" isn't it?

If you think it begs the question, then you haven't understood what
I meant by all of the explanation.  Let me repeat:

	"A..B C..D" is exactly a short-hand for "^A B ^C D" which is
	the same as ANY permutation like "D B ^A ^C".

This is because rev-list machinery NEVER does "ah the command line
asks for two or more sets to be computed and then a union of the
results to be returned".  As I said, it collects positive starting
points (B and D) and negative starting points (A and C), and does a
single traversal "ones that are reachable from positives, excluding
the ones that are reachable from negatives".  That is all it does.

Once that is understood, it should be obvious that it would not have
any effect on the result to permute the order of positives and
negatives.

> I'd say it was the walk - no walk range confusion.

You may _additionally_ have had that confusion ;-).

> i.e. cherry-pick B D F G Q..T;  isn't B D F G R S T, is it?

Of course it isn't, but that is not about any ordering.  It is
because the machinery does not work this way:

  - we have positives B D F G and ... oh wait, we see Q..T, so we
    need to traverse ONLY that bit and come up with positives in the
    resulting set, which are R S T, and take a union of all of the
    above; and then

  - now we process --no-walk to show only the resulting positives.

The "--no-walk" tells the rev-list machinery "I have only positives;
do not traverse from them AT ALL but just use these positives".
Only under that condition, the order of the positive ends you list
on the command line matters.

Having ^Q in the input "B D F G ^Q T" contradicts that "I have only
positives" precondtion and forces the machinery to traverse, i.e. to
find things reachable from B D F G T excluding things reachable from
Q.  The order of the output would be topological (i.e. a parent is
not shown until all its children are), with or without --date-order,
and may not match the order you gave the positive ones from the
command line.

You may want the "exclude things reachable from Q" part to not have
any effect on things related to B, D, F or G, but the machinery does
not work that way.  That is because there is only one single traversal
and no union operation involved.

It is a different matter Git born in a fictional world that takes
A..B C..D as a union of two sets is better than the current one.
There might be cases where such a variant of "a set of commits that
is a union of multiple sets" is handy to use.  But I think we are
talking about what Git in our world does, so I'd not go there in
this discussion.
