From: Jeff King <peff@peff.net>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Mon, 5 Nov 2007 22:26:48 -0500
Message-ID: <20071106032648.GA11717@sigill.intra.peff.net>
References: <20071105175654.GD6205@artemis.corp> <Pine.LNX.4.64.0711051259580.7357@iabervon.org> <20071105210711.GA9176@sigill.intra.peff.net> <Pine.LNX.4.64.0711051620230.7357@iabervon.org> <20071105225540.GA10988@sigill.intra.peff.net> <Pine.LNX.4.64.0711051803231.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, Git ML <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 04:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpF5m-0007ib-Lc
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 04:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbXKFD0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 22:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbXKFD0w
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 22:26:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1384 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754875AbXKFD0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 22:26:51 -0500
Received: (qmail 27127 invoked by uid 111); 6 Nov 2007 03:26:50 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 22:26:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 22:26:48 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711051803231.7357@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63619>

On Mon, Nov 05, 2007 at 06:46:08PM -0500, Daniel Barkalow wrote:

> -	if (!args.dry_run && remote && ret == 0) {
> +	if (!args.dry_run && remote && ret != -4) {
>  		for (ref = remote_refs; ref; ref = ref->next)
>  			update_tracking_ref(remote, ref);
>  	}
> 
> That is, -2 means that we've done less than was asked, but nothing blew 
> up; -4 means something blew up. When we skip something, we drop peer_ref 
> from it, so there's nothing to update (and it's dropped from the set of 
> mappings, in case we cared further about it with respect to reporting the 
> actions we actually took). Then we update all refs that were acted on if 
> ret isn't -4, and we return non-zero if ret is either -2 or -4.

This is OK, I guess. But it really doesn't accomplish the useful thing
we might get by noting per-ref errors, which is that we _can_ update the
tracking refs for those refs where it is appropriate.

We would have to parse the lines from receive_status and match them with
refs. I started a patch to do this, but I wonder if it is really worth
it. I would think that 99% of the time you have a failure at the sending
level, it's because the connection is broken, and you have no idea
_which_ refs were updated anyway, and you have to assume that none were.
So perhaps it is OK to just treat the two classes of errors differently,
and only cover per-ref errors for the "-2" case.

-Peff
