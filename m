Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FB22047F
	for <e@80x24.org>; Fri, 29 Sep 2017 07:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdI2HX6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 03:23:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:54240 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750977AbdI2HX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 03:23:57 -0400
Received: (qmail 24540 invoked by uid 109); 29 Sep 2017 07:23:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 07:23:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1531 invoked by uid 111); 29 Sep 2017 07:24:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 03:24:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Sep 2017 03:23:55 -0400
Date:   Fri, 29 Sep 2017 03:23:55 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
Message-ID: <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net>
 <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 09:18:11AM +0200, Christian Couder wrote:

> On Fri, Sep 29, 2017 at 12:42 AM, Jeff King <peff@peff.net> wrote:
> > On Thu, Sep 28, 2017 at 08:38:39AM +0000, Olga Telezhnaya wrote:
> >
> >> diff --git a/packfile.c b/packfile.c
> >> index f69a5c8d607af..ae3b0b2e9c09a 100644
> >> --- a/packfile.c
> >> +++ b/packfile.c
> >> @@ -876,6 +876,7 @@ void prepare_packed_git(void)
> >>       for (alt = alt_odb_list; alt; alt = alt->next)
> >>               prepare_packed_git_one(alt->path, 0);
> >>       rearrange_packed_git();
> >> +     INIT_LIST_HEAD(&packed_git_mru.list);
> >>       prepare_packed_git_mru();
> >>       prepare_packed_git_run_once = 1;
> >>  }
> >
> > I was thinking on this hunk a bit more, and I think it's not quite
> > right.
> >
> > The prepare_packed_git_mru() function will clear the mru list and then
> > re-add each item from the packed_git list. But by calling
> > INIT_LIST_HEAD() here, we're effectively clearing the packed_git_mru
> > list, and we end up leaking whatever was on the list before.
> 
> The current code is:
> 
> static int prepare_packed_git_run_once = 0;
> void prepare_packed_git(void)
> {
>     struct alternate_object_database *alt;
> 
>     if (prepare_packed_git_run_once)
>         return;
>     prepare_packed_git_one(get_object_directory(), 1);
>     prepare_alt_odb();
>     for (alt = alt_odb_list; alt; alt = alt->next)
>         prepare_packed_git_one(alt->path, 0);
>     rearrange_packed_git();
>     prepare_packed_git_mru();
>     prepare_packed_git_run_once = 1;
> }
> 
> As we use the "prepare_packed_git_run_once" static, this function will
> only be called only once when packed_git_mru has not yet been
> initialized, so there will be no leak.

Check reprepare_packed_git(). It unsets the run_once flag, and then
calls prepare_packed_git() again.

-Peff
