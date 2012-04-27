From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5570: fix forwarding of git-daemon messages via cat
Date: Fri, 27 Apr 2012 03:59:53 -0400
Message-ID: <20120427075953.GB12092@sigill.intra.peff.net>
References: <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
 <20120416174230.GA19226@sigill.intra.peff.net>
 <20120416224424.GA10314@ecki>
 <20120419060326.GA13982@sigill.intra.peff.net>
 <4F8FB779.60004@viscovery.net>
 <20120426130129.GA27785@sigill.intra.peff.net>
 <4F999105.200@kdbg.org>
 <20120426195503.GA29526@ecki>
 <4F99B777.4020103@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:00:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNg5x-0006LU-AY
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 10:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab2D0H74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 03:59:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47766
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613Ab2D0H7z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 03:59:55 -0400
Received: (qmail 25764 invoked by uid 107); 27 Apr 2012 08:00:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Apr 2012 04:00:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Apr 2012 03:59:53 -0400
Content-Disposition: inline
In-Reply-To: <4F99B777.4020103@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196451>

On Thu, Apr 26, 2012 at 11:00:39PM +0200, Johannes Sixt wrote:

> The shell function connects the daemon's stderr to its consumers via a
> FIFO. We cannot just do this:
> 
>    read line <git_daemon_output
>    cat <git_daemon_output >&4 &
> 
> because after the first redirection the pipe is closed and the daemon
> could receive SIGPIPE if it writes at the wrong moment. Therefore, we open
> the readable end of the FIFO only once on fd 7 in the shell and dup from
> there to the stdin of the two consumers.
>
> [...]
>  	{
> -		read line
> +		read line <&7
>  		echo >&4 "$line"
> -		cat >&4 &
> +		cat <&7 >&4 &
> +	} 7<git_daemon_output &&

Argh. I didn't notice your patch yet when I wrote my previous reply, and
ended up rediscovering your analysis and the final form of the solution.

So please disregard my prior email, and consider this:

  Acked-by: Jeff King <peff@peff.net>

-Peff
