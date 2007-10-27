From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/8] push: change push to fail if short ref name does
 not exist
Date: Sat, 27 Oct 2007 17:42:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710271716120.7345@iabervon.org>
References: <119350380778-git-send-email-prohaska@zib.de>
 <11935038081211-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 23:42:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IltQU-00059X-1M
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 23:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbXJ0Vm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 17:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbXJ0Vm0
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 17:42:26 -0400
Received: from iabervon.org ([66.92.72.58]:40323 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbXJ0VmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 17:42:25 -0400
Received: (qmail 25428 invoked by uid 1000); 27 Oct 2007 21:42:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Oct 2007 21:42:24 -0000
In-Reply-To: <11935038081211-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62512>

On Sat, 27 Oct 2007, Steffen Prohaska wrote:

> You can use a branch's shortname to push it. Push used to create
> the branch on the remote side if it did not yet exist. If you
> specified the wrong branch accidentally it was created. A safety
> valve that pushes only existing branches may help to avoid
> errors.
> 
> This commit changes push to fail if the remote ref does not yet
> exist and the refspec does not start with refs/. Remote refs must
> explicitly be created with their full name.

I agree with the change (and I think it's appropriate for master or next), 
but your implementation is a bit too clever for my tastes.

> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  remote.c              |    5 +++--
>  t/t5516-fetch-push.sh |   34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index 170015a..ec992c9 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -611,6 +611,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
>  	struct ref *matched_src, *matched_dst;
>  
>  	const char *dst_value = rs->dst;
> +	const char * const orig_dst_value = rs->dst ? rs->dst : rs->src;

"lit_dst_value" would probably be a better description, and it might be 
worth handling the rs->dst == NULL case where it's handled for dst_value. 
Technically, this variable, when it doesn't match the final value of 
dst_value, has a value that dst_value never had.

>  
>  	if (rs->pattern)
>  		return errs;
> @@ -647,12 +648,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
>  	case 1:
>  		break;
>  	case 0:
> -		if (!memcmp(dst_value, "refs/", 5))
> +		if (!memcmp(orig_dst_value , "refs/", 5))
>  			matched_dst = make_linked_ref(dst_value, dst_tail);

This should also be orig_dst_value, too. I know that dst_value and 
orig_dst_value must be the same in this case, but it takes a bunch of 
analysis to demonstrate that, and it's more intuitive to use the value 
you've just checked anyway, and also to have all of case 0 use the 
differently-computed destination.

>  		else
>  			error("dst refspec %s does not match any "
>  			      "existing ref on the remote and does "
> -			      "not start with refs/.", dst_value);
> +			      "not start with refs/.", orig_dst_value);

Maybe the error should provide a hint if dst_value is not the same as 
orig_dst_value? (if (!rs->dst) error("Did you mean %s?\n", dst_value);)

	-Daniel
*This .sig left intentionally blank*
