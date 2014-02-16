From: Jeff King <peff@peff.net>
Subject: [BUG?] git http connection reuse
Date: Sat, 15 Feb 2014 23:05:38 -0500
Message-ID: <20140216040538.GA4754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 05:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEszB-0001cR-QO
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 05:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbaBPEFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 23:05:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:51416 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752587AbaBPEFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 23:05:41 -0500
Received: (qmail 22793 invoked by uid 102); 16 Feb 2014 04:05:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Feb 2014 22:05:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Feb 2014 23:05:38 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242213>

I've noticed that git does not reuse http connections when fetching, and
I'm trying to figure out why. It seems related to our use of two curl
features:

  1. If we use the curl_multi interface (even though we are doing the
     requests sequentially), we do not get reuse.

  2. If we set CURLOPT_HTTPAUTH to CURLAUTH_ANY, we do not get reuse.

It's fairly easy to replicate with the patch below. Running:

  rm -rf test &&
  GIT_CURL_VERBOSE=1 git clone https://github.com/peff/test 2>&1 |
    grep -i connect

produces this with stock git:

  * Connected to github.com (192.30.252.131) port 443 (#0)
  * SSL connection using ECDHE-RSA-AES128-GCM-SHA256
  * Connection #0 to host github.com left intact
  * Connected to github.com (192.30.252.131) port 443 (#1)
  * SSL connection using ECDHE-RSA-AES128-GCM-SHA256
  * Connection #1 to host github.com left intact

and this with the patched git:

  * Connected to github.com (192.30.252.131) port 443 (#0)
  * SSL connection using ECDHE-RSA-AES128-GCM-SHA256
  * Connection #0 to host github.com left intact
  * Re-using existing connection! (#0) with host github.com
  * Connected to github.com (192.30.252.131) port 443 (#0)
  * Connection #0 to host github.com left intact

The patch itself just turns off our use of these features (and is
obviously just for experimentation, not inclusion):

diff --git a/http.c b/http.c
index 70eaa26..8e642fa 100644
--- a/http.c
+++ b/http.c
@@ -313,9 +313,6 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
-#endif
 
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
diff --git a/http.h b/http.h
index cd37d58..6506347 100644
--- a/http.h
+++ b/http.h
@@ -18,11 +18,6 @@
  */
 #undef USE_CURL_MULTI
 
-#if LIBCURL_VERSION_NUM >= 0x071000
-#define USE_CURL_MULTI
-#define DEFAULT_MAX_REQUESTS 5
-#endif
-
 #if LIBCURL_VERSION_NUM < 0x070704
 #define curl_global_cleanup() do { /* nothing */ } while (0)
 #endif

I'm trying to figure out whether these options do not support connection
reuse for some reason, whether we are just invoking curl in a weird or
wrong way, or whether it's a curl bug. The curl_multi code is a bit more
complex, but here's a very simple program that demonstrates the issue
with CURLAUTH_ANY:

-- >8 --
#include <stdio.h>
#include <curl/curl.h>

int main(int argc, char **argv)
{
        CURL *curl = curl_easy_init();

        curl_easy_setopt(curl, CURLOPT_URL, argv[1]);
        curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
        if (argv[2])
                curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
        curl_easy_perform(curl);

        curl_easy_setopt(curl, CURLOPT_URL, argv[1]);
        curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
        curl_easy_perform(curl);
        return 0;
}
-- 8< --

Running it as "./a.out http://example.com" reuses the connection.
Running "./a.out http://example.com break" will set CURLOPT_HTTPAUTH,
and cause curl to make two connections. Are we using curl wrong? Do we
need to be touching CURLOPT_HTTPAUTH in between the requests (doing so
does not seem to help)?

My curl version is 7.35.0, if that makes a difference.

-Peff
