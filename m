Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598461F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbeGaLzE (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 07:55:04 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38792 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbeGaLzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 07:55:04 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so5924487ybo.5
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 03:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vj5iRZQ4iOCPaNgTX1nQcPOq1KSRCcTTEB6U1slSAOw=;
        b=aqqUYrU+TN923fezJtXHdoGtWKpbjZ5Fw+CoMx4o1ulpBk5Z8uz3BttLe4eWeBMZHp
         XW05m7eTLVIqwRo0Kirtzy5BE1hFfR4qAnTEyQGmvDf/ULOTYwz3GQ8PXysa/Ttwr0no
         H0Jo73eLCfIVVnRI5O1rlOrBMIpDqSPVEMLmdSR16x933Ts7xflzrIJH6zNY7KPLSGfE
         E5iVCioRTALTeQE3pGK8fAND6bhJlUaatG0QryWzjWDoATdzmp0OMnCIjWFCdn/Sx69w
         nftMrqKwJbzEucbFY8Wqukgs6jcw1nPZ2RROONRaMWRZE4rwRHclHv5QAKnp27dTKd+m
         IRCA==
X-Gm-Message-State: AOUpUlGw0/WnKMRzd4g+ce7Ti2jDe1nswHqL6qnAiFLEe1Q5us9OiBfT
        mZUCfpoSFn6g5zFcjq4I6OwWHCKE2c/XQsNo5dY=
X-Google-Smtp-Source: AAOMgpcId7OuR75nCDfadwSzIcMoa8F61dvjnTo39yM+vmjyh0kaT4pshZqYjd4krCi70o9DhzvNb9ny8vT2NFDfczw=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr1625311ybd.497.1533032127911;
 Tue, 31 Jul 2018 03:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731073331.40007-3-sunshine@sunshineco.com> <c80cf729-1bbe-10f5-6837-b074d371b91c@talktalk.net>
In-Reply-To: <c80cf729-1bbe-10f5-6837-b074d371b91c@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 06:15:17 -0400
Message-ID: <CAPig+cRu6fi_SG7LeTBjAWG8aoCT7LmSipDq2a9bPR0_Ae1pFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] sequencer: fix "rebase -i --root" corrupting
 author header timezone
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

On Tue, Jul 31, 2018 at 5:50 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 31/07/18 08:33, Eric Sunshine wrote:
> > -             sq_dequote(in);
> > +             if (!sq_dequote(in)) {
> > +                     warning(_("bad quoting on %s value in '%s'"),
> > +                             keys[i], rebase_path_author_script());
> > +                     return NULL;
>
> Unfortunately the caller does not treat NULL as an error, so this will
> change the date and potentially the author of the commit. While that
> isn't corruption in the sense that it creates a sane commit, it does
> corrupt the author data compared to its expected value. I think it would
> be better to die in the short term, or fix the caller.

Although the caller may not treat NULL as an _error_, it is
nevertheless prepared to handle NULL. Moreover, this new code mirrors
existing behavior in read_author_ident() in which it already returns
NULL for other errors encountered during the parse, so I think
returning NULL is the correct thing to do within the scope of this
patch series, especially considering that this series is about fixing
genuine commit object corruption from which a typical will be unable
to recover (and may not even notice until some time in the future).

While the unexpected change in value you describe is unfortunate, this
patch neither helps nor hurts that since the problem already exists in
that other parts of this function already return NULL, and since the
junk value used by read_author_ident() before this patch was already
an "unexpected change". More importantly, the commit object itself is
not corrupted by this issue, and this sort of "error" is something
from which a typical user is likely to be able to recover, so IMHO is
outside the scope of the critical bug fixes of this series. Fixing
that issue can easily be done on top of this series.

Thanks for thinking critically about this.
