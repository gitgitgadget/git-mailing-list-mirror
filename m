From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] unpack_entry: do not die when we fail to apply a delta
Date: Thu, 13 Jun 2013 20:05:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1306132004090.18597@syhkavp.arg>
References: <20130613232608.GA9844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 02:05:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnHWH-0000QD-7I
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 02:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759246Ab3FNAFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 20:05:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52508 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759227Ab3FNAFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 20:05:22 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MOC00B9BW8XVX00@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Jun 2013 20:05:21 -0400 (EDT)
In-reply-to: <20130613232608.GA9844@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227785>

On Thu, 13 Jun 2013, Jeff King wrote:

> When we try to load an object from disk and fail, our
> general strategy is to see if we can get it from somewhere
> else (e.g., a loose object). That lets users fix corruption
> problems by copying known-good versions of objects into the
> object database.
> 
> We already handle the case where we were not able to read
> the delta from disk. However, when we find that the delta we
> read does not apply, we simply die.  This case is harder to
> trigger, as corruption in the delta data itself would
> trigger a crc error from zlib.  However, a corruption that
> pointed us at the wrong delta base might cause it.
> 
> We can do the same "fail and try to find the object
> elsewhere" trick instead of dying. This not only gives us a
> chance to recover, but also puts us on code paths that will
> alert the user to the problem (with the current message,
> they do not even know which sha1 caused the problem).
> 
> Signed-off-by: Jeff King <peff@peff.net>

That makes sense.

Could you produce a test case to go along with this change?

> ---
> I needed this earlier today to recover from a corrupted packfile (I
> fortunately had an older version of the repo in backups). Still tracking
> down the exact nature of the corruption.
> 
>  sha1_file.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 5c08701..d458708 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2135,8 +2135,17 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
>  		data = patch_delta(base, base_size,
>  				   delta_data, delta_size,
>  				   &size);
> +
> +		/*
> +		 * We could not apply the delta; warn the user, but keep going.
> +		 * Our failure will be noticed either in the next iteration of
> +		 * the loop, or if this is the final delta, in the caller when
> +		 * we return NULL. Those code paths will take care of making
> +		 * a more explicit warning and retrying with another copy of
> +		 * the object.
> +		 */
>  		if (!data)
> -			die("failed to apply delta");
> +			error("failed to apply delta");
>  
>  		free(delta_data);
>  	}
> -- 
> 1.8.3.rc2.14.g7eee6b3
> 
