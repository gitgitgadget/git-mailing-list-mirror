From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Tue, 26 Apr 2016 13:38:53 -0400
Message-ID: <20160426173853.GB7609@sigill.intra.peff.net>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
 <xmqq7fflleau.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1604260851390.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:39:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6x0-00010p-6a
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbcDZRi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:38:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:56647 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751870AbcDZRi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:38:56 -0400
Received: (qmail 6201 invoked by uid 102); 26 Apr 2016 17:38:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 13:38:55 -0400
Received: (qmail 16108 invoked by uid 107); 26 Apr 2016 17:38:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 13:38:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2016 13:38:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604260851390.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292623>

On Tue, Apr 26, 2016 at 05:33:33PM +0200, Johannes Schindelin wrote:

> Testing the headers? I dunno, do we have tests for that already? I thought
> we did not: it requires an HTTP server (so that the headers are actually
> sent) that we can force to check the header...
> 
> So I see we have some tests that use Apache, and one that uses our own
> http-backend. But is there already anything that logs HTTP requests? I did
> not think so, please correct me if I am wrong.

You can ask apache to check for specific headers. Like this:

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 9317ba0..de5a8fe 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -102,6 +102,12 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_HTTP_EXPORT_ALL
 	Header set Set-Cookie name=value
 </LocationMatch>
+<LocationMatch /smart_headers/>
+	Require expr %{HTTP:x-magic-one} == 'abra'
+	Require expr %{HTTP:x-magic-two} == 'cadabra'
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error/ error.sh/
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 58207d8..e44fe72 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -282,5 +282,12 @@ test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
 	test_line_count = 100000 tags
 '
 
+test_expect_success 'custom http headers' '
+	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
+	git -c http.extraheader="x-magic-one: abra" \
+	    -c http.extraheader="x-magic-two: cadabra" \
+	    fetch "$HTTPD_URL/smart_headers/repo.git"
+'
+
 stop_httpd
 test_done
