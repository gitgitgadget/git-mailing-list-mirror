From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Work around curl-gnutls not liking to be reinitialized
Date: Fri, 8 Feb 2008 21:53:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082152410.11591@racer.site>
References: <20080208073456.GA17791@glandium.org> <1202501335-28205-1-git-send-email-mh@glandium.org> <20080208213148.GA2823@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:54:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNbB7-0007f2-KA
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbYBHVxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYBHVxq
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:53:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:45864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751437AbYBHVxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:53:44 -0500
Received: (qmail invoked by alias); 08 Feb 2008 21:53:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 08 Feb 2008 22:53:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PMZQq/bJPgbgf0/SbpPmTn5LgurVIIg0nyWeOTh
	IGWZoGYO4bMcRk
X-X-Sender: gene099@racer.site
In-Reply-To: <20080208213148.GA2823@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73158>

Hi,

On Fri, 8 Feb 2008, Mike Hommey wrote:

> >  In the end, it was a bit of git's fault, but either curl or gnutls is 
> >  the actual culprit. I've not looked into either code to find out 
> >  who's responsible, but a very simplified testcase is as follows:
> > 
> > 	#include <curl/curl.h>
> > 	#include <curl/easy.h>
> > 
> > 	int main(void) {
> > 	        CURL *easy = curl_easy_init();
> > 	        curl_easy_setopt(easy, CURLOPT_VERBOSE, 1);
> > 	        curl_easy_setopt(easy, CURLOPT_URL, "https://www.verisign.com/");
> > 	        curl_easy_perform(easy);
> > 	        curl_global_cleanup();
> > 	        easy = curl_easy_init();
> > 	        curl_easy_setopt(easy, CURLOPT_VERBOSE, 1);
> > 	        curl_easy_setopt(easy, CURLOPT_URL, "https://www.verisign.com/");
> > 	        curl_easy_perform(easy);
> > 	}
> > 
> > 	(build with gcc -o test test.c -lcurl)
> > 	(note curl_easy_init does curl_global_init behind the curtains, 
> >      even the second time. You can convince yourself by adding
> > 	 curl_global_init(CURL_GLOBAL_ALL);)
> 
> And the winner is... curl !
> The bug was introduced in this commit:
> http://cool.haxx.se/cvs.cgi/curl/lib/gtls.c.diff?r1=1.26&r2=1.27
> Note how gtls_inited is not set back to FALSE in cleanup.

Wow.  I hope you used "git bisect", in order to spare you unnecessary 
work...

> This ended up released in 7.16.3. I'm filing a bug.

Thanks for being so persistent.

Ciao,
Dscho
