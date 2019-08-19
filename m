Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094E81F461
	for <e@80x24.org>; Mon, 19 Aug 2019 22:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfHSWXN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 18:23:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54166 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHSWXM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 18:23:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F40C72373;
        Mon, 19 Aug 2019 18:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w1Kzha4U3Vzkwwncc2MoWDqo+Cg=; b=YyuwXc
        0W4j+pvmkL5m8bIIcXxBfcwz9Y79KaH1H54IlogiV73db1K6K/FondtZAhLMcV6g
        g7MXGrgAAP5VO2xv6Z4K/f5XOvMR36fIFZ5yl7j39P9EtSx2oDHd2C94pA1lnX0J
        SK4vxCtHtOXv1P9lkS/HaQl4l9m1r8qEg+t4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZKLV39yFVLI94e18EisjbaXzk4JJ2mfZ
        b5qTn1R331GvmJC/mFxcrivjBUhAkPC1yLEEkn7NujEZHp0ynPY+6yyh3HXLQ1K3
        9qQkCSIsO+J/iJzNRx5O2IhQdFcovgXEsqzkGCVvfnkzmXSKXPsmq2Xr20Q2nIo3
        5mU0QZbuUOo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7804072372;
        Mon, 19 Aug 2019 18:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A216072371;
        Mon, 19 Aug 2019 18:23:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] grep: under --debug, show whether PCRE JIT is enabled
References: <20190818201727.31505-1-dev+git@drbeat.li>
Date:   Mon, 19 Aug 2019 15:23:07 -0700
In-Reply-To: <20190818201727.31505-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Sun, 18 Aug 2019 22:17:27 +0200")
Message-ID: <xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECB4482A-C2CF-11E9-AE70-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> This information is useful and not visible anywhere else, so show it.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> ---
> This applies on top of 'ab/pcre-jit-fixes', currently in pu.

Thanks.  

We saw a few people exchanging patches on the list and discussing
topics aroud PCRE and especially JIT, but the discussion petered out
during the prerelease freeze.  I'd like to see the topics solidify
early in this cycle.

IIRC, some key points/issues addressed by various patches we saw
during the last cycle were:

 - A binary may be prepared to be JIT capable, but on a particular
   system (e.g. SELinux) JIT may not work.  Should we write off such
   a configuration as "broken"?  Should we just fall back on non-JIT?
   Should we fall back with loud warning?

 - JIT and non-JIT codepath may validate UTF-8 differently without
   care, but we should make sure JIT codepath behave identically to
   non JIT (only faster).

 - We should not be validating strict UTF-8 when we do not even know
   if the payload is UTF-8.  What mechanism, if any, do we have to
   let us say "this must be UTF-8 or otherwise it is an error" with
   confidence?  Should we error out in the middle of "git log"
   session upon seeing a binary haystack while looking for UTF-8
   needle (I think not)?

There may be others I am missing.

Is ab/pcre-jit-fixes a good base to collectively work on to finish
the topics floated around PCRE during the last cycle?

I'll queue this debugging aid on top in the meantime.  Thanks.

