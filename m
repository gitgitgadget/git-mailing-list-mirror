Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEC3207D6
	for <e@80x24.org>; Tue,  2 May 2017 03:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdEBD0S (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 23:26:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34188 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdEBD0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 23:26:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id t7so18845681pgt.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IcD9eHk2NgN7n1z/FxbI3P8WanzofCMql01a5RneOeg=;
        b=tAcG/XT0NGXPPMeN+HJgNdWKMk+3ctWyDg82RVoijnZVdXRAs146/QXq9x7bDu40Gi
         1m66rDI0t6fn+v+ym3proL+5hKEpLbZjw5+YjCkkvQhuVA6uxxBd4QUyKi8eJgWyrAQ3
         gcFrRZznZMtUxWtyfbnNDg1dckQWo/9xMgrJo6LNzelExZIOTbj9nHEeDltT95Tn0+1v
         u6OHYbevuEs/S/j8JAYJIg149q5Pb9NqabvkKMeE2aKDSC6eUcW2A9fBTUI4N+yHN5yg
         HlhvYf4rzLN01WqV5K5Lfk69XzxSloUaPYDePVTaBtzkMV99+ALHyvOx1Ub5daeXqPX0
         mDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IcD9eHk2NgN7n1z/FxbI3P8WanzofCMql01a5RneOeg=;
        b=XeWrnhmZWvKNK5qJBDuOqTFSsto2SaNjN9OQc1PEvXDQYc+N32WHpMdqVKfhEDNY5y
         uCN4qUp7g+zGBMG6jir/8c8zpbjAaw4ABtxX3zTilNrNaMlMKmWml7oRgL3IYRwfukEo
         ATCHIX91p8rL8Mx5rhLJh6IiXq7Hzvhot11JB5Dc6n2aTXRGJV9TwXja3X8tUn647Rwq
         tA8PFq2MITfSms+On5z+mr0HIk598hKMYAETz4wdlVesJngZRp7gr7/QFpneur/ckE2C
         6lKYqCq/3ZxRTbdPibEzbecjLvlcuKo0oh2hY2yIyNoVMbHWp/chKPXJGwZst2xkXDpv
         VGxA==
X-Gm-Message-State: AN3rC/4SFTFf7ctK10VSI+lrDm0ic4nxsUIPow/44Oc+vGc3QIaozTO4
        aZJ9tdB0EurRkSyVOGE=
X-Received: by 10.98.145.18 with SMTP id l18mr29646753pfe.173.1493695576689;
        Mon, 01 May 2017 20:26:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id g66sm8855635pgc.2.2017.05.01.20.26.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 20:26:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 23/25] name-rev: avoid leaking memory in the `deref` case
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <cover.1493387231.git.johannes.schindelin@gmx.de>
        <9e897d6f263bcf9a2b2bab613946fe1bf452eb91.1493387231.git.johannes.schindelin@gmx.de>
Date:   Mon, 01 May 2017 20:26:15 -0700
In-Reply-To: <9e897d6f263bcf9a2b2bab613946fe1bf452eb91.1493387231.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 28 Apr 2017 16:04:39 +0200
        (CEST)")
Message-ID: <xmqqd1bsdjmw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When the `name_rev()` function is asked to dereference the tip name, it
> allocates memory. But when it turns out that another tip already
> described the commit better than the current one, we forgot to release
> the memory.

Very well explained.

>
> Pointed out by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/name-rev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 92a5d8a5d26..a4ce73fb1e9 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -28,6 +28,7 @@ static void name_rev(struct commit *commit,
>  	struct rev_name *name = (struct rev_name *)commit->util;
>  	struct commit_list *parents;
>  	int parent_number = 1;
> +	char *p = NULL;
>  
>  	parse_commit(commit);
>  
> @@ -35,7 +36,7 @@ static void name_rev(struct commit *commit,
>  		return;
>  
>  	if (deref) {
> -		tip_name = xstrfmt("%s^0", tip_name);
> +		tip_name = p = xstrfmt("%s^0", tip_name);
>  
>  		if (generation)
>  			die("generation: %d, but deref?", generation);
> @@ -53,8 +54,10 @@ static void name_rev(struct commit *commit,
>  		name->taggerdate = taggerdate;
>  		name->generation = generation;
>  		name->distance = distance;
> -	} else
> +	} else {
> +		free(p);
>  		return;
> +	}
>  
>  	for (parents = commit->parents;
>  			parents;
