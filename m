Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4FA2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcF0QJL (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:09:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751745AbcF0QJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:09:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B8AB427AE5;
	Mon, 27 Jun 2016 12:09:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kv7T3WoRVBo6BBQmWz/7CvO2teY=; b=AM5/6l
	FSLKffJqGpct6GwkPreKdTqNBHubazGMm8l91rG8IQbfKmcSqOF2Ax9ruGCJpalj
	io9X0PfU1CntDqADhohYJVLikjBsSGtW2m7DJYUx1Q8gVPFDgjBkJsyuYAOQF6q5
	4hcyfjyr+cJ6to0m/4A4VvtXdrYjr6qkqKB3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xlfk6/Nbc241io01Kcu0A7kj9szWXRC6
	jw0uIeZ4BhEsd//S2o/OZqvppRhVOdRe06Ft4YlYF2sGezl6oK2DaPM3aOiKjdP3
	nTYUIstGPsxKFODVsidNRmTTD7RD0neyOlnjBD9zSF9SkWFrJHTL5Fi2XypFV7d0
	Dae4L+1O6Dw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B142827AE4;
	Mon, 27 Jun 2016 12:09:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3373527AE3;
	Mon, 27 Jun 2016 12:09:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: Re: [RFC] Native access to Git LFS cache
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
Date:	Mon, 27 Jun 2016 09:09:06 -0700
In-Reply-To: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 27 Jun 2016 07:38:33
	+0200")
Message-ID: <xmqqmvm6bom5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A554342-3C81-11E6-8810-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

larsxschneider@gmail.com writes:

> Unfortunately that fix helps only with cloning. Any local Git operation
> that invokes the clean/smudge filter (e.g. switching branches) is still
> slow.

Do you know where the slowness comes from?  Does Joey's new
clean/smudge interface help GitLFS?

You are not likely to get anything that knows that a blob object may
be named as anything other than SHA-1("blob <len>" + <contents>) to
Git core.  The remote-object-store idea that was floated by Peff and
Christian started running with at least maintains that object naming
property and has a better chance of interacting better with the core,
but LFS, Annex or anything that would not preserve the object naming
would not.

Personally, I view a surrogate blob left by LFS in the tree object
and filtered via clean/smudge a "smarter" kind of symbolic link that
points outside what Git controls.  The area outside what Git
controls is left to be managed by whatever the add-on does; Git
shouldn't even be aware of how they are structured and/or managed.


