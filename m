Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108001F461
	for <e@80x24.org>; Thu,  5 Sep 2019 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbfIESDu (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 14:03:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:40772 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390989AbfIESDu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 14:03:50 -0400
Received: (qmail 1562 invoked by uid 109); 5 Sep 2019 18:03:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 18:03:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29691 invoked by uid 111); 5 Sep 2019 18:05:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 14:05:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 14:03:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>, Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
Message-ID: <20190905180348.GC23663@sigill.intra.peff.net>
References: <20190905082459.26816-1-s-beyer@gmx.net>
 <xmqqd0ger5j7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0ger5j7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 10:56:12AM -0700, Junio C Hamano wrote:

> Stephan Beyer <s-beyer@gmx.net> writes:
> 
> > diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> > index 7e79b555de..ef0963e2f4 100644
> > --- a/t/helper/test-read-cache.c
> > +++ b/t/helper/test-read-cache.c
> > @@ -4,7 +4,7 @@
> >
> >  int cmd__read_cache(int argc, const char **argv)
> >  {
> > -	int i, cnt = 1, namelen;
> > +	int i, cnt = 1, namelen = 0;
> >  	const char *name = NULL;
> >
> >  	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
> 		namelen = strlen(name);
> 
> The above is the only assignment to namelen in this function, and
> namelen is used like so:
> 
> 		if (name) {
> 			...
> 			pos = index_name_pos(&the_index, name, namelen);
> 
> So somebody does not realize that skip_prefix() returns true only
> when it touches name.  But skip_prefix() is inline and visible to
> the compiler, and it is quite clear that name is only touched when 
> the function returns non-zero.

I said earlier that I wouldn't mind seeing "namelen = 0" here. But I
think there is a much more direct solution: keeping the assignment and
point of use closer together. That makes it more clear both to the
compiler and to a human when we expect the variable to be valid. In
fact, since it's only used once, we can drop the variable altogther. :)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 7e79b555de..244977a29b 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -4,11 +4,10 @@
 
 int cmd__read_cache(int argc, const char **argv)
 {
-	int i, cnt = 1, namelen;
+	int i, cnt = 1;
 	const char *name = NULL;
 
 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
-		namelen = strlen(name);
 		argc--;
 		argv++;
 	}
@@ -24,7 +23,7 @@ int cmd__read_cache(int argc, const char **argv)
 
 			refresh_index(&the_index, REFRESH_QUIET,
 				      NULL, NULL, NULL);
-			pos = index_name_pos(&the_index, name, namelen);
+			pos = index_name_pos(&the_index, name, strlen(name));
 			if (pos < 0)
 				die("%s not in index", name);
 			printf("%s is%s up to date\n", name,
