From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 4 Nov 2015 14:56:49 -0500
Message-ID: <20151104195649.GB16101@sigill.intra.peff.net>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
 <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
 <CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
 <xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
 <xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
 <CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
 <xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Doug Kelly <dougk.ff7@gmail.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:56:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4Ay-0004KO-OI
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965369AbbKDT4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:56:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:52881 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965309AbbKDT4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:56:52 -0500
Received: (qmail 14028 invoked by uid 102); 4 Nov 2015 19:56:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 13:56:52 -0600
Received: (qmail 6019 invoked by uid 107); 4 Nov 2015 19:57:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 14:57:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2015 14:56:49 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280874>

On Wed, Nov 04, 2015 at 11:35:52AM -0800, Junio C Hamano wrote:

> Doug Kelly <dougk.ff7@gmail.com> writes:
> 
> > I think the patches I sent (a bit prematurely) address the
> > remaining comments... I did find there was a relevant test in
> > t5304 already, so I added a new test in the same section (and
> > cleaned up some of the garbage it wasn't removing before).  I'm
> > not sure if it's poor form to move tests around like this, but I
> > figured it might be best to keep them logically grouped.
> 
> OK, will queue as I didn't spot anything glaringly wrong ;-)
> 
> I did wonder if we want to say anything about .bitmap files, though.
> If there is one without matching .idx and .pack, shouldn't we report
> just like we report .idx without .pack (or vice versa)?

Yeah, I think so. The logic should really extend to anything without a
matching .pack. And I think the sane rule is probably:

  If we have pack-$sha.$ext, but not pack-$sha.pack, then:

    1. if $ext is known to us as a cache that can be regenerated from the
       .pack (i.e., .idx, .bitmap), then delete it

    2. if $ext is known to us as precious, do nothing (there is nothing
       in this category right now, though)

    3. if $ext is not known to us, warn but do not delete (in case a
       future version adds something precious)

The conservatism in (3) is the right thing to do, I think, but I doubt
it will ever matter, because we probably cannot ever add non-cache
auxiliary files to the pack. Old versions of git would not delete such
precious files, but nor would they carry them forward during a repack.
So short of a repo-version bump, I think we are effectively limited to
adding only caches which can be re-generated from an original .pack.

-Peff
