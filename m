Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CA3208E9
	for <e@80x24.org>; Thu, 19 Jul 2018 17:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbeGSSII (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 14:08:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:52842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731663AbeGSSII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 14:08:08 -0400
Received: (qmail 1848 invoked by uid 109); 19 Jul 2018 17:24:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 17:24:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13009 invoked by uid 111); 19 Jul 2018 17:24:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 13:24:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 13:23:58 -0400
Date:   Thu, 19 Jul 2018 13:23:58 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180719172358.GD4868@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home>
 <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 09:42:00AM -0700, Elijah Newren wrote:

> Thanks for the quick turnaround.  Unfortunately, I have some bad news.
> With this patch, I get the following:
> 
> $ /usr/bin/time -f 'MaxRSS:%M Time:%e' git gc --aggressive
> Enumerating objects: 4460703, done.
> Counting objects: 100% (4460703/4460703), done.
> Delta compression using up to 40 threads.
> Compressing objects: 100% (3807140/3807140), done.
> Writing objects: 100% (4460703/4460703), done.
> Total 4460703 (delta 2831383), reused 1587071 (delta 0)
> error: failed to unpack compressed delta at offset 183854150 from
> .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack
> fatal: packed object 20ce811e53dabbb8ef9368c108cbbdfa65639c03 (stored
> in .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack)
> is corrupt
> error: failed to run prune
> MaxRSS:40025196 Time:2531.52

Looking at that output, my _guess_ is that we somehow end up with a
bogus delta_size value and write out a truncated entry. But I couldn't
reproduce the issue with smaller test cases.

Maybe instrumenting Git with the patch below and running:

  GIT_TRACE_DELTA=$PWD/delta.out git gc --aggressive
  perl -lne '
	/(get|put) ([0-9a-f]{40}) (\d+)/ or next;
	if ($1 eq "put") {
		$h{$2} and print "double put: $2 = ($h{$2}, $3)";
		$h{$2} = $3;
	} else {
		$h{$2} == $3 or print "mismatched get: $2 = ($h{$2}, $3)"
	}
  ' <delta.out

would show some anomalies in the get/set sizes?

---
diff --git a/pack-objects.h b/pack-objects.h
index 978500e474..77a6aae62b 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -327,7 +327,9 @@ static inline void oe_set_size(struct packing_data *pack,
 	}
 }
 
-static inline unsigned long oe_delta_size(struct packing_data *pack,
+static struct trace_key trace_delta = TRACE_KEY_INIT(DELTA);
+
+static inline unsigned long oe_delta_size_1(struct packing_data *pack,
 					  const struct object_entry *e)
 {
 	if (!pack->delta_size)
@@ -335,11 +337,23 @@ static inline unsigned long oe_delta_size(struct packing_data *pack,
 	return pack->delta_size[e - pack->objects];
 }
 
+static inline unsigned long oe_delta_size(struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	unsigned long ret = oe_delta_size_1(pack, e);
+	trace_printf_key(&trace_delta, "get %s %lu",
+			 oid_to_hex(&e->idx.oid), ret);
+	return ret;
+}
+
 void oe_prepare_delta_size_array(struct packing_data *pack);
 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
 				     unsigned long size)
 {
+	trace_printf_key(&trace_delta, "put %s %lu",
+			 oid_to_hex(&e->idx.oid), size);
+
 	e->delta_size_ = size;
 	if (!pack->delta_size && e->delta_size_ == size)
 		return;
