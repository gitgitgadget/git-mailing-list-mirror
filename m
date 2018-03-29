Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601A61F404
	for <e@80x24.org>; Thu, 29 Mar 2018 17:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeC2RsY (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 13:48:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:47594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751164AbeC2RsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 13:48:23 -0400
Received: (qmail 17980 invoked by uid 109); 29 Mar 2018 17:48:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 17:48:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20699 invoked by uid 111); 29 Mar 2018 17:49:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 13:49:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 13:48:21 -0400
Date:   Thu, 29 Mar 2018 13:48:21 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] add chdir-notify API
Message-ID: <20180329174820.GB31833@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net>
 <20180328174041.GB16274@sigill.intra.peff.net>
 <CACsJy8CCvshwb8a5ZozJ+x0D1kAYbeLSgJ0LDm4Z=uUZLtpsjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CCvshwb8a5ZozJ+x0D1kAYbeLSgJ0LDm4Z=uUZLtpsjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 04:53:42PM +0200, Duy Nguyen wrote:

> On Wed, Mar 28, 2018 at 7:40 PM, Jeff King <peff@peff.net> wrote:
> > +static void reparent_cb(const char *old_cwd,
> > +                       const char *new_cwd,
> > +                       void *data)
> > +{
> > +       char **path = data;
> 
> Maybe check data == NULL and return early. This is just for
> convenience, e.g. instead of doing
> 
> path = getenv("foo");
> if (path)
>     chdir_notify_reparent(&path);
> 
> I could do
> 
> path = getenv("foo");
> chdir_notify_reparent(&path);

You'd need to xstrdup(path) there anyway. I guess you could use
xstrdup_or_null(), but it seems somewhat unlikely (unless your work on
top really does add such a callsite?).

I guess it's not that much code to be careful, though.

> > +       char *tmp = *path;
> > +       *path = reparent_relative_path(old_cwd, new_cwd, tmp);
> > +       free(tmp);
> > +}
> > +
> > +void chdir_notify_reparent(char **path)
> > +{
> > +       if (!is_absolute_path(*path))
> 
> I think this check is a bit early. There could be a big gap between
> chdir_notify_reparent() and reparent_cb(). During that time, *path may
> be updated and become a relative path. We can check for absolute path
> inside reparent_cb() instead.

My thinking was that we'd be effectively zero-cost for an absolute path,
though really adding an element to the notification list is probably not
a big deal.

I also assumed that whoever changed it to a relative path would then
install the notification handler. One thing that my series kind of
glosses over is whether somebody might call any of these functions
twice, which would involve setting up the handler twice. So e.g. if you
did:

  set_git_dir("foo");
  set_git_dir("bar");

we'd have two handlers, which would do the wrong thing when the second
one triggered. I hoped we could eventually add a BUG() if that happens,
but maybe we should simply do a:

  static int registered_chdir;

  if (!registered_chdir) {
	chdir_notify_reparent(&path);
	registered_chdir = 1;
  }

at each call-site. Another alternative would be to make it a noop to
feed the same path twice. That requires a linear walk through the list,
but it's a pretty small list.

> > +               chdir_notify_register(reparent_cb, path);
> > +}
> 
> Overall, I like this API very much! I will add another one similar to
> chdir_notify_reparent() but it takes an env name instead and the
> callback will setenv() appropriately. The result looks super good.

Ooh, that's clever.

I had also thought of extending it to other notifications besides
chdir(), like one string depends on another. But then we'd basically
re-inventing a cascading data-flow system, which is probably getting a
bit magical. :)

-Peff
