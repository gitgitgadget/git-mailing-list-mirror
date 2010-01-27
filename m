From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 13:39:00 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001271335140.14365@iabervon.org>
References: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:40:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaCnG-00034U-N8
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 19:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab0A0SjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 13:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282Ab0A0SjD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 13:39:03 -0500
Received: from iabervon.org ([66.92.72.58]:33835 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab0A0SjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 13:39:01 -0500
Received: (qmail 24520 invoked by uid 1000); 27 Jan 2010 18:39:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jan 2010 18:39:00 -0000
In-Reply-To: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138180>

On Wed, 27 Jan 2010, Ilari Liusvaara wrote:

> remote.<remote>.vcs causes remote->foreign_vcs to be set on entry to
> transport_get(). Unfortunately, the code assumed that any such entry
> is stale from previous round.
> 
> Fix this by making VCS set by URL to be volatile w.r.t. transport_get()
> instead.
> 
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>

Except that you missed the "remote == NULL" case (noted below), this is 
what I was thinking of.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

> ---
>  transport.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> Differences from first round:
> 
> This makes VCS setting apply to all URLs that don't explicitly override,
> instead of it applying to just the first one.
> 
> diff --git a/transport.c b/transport.c
> index 7714fdb..87581b8 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -912,20 +912,19 @@ static int external_specification_len(const char *url)
>  
>  struct transport *transport_get(struct remote *remote, const char *url)
>  {
> +	const char *helper;
>  	struct transport *ret = xcalloc(1, sizeof(*ret));
>  
>  	if (!remote)
>  		die("No remote provided to transport_get()");
>  
>  	ret->remote = remote;
> +	helper = remote->foreign_vcs;

Needs to be "helper = remote ? remote->foreign_vcs : NULL", for the same 
reason that the test below had been "remote && remote->foreign_vcs".

>  
>  	if (!url && remote && remote->url)
>  		url = remote->url[0];
>  	ret->url = url;
>  
> -	/* In case previous URL had helper forced, reset it. */
> -	remote->foreign_vcs = NULL;
> -
>  	/* maybe it is a foreign URL? */
>  	if (url) {
>  		const char *p = url;
> @@ -933,11 +932,11 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  		while (isalnum(*p))
>  			p++;
>  		if (!prefixcmp(p, "::"))
> -			remote->foreign_vcs = xstrndup(url, p - url);
> +			helper = xstrndup(url, p - url);
>  	}
>  
> -	if (remote && remote->foreign_vcs) {
> -		transport_helper_init(ret, remote->foreign_vcs);
> +	if (helper) {
> +		transport_helper_init(ret, helper);
>  	} else if (!prefixcmp(url, "rsync:")) {
>  		ret->get_refs_list = get_refs_via_rsync;
>  		ret->fetch = fetch_objs_via_rsync;
> -- 
> 1.7.0.rc0.19.gb557e6
> 
> 
