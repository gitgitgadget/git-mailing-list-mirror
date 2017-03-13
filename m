Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 116DE20373
	for <e@80x24.org>; Mon, 13 Mar 2017 23:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754181AbdCMXbk (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 19:31:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51928 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751486AbdCMXbj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 19:31:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83DC5849B1;
        Mon, 13 Mar 2017 19:31:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ow1eBuY16thGuzjHW/IZDX8BSiU=; b=SQIOfN
        FOkciEoB/ZVu6NGUs/+e6KIv6Qk6k1Ff3YjCaiHvVRjZFRViSgGZSxxCikJNWnqg
        9287pl7ghWrsoqMReL8WvU+5Js9b1n5sxf2YgpTO9UpUGp71jPgiVCH+HyJn58pF
        4vF7PoInL2q62Z0TwdxHUWmYThY2p5gzcuaMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uAf5NVr5/Xwo5OTYqhCKy6qk/7wT7kXp
        e8+n7EhUIMMLtLnbyUbpElouSfgQI7T5M36AZzYrlQj6eOFUvQ5n6e/+r2pS9ZDT
        GVR98yfTsMr1XW+/X2qD6tDO/OOzLwHKuCZ5JOlwG/bYWnSF/BYD4bhc4diFqMen
        Vt4opI9VQY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D0DD849B0;
        Mon, 13 Mar 2017 19:31:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA464849AF;
        Mon, 13 Mar 2017 19:31:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 10/11] setup_git_directory_gently_1(): avoid die()ing
References: <cover.1488897111.git.johannes.schindelin@gmx.de>
        <cover.1489098170.git.johannes.schindelin@gmx.de>
        <a1e24f1b31773f4d2f7f06ab7d5870e920211d51.1489098170.git.johannes.schindelin@gmx.de>
        <xmqqefy5yn4k.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703131826330.3767@virtualbox>
        <xmqqzigpq7qp.fsf@gitster.mtv.corp.google.com>
        <xmqqvardq66u.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703132244400.3767@virtualbox>
Date:   Mon, 13 Mar 2017 16:31:35 -0700
In-Reply-To: <alpine.DEB.2.20.1703132244400.3767@virtualbox> (Johannes
        Schindelin's message of "Mon, 13 Mar 2017 22:46:27 +0100 (CET)")
Message-ID: <xmqqlgs8lpns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3388345C-0845-11E7-8631-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 13 Mar 2017, Junio C Hamano wrote:
>
>> When a patch series is refactoring an existing function to be used
>> in different codepaths, an existing issue inherited from the
>> original code (e.g. perhaps an existing error checking that is
>> looser than ideal) may have been OK in the original context (e.g.
>> perhaps it died and refused to run until the user corrected the
>> repository), and it still is OK in the codepath that uses the
>> refactored building blocks to replace the original code, but it may
>> not be acceptable to leave the issue in the original code when a new
>> caller calls the refactored building block (e.g. perhaps the
>> refactoring made it possible for a caller to ask the function not to
>> die and instead act on different kinds of errors in different ways).
>
> In this case, ...

It becomes somewhat irritating when you get combative and defensive
unnecessarily.  We already established this case is OK two messages
ago, I think.

The above is only to make sure that people cannot take the "issues
in the original is OK to leave outside the scope of a new series" in
my message out of context and treat it as a general rule to justify
their sloppy patches in the future.  We need to see if issues
inherited from the original is necessary to fix before refactoring
even begins on case-by-case basis, seeing what the requirement of
the new code that uses the refactored code.  And the case-by-case
thing we already did for _this_ case.

