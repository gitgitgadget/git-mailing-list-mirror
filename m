Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13751F461
	for <e@80x24.org>; Thu, 29 Aug 2019 23:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfH2XT4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 19:19:56 -0400
Received: from smtp80.iad3a.emailsrvr.com ([173.203.187.80]:56564 "EHLO
        smtp80.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727956AbfH2XTx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 19:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1567120792;
        bh=XSVBxIn3BMnomE+5Di+yLuDu5jd9CJNjkhGwE1sZ3SA=;
        h=From:To:Subject:Date:From;
        b=q8HcX7mcEK5KCAUOGJNOcQfHw6iKcR7yvZUTCrWyiLHL4b4BmaKjKFBLcA1bjq9Im
         rC/4s6IRiuTc25tQqebjNhbZnm+wUqT+1ULxxls9/ZvaxzAS7M/SEUMiB29hhjH6m1
         dI2TigocB4yHBenWJV9RXybNay0V6VLsaL6HyAiw=
X-Auth-ID: jon@jonsimons.org
Received: by smtp19.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 3FEB550F3;
        Thu, 29 Aug 2019 19:19:52 -0400 (EDT)
X-Sender-Id: jon@jonsimons.org
Received: from localhost.localdomain (c-73-223-68-105.hsd1.ca.comcast.net [73.223.68.105])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 29 Aug 2019 19:19:52 -0400
From:   Jon Simons <jon@jonsimons.org>
To:     jon@jonsimons.org, git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sunshine@sunshineco.com,
        stolee@gmail.com
Subject: [PATCH v3 2/2] list-objects-filter: handle unresolved sparse filter OID
Date:   Thu, 29 Aug 2019 19:19:25 -0400
Message-Id: <20190829231925.15223-3-jon@jonsimons.org>
X-Mailer: git-send-email 2.23.0.37.g745f681289.dirty
In-Reply-To: <20190829231925.15223-1-jon@jonsimons.org>
References: <20190829231925.15223-1-jon@jonsimons.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Handle a potential NULL 'sparse_oid_value' when attempting to load
sparse filter exclusions by blob, to avoid segfaulting later during
'add_excludes_from_blob_to_list'.

While here, uniquify the errors emitted to distinguish between the
case that a given OID is NULL due to an earlier failure to resolve it,
and when an OID resolves but parsing the sparse filter spec fails.

t5616 is updated to demonstrate the change.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 list-objects-filter.c    | 6 +++++-
 t/t5616-partial-clone.sh | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 36e1f774bc..252fae5d4e 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -464,9 +464,13 @@ static void *filter_sparse_oid__init(
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
+	if (!filter_options->sparse_oid_value)
+		die(_("unable to read sparse filter specification from %s"),
+		      filter_options->filter_spec);
 	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
 					   NULL, 0, &d->el) < 0)
-		die("could not load filter specification");
+		die(_("unable to parse sparse filter data in %s"),
+		      oid_to_hex(filter_options->sparse_oid_value));
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 5c68431d10..d01886c464 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -262,6 +262,13 @@ test_expect_success 'partial clone with sparse filter succeeds' '
 	git clone --no-local --no-checkout --filter=sparse:oid=master:odd-files sparse-src pc-odd
 '
 
+test_expect_success 'partial clone with unresolvable sparse filter fails cleanly' '
+	test_must_fail git clone --no-local --no-checkout --filter=sparse:oid=master:sparse-filter sparse-src sc1 2>err &&
+	test_i18ngrep "unable to read sparse filter specification from sparse:oid=master:sparse-filter" err &&
+	test_must_fail git clone --no-local --no-checkout --filter=sparse:oid=master sparse-src sc2 2>err &&
+	test_i18ngrep "unable to parse sparse filter data in $(git -C sparse-src rev-parse master)" err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.23.0.37.g745f681289.dirty

