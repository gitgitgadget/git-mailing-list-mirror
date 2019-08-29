Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647DA1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 22:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfH2WqT (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 18:46:19 -0400
Received: from smtp124.ord1d.emailsrvr.com ([184.106.54.124]:33061 "EHLO
        smtp124.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728272AbfH2WqS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 18:46:18 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 18:46:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1567118302;
        bh=dIvzEvx1AoPh8FTDfDSwmiD4gAAuFOrubryc5M4bD+U=;
        h=From:To:Subject:Date:From;
        b=S9hgj4PUYVpLu8f6wSXXxLqeY6bf5qnDJ+Wst15n32oEvx6nRu1SmX10ocXcRpZA3
         YkURFf9hpj4EylbBfhEG50IfaP2iNhcSY3uY4Fae+63QMtqlVGUSgYKS0agZlI6vkc
         +k/yutBuRR8yhpnTDWF7qOC+v1qFTAiVCZ4jiQ7Q=
X-Auth-ID: jon@jonsimons.org
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 6A409A025C;
        Thu, 29 Aug 2019 18:38:21 -0400 (EDT)
X-Sender-Id: jon@jonsimons.org
Received: from localhost.localdomain (c-73-223-68-105.hsd1.ca.comcast.net [73.223.68.105])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 29 Aug 2019 18:38:22 -0400
From:   Jon Simons <jon@jonsimons.org>
To:     jon@jonsimons.org, git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sunshine@sunshineco.com,
        stolee@gmail.com
Subject: [PATCH v2 2/2] list-objects-filter: handle unresolved sparse filter OID
Date:   Thu, 29 Aug 2019 18:38:11 -0400
Message-Id: <20190829223811.12072-3-jon@jonsimons.org>
X-Mailer: git-send-email 2.23.0.37.g745f681289.dirty
In-Reply-To: <20190829223811.12072-1-jon@jonsimons.org>
References: <20190829223811.12072-1-jon@jonsimons.org>
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
index 0c6f365bf2..495998b7fb 100755
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

