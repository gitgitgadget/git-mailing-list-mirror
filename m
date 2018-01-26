Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F111F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeAZTof (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:35 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:37174
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751496AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=eLLZ3XfjFyG8/CVjkk8VgCdiY/+qraR7kuKu3D+g8BU=;
        b=C4ERpnyX3A2hrJ/DBmLJTYJGbguPu+cS5UOYgIJa1jHR4mzSu+fxxZriWeYQlma1
        3AbD5ERprUA5AEnmsxtIrGG4IsWLkC7EH0RxeScn7L7m2eMg96cSCWvtxttUwzzhYme
        sD7vyj2BrgcED4OJ8+PJPOpm27inAxOxoB1Nxo5Q=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b0c-042864ef-1f19-4991-a240-7358c56daec9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 06/24] cat-file: move struct expand_data into ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.18
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
index 65c300184cab8..490d9f8a8a922 100644
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
index ff416b733b4b1..56093a85d52b8 100644
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
https://github.com/git/git/pull/452
