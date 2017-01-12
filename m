Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABF31FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 18:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdALSfn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 13:35:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52952 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751003AbdALSfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 13:35:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1547D5F302;
        Thu, 12 Jan 2017 13:35:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mrVexNo241ICYWBlIk/JUHAWxxc=; b=JN9tTV
        1xPsGcwBySRa/VX8TP5cTFexnaeluWlU+EzHaxjh96D25fEwvRaiNTDTzLOgX3IA
        J1m8v5CzjfoiYRQGX4szWpgSU0Io19g4yS5mcYZF5YpcF3G2rHOtbShzvVuXu4EY
        XCm8LFKOc3PzJexjJqkYEmuTOs8c/PfjGFZHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=an23dJ2cPS+3e7TCNjnnSdew2S5nIvjY
        vB1MNsSzddLlithondBeVISsZaicb9MKnKEwgz9G/ChGWvHAfsAqRxIWHM00xfbq
        93Ps5bZshakfTCkYyTziXFXuF2wYH0gYgkF0tadrE9mNz7lEGdgcJHUDOu3xeb29
        kzKXuCdpdjE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C4A15F301;
        Thu, 12 Jan 2017 13:35:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52EDF5F300;
        Thu, 12 Jan 2017 13:35:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/38] sequencer: avoid unnecessary curly braces
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
        <cover.1483370556.git.johannes.schindelin@gmx.de>
        <bc1a6c21c9ab2f55882c363e802bfcf37e49d79f.1483370556.git.johannes.schindelin@gmx.de>
Date:   Thu, 12 Jan 2017 10:35:28 -0800
In-Reply-To: <bc1a6c21c9ab2f55882c363e802bfcf37e49d79f.1483370556.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 2 Jan 2017 16:26:08 +0100
        (CET)")
Message-ID: <xmqqk2a0ktxr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5226FFE-D8F5-11E6-8A10-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  
> -	if (!commit->parents) {
> +	if (!commit->parents)
>  		parent = NULL;
> -	}
>  	else if (commit->parents->next) {
>  		/* Reverting or cherry-picking a merge commit */
>  		int cnt;

The result becomes

	if (...)
		single statement;
	else if (...) {
		multiple;
                statements;
        }

which is not quite an improvement.  

The preferred style is for all arms in if/elseif/else cascade to
either use or not use brace pairs, so I think a fix toward that goal
would be more like:

	if (!commit->parents) {
		parent = NULL;
-	}                
-	else if (commit->parents->next) {
+	} else if (commit->parents->next) {
		/* Reverting ...

