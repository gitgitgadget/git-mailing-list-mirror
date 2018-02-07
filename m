Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FECE1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeBGUpW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:45:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:44230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754281AbeBGUpW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:45:22 -0500
Received: (qmail 29867 invoked by uid 109); 7 Feb 2018 20:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 20:45:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2304 invoked by uid 111); 7 Feb 2018 20:46:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 15:46:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 15:45:20 -0500
Date:   Wed, 7 Feb 2018 15:45:20 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Andreas Kalz <andreas-kalz@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug? Error during commit
Message-ID: <20180207204520.GA31757@sigill.intra.peff.net>
References: <trinity-cb66d9d6-9035-4c98-948e-6857a7bd4de2-1517838396145@3c-app-gmx-bs16>
 <trinity-5e3c4029-b348-4bd5-9337-215808436a12-1517838482997@3c-app-gmx-bs16>
 <CACsJy8CGQ4ynYFT0mY1DfcGGdzwP36eonMvr-kEZazX_82ag2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CGQ4ynYFT0mY1DfcGGdzwP36eonMvr-kEZazX_82ag2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 05, 2018 at 08:59:52PM +0700, Duy Nguyen wrote:

> On Mon, Feb 5, 2018 at 8:48 PM, Andreas Kalz <andreas-kalz@gmx.de> wrote:
> > Hello,
> >
> > I am using git frequently and usually it is running great.
> >
> > I read to write to this eMail address regarding problems and possible bugs.
> > I am using git version 2.16.1.windows.2 / 64 Bit and during commit the following error message comes up:
> > e:\Internet>git commit -m 2018-01-27
> > fatal: unable to generate diffstat for Thunderbird/andreas-kalz.de/Mail/pop.gmx.net/Inbox
> > [master f74cf30] 2018-01-27
> >
> > I also tried this before with an older git version with same problem.
> >
> > Can you help me with this problem please? Thanks in advance.
> 
> I think if you add -q to that "git commit" command, diffstat is not
> generated and you can get past that. If that particular commit can be
> published in public, it'll help us find out why diffstat could not be
> generated.

I think that's the first time I've seen that particular error. :)

I think the only reason that xdiff would report failure is if malloc()
failed, or if one of the files exceeds MAX_XDIFF_SIZE, which is ~1GB.
I think we'd usually avoid doing a text diff on anything over
core.bigFileThreshold, though.

But it doesn't seem to work:

  $ yes | head -c $((1024*1024*1024 - 10*1024*1024)) >file
  $ git add file
  $ git commit -m one
  $ yes | head -c $((1024*1024*1024)) >file
  $ git commit -am two
  fatal: unable to generate diffstat for file

What's weird is that if I run "git show --stat" on the same commit, it
works! So there's something about how commit invokes the diff that
doesn't let the big-file check kick in.

It looks like the logic in diff_filespec_is_binary() will only check
big_file_threshold if we haven't already loaded the contents into RAM.
So "commit" does that, but "diff" is more careful about not loading the
file contents.

I think we probably ought to consider anything over big_file_threshold
to be binary, no matter what. Possibly even if the user gave us a
.gitattribute that says "no really, this is text". Because that 1GB
limit is a hard limit that the code can't cope with; our options are
either to generate a binary diff or to die.

-Peff
