Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CDD1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 16:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933145AbcLNQk5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 11:40:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:56473 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbcLNQk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 11:40:56 -0500
Received: (qmail 6930 invoked by uid 109); 14 Dec 2016 16:40:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 16:40:53 +0000
Received: (qmail 26204 invoked by uid 111); 14 Dec 2016 16:41:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 11:41:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 11:40:50 -0500
Date:   Wed, 14 Dec 2016 11:40:50 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 5/5] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161214164050.uxk434kzhw6au4c2@sigill.intra.peff.net>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-6-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481679637-133137-6-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 05:40:37PM -0800, Brandon Williams wrote:

> Add the from_user parameter to the 'is_transport_allowed' function.
> This allows callers to query if a transport protocol is allowed, given
> that the caller knows that the protocol is coming from the user (1) or
> not from the user (0) such as redirects in libcurl.  If unknown a -1
> should be provided which falls back to reading `GIT_PROTOCOL_FROM_USER`
> to determine if the protocol came from the user.

I think your commit message is upside-down with respect to the purpose
of the patch. The end goal we want is for http to distinguish between
protocol restrictions for redirects versus initial requests. The rest is
an implementation detail. It's definitely still worth discussing that
implementation detail (though I think your in-code comments may be
sufficient), but I don't see the rationale discussed here at all.

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  http.c      | 14 +++++++-------
>  transport.c |  8 +++++---
>  transport.h | 13 ++++++++++---
>  3 files changed, 22 insertions(+), 13 deletions(-)

I'm trying to think of a way to test this. I guess the case we are
covering here is when a server redirects, but the protocol is only
allowed from the user. So:

diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index 044cc152f..d911afd24 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -30,5 +30,12 @@ test_expect_success 'curl limits redirects' '
 	test_must_fail git clone "$HTTPD_URL/loop-redir/smart/repo.git"
 '
 
+test_expect_success 'http can be limited to from-user' '
+	git -c protocol.http.allow=user \
+		clone "$HTTPD_URL/smart/repo.git" plain.git &&
+	test_must_fail git -c protocol.http.allow=user \
+		clone "$HTTPD_URL/smart-redir-perm/repo.git" redir.git
+'
+
 stop_httpd
 test_done

It's an oddball configuration, and you'd probably just set
http.followRedirects=false in practice, but it does correctly check this
case.

> @@ -588,9 +588,9 @@ static CURL *get_curl_handle(void)
>  #endif
>  #if LIBCURL_VERSION_NUM >= 0x071304
>  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> -			 get_curl_allowed_protocols());
> +			 get_curl_allowed_protocols(0));
>  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> -			 get_curl_allowed_protocols());
> +			 get_curl_allowed_protocols(-1));

This covers internal redirects done by libcurl, but not the dumb-walker
http-alternates nonsense. We have to feed the URL from http-alternates
back to curl ourselves, so it uses CURLOPT_PROTOCOLS even though it
should count as "not from the user".

To fix that, I think we'd need something like:

  - get_curl_handle() stops setting these options, as it is done only
    once when the curl handle is initialized. Instead, the protocol
    restrictions should go into get_active_slot(), which is called for
    each request.  The values set would remain the same, and be the
    baseline.

  - the http-walker.c code would need to know when it's requesting from
    the base URL, and when it's an alternate. I think this would depend
    on the position of the "alt" in in the linked list it keeps.

  - when requesting from an alternate, http-walker would set
    CURLOPT_PROTOCOLS with get_curl_allowed_protocols(0)

I have to admit that it sounds like a fair bit of work for a pretty
obscure case. You'd have to:

  1. Turn http.allowRedirects to "true", to allow redirects even for
     non-initial contact.

  2. Turn one of protocol.{http,https,ftp,ftps}.allow to "user" to
     restrict it from being used in a redirect.

I'm tempted to punt on it and just do:

  if (http_follow_config == HTTP_FOLLOW_ALWAYS &&
      get_curl_allowed_protocols(0) != get_curl_allowed_protocols(-1))
	die("user-only protocol restrictions not implemented for http-alternates");

which errs on the safe side. We could even shove that down into the case
where we actually see some alternates, like:

diff --git a/http-walker.c b/http-walker.c
index c2f81cd6a..5bcc850b1 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -160,6 +160,12 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 #endif
 }
 
+static void check_alternates_protocol_restrictions(void)
+{
+	if (get_curl_allowed_protocols(0) != get_curl_allowed_protocol(-1))
+		die("user-only protocol restrictions not implemented for http alternates");
+}
+
 static void process_alternates_response(void *callback_data)
 {
 	struct alternates_request *alt_req =
@@ -272,6 +278,7 @@ static void process_alternates_response(void *callback_data)
 			/* skip "objects\n" at end */
 			if (okay) {
 				struct strbuf target = STRBUF_INIT;
+				check_alternates_protocol_restrictions();
 				strbuf_add(&target, base, serverlen);
 				strbuf_add(&target, data + i, posn - i - 7);
 				warning("adding alternate object store: %s",

I find it unlikely that anybody would ever care, but at least we'd do
the safe thing. I dunno. Maybe I am just being lazy.

-Peff
