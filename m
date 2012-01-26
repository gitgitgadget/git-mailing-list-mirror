From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 11:54:56 -0500
Message-ID: <20120126165456.GA5278@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
 <4F2119E6.8010109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 17:55:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqSbP-0001Th-HU
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 17:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab2AZQzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 11:55:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45317
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab2AZQzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 11:55:04 -0500
Received: (qmail 27221 invoked by uid 107); 26 Jan 2012 17:02:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 12:02:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 11:54:56 -0500
Content-Disposition: inline
In-Reply-To: <4F2119E6.8010109@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189154>

On Thu, Jan 26, 2012 at 10:16:22AM +0100, Johannes Sixt wrote:

> > +test_expect_success 'recursive relative paths' '
> > +	mkdir subdir &&
> > +	echo "[test]three = 3" >subdir/three &&
> > +	echo "[include]path = three" >subdir/two &&
> > +	echo "[include]path = subdir/two" >base &&
> > +	echo 3 >expect &&
> > +	git config -f base test.three >actual &&
> > +	test_cmp expect actual
> > +'
> 
> Isn't it rather "chained relative paths"? Recursive would be if I write
> 
>   [include]path = .gitconfig
> 
> in my ~/.gitconfig. What happens in this case?

Good point. I used "recursive" because it is recursing in the include
function within git, but obviously from the user's perspective, it is
not a recursion.

And no, I didn't do any cycle detection. We could either do:

  1. Record some canonical name for each source we look at (probably
     realpath() for files, and the sha1 for refs), and don't descend
     into already-seen sources.

  2. Simply provide a maximum depth, and don't include beyond it.

The latter is much simpler to implement, but I think the former is a
little nicer for the user.

-Peff
