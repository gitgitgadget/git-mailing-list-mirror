Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A701F404
	for <e@80x24.org>; Fri,  7 Sep 2018 17:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIGWUm convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 7 Sep 2018 18:20:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33115 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIGWUf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 18:20:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id z78-v6so10184054qka.0
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 10:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Ggs0a7OjbvG53cw19Foixo/2PFvIZLr6/+NH7gFPFE=;
        b=lnrYcSD7Hd+c1NAnROg60yb+gWQxgtC568otOGggQiFbV3+rv4ge4Zl8aH/Jzon5oU
         YQagkWuUsiup2KJMf3pZj7jq8cFG80Nswqnx2tbehdESOMBtYyf6Pd6Vm4D38TMQlj1I
         fi8b4s7MEYzQoH1465TY39nbd1/hjuW/ZB/qg5uRmRLsuAGgL0Hu+o4Ncjnq9o4UXED0
         UtK+BJjMm1t4fxh0iD9D5fj3PLD7Cc8++PXbkn3RqTllk2Lfuy++Fsiizv1cj3j2eMVS
         VcDWUZA8/dBjW3QYo4DrxMLxNhf/tWzkmoVUFI1ky9JEz00Ht/nmFTYzH0lls0IkM7kk
         ROdQ==
X-Gm-Message-State: APzg51Cl2nibFsPN5b4kLIWaHVZVWuJoX9HLANAJBCm6McxCIOXceSkX
        tnUanAma6MQ4hASUjBmx1rgSnPauZQ+icctxeJY=
X-Google-Smtp-Source: ANB0VdbBr8vRbGA6uka7WEGvds4wNPeR9SA5u21cxdwOGB9giAgfeZiZP2Nw/ycuedBWLKFdzwdz8+DlQbF249bv4pw=
X-Received: by 2002:a37:48e:: with SMTP id 136-v6mr6804076qke.26.1536341915291;
 Fri, 07 Sep 2018 10:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180907155133.27737-1-pclouds@gmail.com>
In-Reply-To: <20180907155133.27737-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Sep 2018 13:38:23 -0400
Message-ID: <CAPig+cQVCUyt5NvcSCAO63b1aO8HSc5AobCRKP5mp9jT_LYuJQ@mail.gmail.com>
Subject: Re: [PATCH] status: show progress bar if refreshing the index takes
 too long
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 11:51 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Refreshing the index is usually very fast, but it can still take a
> long time sometimes. Cold cache is one, or something else silly (*).
> In this case, it's good to show something to let the user know "git
> status" is not hanging, it's just busy doing something.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/read-cache.c b/read-cache.c
> @@ -1516,6 +1522,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> +               if (progress)
> +                       display_progress(progress, i);
> @@ -1547,6 +1555,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> +       if (progress)
> +               stop_progress(&progress);

Nit: Both display_progress() and stop_progress() behave sanely when
'progress' is NULL, so no need for the conditional.
