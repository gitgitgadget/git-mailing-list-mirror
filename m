From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git http connection reuse
Date: Mon, 17 Feb 2014 18:56:26 -0500
Message-ID: <20140217235625.GB20499@sigill.intra.peff.net>
References: <20140216040538.GA4754@sigill.intra.peff.net>
 <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com>
 <alpine.DEB.2.00.1402161307160.10435@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Feb 18 00:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFY36-0005Bv-8E
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 00:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbaBQX42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 18:56:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:52305 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751896AbaBQX41 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 18:56:27 -0500
Received: (qmail 24779 invoked by uid 102); 17 Feb 2014 23:56:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Feb 2014 17:56:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Feb 2014 18:56:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1402161307160.10435@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242272>

On Sun, Feb 16, 2014 at 01:18:52PM +0100, Daniel Stenberg wrote:

> On Sat, 15 Feb 2014, Kyle J. McKay wrote:
> 
> >If pipelining is off (the default) and total connections is not 1
> >it sounds to me from the description above that the requests will
> >be executed on separate connections until the maximum number of
> >connections is in use and then there might be some reuse.
> 
> Not exactly. When about to do a request, libcurl will always try to
> find an existing idle but open connection in its connection pool to
> re-use. With the multi interface you can of course easily start N
> requests at once to the same host and then they'll only re-use
> connections to the extent there are connections to pick, otherwise
> it'll create new connections.

Right; I'd expect multiple connections for parallel requests, but in
this case we are completing the first and removing the handle before
starting the second. Digging further, I was able to reproduce the
behavior with a simple program:

-- >8 --
#include <stdio.h>
#include <stdlib.h>
#include <curl/curl.h>

int main(int argc, char **argv)
{
        CURL *curl = curl_easy_init();
        CURLM *multi = curl_multi_init();
        int want_multi = atoi(argv[2]);
        int i;

        curl_easy_setopt(curl, CURLOPT_URL, argv[1]);
        curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);

        for (i = 0; i < 2; i++) {
                if (i < want_multi) {
                        int nr;

                        curl_multi_add_handle(multi, curl);
                        do {
                                curl_multi_perform(multi, &nr);
                        } while (nr);
                        curl_multi_remove_handle(multi, curl);
                }
                else
                        curl_easy_perform(curl);
        }

        return 0;
}
-- 8< --

The program just requests the same URL twice using the same curl handle,
optionally using the multi interface for zero, one, or both of the
requests. For "0" and "2" (i.e., either both curl_easy or both
curl_multi), the connection is reused. But for "1" (in which we use
multi for the first request, but easy for the second), we do not reuse
the connection.

The manpage for curl_multi_add_handle does say:

  When an easy handle has been added to a multi stack, you can not
  and you must not use curl_easy_perform(3) on that handle!

Does that apply to the handle after it has finished its transaction and
been removed from the multi object (in which case git is Doing It
Wrong)? Is the program above failing to take some step to finalize the
first request, so that the second one knows its connection can be
reused? Or should curl be handling this?

-Peff
