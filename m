From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] test-url-normalize.c: Fix gcc errors and sparse warnings
Date: Wed, 24 Jul 2013 20:07:55 +0100
Message-ID: <51F0260B.5000905@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: mackyle@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 24 21:10:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V24SC-00035Z-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 21:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab3GXTKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 15:10:24 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:53876 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753045Ab3GXTKX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 15:10:23 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 3C3B2A6498A;
	Wed, 24 Jul 2013 20:10:22 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 80E35A64987;
	Wed, 24 Jul 2013 20:10:21 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Wed, 24 Jul 2013 20:10:20 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231114>


Sparse issues an "non-ANSI function declaration of function 'main'"
warning when NO_CURL is set. In order to suppress the warning, we
simply add the function prototype.

When NO_CURL and USE_CURL_MULTI are not defined, then gcc issues the
following error:

      CC test-url-normalize.o
  test-url-normalize.c: In function `run_http_options':
  test-url-normalize.c:49: error: `max_requests' undeclared (first use in this function)
  test-url-normalize.c:49: error: (Each undeclared identifier is reported only once
  test-url-normalize.c:49: error: for each function it appears in.)
  make: *** [test-url-normalize.o] Error 1

In order to fix the error, we simply protect the use of the 'max_requests'
variable with an preprocessor conditional.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Kyle,

When you next update the patches in your 'km/http-curl-config-per-url'
branch, could you please squash this (or something like it) into the
relevant patches.

Thanks!

ATB,
Ramsay Jones

 test-url-normalize.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/test-url-normalize.c b/test-url-normalize.c
index abfa4eb..86ce553 100644
--- a/test-url-normalize.c
+++ b/test-url-normalize.c
@@ -1,6 +1,6 @@
 #ifdef NO_CURL
 
-int main()
+int main(void)
 {
 	return 125;
 }
@@ -45,8 +45,10 @@ static int run_http_options(const char *file,
 		printf("%s\n", curl_ssl_try ? "true" : "false");
 	else if (!strcmp("minsessions", opt_lc.buf))
 		printf("%d\n", min_curl_sessions);
+#ifdef USE_CURL_MULTI
 	else if (!strcmp("maxrequests", opt_lc.buf))
 		printf("%d\n", max_requests);
+#endif
 	else if (!strcmp("lowspeedlimit", opt_lc.buf))
 		printf("%ld\n", curl_low_speed_limit);
 	else if (!strcmp("lowspeedtime", opt_lc.buf))
-- 
1.8.3
