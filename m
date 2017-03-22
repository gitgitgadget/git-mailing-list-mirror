Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F42152095B
	for <e@80x24.org>; Wed, 22 Mar 2017 01:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758573AbdCVB6x (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 21:58:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51459 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757867AbdCVB6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 21:58:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5754D6DF7C;
        Tue, 21 Mar 2017 21:57:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=wehd0CGPAfjwfhoJe1rX0mvNjCI=; b=l+nmOm
        +femimcB5DSUgk63Na3gzra9tJ8xkokGJ4l9PUFmbLkoepvoFc8XRWg83QJAj1s6
        S5hBa0OucjYNF9kpSqqm8mnDdiRiCiwnoxGjndhm+Fr3jXrPaEMhLDa/OHzf0Twr
        um8JPhgSyZhIAKKSKwScf/CwfxKhtJO1G4gwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FB3C6DF7B;
        Tue, 21 Mar 2017 21:57:36 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC9EE6DF79;
        Tue, 21 Mar 2017 21:57:35 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] t1400: set core.logAllRefUpdates in "logged by touch" tests
In-Reply-To: <20170321014920.qas2xbbx66zqo5lp@sigill.intra.peff.net>
References: <20170321005616.31324-1-kyle@kyleam.com> <20170321005616.31324-3-kyle@kyleam.com> <20170321014920.qas2xbbx66zqo5lp@sigill.intra.peff.net>
Date:   Tue, 21 Mar 2017 21:57:34 -0400
Message-ID: <87k27ikr8x.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB9CF15A-0EA2-11E7-AC21-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=wehd0CGPAfjwfhoJe1rX0mvNjCI=; b=Ej2bbdyvJ8eTtFqfqqz9Lzlqmj2ypS6BkAIFa0pQGIh4YW/MFeqfyXacLkxqdoNiKSO5Iutd3ZTHmQQyuptAMzmCAM0vJUrQqfeaRmH+6FpD29QW8xdk/OdDbsUGehWNYgo+a5ykm91hEDqWWtC340VgDU1UT51uV+H+WRkpe6w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Mar 20, 2017 at 08:56:13PM -0400, Kyle Meyer wrote:

[...]

>> I'm confused about the setup for the "logged by touch" tests.
>> d0ab05849 (tests: remove some direct access to .git/logs, 2015-07-27)
>> changed the setup to delete the log file itself rather than its
>> contents.  The reflog was then recreated by using "--create-reflog" in
>> the "create $m (logged by touch)" test.  What I don't understand is
>> how this change fits with d0ab05849, which seems to be concerned with
>> loosening the assumption that the logs are stored in .git/logs.
>
> I suspect the answer is that the conversion was incomplete. That commit
> was done for alternate ref backends, which is an ongoing saga.
>
> I think it's OK to leave it as-is for now. It's not clear what "logged
> by touch" will look like for backends that don't use the filesystem.
> Probably it will need to call "update-ref --create-reflog" to kickstart
> it, and then further updates will automatically write to it.
>
> At that point the "rm -f" would need to become "tell the backend to
> delete this reflog". There's no command for that now, but we can add one
> later. Until then, I suspect the "rm -f" would be a noop. That means
> that the first --create-reflog test is failing to test what it claims,
> but the result passes anyway.
>
> And that probably answers the question about why the conversion is
> half-done. It was enough to get the tests to stop complaining when built
> with an alternate ref backend. :)

OK, thanks for the background.

-- 
Kyle
