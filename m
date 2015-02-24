From: Jeff King <peff@peff.net>
Subject: Re: [BUG] diffcore-rename with duplicate tree entries can segfault
Date: Tue, 24 Feb 2015 17:49:18 -0500
Message-ID: <20150224224918.GA24749@peff.net>
References: <20150224214311.GA8622@peff.net>
 <xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:49:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQOIB-0002KL-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 23:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbbBXWtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 17:49:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:52925 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752234AbbBXWtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 17:49:20 -0500
Received: (qmail 10769 invoked by uid 102); 24 Feb 2015 22:49:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 16:49:20 -0600
Received: (qmail 10167 invoked by uid 107); 24 Feb 2015 22:49:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 17:49:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2015 17:49:18 -0500
Content-Disposition: inline
In-Reply-To: <xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264358>

On Tue, Feb 24, 2015 at 02:42:42PM -0800, Junio C Hamano wrote:

> > That does fix this problem, and it doesn't break any other tests. But
> > frankly, I don't know what I'm doing and this feels like a giant hack.
> >
> > Given that this is tangentially related to the "-B -M" stuff you've been
> > looking at (and it's your code in the first place :) ), I thought you
> > might have some insight.
> 
> Indeed.
> 
> Honestly, I'd rather see us diagnose duplicate filepairs as an error
> and drop them on the floor upon entry to the diffcore_std(), even
> before we go into the rename codepath.

Yeah, I had a similar thought. Just saying "your diff is broken, we
can't do rename detection" is totally reasonable to me.

My main concern with that approach is that we would waste time finding
the duplicate paths, for something that comes up only rarely. At the
time of locate_rename_dst, we've already created a mapping, and it's
very easy to detect the duplicates. But before that, we have only the
linear list of queued items.

In theory they're sorted and we could do an O(n) pass to find
duplicates. But I'm not sure if the sorting holds in the face of other
breakages (like unsorted trees; they also shouldn't happen, but the
whole point here is to gracefully handle things that shouldn't).

I dunno. Maybe we could do an O(n) pass to check sort order and
uniqueness. If either fails (which should be rare), then we sort and
re-check uniqueness.

I'm assuming there _is_ a sane sort order. We have two halves of a
filepair, but I think before any of the rename or break detection kicks
in, each pair should either:

  1. Have a name in pair->one, and an invalid filespec in pair->two
     (i.e., a deletion).

  2. The opposite (name in pair->two, /dev/null in pair->one). An
     addition.

  3. The same name in pair->one and pair->two.

-Peff
