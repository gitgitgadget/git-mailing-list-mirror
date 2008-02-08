From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Work around curl-gnutls not liking to be reinitialized
Date: Fri, 8 Feb 2008 23:01:23 +0100
Organization: glandium.org
Message-ID: <20080208220123.GA21882@glandium.org>
References: <20080208073456.GA17791@glandium.org> <1202501335-28205-1-git-send-email-mh@glandium.org> <20080208213148.GA2823@glandium.org> <alpine.LSU.1.00.0802082152410.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNbHy-0001lK-QH
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbYBHWBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYBHWBA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:01:00 -0500
Received: from vuizook.err.no ([85.19.215.103]:56192 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754249AbYBHWA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:00:59 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNbI7-0006en-Hi; Fri, 08 Feb 2008 23:01:58 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNbHf-0005je-KF; Fri, 08 Feb 2008 23:01:23 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802082152410.11591@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73159>

On Fri, Feb 08, 2008 at 09:53:47PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 8 Feb 2008, Mike Hommey wrote:
> 
> > >  In the end, it was a bit of git's fault, but either curl or gnutls is 
> > >  the actual culprit. I've not looked into either code to find out 
> > >  who's responsible, but a very simplified testcase is as follows:
> > > 
> > > 	#include <curl/curl.h>
> > > 	#include <curl/easy.h>
> > > 
> > > 	int main(void) {
> > > 	        CURL *easy = curl_easy_init();
> > > 	        curl_easy_setopt(easy, CURLOPT_VERBOSE, 1);
> > > 	        curl_easy_setopt(easy, CURLOPT_URL, "https://www.verisign.com/");
> > > 	        curl_easy_perform(easy);
> > > 	        curl_global_cleanup();
> > > 	        easy = curl_easy_init();
> > > 	        curl_easy_setopt(easy, CURLOPT_VERBOSE, 1);
> > > 	        curl_easy_setopt(easy, CURLOPT_URL, "https://www.verisign.com/");
> > > 	        curl_easy_perform(easy);
> > > 	}
> > > 
> > > 	(build with gcc -o test test.c -lcurl)
> > > 	(note curl_easy_init does curl_global_init behind the curtains, 
> > >      even the second time. You can convince yourself by adding
> > > 	 curl_global_init(CURL_GLOBAL_ALL);)
> > 
> > And the winner is... curl !
> > The bug was introduced in this commit:
> > http://cool.haxx.se/cvs.cgi/curl/lib/gtls.c.diff?r1=1.26&r2=1.27
> > Note how gtls_inited is not set back to FALSE in cleanup.
> 
> Wow.  I hope you used "git bisect", in order to spare you unnecessary 
> work...

This was actually easy to spot without. I was pretty sure something
fishy was going on with the curl_global_cleanup code, so I followed it
up to Curl_gtls_cleanup and there it was just under my eyes. I only had
to use the annotate thingy in viewcvs (and leave out version 1.35 of the
file, that does whitespace changes only).

Mike
