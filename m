From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fail properly when cloning from invalid HTTP URL
Date: Thu, 7 Aug 2008 10:10:35 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808071007440.19665@iabervon.org>
References: <1218067590-31590-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 07 16:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR6DN-0008QS-9X
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 16:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbYHGOKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 10:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYHGOKi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 10:10:38 -0400
Received: from iabervon.org ([66.92.72.58]:53155 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbYHGOKh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 10:10:37 -0400
Received: (qmail 21990 invoked by uid 1000); 7 Aug 2008 14:10:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Aug 2008 14:10:35 -0000
In-Reply-To: <1218067590-31590-1-git-send-email-pasky@suse.cz>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91583>

On Thu, 7 Aug 2008, pasky@suse.cz wrote:

> From: Petr Baudis <pasky@suse.cz>
> 
> Currently, when cloning from invalid HTTP URL, git clone will possibly
> return curl error, then a confusing message about remote HEAD and then
> return success and leave an empty repository behind, confusing either
> the end-user or the automated service calling it (think repo.or.cz).
> 
> This patch changes the error() calls in get_refs_via_curl() to die()s,
> akin to the other get_refs_*() functions.
> 
> Cc: Daniel Barkalow <barkalow@iabervon.org>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
>  transport.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/transport.c b/transport.c
> index 6eb65b8..b88b89b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -464,16 +464,15 @@ static struct ref *get_refs_via_curl(struct transport *transport)
>  		if (results.curl_result != CURLE_OK) {
>  			strbuf_release(&buffer);
>  			if (missing_target(&results)) {
> +				die("%s not found: did you run git update-server-info on the server?", refs_url);
>  				return NULL;

The "return NULL" isn't necessary any more. Otherwise,

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

>  			} else {
> -				error("%s", curl_errorstr);
> -				return NULL;
> +				die("%s download error - %s", refs_url, curl_errorstr);
>  			}
>  		}
>  	} else {
>  		strbuf_release(&buffer);
> -		error("Unable to start request");
> -		return NULL;
> +		die("Unable to start HTTP request");
>  	}
>  
>  	data = buffer.buf;
> -- 
> 1.5.6.3.392.g292f1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
