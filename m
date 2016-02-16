From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/18] convert trivial cases to ALLOC_ARRAY
Date: Tue, 16 Feb 2016 00:46:37 -0500
Message-ID: <20160216054637.GA28237@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
 <20160215215154.GE10287@sigill.intra.peff.net>
 <CAPig+cRTz4Fb10JDWLjmTEXzQ+FbvmKU51A9B3vmwBepDX+BYA@mail.gmail.com>
 <20160216042346.GB27060@sigill.intra.peff.net>
 <CAPig+cSn29QtcWKRAaKMDzObuXetEySrVtLogkzfZXKXjPeufQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 06:47:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVYTg-0005Mu-Dm
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 06:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbcBPFrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 00:47:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:42869 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753041AbcBPFqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 00:46:40 -0500
Received: (qmail 24939 invoked by uid 102); 16 Feb 2016 05:46:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 00:46:40 -0500
Received: (qmail 17998 invoked by uid 107); 16 Feb 2016 05:46:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 00:46:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 00:46:37 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cSn29QtcWKRAaKMDzObuXetEySrVtLogkzfZXKXjPeufQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286321>

On Mon, Feb 15, 2016 at 11:32:25PM -0500, Eric Sunshine wrote:

> On Mon, Feb 15, 2016 at 11:23 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Feb 15, 2016 at 11:22:12PM -0500, Eric Sunshine wrote:
> >> On Mon, Feb 15, 2016 at 4:51 PM, Jeff King <peff@peff.net> wrote:
> >> > -       path = xmalloc((n+1)*sizeof(char *));
> >> > +       ALLOC_ARRAY(path, n+1);
> >>
> >> Elsewhere in this patch, you've reformatted "x+c" as "x + c"; perhaps
> >> do so here, as well.
> >
> > Will do. I noticed while going over this before sending it out that it
> > may also be technically possible for "n+1" to overflow here (and I think
> > in a few other places in this patch). I don't know how paranoid we want
> > to be.
> 
> Yes, I also noticed those and considered mentioning it. There was also
> some multiplication which might be of concern.
> 
>     ALLOC_ARRAY(graph->mapping, 2 * graph->column_capacity);
> 
> It would be easy enough to manually call st_add() and st_mult() for
> those cases, but I haven't examined them closely enough to determine
> how likely they would be to overflow, nor do I know if the resulting
> noisiness of code is desirable.

Yeah, I'm quite sure that one is safe (we set column_capacity to a fixed
integer immediately beforehand). And many of the "+" ones are likely
safe, too.  If "n" is close to wrapping, then allocating "n" structs
will probably fail beforehand (though not always, if you have a ton of
RAM and "n" is a signed int).

But part of the point of this series is that we shouldn't have to wonder
if things are safe. They should just be obviously so, and we should err
on the side of caution. So I think it probably _is_ worth sprinkling
st_add() calls in those places. I'll take a look for the re-roll.

-Peff
