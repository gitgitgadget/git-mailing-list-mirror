Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11106208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeHFQIL (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:08:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:43752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727582AbeHFQIL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:08:11 -0400
Received: (qmail 9615 invoked by uid 109); 6 Aug 2018 13:58:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 13:58:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25451 invoked by uid 111); 6 Aug 2018 13:58:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 09:58:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 09:58:55 -0400
Date:   Mon, 6 Aug 2018 09:58:55 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
Message-ID: <20180806135855.GC31282@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org>
 <xmqqk1pkzhuo.fsf@gitster-ct.c.googlers.com>
 <xmqqfu08zhh7.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD2Ri6N33UhZSHOvxtxiCBC13-1rpa_ZByY9dsyPjmaC8A@mail.gmail.com>
 <CAP8UFD3uruf94d7eV9Fy25h19y_KV8uZeaZN71F_xFM2XrspWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3uruf94d7eV9Fy25h19y_KV8uZeaZN71F_xFM2XrspWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 10:44:14AM +0200, Christian Couder wrote:

> Taking a look at how we use regexec() in our code base, it looks like
> it might be better to use regexec_buf() defined in
> "git-compat-util.h".
> 
> I am not completely sure about that because apply.c has:
> 
>     status = regexec(stamp, timestamp, ARRAY_SIZE(m), m, 0);
>     if (status) {
>         if (status != REG_NOMATCH)
>             warning(_("regexec returned %d for input: %s"),
>                 status, timestamp);
>         return 0;
>     }
> 
> Though the above uses a regex that is defined in apply.c. The regex
> doesn't come from the config file.
> 
> Actually except the above there is a mix of regexec() and
> regexec_buf() in our code base, which are used with only 0, 1 or 2
> capture groups, so it is not very clear what should be used.

I don't think we need regexec_buf(). The advantage it has is that it can
operate on strings that aren't NUL-terminated, but that isn't the case
here.

> And anyway I still don't see how we could diagnose when the end user
> input requires more captures than we support.

We can use the final element as a sentinel, and complain if it gets
filled in:

diff --git a/delta-islands.c b/delta-islands.c
index dcc6590cc1..18426ffb18 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -375,6 +375,10 @@ static int find_island_for_ref(const char *refname, const struct object_id *oid,
 	if (i < 0)
 		return 0;
 
+	if (matches[ARRAY_SIZE(matches)-1].rm_so != -1)
+		die("island regex had too many matches (max=%d)",
+		    (int)ARRAY_SIZE(matches) - 2);
+
 	for (m = 1; m < ARRAY_SIZE(matches); m++) {
 		regmatch_t *match = &matches[m];
 

The big downside is that it only kicks in when you actually successfully
make a match. So you could have:

  [pack]
  island = refs/(one)/(two)/(three)/(four)/(five)/(six)/(seven)

in your config for years, and then one day it blows up when somebody
actually has a ref that matches it.

I think it would be fine to just say "we only respect the first N
capture groups". And maybe even issue a warning (based on the detection
above). I'd also be fine with bumping the "matches" array to something
more ridiculous, like 32. The current value of 8 was supposed to be
ridiculous already (we've never used more than 2).

-Peff
