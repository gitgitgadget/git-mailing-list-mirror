Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059EA1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756418AbcIUQH6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:07:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56949 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755320AbcIUQH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:07:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E30503C2C2;
        Wed, 21 Sep 2016 12:07:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=41ypPM47aesaf0EqA4IxQ/D690I=; b=bSM0A0
        9Kd/4TTomOLJxTG1GY7UiyUliyY+G4W9r2OAMHzTMkHJEy5mVbNv5dmXCUdkrb6T
        uUwcSp8W39xojssj435nMW02jTountKMHPcImtSzqFd6p1gGzxJJzak+X/RHJNZE
        JIJOFJJIFFcvPrmGzyvAN8ZGf3YbuSMVylm5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cUeXr2ZGv6upjPDJ4lRm863F7UW0IOqQ
        1kmtsb7q1B2WUdgSUB3BY7qNUB/na4fGJIubAdc4+xa8U6Z1frGTVLqrvUspS5KZ
        FQE72YaHDIxyoTvnPgGnU4a7SvIcbu7N50qquol8oTiLG3mUayjq2CD1YGs3tS2Y
        8m4qJqvg6r8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB5A33C2C1;
        Wed, 21 Sep 2016 12:07:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62FFF3C2C0;
        Wed, 21 Sep 2016 12:07:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Swift Geek <swiftgeek@gmail.com>
Subject: Re: [PATCH] mailinfo: unescape quoted-pair in header fields
References: <20160916210204.31282-1-me@ikke.info>
        <20160916222206.jz2d4gpaxxccia5p@sigill.intra.peff.net>
        <20160919105133.GA10901@ikke.info>
        <20160920035710.qw2byl3qeqwih7t5@sigill.intra.peff.net>
Date:   Wed, 21 Sep 2016 09:07:53 -0700
In-Reply-To: <20160920035710.qw2byl3qeqwih7t5@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 19 Sep 2016 20:57:11 -0700")
Message-ID: <xmqqtwd9b5ie.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E76C3BE-8015-11E6-B12B-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So if that's the case, do we actually need to care if we see any
> parenthesized comments? I think we should just leave comments in place
> either way, so syntactically they are only interesting insofar as we
> replace quoted pairs or not.
>
> IOW, I wonder if:
>
>   while ((c = *in++)) {
> 	switch (c) {
> 	case '\\':
> 		if (!*in)
> 			return 0; /* ignore trailing backslash */
> 		/* quoted pair */
> 		strbuf_addch(out, *in++);
> 		break;
> 	case '"':
> 		/*
> 		 * This may be starting or ending a quoted section,
> 		 * but we do not care whether we are in such a section.
> 		 * We _do_ need to remove the quotes, though, as they
> 		 * are syntactic.
> 		 */
> 		break;
> 	default:
> 		/*
> 		 * Anything else is a normal character we keep. These
> 		 * _might_ be violating the RFC if they are magic
> 		 * characters outside of a quoted section, but we'd
> 		 * rather be liberal and pass them through.
> 		 */
> 		strbuf_addch(out, c);
> 		break;
> 	}
>   }
>
> would work. I certainly do not mind following the RFC more closely, but
> AFAICT the very simple code above gives a pretty forgiving outcome.

The simplicity of the code does look attractive to me.  I do not
offhand see an obvious case/flaw that this simplified rule would
mangle a valid human-readable part.

