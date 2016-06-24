Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65FF72018A
	for <e@80x24.org>; Fri, 24 Jun 2016 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbcFXPgv (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 11:36:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:59733 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751104AbcFXPgu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 11:36:50 -0400
Received: (qmail 20788 invoked by uid 102); 24 Jun 2016 15:36:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 11:36:50 -0400
Received: (qmail 20165 invoked by uid 107); 24 Jun 2016 15:37:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 11:37:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 11:36:47 -0400
Date:	Fri, 24 Jun 2016 11:36:47 -0400
From:	Jeff King <peff@peff.net>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Ovatta Bianca <ovattabianca@gmail.com>, git@vger.kernel.org
Subject: Re: what is a snapshot?
Message-ID: <20160624153647.GA2448@sigill.intra.peff.net>
References: <CAHWPVgNrTEw9FmW6K7QucgA74QWsTKfxZGt+mGd099k+O7O+rw@mail.gmail.com>
 <CAHWPVgMWeHoD5vTiFJ1gsm2hS74LK7j4npVVbOZeR43cX3qWXw@mail.gmail.com>
 <F6172B8DA802476C863849DEA02684A7@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F6172B8DA802476C863849DEA02684A7@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 04:20:14PM +0100, Philip Oakley wrote:

> From: "Ovatta Bianca" <ovattabianca@gmail.com>
> > I read in every comparison of git vs other version control systems,
> > that git does not record differences but takes "snapshots"
> > I was wondering what a "snapshot" is ? Does git store at every commit
> > the entire files which have been modified even if only a few bytes
> > were changed out of a large file?
> > 
> A snaphot is like a tar or zip of all your tracked files. This means it is
> easier to determine (compared to lots of diffs) the current content.
> 
> Keeping all the snapshots as separate loose items, when the majority of
> their content is unchanged would be very inefficient, so git then uses, at
> the right time, an efficient (and obviously lossless) compression technique
> to 'zip' all the snapshots together so that the final repository is
> 'packed'. The overall effect is a very efficient storage scheme.
> 
> There are some good explanations on the web, such as the
> https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
> though you may want to scan from the beginning ;-)

I think the delta compression is only half the story.

Each commit is a snapshot in that it points to the sha1 of the root
tree, which points to the sha1 of other trees and blobs. And following
that chain gives you the whole state of the tree, without having to care
about other commits.

And if the next commit changes only a few files, the sha1 for all the
other files will remain unchanged, and git does not need to store them
again. So already, before any explicit compression has happened, we get
de-duplication of identical content from commit to commit, at the file
and tree level.

And then when a file does change, we store the whole new version, then
delta compress it during "git gc", etc, as you describe.

-Peff
