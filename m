Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBD31F462
	for <e@80x24.org>; Wed, 31 Jul 2019 03:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfGaD1h (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 23:27:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:56390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726440AbfGaD1h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 23:27:37 -0400
Received: (qmail 10834 invoked by uid 109); 31 Jul 2019 03:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 03:27:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13099 invoked by uid 111); 31 Jul 2019 03:29:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 23:29:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 23:27:35 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190731032735.GA14684@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
 <20190731012336.GA13880@sigill.intra.peff.net>
 <20190731015917.GB4545@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731015917.GB4545@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 09:59:17PM -0400, Todd Zullinger wrote:

> At the risk of showing my complete lack of knowledge about
> these tests, I was wondering if the order mattered for the
> other tests in t0011 and t0016.  I had assumed it didn't and
> had something like this for testing (and a similar change to
> test_oidmap() in t0016):
> 
>  diff --git i/t/t0011-hashmap.sh w/t/t0011-hashmap.sh
>  index 9c96b3e3b1..9ed1c4f14d 100755
>  --- i/t/t0011-hashmap.sh
>  +++ w/t/t0011-hashmap.sh
>  @@ -4,8 +4,8 @@ test_description='test hashmap and string hash functions'
>   . ./test-lib.sh
>   
>   test_hashmap() {
>  -	echo "$1" | test-tool hashmap $3 > actual &&
>  -	echo "$2" > expect &&
>  +	echo "$1" | test-tool hashmap $3 | sort >actual &&
>  +	echo "$2" | sort >expect &&
>   	test_cmp expect actual
>   }
> 
> You've got a more comprehensive patch and a proper commit
> message, so this is really just a matter of curiosity.

I think the order does matter for those ones. E.g., the ones that run
"get" want to make sure they're seeing the values in the same order in
which they were requested.

One thing that makes it all a bit funky is that the "put" lines also
output the old value (which is what all those NULLs) are. And I think
that solves my "value3" puzzlement from earlier. It is not part of the
iteration at all, but rather the result of the duplicate "put".

That would perhaps be clearer if the "hashmap" tool actually did the
sorting itself (so we'd sort _just_ the iteration, not the whole
output). Something like this, though I'm on the fence about whether it
is worth it:

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index aaf17b0ddf..9f6901666e 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -2,6 +2,7 @@
 #include "git-compat-util.h"
 #include "hashmap.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 struct test_entry
 {
@@ -221,10 +222,18 @@ int cmd__hashmap(int argc, const char **argv)
 
 		} else if (!strcmp("iterate", cmd)) {
 
+			struct string_list sorted = STRING_LIST_INIT_NODUP;
+			struct string_list_item *item;
 			struct hashmap_iter iter;
 			hashmap_iter_init(&map, &iter);
-			while ((entry = hashmap_iter_next(&iter)))
-				printf("%s %s\n", entry->key, get_value(entry));
+			while ((entry = hashmap_iter_next(&iter))) {
+				item = string_list_append(&sorted, entry->key);
+				item->util = (void *)get_value(entry);
+			}
+			string_list_sort(&sorted);
+			for_each_string_list_item(item, &sorted)
+				printf("%s %s\n", item->string, (const char *)item->util);
+			string_list_clear(&sorted, 0);
 
 		} else if (!strcmp("size", cmd)) {
 
