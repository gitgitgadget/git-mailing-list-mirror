From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/8] git-repack --max-pack-size: make close optional in sha1close()
Date: Tue, 1 May 2007 01:01:56 -0400
Message-ID: <20070501050155.GY5942@spearce.org>
References: <463679AE.7020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 07:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HikV9-0001rm-0p
	for gcvg-git@gmane.org; Tue, 01 May 2007 07:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423785AbXEAFCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 01:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946311AbXEAFCH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 01:02:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60659 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423789AbXEAFCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 01:02:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HikUw-0007tO-OD; Tue, 01 May 2007 01:01:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9467820FBAE; Tue,  1 May 2007 01:01:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <463679AE.7020106@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45912>

Dana How <danahow@gmail.com> wrote:
> sha1close() flushes, writes checksum, and closes.
> The 2nd can be suppressed; make the last suppressible as well.
...
> diff --git a/csum-file.c b/csum-file.c
> index 7c806ad..993c899 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -35,7 +35,10 @@ int sha1close(struct sha1file *f, unsigned char *result, int update)
>  	if (offset) {
>  		SHA1_Update(&f->ctx, f->buffer, offset);
>  		sha1flush(f, offset);
> +		f->offset = 0;
>  	}
> +	if (update < 0)
> +		return 0;	/* only want to flush (no checksum write, no close) */
>  	SHA1_Final(f->buffer, &f->ctx);
>  	if (result)
>  		hashcpy(result, f->buffer);

Huh.  Nobody currently uses that update parameter; all current in-tree
callers (which better be *all* callers since we don't have a true
libgit!) seem to always pass a 1 for this argument.  This makes the
later:

  if (update)
    sha1flush(f, 20);

always true anytime sha1close is called.  Maybe we should be
redefining that update argument to be 1 means do all work, 0 means
return where you return update < 0 above?

-- 
Shawn.
