Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449F1C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142D32070E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 15:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgA2PAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:00:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39325 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgA2PAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 10:00:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so20532061wrt.6
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 07:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFz7BHa6bpjZisDQ8U8RTrP/Akepf5mMgPcxQII+pO8=;
        b=BlMlUvcRqW+uTPWQOS+fGwvRhAKEcUEPwN/pzWk5EAE2RYN1LxQlApwxv01A10Hg4X
         WCb1pJZrlJETtBKRYiwCWYLKUC2DwZcNzaKbXeqBs/lbkJoijqh8Qi7NbzupGMIvSs1w
         I29zsDG46F6Trg2oPB1MGRHpLLIwXHzSKr28cyH+PwpG5ASlNJ9+8vRCqmYn5Aa5BOfC
         8uqkFf5y9X7lbu+4DgbKrSTyPdTM8u3UaFgVByIKrnUfB7LE1lYbw/x0QAu1nqCxsuXG
         hmWe3CjNd9zndHhwPjUVli05YXs62PS7oGXg/pOWtSWCkvoCuEg9RPm6f8bis3rhgHJr
         KIgw==
X-Gm-Message-State: APjAAAUIEOY+n+kuOujkGryqFegc3+MksxHm8fz91pRr0MPxf35WHw5f
        TC4ZjpOuJiz/YAkRfvUbxYNTVJR6kWe4eeyOxjc=
X-Google-Smtp-Source: APXvYqwlMFPb7pGNQyYf5YwH8jnJXkwrLCRT5zGMkriPtk4VG9d3a33/57o0Fg+l5wtxdYuN+uxx6Oen4PFqrV6EmbA=
X-Received: by 2002:a5d:5752:: with SMTP id q18mr23175036wrw.277.1580310040731;
 Wed, 29 Jan 2020 07:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20200129111246.12196-1-luke@diamand.org> <20200129111246.12196-2-luke@diamand.org>
 <20200129111246.12196-3-luke@diamand.org> <20200129111246.12196-4-luke@diamand.org>
 <20200129111246.12196-5-luke@diamand.org>
In-Reply-To: <20200129111246.12196-5-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Jan 2020 10:00:29 -0500
Message-ID: <CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com>
Subject: Re: [PATCHv1 4/6] git-p4: create helper function importRevisions()
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 6:13 AM Luke Diamand <luke@diamand.org> wrote:
> This makes it easier to try/catch around this block of code to ensure
> cleanup following p4 failures is handled properly.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -3555,6 +3555,73 @@ def importHeadRevision(self, revision):
> +    def importRevisions(self, args, branch_arg_given):
> +        if len(self.changesFile) > 0:
> +            output = open(self.changesFile).readlines()

Not a new problem (since this code is merely being relocated), but is
this leaking the open file? Should there be an accompanying close()
somewhere?

    f = open(self.changesFile)
    output = f.readlines()
    close(f)

or something.
