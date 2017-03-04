Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87A552013E
	for <e@80x24.org>; Sat,  4 Mar 2017 08:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbdCDIhP (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 03:37:15 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51030 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdCDIhO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 03:37:14 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 397BA2013E;
        Sat,  4 Mar 2017 08:36:46 +0000 (UTC)
Date:   Sat, 4 Mar 2017 08:36:45 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jann Horn <jannh@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v2] http: inform about alternates-as-redirects behavior
Message-ID: <20170304083645.GA24694@whir>
References: <20170304013504.GA27183@untitled>
 <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
 <20170304065548.GA20734@whir>
 <20170304074140.mzgs27jp2jer4mlv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170304074140.mzgs27jp2jer4mlv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Sat, Mar 04, 2017 at 06:55:48AM +0000, Eric Wong wrote:
> > Jeff King <peff@peff.net> wrote:
> > > The warning itself:
> > > 
> > > > +		warning("alternate disabled by http.followRedirects!=true: %s",
> > > 
> > > feels like it could use some whitespace around the "!=", but maybe
> > > that's just me.
> > 
> > Yeah, I kinda wanted to emulate the command-line syntax.
> > 
> > Maybe rewording it a bit and showing how to enable it will
> > make more sense:
> > 
> > 		warning("alternate: %s", url);
> > 		warning(" may be enabled by -c http.followRedirects=true");
> 
> I kind of hoped people would look at the documentation for
> followRedirects before blindly enabling it. Though I guess the
> documentation doesn't really explain the possible security implications,
> so maybe it doesn't matter (and they're pretty subtle anyway).

You bring up a good point, perhaps just mentioning the config
key is enough to convince somebody to (v2 below).


I also think the security implications for relative alternates
on the same host would not matter, since the smart HTTP will
take them into account on the server side.

Perhaps we give http_follow_config ORable flags:

	HTTP_FOLLOW_NONE = 0,
	HTTP_FOLLOW_INITIAL = 0x1,
	HTTP_FOLLOW_RELATIVE = 0x2,
	HTTP_FOLLOW_ABSOLUTE = 0x4,
	HTTP_FOLLOW_ALWAYS = 0x7,

With the default would being: HTTP_FOLLOW_INITIAL|HTTP_FOLLOW_RELATIVE
(but I suppose that's a patch for another time)

----------8<-----------
From: Eric Wong <e@80x24.org>
Subject: [PATCH] http: inform about alternates-as-redirects behavior

It is disconcerting for users to not notice the behavior
change in handling alternates from commit cb4d2d35c4622ec2
("http: treat http-alternates like redirects")

Give the user a hint about the config option so they can
see the URL and decide whether or not they want to enable
http.followRedirects in their config.

Signed-off-by: Eric Wong <e@80x24.org>
---
 http-walker.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index b34b6ace7..6396cebe5 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -168,6 +168,11 @@ static int is_alternate_allowed(const char *url)
 	};
 	int i;
 
+	if (http_follow_config != HTTP_FOLLOW_ALWAYS) {
+		warning("alternate disabled by http.followRedirects: %s", url);
+		return 0;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(protocols); i++) {
 		const char *end;
 		if (skip_prefix(url, protocols[i], &end) &&
@@ -331,9 +336,6 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	struct alternates_request alt_req;
 	struct walker_data *cdata = walker->data;
 
-	if (http_follow_config != HTTP_FOLLOW_ALWAYS)
-		return;
-
 	/*
 	 * If another request has already started fetching alternates,
 	 * wait for them to arrive and return to processing this request's
-- 
EW
