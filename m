Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5D01F406
	for <e@80x24.org>; Mon,  8 Jan 2018 10:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755053AbeAHK1L (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 05:27:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:37146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751600AbeAHK1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 05:27:10 -0500
Received: (qmail 11534 invoked by uid 109); 8 Jan 2018 10:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 08 Jan 2018 10:27:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27121 invoked by uid 111); 8 Jan 2018 10:27:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 08 Jan 2018 05:27:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jan 2018 05:27:08 -0500
Date:   Mon, 8 Jan 2018 05:27:08 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
Message-ID: <20180108102708.GA19461@sigill.intra.peff.net>
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com>
 <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
 <20180108102029.GA21232@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180108102029.GA21232@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 08, 2018 at 05:20:29AM -0500, Jeff King wrote:

> I.e., what if we did something like this:
> 
> diff --git a/sha1_name.c b/sha1_name.c
> index 611c7d24dd..04c661ba85 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -600,6 +600,15 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
>  	if (len == GIT_SHA1_HEXSZ || !len)
>  		return GIT_SHA1_HEXSZ;
>  
> +	/*
> +	 * A default length of 10 implies a repository big enough that it's
> +	 * getting expensive to double check the ambiguity of each object,
> +	 * and the chance that any particular object of interest has a
> +	 * collision is low.
> +	 */
> +	if (len >= 10)
> +		return len;
> +

Oops, this really needs to terminate the string in addition to returning
the length (so it was always printing 40 characters in most cases). The
correct patch is below, but it performs the same.

diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..5921298a80 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -600,6 +600,17 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
 
+	/*
+	 * A default length of 10 implies a repository big enough that it's
+	 * getting expensive to double check the ambiguity of each object,
+	 * and the chance that any particular object of interest has a
+	 * collision is low.
+	 */
+	if (len >= 10) {
+		hex[len] = 0;
+		return len;
+	}
+
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
