From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP Patch 08/12] Use the new http API in
 update_remote_info_refs()
Date: Sun, 18 Jan 2009 16:18:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181615070.3586@pacific.mpi-cbg.de>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org> <1232265877-3649-6-git-send-email-mh@glandium.org> <1232265877-3649-7-git-send-email-mh@glandium.org> <1232265877-3649-8-git-send-email-mh@glandium.org> <1232265877-3649-9-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:19:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZR7-00084T-6g
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764201AbZARPST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762659AbZARPSS
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:18:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:51875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756604AbZARPSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:18:17 -0500
Received: (qmail invoked by alias); 18 Jan 2009 15:18:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 18 Jan 2009 16:18:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pjQl6wpppARGR7QhSAA/RZdMqnIbC34X09BZDcI
	DNVLUKbl5J98vt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232265877-3649-9-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106224>

Hi,

On Sun, 18 Jan 2009, Mike Hommey wrote:

> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  http-push.c |   29 ++++++++++-------------------
>  1 files changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/http-push.c b/http-push.c
> index e0b4f5a..7627860 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1960,29 +1960,20 @@ static void update_remote_info_refs(struct remote_lock *lock)
>  static int remote_exists(const char *path)
>  {

Heh, I see where your commit subject comes from, but it should rather 
mention the function "remote_exists()"...

>  	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
> -	struct active_request_slot *slot;
> -	struct slot_results results;
> -	int ret = -1;
> +	int ret;
>  
>  	sprintf(url, "%s%s", remote->url, path);
>  
> -	slot = get_active_slot();
> -	slot->results = &results;
> -	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> -	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
> -
> -	if (start_active_slot(slot)) {
> -		run_active_slot(slot);
> -		if (results.http_code == 404)
> -			ret = 0;
> -		else if (results.curl_result == CURLE_OK)
> -			ret = 1;
> -		else
> -			fprintf(stderr, "HEAD HTTP error %ld\n", results.http_code);
> -	} else {
> -		fprintf(stderr, "Unable to start HEAD request\n");
> +	switch (http_get_strbuf(url, NULL, 0)) {
> +	case HTTP_OK:
> +		ret = 1;
> +		break;
> +	case HTTP_MISSING_TARGET:
> +		ret = 0;
> +		break;
> +	default:
> +		ret = -1;
>  	}

Does http_get_strbuf() already show the error?  Not as far as I can see, 
even if it would make sense, no?  At least you'll have to "return 
error(...)".

Ciao,
Dscho
