Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935E21F403
	for <e@80x24.org>; Mon,  4 Jun 2018 02:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeFDClF (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 22:41:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38442 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeFDClE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 22:41:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so41499285wrf.5
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OljyrbtE1cpWHRxLMFz+qDDwMf+J4H+Chg31Kyewxsg=;
        b=AzVvlQQZctSISAaWhR7sI3PqUPuwwwQXbps4MXMWQX3t8NG8vg8mCE5JUWumJe54/8
         cikcJOHNSVUO0uApgqTqH5+rHi1Cs2hp2LwxAGDAB6tkoIDny7kXbJ6jLOS88wBlny3a
         NraB3U4rL3ibV2zISDVIrSzTWMvA83qUpIliOMyKA9icsiGvuaqRC2MCEhcuWEmeJ6Og
         hZO1/XVuE+v4DsuM/YnF1xFOWbwwzeCamJYKLLmJD59ixzFKAI3ujsNWnlbQ6yAe81/6
         Kj7Dvz2L0dSN68FqaaNjh4xSr99TmlPx5uL4hNnAHEJZK78FxtjDOOot2PWa01VYZ6QK
         EjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OljyrbtE1cpWHRxLMFz+qDDwMf+J4H+Chg31Kyewxsg=;
        b=KbDULe7gCkhHGRP3BPWSAxK9kRPAuaLD8DxkTJpz8BoUGsSWPn7NcH+JobRGrspYh8
         /AnxJ9N5MRq1r7auTQayF9jH4nfjgoLLpuFciBVOniFWJ+p2TCUBCM0aQD8XpaPUbV1W
         xyCksRKMEfE9CRCvGfCNypy0Nux7p0TpMKq8Ns2AcF8M5zfIOIdp5ioAOpzbKUvW01r6
         +0ANfCaSmthKAw+rTy78mFtG6ss5y+K4U3nv0rHcHWenuf++T0a0KZnBtwEjT7KQwhry
         AQlaSDO3KL7QfOyow2lXNZ7h7gEhILp6gfi4CrDG/4qp4ab9CJAU7I6BH2C/n40E2Pb1
         9jUA==
X-Gm-Message-State: ALKqPweZHgDGrQEWC8blyC8rCWj3rdYHMIH93JdUk8ip2eYc7kpylm1w
        r5HJ42dGMgE/QpCczYQ5iek=
X-Google-Smtp-Source: ADUXVKJrMP2SPR0o5rK8DIjPrI5jPgEdrsZtdoeqLCeYtaPazEWogsoruNNN4b0YqEsFzZ4aTOg+5A==
X-Received: by 2002:adf:ba8f:: with SMTP id p15-v6mr7891326wrg.139.1528080063287;
        Sun, 03 Jun 2018 19:41:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a14-v6sm6106735wmb.44.2018.06.03.19.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 19:41:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
References: <20180601200146.114919-1-sbeller@google.com>
        <20180601200146.114919-2-sbeller@google.com>
Date:   Mon, 04 Jun 2018 11:41:02 +0900
In-Reply-To: <20180601200146.114919-2-sbeller@google.com> (Stefan Beller's
        message of "Fri, 1 Jun 2018 13:01:46 -0700")
Message-ID: <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index b98690ecd41..aba03e9429a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -175,6 +175,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>  			warning(_("invalid commit message cleanup mode '%s'"),
>  				  s);
>  
> +		free(s);
>  		return status;
>  	}

Shouldn't 's' now lose 'const'?  After all, git_config_string()
gives you an allocated memory so...
