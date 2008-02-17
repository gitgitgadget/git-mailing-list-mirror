From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] sending errors to stdout under $PAGER
Date: Sun, 17 Feb 2008 02:50:33 -0500
Message-ID: <20080217075033.GP24004@spearce.org>
References: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 08:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQeJ6-0006FA-GX
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 08:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbYBQHuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 02:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbYBQHuh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 02:50:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49431 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYBQHug (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 02:50:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JQeID-0007Lg-PR; Sun, 17 Feb 2008 02:50:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B120520FBAE; Sun, 17 Feb 2008 02:50:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74099>

Junio C Hamano <gitster@pobox.com> wrote:
> Because we spawn the pager as the foreground process and feed
> its input via pipe from the real command, we cannot affect the
> exit status the shell sees from git command when the pager is in
> use (I think there is not much gain we can have by working it
> around, though).  But at least it may make sense to show the
> error message to the user sitting in front of the pager, perhaps
> like this.
> 
> What do people think?  Have I overlooked any downsides?

I think this is a good idea.

If you are using an interactive pager, you have asked for the content
to come to you through that.  Not unlike how I have chosen to have
the content come to me through a virtual pty and not a printer with
green-and-white bar paper.  :)

I've been bitten by this in the past a few times, but I have also
been knowledgable enough about git, the command I ran, and the
project I ran it on to realize something wasn't right with the
output I am seeing in the pager and retry without the pager to see
the real error(s).

> +++ b/usage.c
> @@ -4,12 +4,15 @@
>   * Copyright (C) Linus Torvalds, 2005
>   */
>  #include "git-compat-util.h"
> +#include "cache.h"
>  
>  static void report(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[256];
> +	FILE *outto = (pager_in_use() ? stdout : stderr);
> +
>  	vsnprintf(msg, sizeof(msg), err, params);
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +	fprintf(outto, "%s%s\n", prefix, msg);
>  }

-- 
Shawn.
