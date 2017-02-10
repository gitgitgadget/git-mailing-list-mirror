Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CFD1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 20:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdBJUvl (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 15:51:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:53161 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751477AbdBJUvl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 15:51:41 -0500
Received: (qmail 2588 invoked by uid 109); 10 Feb 2017 20:51:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 20:51:40 +0000
Received: (qmail 13139 invoked by uid 111); 10 Feb 2017 20:51:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 15:51:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 15:51:38 -0500
Date:   Fri, 10 Feb 2017 15:51:38 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v3] gc: ignore old gc.log files
Message-ID: <20170210205138.5nnexap32pkbjjrk@sigill.intra.peff.net>
References: <20170210192019.13927-1-dturner@twosigma.com>
 <20170210200838.kuwpldsgzvkjlmri@sigill.intra.peff.net>
 <7852bf6688ed487097d4f997ac72dcba@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7852bf6688ed487097d4f997ac72dcba@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 08:44:27PM +0000, David Turner wrote:

> > But maybe there are other systems emulating fstat() would trigger here.
> > I dunno.
> 
> Yeah, I'm also not sure.  On the other hand, if we're going to catch fstat 
> errors anyway, we might as well do something sensible with this one.

I'd say it's probably not worth worrying about here. We don't think it
can happen, and it would just fall-through to the "woah, fstat failed"
code path if it does.

> > If there was an i/o error, then gc.log.lock still exists. And this attempt to lock will
> > therefore fail, calling die(). Which would trigger our atexit() to call process_log(),
> > which would hit this code again, and so forth. I'm not sure if we'd actually
> > recurse when an atexit handler calls exit(). But it seems questionable.
> 
> No, because  we call rollback_log_file first.

Ah, right, sorry I missed that.

> > I'm also not sure why we need to re-open the file in the first place. We have an
> > open descriptor (and we even redirected stderr to it already).
> > Why don't we just write to it?
> 
> If fstat failed, that probably indicates something bad about the old fd.  I'm not 
> actually sure why fstat would ever fail, since in all likelihood, the kernel keeps 
> information about inodes corresponding to open fds in-memory.  Maybe someone
> forcibly unmounted the drive?

It seems like the re-open would fail then, too. And the error message
for that would go to stderr, which goes to...the old file.

I dunno. This seems like a lot of manual scrambling to try to overcome
unlikely errors just to make our stderr heard (and we'd still fail in
some cases). It seems like:

  if (fstat(...)) {
	/* weird, fstat failed; try our best to mention it */
	error_errno("unable to fstat gc.log.lock");
	commit_lock_file(&log_lock));
  } else if (st.st_size) {
	/* we have new errors to report */
	commit_lock_file(&log_lock);
  } else {
	/* no new errors; clean up old ones */
	unlink(git_path("gc.log"));
	rollback_lock_file(&log_lock);
  }

would be sufficient.

-Peff
