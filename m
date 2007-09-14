From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RESEND PATCH 1/2] Fix builtin-fetch memory corruption by not overstepping array
Date: Fri, 14 Sep 2007 19:14:41 -0400
Message-ID: <20070914231441.GW3099@spearce.org>
References: <20070914225953.GC16512@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 01:14:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWKNB-0001va-UW
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 01:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166AbXINXOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 19:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbXINXOu
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 19:14:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51308 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbXINXOt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 19:14:49 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWKNF-0000lI-B5; Fri, 14 Sep 2007 19:14:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 07AEA20FBAE; Fri, 14 Sep 2007 19:14:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070914225953.GC16512@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58210>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Unfortunately we cannot continue to NULL terminate the array at
> this point as the array may only have been allocated large enough
> to match the input of nr_heads.  If there are no duplicates than
> we would be trying to store NULL into heads[nr_heads] and that may
> be outside of the array.
...
> diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
> index b0936cc..2977a94 100644
> --- a/builtin-fetch-pack.c
> +++ b/builtin-fetch-pack.c
> @@ -654,7 +654,6 @@ static int remove_duplicates(int nr_heads, char **heads)
>  			heads[dst] = heads[src];
>  		dst++;
>  	}
> -	heads[dst] = 0;
>  	return dst;
>  }
>  

This fortunately does not appear to be a bug in `maint`, `master`,
or `next`.  It appears to be isolated to the builtin-fetch topic.
The builtin-fetch topic changed fetch-pack to be builtin-fetch-pack
and in doing so changed things such that the heads array might not
have room for this final entry.

In maint/master/next the heads array is actually backed by the
argv passed into main by the kernel, and that does have an existing
NULL terminator, which the above "heads[dst] = 0" is simply going
to overwrite if "heads == nr_heads".

-- 
Shawn.
