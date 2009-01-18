From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP Patch 04/12] Use the new http API in http_fetch_ref()
Date: Sun, 18 Jan 2009 16:10:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181607210.3586@pacific.mpi-cbg.de>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <1232265877-3649-4-git-send-email-mh@glandium.org>
 <1232265877-3649-5-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:12:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZJn-0003rD-Vv
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761739AbZARPKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762306AbZARPKm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:10:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:56294 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759681AbZARPKm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:10:42 -0500
Received: (qmail invoked by alias); 18 Jan 2009 15:10:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 18 Jan 2009 16:10:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vjb0CDzXvoZkI0545yeGr3j8v6Xjs5REiVLXkv4
	AZQtvnr5KP3AHd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232265877-3649-5-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106211>

Hi,

On Sun, 18 Jan 2009, Mike Hommey wrote:

> diff --git a/http.c b/http.c
> index 82534cf..0c9504b 100644
> --- a/http.c
> +++ b/http.c
> @@ -604,34 +604,17 @@ int http_fetch_ref(const char *base, struct ref *ref)
>  {
>  	char *url;
>  	struct strbuf buffer = STRBUF_INIT;
> -	struct active_request_slot *slot;
> -	struct slot_results results;
> -	int ret;
> +	int ret = -1;
>  
>  	url = quote_ref_url(base, ref->name);
> -	slot = get_active_slot();
> -	slot->results = &results;
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
> -	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> -	if (start_active_slot(slot)) {
> -		run_active_slot(slot);
> -		if (results.curl_result == CURLE_OK) {
> -			strbuf_rtrim(&buffer);
> -			if (buffer.len == 40)
> -				ret = get_sha1_hex(buffer.buf, ref->old_sha1);
> -			else if (!prefixcmp(buffer.buf, "ref: ")) {
> -				ref->symref = xstrdup(buffer.buf + 5);
> -				ret = 0;
> -			} else
> -				ret = 1;
> -		} else {
> -			ret = error("Couldn't get %s for %s\n%s",
> -				    url, ref->name, curl_errorstr);
> +	if (http_get_strbuf(url, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
> +		strbuf_rtrim(&buffer);
> +		if (buffer.len == 40)
> +			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
> +		else if (!prefixcmp(buffer.buf, "ref: ")) {
> +			ref->symref = xstrdup(buffer.buf + 5);
> +			ret = 0;
>  		}
> -	} else {
> -		ret = error("Unable to start request");
>  	}

Why not keep that error?

BTW I had to scratch my head for a few seconds why you do not need to 
set "else ret=1;" for the HTTP_OK case; you set ret = 1 in the beginning.  
I'd rather put that back for clarity.

Ciao,
Dscho
