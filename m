Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CDA1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeGaMKG (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:10:06 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46707 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaMKG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:10:06 -0400
Received: by mail-yw0-f195.google.com with SMTP id e23-v6so5549619ywe.13
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 03:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8b36Ek5elZWAvqknqSfwQmqDXv69kXoodgeu/dfV6Co=;
        b=jdNCV8RE0Rqsz4vf8TFwA+G+t4lmBvb1cXZFOnS/yEjQe6+jcTgipZQ/5/6fD/PwFa
         gxng7wh6XalbdzYvcTGoaXGLSI7yTmK/tuEbnMlycMUgY9ip8L0vnYA4ByX4aMOCGELG
         GbCCDN847SPy8CWG+svbl8g6EqqnwJ65pJ+JgfQwkoF7les237r8WwrrlaZ/LxNe2mxS
         SIs4u1Zak3a7FLFMvsnD0q9jkeCIQH73+cO4eNs5owMcOB6j9GUlW9Q86zS+ajQJur7Y
         ulItHWRFwXMC6s55x1ej1nBABCg6OcCVfTbT6yU5uR65aniVpfa+1BHXJJlzqsRyeHc+
         2uDA==
X-Gm-Message-State: AOUpUlFNCh0bdQRE9vPBPfc78N16jG3tX9spqOTVF6l2jQ+HjGrwKPfa
        /UstEzjZSolsGDOt6AvNUqOGVBXIotxIsXlLf5E=
X-Google-Smtp-Source: AAOMgpcRZBWdNeVWd6uq662SGxHjkp6S/uCF6hSRBHg4uW8kjLCa6NYAdkSMFO9DZQSBxCcf2NjmpQJhY1WqFkZ/SCM=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr10590738ywc.70.1533033026861;
 Tue, 31 Jul 2018 03:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731073331.40007-4-sunshine@sunshineco.com> <31870bca-329f-2451-750a-56d917153844@talktalk.net>
In-Reply-To: <31870bca-329f-2451-750a-56d917153844@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 06:30:15 -0400
Message-ID: <CAPig+cQQvZgFFWfn=OaJ969YKhGx5PQ3r6iSMBpqpjDZGBuViA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sequencer: fix "rebase -i --root" corrupting
 author header timestamp
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 6:01 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> Now that the author is correct, can we test_cmp() it against its
> expected value to make sure there are no hidden surprises in the name
> and email in the future. (It would be reassuring to test an author with
> "'" in the name as well but that is out of scope for this series.)
>
> +       git cat-file commit HEAD^ |grep ^author >expected &&
> >       set_fake_editor &&
> >       FAKE_LINES="2 1" git rebase -i --root &&
> >       git cat-file commit HEAD^ >out &&
> -       git cat-file commit HEAD^ >out &&
> > -     grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
> +       git cat-file commit HEAD^ |grep ^author >out &&
> +       test_cmp expected out
> > +     grep "^author ..*> [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
> >   ' >   test_done

I deliberately avoided test_cmp() in favor of 'grep' specifically
because I didn't want to hard-code the timestamp into the 'expect'
file since future changes to tests preceding this one could
potentially outdate the hard-coded value, and setting up my own commit
to ensure a consistent timestamp would have made this test longer and
less "obvious".

However, your approach sidesteps those concerns nicely. That said, I
think such a simplification could be done on top of this patch since
the current change to the test in this patch makes it very clear (to
the reader) that the "@" problem has been corrected, whereas it would
not be at all obvious if this patch incorporated your simplification.

While your idea is nice, I'd rather not re-roll this series just for
that. (I'd really like to see these fixes for this critical commit
object corruption land as soon as possible without re-rolling
repeatedly for "optional" or less important changes.) Perhaps such a
simplification can be done in the series you're working on(?).

Thanks for the review.
