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
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB3F1F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeBEL1o (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:27:44 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:41050
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752312AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=vdRkP85+55EXyoELa3FWM4PObi25dlDZUy6iKsYVKwY=;
        b=Fd0Bz1wG0Ym2AyqvUvUJcTOonyJx2mweYtq2bqB2N1i5x35Ws85gPbHrL/AnVizq
        WZ6NERzz4NvyDxlSUJexxqFtnC9jUcL36b+1Iq2kYdF1F1f/cokAVeBsaS/+CpckPy/
        gALMCjCHnRXdrmOd14CIuvi0u8Vd2SQmqD004h4k=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b426-befe124b-fbe7-4b83-b7e0-c340b4f6dd57-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 05/25] cat-file: move struct expand_data into
 ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.18
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
index 98fc5ec069a49..37d6096d201b5 100644
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
index b75c8ac45248e..17f2ac24d2739 100644
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
