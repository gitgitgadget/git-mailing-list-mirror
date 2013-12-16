From: Jeff King <peff@peff.net>
Subject: Re: "git fsck" fails on malloc of 80 G
Date: Mon, 16 Dec 2013 14:15:00 -0500
Message-ID: <20131216191500.GD29324@sigill.intra.peff.net>
References: <201312161605.rBGG5Wm5027739@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:15:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsddK-0004dq-GK
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab3LPTPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:15:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:45694 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755002Ab3LPTPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:15:06 -0500
Received: (qmail 24260 invoked by uid 102); 16 Dec 2013 19:15:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Dec 2013 13:15:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Dec 2013 14:15:00 -0500
Content-Disposition: inline
In-Reply-To: <201312161605.rBGG5Wm5027739@hobgoblin.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239347>

On Mon, Dec 16, 2013 at 11:05:32AM -0500, Dale R. Worley wrote:

> # git fsck
> Checking object directories: 100% (256/256), done.
> fatal: Out of memory, malloc failed (tried to allocate 80530636801 bytes)
> #

Can you give you give us a backtrace from the die() call? It would help
to know what it was trying to allocate 80G for.

> I don't know if this is due to an outright bug or not.  But it seems
> to me that "git fsck" should not need to allocate any more memory than
> the size (1 GiB) of a single pack file.  And given its purpose, "git
> fsck" should be one of the *most* robust Git tools!

Agreed. Fsck tends to be more robust, but there are still many code
paths that can die(). One of the problems I ran into recently is that
corrupt data can cause it to make a large allocation; we notice the
bogus data as soon as we try to start filling the buffer, but sometimes
the bogus allocation is large enough to kill the process.

That was fixed by b039718, which is in master but not yet any released
version. You might see whether that helps.

-Peff
