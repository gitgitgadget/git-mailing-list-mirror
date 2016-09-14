Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65F420984
	for <e@80x24.org>; Wed, 14 Sep 2016 05:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754710AbcINFy6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 01:54:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57139 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753849AbcINFy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 01:54:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86F0A3FF9E;
        Wed, 14 Sep 2016 01:54:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=de1SaSNGq54gFmOobJSinqitzsI=; b=rHw3Uf
        safZw/k6J+SgzPV4ON4ik01UAlmslagbWf+IFa9EJuPOPe7FA8TMhb+Ydvc/y4s1
        ssAXKy97Zev1iZsEEQm5WBwK13+V6CUQc7vbF+CVQzOkRjf4BKdjkHS/HoDyJzB/
        btKTtMxqfSjiuLm6U1owrShy9Rd7FHJbzXIME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CjEEnVjpFq7rhAbD5l6S12FNAaN0+Yx9
        GX1FY5KAU9e4IRrfdDkGeP+hphsqAXM0WtYbH7ivKJYkEbbSlOk2aF4XUhmrSmEt
        br/Fqq2qsObCDyVuF/zMuDYm7W3tAdxOtji5ADe94N73TdpT9C7x4/6FIXX/p6YA
        Hv4818PmkNs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E04C3FF9D;
        Wed, 14 Sep 2016 01:54:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB6703FF98;
        Wed, 14 Sep 2016 01:54:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
        <20160913234612.22806-1-me@ikke.info>
        <20160913234612.22806-2-me@ikke.info>
        <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
        <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
Date:   Tue, 13 Sep 2016 22:54:47 -0700
In-Reply-To: <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Sep 2016 22:09:20 -0700")
Message-ID: <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFBD6C6A-7A3F-11E6-AA51-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It has been a while since I looked at rfc2822, but aren't the quoting
> and syntax rules different for addresses versus other headers? We would
> not want to dequote a Subject header, I think.

You're absolutely right.  RFC2822 does not quite _want_ to dequote
anything.  As you pointed out in a separate message, we are the one
who want to strip out "" quoting when mailinfo says

	Author: "Jeff King"

to its standard output (aka "info"), and turn it into

	GIT_AUTHOR_NAME='Jeff King'

and do so ONLY for the author name.

So I would think it is the responsibility of the one that reads the
"info" file that is produced by mailinfo to dequote the backslash
thing if the mailinfo gave us

	Author: "Jeff \"Peff\" King"

