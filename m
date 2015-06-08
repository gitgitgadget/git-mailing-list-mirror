From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fsck: report errors if reflog entries point at
 invalid objects
Date: Mon, 8 Jun 2015 12:56:44 -0400
Message-ID: <20150608165643.GA6863@peff.net>
References: <cover.1433769878.git.mhagger@alum.mit.edu>
 <2ba9ee48a062b049c8b64fed4caba32c42f03031.1433769878.git.mhagger@alum.mit.edu>
 <e9d2f8cc371aa41e5d9095abd3cb7edb@www.dscho.org>
 <5575B03C.6040008@alum.mit.edu>
 <c5720357601be135485ef546cae7ffdb@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20M2-0004mD-2t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbbFHQ4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:56:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:42900 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751278AbbFHQ4s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:56:48 -0400
Received: (qmail 16978 invoked by uid 102); 8 Jun 2015 16:56:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Jun 2015 11:56:48 -0500
Received: (qmail 6576 invoked by uid 107); 8 Jun 2015 16:56:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Jun 2015 12:56:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2015 12:56:44 -0400
Content-Disposition: inline
In-Reply-To: <c5720357601be135485ef546cae7ffdb@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271077>

On Mon, Jun 08, 2015 at 06:00:09PM +0200, Johannes Schindelin wrote:

> >> I like the idea, but I am a bit uncertain whether it would constitute
> >> "too backwards-incompatible" a change to make this an error. I think
> >> it could be argued both ways: it *is* an improvement, but it could
> >> also possibly disrupt scripts that work pretty nicely at the moment.
> > 
> > What kind of script are you worried about?
> 
> I was concerned about scripts that work on repositories whose reflogs
> become inconsistent for whatever reason (that happened a lot to me in
> the past, IIRC it had something to do with bare repositories and/or
> shared object databases).

I think these repositories are already broken. You cannot run `git gc`
in such a repository, as it will barf when trying to walk the reflog
tips during `git repack`.

We run into this exact situation at GitHub because of our shared object
databases. Our per-fork repack code basically has to do:

  if ! git repack ...; then
    git reflog expire --expire-unreachable=all --all &&
    git repack ... ||
    die "ok, it really is broken"
  fi

-Peff
