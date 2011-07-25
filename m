From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Pro-Git thanks, Control-flow bug report
Date: Mon, 25 Jul 2011 10:25:49 -0600
Message-ID: <20110725162548.GA7071@sigill.intra.peff.net>
References: <20110725125037.GA24198@sherwood.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 18:25:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlNyh-0004IT-AN
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 18:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726Ab1GYQZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 12:25:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59507
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab1GYQZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 12:25:53 -0400
Received: (qmail 10573 invoked by uid 107); 25 Jul 2011 16:26:23 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Jul 2011 12:26:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2011 10:25:49 -0600
Content-Disposition: inline
In-Reply-To: <20110725125037.GA24198@sherwood.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177799>

On Mon, Jul 25, 2011 at 02:50:38PM +0200, Steffen Daode Nurpmeso wrote:

> So while exploring git(1) i recently tried out colours (it's oh
> so coloured for a two, since 2011 three colors vim(1) user -
> fascinating) and found a control flow bug:
> 
>   ?0%0[steffen@sherwood git.git]$ ./git --version
>   git version 1.7.6.233.gd79bc.dirty
>   ?0%0[steffen@sherwood git.git]$ ./git -c color.ui=auto -c color.pager=false diff 2> AU; cat AU
>   git_config_colorbool(color.ui,auto,-1)
>     [pager_in_use(): spawned:0, GIT_PAGER_IN_USE:0]
>     auto_color:1
>     color acc. 2 getenv(TERM)
>   git_default_config(color.pager,false): 0
> 
> So the pager is spawned after the color config setting has been
> queried (and the latter is never updated).

Hmm. What's old is new again, I guess. I posted a patch to fix this
almost exactly 3 years ago:

  http://article.gmane.org/gmane.comp.version-control.git/90427

The patch is kind of an ugly special-case, and nobody else brought it up
in the past 3 years, so it just got dropped. Maybe it's worth taking it
now.

> I'm not aware of the codebase, and so i can't offer a patch,
> unfortunately.  I tried the following change in color.c first,
> but that's not a solution for the real problem:
> 
>   jauto_color:
> 	if (pager_in_use())
> 		stdout_is_tty = pager_use_color;
> 	else if (stdout_is_tty < 0)
> 		stdout_is_tty = isatty(1);
> 	if (stdout_is_tty) {
> 		...

You can't fix it strictly through color.c. The problem is that diff asks
the color code about using colors, _then_ starts a pager. So the color
code doesn't have enough information at the time it is asked to make the
right decision.

A more elegant solution would be to push the query to color.c to happen
at the time of color use, instead of during the startup sequence.

-Peff
