Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0262FC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 22:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D58220758
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 22:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w6x04ed4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgITWPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 18:15:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60185 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITWPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 18:15:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C36A1EC8DA;
        Sun, 20 Sep 2020 18:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=80w93mv/FLbawb//8O/5SIqLepc=; b=w6x04e
        d40v1VvOFmJwE0nHLqRp64N22ACB0Eix9Gl07mkQzvSxbYEicTa0L7PeDHwx0GXf
        Bd6XBfn6qxhvyGjq0S1idfZ/aY1utbvFofGzZ22AJSW6ZZXV+iDu8mCcro4+RMoj
        /6RF7B0oUoDca19Jkk3iDOn8m7WsMDVLCUBb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S2mDiVSTGHG937kS/j30aZZEsFyJ2Gda
        Uufcw+YK5YEUcNqJgGCufbr3X5h7w5JqBO0fb3nKbPKxQ0iBLgbqPeFh/WioV5Yk
        pNRQ6292melLD4qvJPaDZsOQicgPR37kqRfW+iogadEYkXuwCIAvXexUwgPvk5/g
        nrLYf8WXoAM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A770BEC8D9;
        Sun, 20 Sep 2020 18:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8494EC8D8;
        Sun, 20 Sep 2020 18:15:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca, peff@peff.net
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-2-tguyot@gmail.com>
        <20200920130945.26399-1-tguyot@gmail.com>
        <20200920153915.GB2726066@nand.local>
        <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
        <xmqqd02ggp84.fsf@gitster.c.googlers.com>
Date:   Sun, 20 Sep 2020 15:15:28 -0700
In-Reply-To: <xmqqd02ggp84.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 20 Sep 2020 13:36:27 -0700")
Message-ID: <xmqq8sd4gkn3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB101EDA-FB8E-11EA-A54D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

Sorry, this will be the last message from me on this topic for now.

> we'd probably need to factor out the condition used in the above
> into a helper function, e.g.
>
>     static int cannot_be_the_same(struct diff_filespec *one, struct diff_filespec *two)

The naming of this helper is tricky.  In both potential callers,
what we want to see is "one and two may be different, we cannot say
they are the same with certainty", so "cannot be the same" is a
misnomer.  Worse, the negated form is hard to grok.

Perhaps "may_differ()" is a more correct name.  If either side is
NULL oid, we cannot say they are the same, so it is true.  If two
oid that are not NULL oid are the same, there is no possibility that
they are different, so we return false.  And two oid that are not
NULL oid are different, we know they are different, so we return
true.

>     {
> 	if ((oideq(&one->oid, &null_oid) || oideq(&two->oid, &null_oid))
> 		return 1;
> 	else if (oideq(&one->oid, &two->oid))
> 		return 0;
> 	else
> 		return 1;
>     }
>
> and rewrite the conditional in fill_metainfo() to
>
> 	if (one && two && cannot_be_the_same(one, two)) {
> 		...

And this becomes much easier to read and understand, i.e.

	if (one && two && may_differ(one, two)) {
		... create the index one->oid..two->oid header ...

> The "second best fix" could then become a single liner:
>
> 	same_contents = !cannot_be_the_same(one, two);
>
> using the helper.

And this becomes

	same_contents = !may_differ(one, two);

meaning that "there is no possibility that one and two are
different".  That allows us to optimize out the invocation of the
xdl machinery.

