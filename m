From: Jeff King <peff@peff.net>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 14:15:09 -0400
Message-ID: <20110616181509.GA12689@sigill.intra.peff.net>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
 <m362o5vrhd.fsf@localhost.localdomain>
 <BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
 <20110616173451.GB6584@sigill.intra.peff.net>
 <7vy611hd38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Blackburn <jamesblackburn@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:15:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXH69-0002MC-0Z
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620Ab1FPSPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 14:15:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53464
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab1FPSPM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 14:15:12 -0400
Received: (qmail 15891 invoked by uid 107); 16 Jun 2011 18:15:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 14:15:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 14:15:09 -0400
Content-Disposition: inline
In-Reply-To: <7vy611hd38.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175910>

On Thu, Jun 16, 2011 at 10:59:23AM -0700, Junio C Hamano wrote:

> > Doesn't:
> >
> >   git log -- plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/debug/service/IBreakpoints.java
> >
> > do that?
> 
> If the file emerged in one branch (either the primary or a side branch) in
> the past as a failed experiment and then got removed before merging back,
> i.e.
> 
>    past ---o----o-----o-----o-----o-----o-----o-----o--- now
>             \                          /
>              o----*----o----o----*----o
>                   ^added         ^removed
> 
> then the merges are simplified away and you would not see it.

Ah, right. The default simplification so often does what I want that I
forget there are cases it can miss.

> Perhaps simplify-merges option may help.

This test case shows full-history helping:

-- >8 --
commit() {
  echo $1 >$1 && git add $1 && git commit -m $1
}

git init repo &&
cd repo &&
commit one &&
commit two &&
commit three &&
git checkout -b side HEAD^ &&
commit four &&
commit five &&
git rm five && git commit -m "remove five" &&
commit six &&
git checkout master &&
git merge side &&
echo "==> default log (shows nothing)" &&
git --no-pager log -- five
echo "==> full-history" &&
git --no-pager log --full-history -- five
