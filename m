Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7180B2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 17:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcHHRzj (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 13:55:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751479AbcHHRzi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 13:55:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B9213256F;
	Mon,  8 Aug 2016 13:55:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xq35Y+PK5XWXGh8Auifbkpj5WaE=; b=UY0G8Y
	rZXf5HTZ+PSIXQQaWsz82Tmc2pLX6kwOC16EWVyl+LRruL3Ta9reHfR74jkzXlYF
	l9qfOM+MC+ctkQxIaKzQ+Y3GtkQaxsEBRV+6CENXWig3Nc+iQBKEOPPZ6advHFON
	zfcJ45FDtqsTd22jY63nUJRGoedECJ56lzCng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pGwZjyyYmyC5VAHU5nV2X2Z+9PZv1aVy
	ZFi399NxxI/pHW+qdOJqz/iCeKv1aWDdVYBnQLY+KMoxbAr2fi8Wq7KNSZcO58cc
	Fu3KGuI8lTziU/BCQla85f0E7zVWP+KF7HE0e5rrqIOPBZ/Aomt0wYzcGR/Kf51D
	OzFBeC7VZPg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DD763256E;
	Mon,  8 Aug 2016 13:55:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D00293256D;
	Mon,  8 Aug 2016 13:55:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge: use string_list_split() in add_strategies()
References: <57A4FEAF.3040208@web.de>
	<alpine.DEB.2.20.1608081034250.5786@virtualbox>
Date:	Mon, 08 Aug 2016 10:55:34 -0700
In-Reply-To: <alpine.DEB.2.20.1608081034250.5786@virtualbox> (Johannes
	Schindelin's message of "Mon, 8 Aug 2016 10:39:08 +0200 (CEST)")
Message-ID: <xmqqeg5zf8mh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F9B92CE-5D91-11E6-B822-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I wonder, however, if we could somhow turn things around by introducing
> something like
>
> 	split_and_do_for_each(item_p, length, string, delimiter)
> 		... <do something with item_p and length> ...
>
> that both string_list_split() *and* add_strategies() could use? We would
> then be able to avoid allocating the list and duplicating the items in the
> latter case.

I do think such a feature may be useful if we often work on pieces
of a string delimited by a delimiter, but if the caller does not see
the split result, then the function with "split" is probably
misnamed.

I however suspect the variant of this where "delimiter" can just be
a single byte would not be so useful.

If the input comes from the end user, we certainly would want to
allow "word1 word2\tword3 " as input (i.e. squishing repeated
delimiters into one without introducing an "empty" element, allowing
more than one delimiter characters like SP and HT, and ignoring
leading or trailing runs of delimiter characters).

If the input is generated internally, perhaps we should rethink the
interface between the function that wants to do the for-each-word
and its caller; if the caller wants to pass multiple things to the
callee, it should be able to do so without first having to stuff
these multiple things into a single string, only to force the callee
to use this helper to split them out into individual pieces.

