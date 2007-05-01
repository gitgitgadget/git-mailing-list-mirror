From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 6/8] git-repack --max-pack-size: write_one() implements limits
Date: Tue, 1 May 2007 01:25:17 -0400
Message-ID: <20070501052517.GA5942@spearce.org>
References: <46367A68.4010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 07:25:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiks4-0000po-NB
	for gcvg-git@gmane.org; Tue, 01 May 2007 07:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbXEAFZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 01:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754411AbXEAFZh
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 01:25:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:32863 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030965AbXEAFZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 01:25:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HikrY-0000L8-22; Tue, 01 May 2007 01:25:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1B8A220FBAE; Tue,  1 May 2007 01:25:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46367A68.4010008@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45915>

Dana How <danahow@gmail.com> wrote:
> 
> If --max-pack-size is specified,  generate the appropriate
> write limit for each object and pass it to write_object().
> Detect and return write "failure".
> 
> Signed-off-by: Dana L. How <danahow@gmail.com>
> ---
>  builtin-pack-objects.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index d3ebe1d..b50de05 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -612,11 +612,17 @@ static off_t write_one(struct sha1file *f,
>  		return offset;
>  
>  	/* if we are deltified, write out base object first. */
> -	if (e->delta)
> +	if (e->delta) {
>  		offset = write_one(f, e->delta, offset);
> +		if (!offset)
> +			return 0;
> +	}

So offset == 0 means we didn't write this object into this packfile?
Did I read your changes right?

>  	e->offset = offset;
> -	size = write_object(f, e, 0);
> +	/* pass in write limit if limited packsize and not first object */
> +	size = write_object(f, e, pack_size_limit && nr_written ? pack_size_limit - offset : 0);

Why wasn't this in the prior patch?  You had almost everything in
place, but hardcoded the option to 0, to then just change it here
in this patch to non-zero under some conditions?

I'd also like to see that line <80 characters, but that's just me
and my own style preferences.

But isn't that argument actually kind of silly here?  None of
the values that are used to compute that 3rd boolean argument to
write_objet depend on things that are local to write_one - they
are all global values.  Can't we spare the poor register-starved
x86 platform and just let write_object compute that value itself?

> +	if (!size)
> +		return e->offset = 0;

Ugh.  I don't really like to see assignment in the middle of an
evaluation of an rvalue, and especially here in a return.  Burn the
couple of lines to segment it out:

	if (!size) {
		e->offset = 0;
		return 0;
	}

or something.  Because its a lot more clear and doesn't look like
you missed an = to make "return e->offset == 0".

-- 
Shawn.
