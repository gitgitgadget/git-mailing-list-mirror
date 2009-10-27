From: Jeff King <peff@peff.net>
Subject: Re: git update --prune issue
Date: Tue, 27 Oct 2009 14:46:27 -0400
Message-ID: <20091027184627.GA19292@sigill.intra.peff.net>
References: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com>
 <4AE6B28F.9010407@drmicha.warpmail.net>
 <4389ce950910270807o69d51155xb083f34bb31e1dae@mail.gmail.com>
 <20091027162936.GA8130@sigill.intra.peff.net>
 <20091027164040.GB12464@localhost>
 <20091027165054.GA8554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeffrey Middleton <jefromi@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:46:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2r48-0002fi-2f
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 19:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302AbZJ0Sq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 14:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756253AbZJ0Sq1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 14:46:27 -0400
Received: from peff.net ([208.65.91.99]:50795 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127AbZJ0Sq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 14:46:27 -0400
Received: (qmail 3120 invoked by uid 107); 27 Oct 2009 18:50:08 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Oct 2009 14:50:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2009 14:46:27 -0400
Content-Disposition: inline
In-Reply-To: <20091027165054.GA8554@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131368>

On Tue, Oct 27, 2009 at 12:50:55PM -0400, Jeff King wrote:

> > Actually, it's beta_gc_dev_old and beta_gc_dev, not the same refs.
> 
> OK, I'm a bit blind. Thanks for pointing it out. I'll still see if I can
> replicate it.

I'm not having any luck reproducing here with a simple case. :( I'm
trying:

-- >8 --
#!/bin/sh

rm -rf parent* child

commit() {
  echo $1 >file && git add file && git commit -m $1
}

mkdir parent1 && (
  cd parent1 &&
  git init &&
  commit one &&
  commit two &&
  git checkout -b other
) &&
mkdir parent2 && (
  cd parent2 &&
  git init &&
  commit three
) &&
mkdir child && (
  cd child &&
  git init &&
  git remote add parent1 ../parent1 &&
  git remote add parent2 ../parent2 &&
  git remote update
) &&
(
  cd parent1 &&
  git checkout master &&
  git branch -d other &&
  git reset --hard HEAD^ &&
  commit four
) && (
  cd child &&
  git remote update --prune
)
