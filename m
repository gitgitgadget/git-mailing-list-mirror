Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01071F453
	for <e@80x24.org>; Thu, 18 Oct 2018 12:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJRUxe (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 16:53:34 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33907 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeJRUxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 16:53:33 -0400
Received: by mail-oi1-f178.google.com with SMTP id v69-v6so23919166oif.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 05:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BONLBGgbbgf6X4MnFZhZUYjKI0JxjnvE3zsIgRYv5Nw=;
        b=GQVr6f15Ul1ZSZj8a6j+3xCEOLUcU4AlRROaLQCG88NNVUXNXYEQDSQP1NKBMAox93
         +kadjo0kNvvYoEypafZsknkdXJt9i3+Bd7l8QEtKBfJONkWFg0DF0/ATGjN+v2PSxJGv
         5etkAr8rChbTcESQmKLgxxumZ0ZEUZ5yLmMY6Ez+mMsokYmzNZU+1+kqkBHLPIHJMIsb
         aoMXWIxQRoleavTrEf1yU5hLOc+HmCElESaBHUKGcptdzLHdg0ZFn3nVkx0nihAh/nl9
         uC93juEObEFmQASeR9KQfsWeeG1xAVUy8uQ7+vwYXUT5C0xEuO6Pl7cM9wCFX/FfGqV+
         caXw==
X-Gm-Message-State: ABuFfoju0DVmF+fbVPebVHsUsJcNXtMkUKdx9jaxjeub0yFDmq+OT9A+
        jGpyp23DTfkBWG8cQJKHntk1PQh2BtIfNNrunBcT8Atl
X-Google-Smtp-Source: ACcGV63gxDSftVTgk82FTBRJvuk5YH3Z37Go5YGAyHTwxfyV/tEmEO0gMhI++Toqe4/TSdr7l+HW9KVHgOYx7d7qR1c=
X-Received: by 2002:aca:d785:: with SMTP id o127-v6mr16578306oig.33.1539867160715;
 Thu, 18 Oct 2018 05:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181017134947.12571-1-agruenba@redhat.com> <20181018065328.GC23537@sigill.intra.peff.net>
In-Reply-To: <20181018065328.GC23537@sigill.intra.peff.net>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Oct 2018 14:52:28 +0200
Message-ID: <CAHc6FU7iZN6t-mN=nrAptg7WgeDGXVpKwZawSq80+S-bKH1isg@mail.gmail.com>
Subject: Re: [RFC v2] revision: Add --sticky-default option
To:     peff@peff.net
Cc:     git@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Oct 2018 at 08:53, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 17, 2018 at 03:49:47PM +0200, Andreas Gruenbacher wrote:
> > @@ -2431,7 +2446,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
> >               opt->tweak(revs, opt);
> >       if (revs->show_merge)
> >               prepare_show_merge(revs);
> > -     if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
> > +     if (revs->sticky_default)
> > +             cancel_default = has_interesting_revisions();
> > +     else
> > +             cancel_default = got_rev_arg;
> > +     if (revs->def && !revs->rev_input_given && !cancel_default) {
>
> How do you want to handle "maybe has a ref" options like --stdin,
> --tags, etc? Those set revs->rev_input_given.
>
> With the code you have here, rev_input_given overrides any
> sticky_default decision, and you cannot do this:
>
>   git log --not --remotes=origin
>
> and get the default, because even though you have only UNINTERESTING
> commits, rev_input_given is true.
>
> If you move rev_input_given to the cancel_default line above the final
> conditional and turn that conditional into:
>
>   if (revs->def && !cancel_default)
>
> then it works.

Yes, this still needs fixing, I'm just not sure yet if this is the right way.

Thanks,
Andreas
