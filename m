From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diffcore-rename: support rename cache
Date: Sat, 8 Nov 2008 21:04:13 -0500
Message-ID: <20081109020413.GA31408@coredump.intra.peff.net>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com> <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net> <7vy6zvdt25.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0811072001o6df7ae00k1b1bffaadf75d3a1@mail.gmail.com> <20081108092409.GD4030@nan92-1-81-57-214-146.fbx.proxad.net> <20081108114719.GA4989@sigill.intra.peff.net> <fcaeb9bf0811080400h7ea5377cvaa8d658335811c23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <ydirson@altern.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 03:06:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyzgv-0007N8-Tx
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 03:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYKICER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 21:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbYKICER
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 21:04:17 -0500
Received: from peff.net ([208.65.91.99]:3865 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbYKICEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 21:04:16 -0500
Received: (qmail 8775 invoked by uid 111); 9 Nov 2008 02:04:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Nov 2008 21:04:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2008 21:04:13 -0500
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0811080400h7ea5377cvaa8d658335811c23@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100434>

On Sat, Nov 08, 2008 at 07:00:10PM +0700, Nguyen Thai Ngoc Duy wrote:

> >  The downsides are:
> >
> >   - your cache is potentially bigger, since you are caching the score of
> >    every pair you look at, instead of just "good" pairs (OTOH, you are
> >    not doing a per-commit cache, which helps reduce the size)
> 
> It is huge if you accidentially add --find-copies-harder to your
> command, considering that every new file will be compared against
> every files in tree (about 25k).

Hmm, yeah. I was thinking you might be able to do some kind of cut-off
on the caching (i.e., don't bother storing anything that didn't come
close). But you can't safely assume that because an entry isn't there,
it isn't worth seeing (since it might also just not have been computed
yet). You could still organize by commit, and then each commit is either
fully computed or not. But then you still have a pathspec problem.

One thing you could do is just compute the rename score between all
pairs, even if a pathspec is given, limit it to values over "0.5" (or
something low, but that eliminates the totally uninteresting cases), and
then store that as the complete cache for that commit (or tree pair, if
you want to support that).

Then you would have the full information and could do an arbitrary
pathspec limit on it. If you wanted to set the rename threshold below
0.5, then we would have to recompute without the cache (but in practice,
that should be rare).

The real downside is that you pay for the whole-tree detection when you
have asked for a pathspec (but only the first time, after which you can
always generate from cache).

Just thinking out loud...

-Peff
