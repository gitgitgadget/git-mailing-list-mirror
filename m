Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D218C1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964994AbeAJJio (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:38:44 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:56990
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755581AbeAJJgm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=f1ACqMcx6EmRZFt9F779T89ItDllll8Tp3tXucG9ehQ=;
        b=I99btD4V0Gq0WO5qiH7ECYXlTA1c5M/9bQ/6E9MYmS+e1qEhrvNhQS0YiUTPZJxa
        fvfWhqInwFQe0YDKz31oaNcqdN4psBGdfFl3kIXa1yBDDya/RSqoMLJBJs2quICcuEc
        ruxBUJ2JzyyEFukx+v+wP7Guf/5Kvz6nPVjcpKLE=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc532-75f3ef78-26cb-4751-9ded-eb0e8d23833b-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 04/18] cat-file: move struct expand_data into ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jan 2018 09:36:41 +0000
X-SES-Outgoing: 2018.01.10-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Need that for further reusing of formatting logic in cat-file.
Have plans to get rid of using expand_data in cat-file at all,
and use it only in ref-filter for collecting, formatting and printing
needed data.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 36 ------------------------------------
 ref-filter.h       | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7655a9a726773..7fd5b960ad698 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -176,42 +176,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	return 0;
 }
 
-struct expand_data {
-	struct object_id oid;
-	enum object_type type;
-	unsigned long size;
-	off_t disk_size;
-	const char *rest;
-	struct object_id delta_base_oid;
-
-	/*
-	 * If mark_query is true, we do not expand anything, but rather
-	 * just mark the object_info with items we wish to query.
-	 */
-	int mark_query;
-
-	/*
-	 * Whether to split the input on whitespace before feeding it to
-	 * get_sha1; this is decided during the mark_query phase based on
-	 * whether we have a %(rest) token in our format.
-	 */
-	int split_on_whitespace;
-
-	/*
-	 * After a mark_query run, this object_info is set up to be
-	 * passed to sha1_object_info_extended. It will point to the data
-	 * elements above, so you can retrieve the response from there.
-	 */
-	struct object_info info;
-
-	/*
-	 * This flag will be true if the requested batch format and options
-	 * don't require us to call sha1_object_info, which can then be
-	 * optimized out.
-	 */
-	unsigned skip_object_info : 1;
-};
-
 static int is_atom(const char *atom, const char *s, int slen)
 {
 	int alen = strlen(atom);
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b34319..16d00e4b1bded 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -72,6 +72,42 @@ struct ref_filter {
 		verbose;
 };
 
+struct expand_data {
+	struct object_id oid;
+	enum object_type type;
+	unsigned long size;
+	off_t disk_size;
+	const char *rest;
+	struct object_id delta_base_oid;
+
+	/*
+	 * If mark_query is true, we do not expand anything, but rather
+	 * just mark the object_info with items we wish to query.
+	 */
+	int mark_query;
+
+	/*
+	 * Whether to split the input on whitespace before feeding it to
+	 * get_sha1; this is decided during the mark_query phase based on
+	 * whether we have a %(rest) token in our format.
+	 */
+	int split_on_whitespace;
+
+	/*
+	 * After a mark_query run, this object_info is set up to be
+	 * passed to sha1_object_info_extended. It will point to the data
+	 * elements above, so you can retrieve the response from there.
+	 */
+	struct object_info info;
+
+	/*
+	 * This flag will be true if the requested batch format and options
+	 * don't require us to call sha1_object_info, which can then be
+	 * optimized out.
+	 */
+	unsigned skip_object_info : 1;
+};
+
 struct ref_format {
 	/*
 	 * Set these to define the format; make sure you call

--
https://github.com/git/git/pull/450
