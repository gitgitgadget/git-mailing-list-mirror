Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA59620960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755306AbdDMSDi (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:03:38 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33542 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbdDMSDg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:03:36 -0400
Received: by mail-lf0-f49.google.com with SMTP id h125so33331049lfe.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xU3acw576bj/uDJlFzvAjQzxm2e/TWpChOXO9219PG4=;
        b=GSYLQPi4TGE4Me7Y8kUoYhT7hRBrWGAkDpvzyKhRTEP043aMXCVzaRIGleKgi+bls1
         hy1+xitxwpMRql2uuqsNx3hiByaO7TzZWbBffPi+UQAQDGbyoDR73g06l3+CKT3/RYOJ
         EDDdPuDY0n0f3LnwhY3ejHTQn3Tz+NrgwnVPVJrJ4mQtqxNPqdF3l93KhdK+Tm9HVX5A
         5udII+AWBtAysPa9YR4K1IekHdANzpjj+/ACWWPU5RS3gdW8y8TDq9QD0YsBP2NZP+gP
         YuBZRHebXg2y+KY1RJLjVFjZMMv4Y7zHFBveApSuOHLB6KTPvX3BTcymmaJN7uZufqxX
         UE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xU3acw576bj/uDJlFzvAjQzxm2e/TWpChOXO9219PG4=;
        b=XPBEfMi/uoObXK9WOBKejseyCbCHThfcIsvJ+cHhXI7LrVYLvIZASbrPX4M4hW2vQv
         LGP7rqSCMrXSGOovij9mdCejolyoJjEaEyTqSdn5IQO3D+vatHGh+68dUICBKYwaGNLQ
         nWUiby9pudrRpXobvREBlXaaeK0Tp6FanVX+20fN/Ey1dqVIKs+VcB3OgvoyhQaXQniv
         hucs+OxxhGOnzDWn5GZImVsGYHTPr/RScd4SL2LSiqbrL9ioaGME3dyPS0XRA2j6TKeO
         fcBPD//hOaR9XWDtSi171LiuXubMxB3xmGxRdZcwkTVL60S93vBaAAFiRlxrv0iq/qjl
         cytw==
X-Gm-Message-State: AN3rC/6h5hhk5VwuFNcXhVHNVSHCfWh/31lCaW1neIIwZVY6iMgkQetZ
        yLPSiW4RJlzkH9PaVeIoCay23AB/Ew==
X-Received: by 10.25.216.212 with SMTP id r81mr1646090lfi.66.1492106615212;
 Thu, 13 Apr 2017 11:03:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 11:03:14 -0700 (PDT)
In-Reply-To: <1492104698.1527.79.camel@novalis.org>
References: <1492104698.1527.79.camel@novalis.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 11:03:14 -0700
Message-ID: <CA+P7+xo4mwA8DMeObq_T9=P9m7tG1d6afDS_Md56_EnhuXLVgw@mail.gmail.com>
Subject: Re: Simultaneous gc and repack
To:     David Turner <novalis@novalis.org>
Cc:     Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 10:31 AM, David Turner <novalis@novalis.org> wrote:
> Git gc locks the repository (using a gc.pid file) so that other gcs
> don't run concurrently. But git repack doesn't respect this lock, so
> it's possible to have a repack running at the same time as a gc.  This
> makes the gc sad when its packs are deleted out from under it with:
> "fatal: ./objects/pack/pack-$sha.pack cannot be accessed".  Then it
> dies, leaving a large temp file hanging around.
>
> Does the following seem reasonable?
>
> 1. Make git repack, by default, check for a gc.pid file (using the same
> logic as git gc itself does).
> 2. Provide a --force option to git repack to ignore said check.
> 3. Make git gc provide that --force option when it calls repack under
> its own lock.
>

What about just making the code that calls repack today just call gc
instead? I guess it's more work if you don't strictly need it but..?

Thanks,
Jake

> This came up because Gitlab runs a repack after every N pushes and a gc
> after every M commits, where M >> N.  Sometimes, when pushes come in
> rapidly, the repack catches the still-running gc and the above badness
> happens.  At least, that's my understanding: I don't run our Gitlab
> servers, but I talked to the person who does and that's what he said.
>
> Of course, Gitlab could do its own locking, but the general approach
> seems like it would help other folks too.
