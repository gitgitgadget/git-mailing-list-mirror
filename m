Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653B81FA7B
	for <e@80x24.org>; Wed, 21 Jun 2017 08:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbdFUIMU (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 04:12:20 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:32961 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbdFUIMS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 04:12:18 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Wed, 21 Jun 2017 10:12:11 +0200
  id 0000000000000065.00000000594A2A5B.0000799A
Date:   Wed, 21 Jun 2017 10:12:09 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     "=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
Message-ID: <20170621081209.gfqqkselek4bqdjl@ruderich.org>
References: <20170619220036.22656-1-avarab@gmail.com>
 <20170620155459.a6e7pypxx6vpdbvs@sigill.intra.peff.net>
 <87lgom8pew.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lgom8pew.fsf@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 08:49:59PM +0200, Ævar Arnfjörð Bjarmason wrote:
> If I understand you correctly this on top:
>
>     diff --git a/usage.c b/usage.c
>     index 1c198d4882..f6d5af2bb4 100644
>     --- a/usage.c
>     +++ b/usage.c
>     @@ -46,7 +46,19 @@ static int die_is_recursing_builtin(void)
>      	static int dying;
>      	static int recursion_limit = 1024;
>
>     -	return dying++ > recursion_limit;
>     +	dying++;
>     +
>     +	if (!dying) {

This will never trigger as dying was incremented two lines
before. But I think it's already handled by the dying <
recursion_limit case so we can just omit it.

>     +		/* ok, normal */
>     +		return 0;
>     +	} else if (dying < recursion_limit) {
>     +		/* only show the warning once */
>     +		if (dying == 1)
>     +			warning("die() called many times. Recursion error or racy threaded death!");
>     +		return 0; /* don't bail yet */
>     +	} else {
>     +		return 1;
>     +	}
>      }

Maybe restructure it like this:

    dying++
    if (dying > recursion_limit)
        return 1;
    if (dying == 1)
        warning();
    return 0;

Btw. is there a reason why recursion_limit is a static variable
and not a constant/define?

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
