From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Work around curl-gnutls not liking to be
 reinitialized
Date: Fri, 8 Feb 2008 22:51:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082250550.11591@racer.site>
References: <20080208220941.GA22199@glandium.org> <1202509359-23840-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNc50-0002iZ-9t
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbYBHWvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbYBHWvq
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:51:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:41761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751637AbYBHWvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:51:45 -0500
Received: (qmail invoked by alias); 08 Feb 2008 22:51:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp057) with SMTP; 08 Feb 2008 23:51:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Mvj0mde+MLkxMy/Iek1KSBWir/Rn1E5unMfM0j8
	aHW6I/h+syCIq+
X-X-Sender: gene099@racer.site
In-Reply-To: <1202509359-23840-1-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73168>

Hi,

On Fri, 8 Feb 2008, Mike Hommey wrote:

> diff --git a/http.c b/http.c
> index d2c11ae..a3aa9e9 100644
> --- a/http.c
> +++ b/http.c
> @@ -215,9 +215,14 @@ static CURL* get_curl_handle(void)
>  
>  void http_init(void)
>  {
> +	static int init = 0;
>  	char *low_speed_limit;
>  	char *low_speed_time;
>  
> +	if (init)
> +		return;
> +	init = 1;
> +

Don't you have to make this conditional on the CURL version as well?  I 
mean, that cleanup:

> diff --git a/transport.c b/transport.c
> index babaa21..32ab521 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -473,7 +473,9 @@ static struct ref *get_refs_via_curl(struct transport *transport)
>  		return NULL;
>  	}
>  
> +#if (LIBCURL_VERSION_NUM < 0x071003) || (LIBCURL_VERSION_NUM > 0x071200)
>  	http_cleanup();
> +#endif

requires us to init again, no?

Ciao,
Dscho
