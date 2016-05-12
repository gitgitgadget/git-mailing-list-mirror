From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] am: plug FILE * leak in split_mail_conv()
Date: Thu, 12 May 2016 04:03:31 -0400
Message-ID: <20160512080331.GA18874@sigill.intra.peff.net>
References: <20160511233546.13090-1-gitster@pobox.com>
 <20160511233546.13090-2-gitster@pobox.com>
 <20160512044730.GA5436@sigill.intra.peff.net>
 <20160512075939.GA31343@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Thu May 12 10:03:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0lav-00066c-Uu
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 10:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbcELIDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 04:03:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:38442 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751338AbcELIDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 04:03:34 -0400
Received: (qmail 4211 invoked by uid 102); 12 May 2016 08:03:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 04:03:34 -0400
Received: (qmail 7623 invoked by uid 107); 12 May 2016 08:03:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 04:03:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 04:03:31 -0400
Content-Disposition: inline
In-Reply-To: <20160512075939.GA31343@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294400>

On Thu, May 12, 2016 at 07:59:39AM +0000, Eric Wong wrote:

> I think both patches in this series would benefit from capturing
> errno before cleanup.  `fclose` can call `free`, and `free` could
> do any manner of things such as calling `madvise` with a flag
> not implemented in the running kernel, or failing an optional
> trylock without being fatal.
> 
> There's lots of non-standard malloc implementations out there :)
> 
> So I'm not sure if there's ever a guarantee that a non-error
> function call preserves `errno`.

Good point. This came up not too long ago in:

  http://article.gmane.org/gmane.comp.version-control.git/286460

I believe POSIX does say that non-error calls should preserve errno, but
all the world is not POSIX. And a future POSIX will mandate that `free`
should not touch errno, but it's not the future yet (and also, all the
world's not POSIX).

-Peff
