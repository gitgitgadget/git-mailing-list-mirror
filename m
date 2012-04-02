From: Jeff King <peff@peff.net>
Subject: Re: Cannot clone the git repository shared over http with
 authorization.
Date: Mon, 2 Apr 2012 04:31:15 -0400
Message-ID: <20120402083115.GA2235@sigill.intra.peff.net>
References: <20120401184804.GJ3236@szczaw.snafu.pl>
 <20120401194534.GA16512@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Artur R. Czechowski" <arturcz@hell.pl>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Apr 02 10:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEcfc-0002v2-Np
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 10:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab2DBIbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 04:31:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43144
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab2DBIbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 04:31:18 -0400
Received: (qmail 14522 invoked by uid 107); 2 Apr 2012 08:31:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Apr 2012 04:31:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2012 04:31:15 -0400
Content-Disposition: inline
In-Reply-To: <20120401194534.GA16512@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194502>

On Sun, Apr 01, 2012 at 09:45:36PM +0200, Clemens Buchacher wrote:

> So far I figured out that setting 'git config http.maxRequests 1' fixes
> the problem as well. Looking at the output with GIT_CURL_VERBOSE=1 set,
> it seems that some GET requests use the credentials, while others do
> not. My guess is that the CURLOPT_USERPWD option does not apply to all
> threads.

Yes, that is exactly it. Furthermore, the multi-fetch code paths used by
the http walker do not have the magic "notice a 401 and retry". I think
something like this should fix it (it passes your tests):

diff --git a/http.c b/http.c
index f3f83d7..c6dc9b7 100644
--- a/http.c
+++ b/http.c
@@ -494,6 +494,8 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	if (http_auth.password)
+		init_curl_http_auth(slot->curl);
 
 	return slot;
 }

which is basically just double-checking that we set CURLOPT_USERPWD
whenever we get a slot (I wish there was some way of asking "does this
curl handle have USERPWD already set?", but I couldn't fine one).

It still doesn't do 401-handling itself, but it works OK in practice
because the first request will be a non-multi fetch (to get info/refs),
which recognizes the 401 and prompts the user, and then that credential
gets used subsequently.

-Peff
