Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7388B202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 01:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbdJTBOM (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 21:14:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64884 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750960AbdJTBOL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 21:14:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB95BA51B5;
        Thu, 19 Oct 2017 21:14:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rXf+BPyqs7fj30MtShwXAEok5yY=; b=TPdMgr
        T4btkpqzzRPbP+bttjG0yiO2hA7vZcunpzGQ/rfSfzLFC4bQiswotogx3UreJqg5
        NJbIc9h5+q0cD6XWL2Z3TSceiTRgH2NSSwW6YXO+kpopItfIvDG49CyXAqP/YvMv
        2KpbCfnz2ZNXf1pi7+dffgrVlIR25KEh4UVpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gye366ly1yaA++82uVKAHZIeUALIYuL+
        2GOD+Khf8OE0+kV4T57gkJxaR0M0xbiTJK6C8Fvn8PNOcN5yJNbZNF9yUHrdww1M
        Eaz52dwQ6lvY6bZjikhUnpaTzuBHWlfNy2m4FMqWg1vjZBmGemotl1Ma1+8kQsLn
        0S9UHolYG+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1BD6A51B4;
        Thu, 19 Oct 2017 21:14:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2060BA51B1;
        Thu, 19 Oct 2017 21:14:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <peartben@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        git@vger.kernel.org, jeffhost@microsoft.com, t.gummerer@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v1] read_index_from(): Skip verification of the cache entry order to speed index loading
References: <20171018142725.10948-1-benpeart@microsoft.com>
        <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com>
        <db8da340-f8f5-0114-392d-e415b5564993@gmail.com>
        <20171019160532.54teojqnhkeo2yfv@sigill.intra.peff.net>
Date:   Fri, 20 Oct 2017 10:14:08 +0900
In-Reply-To: <20171019160532.54teojqnhkeo2yfv@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Oct 2017 12:05:32 -0400")
Message-ID: <xmqqh8uuipsv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA1AF776-B533-11E7-823D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It should be easy enough to check that; the patch below implements it.
> I couldn't measure any speedup with it running "git ls-files >/dev/null"
> on linux.git (60k files). But nor could I get any by dropping the check
> entirely.

I would expect that the speedup (due to possible cache effect)
wouldn't be measurable if the overhead of the existing check itself
is unmeasuably not-expensive.  No suprise here.

> This is mostly just a curiosity to me. For the record, I have no real
> problem with dropping this kind of on-disk data-structure validation
> when it's expensive. After all, we do not check the sort on pack .idx
> files on each run (nor pack sha1 checksums, etc) because it's too
> expensive to do so.

Yes, I agree with that stance, too.  If this were expensive in the
overall picture to be measurable, I think we are OK omitting when
the index is read, especially if we make sure we are not writing out
nonsense trees out of it.  Local damage to the index is very
contained as long as we do not spread breakages to trees and
commits.
