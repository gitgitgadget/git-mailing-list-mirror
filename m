From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct
 child_process variables
Date: Mon, 3 Nov 2014 17:04:08 -0500
Message-ID: <20141103220408.GA12462@peff.net>
References: <54500212.7040603@web.de>
 <20141029172109.GA32234@peff.net>
 <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
 <20141030213523.GA21017@peff.net>
 <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
 <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
 <20141101033327.GA8307@peff.net>
 <F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley>
 <xmqqmw88rvh3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:04:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlPjT-0000E2-FQ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 23:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbaKCWEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 17:04:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:36459 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750810AbaKCWEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 17:04:10 -0500
Received: (qmail 20012 invoked by uid 102); 3 Nov 2014 22:04:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Nov 2014 16:04:09 -0600
Received: (qmail 8141 invoked by uid 107); 3 Nov 2014 22:04:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Nov 2014 17:04:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Nov 2014 17:04:08 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmw88rvh3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 03, 2014 at 10:26:48AM -0800, Junio C Hamano wrote:

> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> > This certainly looks the way to go. The one extra question would be
> > whether the symref should be included by default when HEAD is present,
> > or only if there was possible ambiguity between the other listed
> > refs.
> 
> Just include the "\0symref=..." for any symbolic ref you mention,
> and the ref in question does not even have to be "HEAD", I would
> say.
> 
> The mechanism chosen should be something that will be transparently
> ignored by existing implementations, there is no need to make the
> data format conditional.

One thing I glossed over in my suggestion of the NUL trick: it works on
git.git, but no clue about elsewhere. I can imagine that other non-C
implementations might treat the whole thing (NUL and extra data
included) as the refname. Back when we did the NUL trick to the online
protocol, git.git was the only serious implementation. But nowadays we
should at least consider the impact on JGit, libgit2, and/or dulwich
(breaking them is not necessarily a showstopper IMHO, but we should at
least know what we are breaking).

I peeked at libgit2 and I think it does not support bundles at all yet,
so that is safe. Grepping for "bundle" in dulwich turns up no hits,
either.

Looks like JGit does support them. I did a very brief test, and it seems
to silently ignore a HEAD ref that has the NUL (I guess maybe it just
rejects it as a malformed refname).

We could make JGit happier either by:

  1. Only including the symref magic in ambiguous cases, so that regular
     ones Just Work as usual.

  2. Including two lines, like:

        $sha1 HEAD\0symref=refs/heads/master
	$sha1 HEAD

     which JGit does the right thing with (and git.git seems to, as
     well).

-Peff
