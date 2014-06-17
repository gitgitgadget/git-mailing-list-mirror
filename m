From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: fix charset detection of extract_content_type()
Date: Tue, 17 Jun 2014 05:31:07 -0400
Message-ID: <20140617093106.GA5922@sigill.intra.peff.net>
References: <539caff7.e7bc420a.76b9.fffff853@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: nori <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:31:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwpjV-0006zS-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 11:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbaFQJbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 05:31:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:45912 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932240AbaFQJbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 05:31:07 -0400
Received: (qmail 22455 invoked by uid 102); 17 Jun 2014 09:31:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 04:31:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 05:31:07 -0400
Content-Disposition: inline
In-Reply-To: <539caff7.e7bc420a.76b9.fffff853@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251856>

On Sun, Jun 15, 2014 at 03:49:34AM +0900, nori wrote:

> extract_content_type() could not extract a charset parameter if the
> parameter is not the first one and there is a whitespace and a following
> semicolon just before the parameter. For example:
> 
>     text/plain; format=fixed ;charset=utf-8

Thanks, I think your patch does the right thing. We also have a similar
situation going the other way. If we have:

   text/plain; charset=utf-8; format=fixed

we will parse the charset as "utf-8;". My version of iconv actually
seems to accept that, but we should probably be more careful.

I think parameter values can actually be fully quoted. So you could
have something as nasty as:

  text/plain; some-param="a long value with ;semicolons;"; charset=utf-8

I'd rather not get into parsing that level, as I don't expect it to
happen in the real world. And besides, we actually _would_ find the
charset here with the current code; the only thing we might do wrong is
to parse:

  text/plain; tricky="param; charset=foo"; charset=bar

with charset "foo" rather than "bar". But that's highly unlikely, and
the stakes are fairly low (we just show the error message in the wrong
charset).

Anyway, when you re-roll with the correct "From:" header, do you mind
squashing in the extra change and the tests below?

diff --git a/http.c b/http.c
index 05e8b91..3a28b21 100644
--- a/http.c
+++ b/http.c
@@ -927,7 +927,7 @@ static int extract_param(const char *raw, const char *name,
 		return -1;
 	raw++;
 
-	while (*raw && !isspace(*raw))
+	while (*raw && !isspace(*raw) && *raw != ';')
 		strbuf_addch(out, *raw++);
 	return 0;
 }
diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
index eafc9d2..a77b8e5 100755
--- a/t/lib-httpd/error.sh
+++ b/t/lib-httpd/error.sh
@@ -19,6 +19,10 @@ case "$PATH_INFO" in
 	printf "text/plain; charset=utf-16"
 	charset=utf-16
 	;;
+*odd-spacing*)
+	printf "text/plain; foo=bar ;charset=utf-16; other=nonsense"
+	charset=utf-16
+	;;
 esac
 printf "\n"
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 01b8aae..ac71418 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -191,5 +191,10 @@ test_expect_success 'http error messages are reencoded' '
 	grep "this is the error message" stderr
 '
 
+test_expect_success 'reencoding is robust to whitespace oddities' '
+	test_must_fail git clone "$HTTPD_URL/error/odd-spacing" 2>stderr &&
+	grep "this is the error message" stderr
+'
+
 stop_httpd
 test_done
