Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA5C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B30F61183
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhIUF0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:26:21 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41889 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhIUF0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:26:21 -0400
Received: by mail-ed1-f47.google.com with SMTP id co2so23310223edb.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2RMNtyFRUBa2zpglo8lKRLhMfrHl8SPxqJdvTWQEpk=;
        b=FK943FSJEk/gUI9nuYQL598qhGjcbMk3udtZpFAk62A6twSGO9krXBdwjuuZMMxAEm
         JDrbWdAeANIttzY5uEZX7zUfAnZrmSVDxl2VtW9KS2nZELkKz0gRlzemhW4X0nynL5PA
         tlVi/liNFipEzpkHkU4ukq5mFDyU6duRQlapFZTcMFDwX7Rb+33wB3+bYTX1rx67l1SQ
         Eca8UWpkiFErJduLnm5i31kiYOHU6pidW2ZN+fuLt9n1RL4IqSG9hT3hEdXo/NBofSoF
         BT6xn/LB/lxdI9yxjZQDdmTooAyiuuHhwODGtN/5cYvtY8btJYo1f4qvK6+PD7PRC2Ug
         IZ+w==
X-Gm-Message-State: AOAM531Al4PKgEJxXwhmd1JVoycXbQ9zM4A84cVIPOZ+TpOVF9H0c+Ab
        +SZkygOl1iPalRf2NJLv6J57QMnejBcYPrjX9T4=
X-Google-Smtp-Source: ABdhPJy9N5I61JZHhurmSosO5HX8LF0jBJY8exyOSbP+CkCK2KwMyrpvciLTtHIAbz0+PldFiXbFWVPj5y2p9KD8w7E=
X-Received: by 2002:a17:906:4691:: with SMTP id a17mr31876736ejr.36.1632201892264;
 Mon, 20 Sep 2021 22:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net> <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
In-Reply-To: <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Sep 2021 01:24:41 -0400
Message-ID: <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 1:18 AM Carlo Arenas <carenas@gmail.com> wrote:
> On Mon, Sep 20, 2021 at 9:09 PM Jeff King <peff@peff.net> wrote:
> > @@ -971,7 +966,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
> >                 switch (p->field) {
> >                 case GREP_HEADER_AUTHOR:
> >                 case GREP_HEADER_COMMITTER:
> > -                       saved_ch = strip_timestamp(bol, &eol);
> > +                       strip_timestamp(bol, &eol);
>
> Why not something like (plus added error handling, even if it seems
> the original didn't have them)?
>
>   eol = strrchr(bol, '>');

strrchr() would search backward from the NUL, not from `eol`, thus
would not be a faithful conversion (and might not be safe, though I
didn't dig through all the callers).
