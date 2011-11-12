From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/14] resumable network bundles
Date: Sat, 12 Nov 2011 12:58:26 -0500
Message-ID: <20111112175826.GA9427@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
 <CALUzUxqsLP11Tcsoc1tzGMfNcMqor2wQF+Yutu3FRiTin4Pnew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 18:58:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPHqb-0003yU-HI
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 18:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab1KLR63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 12:58:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39983
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab1KLR62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 12:58:28 -0500
Received: (qmail 13590 invoked by uid 107); 12 Nov 2011 17:58:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Nov 2011 12:58:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Nov 2011 12:58:26 -0500
Content-Disposition: inline
In-Reply-To: <CALUzUxqsLP11Tcsoc1tzGMfNcMqor2wQF+Yutu3FRiTin4Pnew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185311>

On Sun, Nov 13, 2011 at 12:11:31AM +0800, Tay Ray Chuan wrote:

> One thing I'm not comfortable with is the "flexibility" allowed in
> bundle fetching - servers are allowed to send bundles if they see fit,
> and we have to detect it when they do (if I'm reading the "surprised"
> scenario in patch 9 correctly).

Right.

> Perhaps we can expose bundle fetching through /objects/info/bundles?

But what if the server you are hitting doesn't have a git repo at all?
In the simplest case, a bundle provider should just be able to put a
file somewhere http-ccessible, without having any special directory
structure or other meta files.

Which means that we have to be prepared for the URL the user gave us to
be a bundle, not a git repo that contains bundles.

> It could possibly contain information about what bundles are available
> and what revs they contain. If bundles are found, fetch them;
> otherwise, go through the usual ref advertisement and other steps of
> the pack protocol.

This is "step 2" of my plan: hitting a git repo will provide a way of
redirecting to other, static storage. But I think it's important that
the other storage not just be a path in the existing repo, for two
reasons:

  1. You might want to redirect the client off-server to a
     higher-bandwidth static service like S3, or something backed by a
     CDN.

  2. The client might not be hitting you through http, so you can't
     expect them to look at arbitrary repo files (like
     objects/info/bundles). We need to provide the information over the
     git protocol (my plan is to use a special ref name, like
     "refs/mirrors" to encode the information).

> That way, we take out the "surprise" factor in the fetching protocol.

I don't think it's that big a deal. It influenced the way that patches 9
and 10 were written (patch 9 handles "surprise" bundles when fetching
info/refs, and then patch 10 falls back to fetching $URL without
info/refs). But even if we didn't have the "surprise" case, most of the
code in patch 9 would have just ended up in patch 10. That is, the
surprise case doesn't take much code, and doesn't have a negative impact
on the non-surprise case (i.e., until we see a bundle header, the
behavior is identical, just putting the refs into a memory buffer).

-Peff
