From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/9] streaming_write_entry: propagate streaming errors
Date: Mon, 25 Mar 2013 17:37:37 -0400
Message-ID: <20130325213737.GC19303@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202216.GF16019@sigill.intra.peff.net>
 <CAPig+cRjK6mrRm+K4Qzf2CsjT3SYGotZ2PrVLniYzdBRC1Mv2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:38:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKF5m-0003Rr-2r
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933122Ab3CYVhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:37:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39431 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933100Ab3CYVhl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:37:41 -0400
Received: (qmail 28768 invoked by uid 107); 25 Mar 2013 21:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 17:39:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 17:37:37 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRjK6mrRm+K4Qzf2CsjT3SYGotZ2PrVLniYzdBRC1Mv2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219095>

On Mon, Mar 25, 2013 at 05:35:51PM -0400, Eric Sunshine wrote:

> On Mon, Mar 25, 2013 at 4:22 PM, Jeff King <peff@peff.net> wrote:
> > diff --git a/entry.c b/entry.c
> > index 17a6bcc..002b2f2 100644
> > --- a/entry.c
> > +++ b/entry.c
> > @@ -126,8 +126,10 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
> >         fd = open_output_fd(path, ce, to_tempfile);
> >         if (0 <= fd) {
> >                 result = stream_blob_to_fd(fd, ce->sha1, filter, 1);
> > -               *fstat_done = fstat_output(fd, state, statbuf);
> > -               result = close(fd);
> > +               if (!result) {
> > +                       *fstat_done = fstat_output(fd, state, statbuf);
> > +                       result = close(fd);
> > +               }
> 
> Is this intentionally leaking the opened 'fd' when stream_blob_to_fd()
> returns an error?

Good catch. I was so focused on making sure we still called unlink that
I forgot about the cleanup side-effect of close.

I'll re-roll it.

-Peff
