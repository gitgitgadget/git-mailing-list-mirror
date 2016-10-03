Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988DB207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbcJCVBF (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:01:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51521 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbcJCVBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:01:04 -0400
Received: (qmail 19227 invoked by uid 109); 3 Oct 2016 21:01:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 21:01:03 +0000
Received: (qmail 30226 invoked by uid 111); 3 Oct 2016 21:01:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 17:01:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 17:01:01 -0400
Date:   Mon, 3 Oct 2016 17:01:01 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] http: http.emptyauth should allow empty (not just NULL)
 usernames
Message-ID: <20161003210100.t5nqknwfotag3lmj@sigill.intra.peff.net>
References: <1475515168-29679-1-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1475515168-29679-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 01:19:28PM -0400, David Turner wrote:

> When using kerberos authentication, one URL pattern which is
> allowed is http://@gitserver.example.com.  This leads to a username
> of zero-length, rather than a NULL username.  But the two cases
> should be treated the same by http.emptyauth.
> 
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  http.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/http.c b/http.c
> index 82ed542..bd0dba2 100644
> --- a/http.c
> +++ b/http.c
> @@ -351,7 +351,7 @@ static int http_options(const char *var, const char *value, void *cb)
>  
>  static void init_curl_http_auth(CURL *result)
>  {
> -	if (!http_auth.username) {
> +	if (!http_auth.username || !*http_auth.username) {

Hmm. This fixes this caller, but what about other users of the
credential struct? I wonder if the correct fix is in
credential_from_url(), which should avoid writing an empty
field.

OTOH, I can imagine that "http://user:@example.com" would be a way to
say "I have a username and the password is blank" without getting
prompted.  Which makes me wonder if it is useful to say "my username is
blank" in the same way.

I dunno. The code path you are changing _only_ affects anything
if the http.emptyauth config is set. But I guess I just don't understand
why you would say "http://@gitserver" in the first place. Is that a
common thing?

-Peff
