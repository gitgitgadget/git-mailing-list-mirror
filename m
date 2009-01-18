From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP Patch 05/12] Use the new http API in get_refs_via_curl()
Date: Sun, 18 Jan 2009 16:12:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181611380.3586@pacific.mpi-cbg.de>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org> <1232265877-3649-6-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:14:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZLw-0004xr-SM
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762771AbZARPM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762745AbZARPM4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:12:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:48055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762659AbZARPM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:12:56 -0500
Received: (qmail invoked by alias); 18 Jan 2009 15:12:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 18 Jan 2009 16:12:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/A4Jfzfu/409SIanJUg9E8st0YUeEEFMLquqFF+
	+3d+FcSg8xhYZz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232265877-3649-6-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106213>

Hi,

On Sun, 18 Jan 2009, Mike Hommey wrote:

> @@ -450,26 +447,8 @@ static struct ref *get_refs_via_curl(struct transport *transport)
>  	refs_url = xmalloc(strlen(transport->url) + 11);
>  	sprintf(refs_url, "%s/info/refs", transport->url);
>  
> -	slot = get_active_slot();
> -	slot->results = &results;
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_URL, refs_url);
> -	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
> -
> -	if (start_active_slot(slot)) {
> -		run_active_slot(slot);
> -		if (results.curl_result != CURLE_OK) {
> -			strbuf_release(&buffer);
> -			if (missing_target(&results))
> -				die("%s not found: did you run git update-server-info on the server?", refs_url);
> -			else
> -				die("%s download error - %s", refs_url, curl_errorstr);
> -		}
> -	} else {
> -		strbuf_release(&buffer);
> -		die("Unable to start HTTP request");
> -	}
> +	if (http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE) != HTTP_OK)
> +		goto cleanup;

Why not die() as the original code?

Ciao,
Dscho
