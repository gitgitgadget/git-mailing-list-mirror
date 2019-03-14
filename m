Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDFF20248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCNAlY (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:41:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:50110 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726412AbfCNAlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:41:23 -0400
Received: (qmail 31702 invoked by uid 109); 14 Mar 2019 00:41:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:41:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17902 invoked by uid 111); 14 Mar 2019 00:40:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:40:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:40:06 -0400
Date:   Wed, 13 Mar 2019 20:40:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] gc: don't run "reflog expire" when keeping reflogs
Message-ID: <20190314004006.GI31968@sigill.intra.peff.net>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
 <20190313235439.30439-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313235439.30439-5-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:54:38AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Don't redundantly run "git reflog expire --all" when gc.reflogExpire
> and gc.reflogExpireUnreachable are set to "never".
> 
> I'm being careful to not repeat the issue fixed in
> 8ab5aa4bd8 ("parseopt: handle malformed --expire arguments more
> nicely", 2018-04-21). We'll die early if the config variables are set
> to invalid values.

I think the general sentiment here makes sense, that reflog expiration
should be a noop if we're set to "never" anyway.

It does feel a little funny for "gc" to be peeking into the internals of
how "reflog" will make its decision about how to run, though. I doubt
those rules are likely to change, but if they did, there'd be very
little to remind somebody working on reflog that they need to change the
matching rules here.

Is our problem running "git reflog" at all, or is it that "git reflog"
does too much work even when it's been told "never"? If the latter,
could we just have it exit early as soon as it's figured out the prune
expiry dates it's using?

I.e., something like:

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4d3430900d..aab221f315 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -594,6 +594,15 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
+	/*
+	 * If we're not expiring anything and not dropping stale entries,
+	 * there's no point in even opening the reflogs, since we're guaranteed
+	 * to do nothing.
+	 */
+	if (!cb.cmd.expire_total && !cb.cmd.expire_unreachable &&
+	    !cb.cmd.stalefix)
+		return 0;
+
 	/*
 	 * We can trust the commits and objects reachable from refs
 	 * even in older repository.  We cannot trust what's reachable

Seeing "--stale-fix" again reminded me: that may be the "oops, we can
spend tons of CPU walking history" bit that I mentioned in the other
part of the thread. But I don't think git-gc would ever run with that
option.

-Peff
