Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC1320705
	for <e@80x24.org>; Thu,  8 Sep 2016 16:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966170AbcIHQ5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 12:57:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56439 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965359AbcIHQ5s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 12:57:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4361A3B1A4;
        Thu,  8 Sep 2016 12:57:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cMqTYwa8W2Zn2WOulydVjquQpZs=; b=hdV9Nk
        Ap7Y14ThOFdDLowpLoo0Fy0l1K7vrLewQFgu1e/EaBsP6D9eM539Rpk3W/w2PSth
        ayTsHZa28+Hx7SuZEypsx41xuU06oYzOOrUAKBagCTektLpJucNbJVHfpOCTMV3x
        47sRiREMKP9HN0OTOOrr0gIK+09xBM6wzGpx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tMaMFkF2o+db3Jl2mIJmeGt5TNZoulS7
        R9t8OLP9XHZoOGTDRm1NhxCNTwpW+p/InrhP3MchlW6Lq72oqJGwp98hrs4TVDHM
        8X8fYv758Ndgb+cY00atjmZc6YyNXSp3Kf0oqyu0A/A23KpVEK9kj0uzBXgs9z0/
        DoUENj84vaU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BF833B1A3;
        Thu,  8 Sep 2016 12:57:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B41593B1A2;
        Thu,  8 Sep 2016 12:57:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
        <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de>
        <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net>
        <alpine.DEB.2.20.1609061613270.129229@virtualbox>
        <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net>
        <alpine.DEB.2.20.1609080933470.129229@virtualbox>
        <20160908082246.saf7vlw2xgjo7jvg@sigill.intra.peff.net>
Date:   Thu, 08 Sep 2016 09:57:43 -0700
In-Reply-To: <20160908082246.saf7vlw2xgjo7jvg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 8 Sep 2016 04:22:46 -0400")
Message-ID: <xmqqa8fijpmg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E1119D4-75E5-11E6-AC32-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Between the two options for regexec_buf(), I think you have convinced me
> that REG_STARTEND is better than just using compat/regex everywhere. I
> do think the fallback for platforms like musl should be "use
> compat/regex" and not doing an expensive copy (which in most cases is
> not even necessary).

I agree with you that it would be the best approach to build
regexec_buf() that unconditionally uses REG_STARTEND and tell people
without REG_STARTEND to use compat/regex instead of their platform
regex library.

The description in Makefile may want to be rephrased to clarify.

-# Define NO_REGEX if you have no or inferior regex support in your C library.
+# Define NO_REGEX if your C library lacks regex support with REG_STARTEND
+# feature.

The word "inferior" is not giving any useful information there.

