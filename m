Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4584C1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 03:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfGaDxp (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 23:53:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:56416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725970AbfGaDxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 23:53:45 -0400
Received: (qmail 11069 invoked by uid 109); 31 Jul 2019 03:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 03:53:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13167 invoked by uid 111); 31 Jul 2019 03:55:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 23:55:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 23:53:44 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190731035344.GA26019@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
 <20190731012336.GA13880@sigill.intra.peff.net>
 <20190731015917.GB4545@pobox.com>
 <20190731032735.GA14684@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731032735.GA14684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 11:27:35PM -0400, Jeff King wrote:

> That would perhaps be clearer if the "hashmap" tool actually did the
> sorting itself (so we'd sort _just_ the iteration, not the whole
> output). Something like this, though I'm on the fence about whether it
> is worth it:
> [...]

And here it is for reference with the matching change in test-oidmap,
and the adjustments necessary for the test scripts (from master, not
from my earlier patch). I think I prefer the simpler "just sort it all"
version I posted with the commit message.

The post-image in t0016 may be a new low: a command substitution in a DQ
string fed to echo, itself inside a command substitution in a here-doc.
Yuck. :)

---
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
 
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 0acf99931e..5fd059fe90 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -94,10 +94,19 @@ int cmd__oidmap(int argc, const char **argv)
 
 		} else if (!strcmp("iterate", cmd)) {
 
+			struct string_list sorted = STRING_LIST_INIT_DUP;
+			struct string_list_item *item;
 			struct oidmap_iter iter;
 			oidmap_iter_init(&map, &iter);
-			while ((entry = oidmap_iter_next(&iter)))
-				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
+			while ((entry = oidmap_iter_next(&iter))) {
+				item = string_list_append(&sorted,
+							  oid_to_hex(&entry->entry.oid));
+				item->util = entry->name;
+			}
+			string_list_sort(&sorted);
+			for_each_string_list_item(item, &sorted)
+				printf("%s %s\n", item->string, (const char *)item->util);
+			string_list_clear(&sorted, 0);
 
 		} else {
 
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 9c96b3e3b1..1adcd7762d 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -177,9 +177,9 @@ put fooBarFrotz value3
 iterate" "NULL
 NULL
 NULL
-key2 value2
+fooBarFrotz value3
 key1 value1
-fooBarFrotz value3"
+key2 value2"
 
 '
 
@@ -192,8 +192,8 @@ iterate" "NULL
 NULL
 NULL
 fooBarFrotz value3
-key2 value2
-key1 value1" ignorecase
+key1 value1
+key2 value2" ignorecase
 
 '
 
diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index bbe719e950..abeaa64159 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -93,9 +93,14 @@ put three 3
 iterate" "NULL
 NULL
 NULL
-$(git rev-parse two) 2
-$(git rev-parse one) 1
-$(git rev-parse three) 3"
+$(
+	# sort to avoid relying on exact oids
+	{
+		echo "$(git rev-parse one) 1"
+		echo "$(git rev-parse two) 2"
+		echo "$(git rev-parse three) 3"
+	} | sort
+)"
 
 '
 
