Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5681C83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FF92085B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fc4neR1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgD1Red (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:34:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53326 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgD1Rec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 13:34:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53FEACE7A1;
        Tue, 28 Apr 2020 13:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=njzOgmSRhzQErU7lybeuVPf6nCs=; b=Fc4neR
        1JEYdHwXoZ0LHg75cozCOfyribWtrc9623Dtbr801Vwfi5ktHAAg/wFBNiHR5Z+E
        3v9CvLiaugD7KpXurXGIA1+RJ/RRFT9037wiYYXfPD6y+Cd2VzDXEneJt4VrN8fj
        0sCXbhCvq8Os2E13uNlXes7fdftqALJY31y4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nYSUBRGWDPLb04yjcfM/J7wIbpYROCjv
        2NVfHLB77KAGXdvS0OPusWYDI83QhYAoeGqlTsm70nZbJzxuCRcgyZu37i3LjQmc
        5whdJKOLCwz8aScyruqRVf1fPMLXJw1X2uUrCCUblf1ZqVAki4x37YXJ0cXcCU4I
        scLUAO+fbnc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C97BCE7A0;
        Tue, 28 Apr 2020 13:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FF7ECE79F;
        Tue, 28 Apr 2020 13:34:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andrew White <andrew.white@audinate.com>
Subject: Re: [PATCH] Use OPT_CALLBACK and OPT_CALLBACK_F
References: <xmqq7dy092tq.fsf@gitster.c.googlers.com>
        <d6d35a21a5bb1077eea4dd49f5716bece9e015de.1588062647.git.liu.denton@gmail.com>
        <20200428084543.GC2381876@coredump.intra.peff.net>
Date:   Tue, 28 Apr 2020 10:34:26 -0700
In-Reply-To: <20200428084543.GC2381876@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Apr 2020 04:45:43 -0400")
Message-ID: <xmqq368n4iql.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82749974-8976-11EA-B824-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Apr 28, 2020 at 04:36:28AM -0400, Denton Liu wrote:
>
>> In the codebase, there are many options which use OPTION_CALLBACK in a
>> plain ol' struct definition. However, we have the OPT_CALLBACK and
>> OPT_CALLBACK_F macros which are meant to abstract these plain struct
>> definitions away. These macros are useful as they semantically signal to
>> developers that these are just normal callback option with nothing fancy
>> happening.
>
> I think this is worth doing. It's a little easier to read, and sets a
> better example anyone copying the code.

Sure.

And it would be much nicer if the patch actually applies.  I am
getting "SHA-1 information for builtin/push.c is unusable" from 
"am -3".

I'd reject the first hunk on builtin/push.c as that part should be
done with an updated version of the patch that is titled "push:
unset PARSE_OPT_OPTARG for --recurse-submodules" and apply the rest
as an independent clean-up patch.

Thanks, both.




