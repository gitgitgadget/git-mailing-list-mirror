From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Optimize sha1_object_info for loose objects, not
	concurrent repacks
Date: Tue, 5 Aug 2008 13:18:53 -0700
Message-ID: <20080805201853.GG27207@spearce.org>
References: <20080805200841.GA23121@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 22:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQT0i-0005x3-4H
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 22:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764176AbYHEUS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763810AbYHEUS4
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 16:18:56 -0400
Received: from george.spearce.org ([209.20.77.23]:60942 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764091AbYHEUSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 16:18:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D9F9538419; Tue,  5 Aug 2008 20:18:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080805200841.GA23121@midwinter.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91460>

Steven Grimm <koreth@midwinter.com> wrote:
> When dealing with a repository with lots of loose objects, sha1_object_info
> would rescan the packs directory every time an unpacked object was referenced
> before finally giving up and looking for the loose object. This caused a lot
> of extra unnecessary system calls during git pack-objects; the code was
> rereading the entire pack directory once for each loose object file.
> 
> This patch looks for a loose object before falling back to rescanning the
> pack directory, rather than the other way around.
> 
> Signed-off-by: Steven Grimm <koreth@midwinter.com>

Heh.  Cute bug.

ACK.

> diff --git a/sha1_file.c b/sha1_file.c
> index e281c14..32e4664 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1929,11 +1929,18 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
>  int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
>  {
>  	struct pack_entry e;
> +	int status;
>  
>  	if (!find_pack_entry(sha1, &e, NULL)) {
> +		/* Most likely it's a loose object. */
> +		status = sha1_loose_object_info(sha1, sizep);
> +		if (status >= 0)
> +			return status;
> +
> +		/* Not a loose object; someone else may have just packed it. */
>  		reprepare_packed_git();
>  		if (!find_pack_entry(sha1, &e, NULL))
> -			return sha1_loose_object_info(sha1, sizep);
> +			return status;
>  	}
>  	return packed_object_info(e.p, e.offset, sizep);
>  }

-- 
Shawn.
