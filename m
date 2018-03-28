Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC421F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeC1SCN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:02:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:46394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752935AbeC1SCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:02:12 -0400
Received: (qmail 14720 invoked by uid 109); 28 Mar 2018 18:02:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 18:02:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11493 invoked by uid 111); 28 Mar 2018 18:03:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 14:03:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 14:02:10 -0400
Date:   Wed, 28 Mar 2018 14:02:10 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] add chdir-notify API
Message-ID: <20180328180210.GA16565@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net>
 <20180328174041.GB16274@sigill.intra.peff.net>
 <CAPig+cQ0D+k+WmDWcaFHQj7DBb1RPfaUYwOvLosWXdHOzsoLOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ0D+k+WmDWcaFHQj7DBb1RPfaUYwOvLosWXdHOzsoLOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 01:58:18PM -0400, Eric Sunshine wrote:

> On Wed, Mar 28, 2018 at 1:40 PM, Jeff King <peff@peff.net> wrote:
> > [...]
> > Let's provide an API to let code that stores relative paths
> > "subscribe" to updates to the current working directory.
> > This means that callers of chdir() don't need to know about
> > all subscribers ahead of time; they can simply consult a
> > dynamically built list.
> > [...]
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/chdir-notify.c b/chdir-notify.c
> > @@ -0,0 +1,71 @@
> > +int chdir_notify(const char *new_cwd)
> > +{
> > +       struct strbuf old_cwd = STRBUF_INIT;
> > +       struct list_head *pos;
> > +
> > +       if (strbuf_getcwd(&old_cwd) < 0)
> > +               return -1;
> > +       if (chdir(new_cwd) < 0)
> > +               return -1;
> 
> This 'return' is leaking 'old_cwd', isn't it?

Whoops, yes. I wrote it the other way around first to avoid the leak,
but of course that has other problems. ;)

> > diff --git a/chdir-notify.h b/chdir-notify.h
> > @@ -0,0 +1,64 @@
> > + * In practice most callers will want to move a relative path to the new root;
> > + * they can use the reparent_relative_path() helper for that. If that's all
> > + * you're doing, you can also use the convenience function:
> > + *
> > + *   chdir_notify_reparent(&my_path);
> > + */
> > +typedef void (*chdir_notify_callback)(const char *old_cwd,
> > +                                     const char *new_cwd,
> > +                                     void *data);
> > +void chdir_notify_register(chdir_notify_callback cb, void *data);
> > +void chdir_notify_reparent(char **path);
> 
> Can we have some documentation here (or in the chdir_notify_reparent()
> example above) explaining that *path is a heap-allocated value? I had
> to consult the implementation to understand ownership.

Sure. I originally had reparent_relative_path() handle the freeing and
allocation, and it explained the ownership in its docstring. But as I
revised that to simply return its value, that got lost. I'll add it back
in here.

-Peff
