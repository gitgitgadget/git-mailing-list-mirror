From: Jeff King <peff@peff.net>
Subject: Re: Disabling Delta Compression on a fetch
Date: Thu, 8 Dec 2011 15:14:43 -0500
Message-ID: <20111208201443.GA8035@sigill.intra.peff.net>
References: <070681D4-F87B-435E-8A3B-144E59DE722B@cpanel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Todd Rinaldo <toddr@cpanel.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 21:14:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYkMk-0002sh-Ge
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 21:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab1LHUOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 15:14:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44508
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab1LHUOp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 15:14:45 -0500
Received: (qmail 30392 invoked by uid 107); 8 Dec 2011 20:21:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 15:21:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 15:14:43 -0500
Content-Disposition: inline
In-Reply-To: <070681D4-F87B-435E-8A3B-144E59DE722B@cpanel.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186593>

On Thu, Dec 08, 2011 at 11:34:26AM -0600, Todd Rinaldo wrote:

> All of the git communication happens on 1 subnet all connected by a
> single gigabit switch. As I see it, the Delta Compression is actually
> a performance degradation in our environment.
> 
> The solution I've come up with is to set pack.window=0 in
> /etc/gitconfig on the gitorious server. 

An alternative is to mark the binary files as "-delta" with
gitattributes on the server. Then you will get the benefits of delta
compression for other files without bothering to try the binary files.

Note that git won't read the gitattributes file out of the tree in a
bare repository, so these attributes should go either in
$REPO/info/attributes (if they are repo-specific), or in
/etc/gitattributes (if they are in many repos).

I.e., something like:

  echo '*.bin -delta' >/etc/gitattributes

Also, before any of that, make sure that the upstream repos are fully
packed. Git will not try to delta two objects coming from the same pack
(since it will already have tried when they were entering the pack).
That by itself might be enough to solve your problem without any other
configuration.

> My question is: Are there are any unintended consequences of this
> approach anyone can think of?

Other than trading bandwidth, you are also trading space on the client
side, since each client will store the resulting pack.

-Peff
