Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DAAA201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 21:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932780AbdBVVeP (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 16:34:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:60198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932293AbdBVVeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:34:14 -0500
Received: (qmail 25851 invoked by uid 109); 22 Feb 2017 21:34:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 21:34:12 +0000
Received: (qmail 29517 invoked by uid 111); 22 Feb 2017 21:34:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 16:34:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 16:34:10 -0500
Date:   Wed, 22 Feb 2017 16:34:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170222213410.iak43asq775tzr42@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
 <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 01:16:33PM -0800, Junio C Hamano wrote:

> David Turner <David.Turner@twosigma.com> writes:
> 
> > Always, no.  For failed authentication (or authorization), apparently, yes.  
> > I tested this by  setting the variable to false and then true, and trying to 
> > Push to a github repository which I didn't have write access to, with 
> > both an empty username (https://@:github.com/...) and no username 
> > (http://github.com/...).   I ran this under GIT_CURL_VERBOSE=1 and
> > I saw two 401 responses in the "http.emptyauth=true" case and one
> > in the false case.  I also tried with a repo that I did have access to (first
> > configuring the necessary tokens for HTTPS push access), and saw two
> > 401 responses in *both* cases.  
> 
> Thanks; that matches my observation.  I do not think we care about
> an extra roundtrip for the failure case, but as long as we do not
> increase the number of roundtrip in the normal case, we can declare
> that this is an improvement.  I am not quite sure where that extra
> 401 comes from in the normal case, and that might be an indication
> that we already are doing something wrong, though.

This patch drops the useless probe request:

diff --git a/http.c b/http.c
index 943e630ea..7b4c2db86 100644
--- a/http.c
+++ b/http.c
@@ -1663,6 +1663,9 @@ static int http_request(const char *url,
 		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
 				options->effective_url);
 
+	if (results.auth_avail == CURLAUTH_BASIC)
+		http_auth_methods = CURLAUTH_BASIC;
+
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 

but setting http.emptyauth adds back in the useless request. I think
that could be fixed by skipping the empty-auth thing when
http_auth_methods does not have CURLAUTH_NEGOTIATE in it (or perhaps
other methods need it to, so maybe skip it if _just_ BASIC is set).

I suspect the patch above could probably be generalized as:

  /* cut out methods we know the server doesn't support */
  http_auth_methods &= results.auth_avail;

and let curl figure it out from there.

-Peff
