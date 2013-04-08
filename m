From: Jeff King <peff@peff.net>
Subject: Re: RFC: two minor tweaks to check-ignore to help git-annex assistant
Date: Mon, 8 Apr 2013 18:20:59 -0400
Message-ID: <20130408222059.GA12454@sigill.intra.peff.net>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:21:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKR4-000825-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934871Ab3DHWVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 18:21:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34415 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758971Ab3DHWVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 18:21:04 -0400
Received: (qmail 17398 invoked by uid 107); 8 Apr 2013 22:22:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 18:22:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 18:20:59 -0400
Content-Disposition: inline
In-Reply-To: <20130408181311.GA14903@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220534>

On Mon, Apr 08, 2013 at 07:13:11PM +0100, Adam Spiers wrote:

> I was recently informed by the author of git-annex that my
> implementation of git check-ignore has two minor deficiencies which
> currently prevent him from adding .gitignore support to the git-annex
> assistant (web UI):
> 
>     1. When accepting a list of files to check via --stdin, no results
>        are calculated until EOF is hit.  This prevents it being used
>        as a persistent background query process which streams results
>        to its caller.  (This is inconsistent with check-attr, which
>        *does* support stream-like behaviour.)

I think flushing on each line is reasonable, though you are also
introducing a deadlock possibility for callers which do not read back
the output in real-time. For example, if I write N paths out then read N
ignore-lines back in, I risk a situation where I am blocked on write()
to check-ignore, and it is blocked on write back to me. Somebody has to
buffer (the pipe buffers give you some leeway, but they are limited).

Given how new check-ignore is, and that we have not advertised any
particular buffering scheme so far, it's probably OK to switch without
worrying about breaking existing callers.

But if this is a mode of operation that we expect people to use (here
and for check-attr), we should advertise the flushing behavior, and
probably warn about the deadlock (I don't think adding a "--no-flush"
option is worth it, as it would just mean buffering in check-ignore,
which the caller could just as easily do itself).

-Peff
