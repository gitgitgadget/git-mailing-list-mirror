From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git_mkstemp to return an error when path is too
 long.
Date: Thu, 26 Jul 2007 04:36:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260433280.14781@racer.site>
References: <46A7F9C4.7030004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 05:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDu9T-00010C-HH
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774AbXGZDgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 23:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757918AbXGZDgc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:36:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:49295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757724AbXGZDgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:36:31 -0400
Received: (qmail invoked by alias); 26 Jul 2007 03:36:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 26 Jul 2007 05:36:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19V3zIXNcRVJ83SE90aLCgUf23DP5bc4XVwumfYYr
	YU3i2exHYRZBNr
X-X-Sender: gene099@racer.site
In-Reply-To: <46A7F9C4.7030004@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53757>

Hi,

On Thu, 26 Jul 2007, Carlos Rica wrote:

> @@ -79,12 +80,14 @@ int git_mkstemp(char *path, size_t len, const char *template)
>  		pch += 5;
>  	} else {
>  		size_t n = snprintf(pch, len, "%s/", env);
> -
> +		if (n >= len)
> +			return -2;

That is certainly a bug fixed (even if few people have an insanely long 
TMPDIR...)

>  		len -= n;
>  		pch += n;
>  	}
> 
> -	strlcpy(pch, template, len);
> +	if (strlcpy(pch, template, len) >= len)
> +		return -2;

Maybe just "return error("filename too long: %.*s", 60, pch);"?  So that 
all callers to git_mkstemp() get the message for free?


Ciao,
Dscho
