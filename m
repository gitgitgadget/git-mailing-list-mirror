Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1CF1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 20:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755461AbcIGUIL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 16:08:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:39599 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932677AbcIGUGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 16:06:45 -0400
Received: (qmail 22108 invoked by uid 109); 7 Sep 2016 20:06:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 20:06:45 +0000
Received: (qmail 7516 invoked by uid 111); 7 Sep 2016 20:06:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 16:06:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 16:06:42 -0400
Date:   Wed, 7 Sep 2016 16:06:42 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Wendler <polynomial-c@gentoo.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Knut Franke <k.franke@science-computing.de>,
        git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>,
        lekto@o2.pl
Subject: Re: segfault in http.c when https URL is mistyped
Message-ID: <20160907200642.5o3otxxt7ybw6x4c@sigill.intra.peff.net>
References: <20160907151607.2b288034@abudhabi.paradoxon.rec>
 <20160907154404.107fe6e6@abudhabi.paradoxon.rec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907154404.107fe6e6@abudhabi.paradoxon.rec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 03:44:04PM +0200, Lars Wendler wrote:

> we at Gentoo got a bug report [1] about git-remote-https segfaulting
> when the URL has been mistyped. 
> This seems to only be triggered when git was compiled with curl
> support:
> 
>   git clone https::/some.example-site.net/test.git

Thanks, this was easy to reproduce. It's a regression in v2.8.0. The fix
is below.

-- >8 --
Subject: [PATCH] remote-curl: handle URLs without protocol

Generally remote-curl would never see a URL that did not
have "proto:" at the beginning, as that is what tells git to
run the "git-remote-proto" helper (and git-remote-http, etc,
are aliases for git-remote-curl).

However, the special syntax "proto::something" will run
git-remote-proto with only "something" as the URL. So a
malformed URL like:

  http::/example.com/repo.git

will feed the URL "/example.com/repo.git" to
git-remote-http. The resulting URL has no protocol, but the
code added by 372370f (http: use credential API to handle
proxy authentication, 2016-01-26) does not handle this case
and segfaults.

For the purposes of this code, we don't really care what the
exact protocol; only whether or not it is https. So let's
just assume that a missing protocol is not, and curl will
handle the real error (which is that the URL is nonsense).

Signed-off-by: Jeff King <peff@peff.net>
---
I looked around for other similar over-assumptions about the URL parsing
but didn't see any.

 http.c                     | 2 +-
 t/t5550-http-fetch-dumb.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index cd40b01..edce47c 100644
--- a/http.c
+++ b/http.c
@@ -723,7 +723,7 @@ static CURL *get_curl_handle(void)
 	 * precedence here, as in CURL.
 	 */
 	if (!curl_http_proxy) {
-		if (!strcmp(http_auth.protocol, "https")) {
+		if (http_auth.protocol && !strcmp(http_auth.protocol, "https")) {
 			var_override(&curl_http_proxy, getenv("HTTPS_PROXY"));
 			var_override(&curl_http_proxy, getenv("https_proxy"));
 		} else {
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 3484b6f..01bb633 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -299,5 +299,13 @@ test_expect_success 'git client does not send an empty Accept-Language' '
 	! grep "^Accept-Language:" stderr
 '
 
+test_expect_success 'remote-http complains cleanly about malformed urls' '
+	# do not actually issue "list" or other commands, as we do not
+	# want to rely on what curl would actually do with such a broken
+	# URL. This is just about making sure we do not segfault during
+	# initialization.
+	test_must_fail git remote-http http::/example.com/repo.git
+'
+
 stop_httpd
 test_done
-- 
2.10.0.rc2.154.gb4a4b8b

