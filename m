From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP Patch 07/12] Use the new http API in
 http-push.c:fetch_indices()
Date: Sun, 18 Jan 2009 16:14:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181613580.3586@pacific.mpi-cbg.de>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org> <1232265877-3649-6-git-send-email-mh@glandium.org> <1232265877-3649-7-git-send-email-mh@glandium.org> <1232265877-3649-8-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZNY-0005nr-6w
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762306AbZARPOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759681AbZARPOg
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:14:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:60844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756871AbZARPOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:14:35 -0500
Received: (qmail invoked by alias); 18 Jan 2009 15:14:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 18 Jan 2009 16:14:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fhIVazPVflAfwK6TstA9R+410OeSvh107uLHJdh
	2gEj1aMFgTLASI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232265877-3649-8-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106214>

Hi,

On Sun, 18 Jan 2009, Mike Hommey wrote:

> @@ -1018,28 +1016,10 @@ static int fetch_indices(void)
>  	url = xmalloc(strlen(remote->url) + 20);
>  	sprintf(url, "%sobjects/info/packs", remote->url);
>  
> -	slot = get_active_slot();
> -	slot->results = &results;
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> -	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
> -	if (start_active_slot(slot)) {
> -		run_active_slot(slot);
> -		if (results.curl_result != CURLE_OK) {
> -			strbuf_release(&buffer);
> -			free(url);
> -			if (results.http_code == 404)
> -				return 0;
> -			else
> -				return error("%s", curl_errorstr);
> -		}
> -	} else {
> -		strbuf_release(&buffer);
> -		free(url);
> -		return error("Unable to start request");
> +	if (http_get_strbuf(url, &buffer, 0) != HTTP_OK) {
> +		ret = -1;
> +		goto cleanup;
>  	}

Let's make that

		ret = error("%s", curl_errorstr);

okay?

Ciao,
Dscho
