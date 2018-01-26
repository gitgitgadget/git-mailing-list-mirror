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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3EA1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeAZToF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:05 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:38308
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752118AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=JnvsAZSP43GHLntJyzc3sDAuBsOqIhKhLmh0kY0IMmI=;
        b=EyCHc9luPF4vtPksKPZlNkyNFb7ufm3Lw/Vq6CL3aZ+mpxctTs9f62Xx2AfU4GZF
        IfJ6YohVQuTQnbEBFzdqKPUuMCtdAD7ih2hDvsxX+plEKLhAaVO5EkJETAze/lY8pNJ
        MvBATAyVs4DtvP+cXu2hA+FAO2m9/agV0T+UN3nw=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b3b-a0ab669e-bc4b-4a25-ac66-5365c56856b1-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 13/24] ref-filter: add is_cat flag
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add is_cat flag, further it helps to get rid of cat_file_data field
in ref_format.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 1 +
 ref-filter.c       | 8 +++++---
 ref-filter.h       | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index c2ca645662ae7..8f34d085962ed 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -394,6 +394,7 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	opt->format.cat_file_data = &data;
+	opt->format.is_cat = 1;
 	verify_ref_format(&opt->format);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 8d10d356609e7..3b61e790e90d1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -101,6 +101,7 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 struct expand_data *cat_file_info;
+static int is_cat = 0;
 
 static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
 {
@@ -493,7 +494,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
-	if (cat_file_info && !strcmp(valid_atom[i].name, "rest"))
+	if (is_cat && !strcmp(valid_atom[i].name, "rest"))
 		cat_file_info->split_on_whitespace = 1;
 	return at;
 }
@@ -739,6 +740,7 @@ int verify_ref_format(struct ref_format *format)
 	const char *cp, *sp;
 
 	cat_file_info = format->cat_file_data;
+	is_cat = format->is_cat;
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		const char *color, *ep = strchr(sp, ')');
@@ -748,7 +750,7 @@ int verify_ref_format(struct ref_format *format)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
 
-		if (format->cat_file_data) {
+		if (is_cat) {
 			at = parse_ref_filter_atom(format, valid_cat_file_atom,
 						   ARRAY_SIZE(valid_cat_file_atom), sp + 2, ep);
 		} else {
@@ -1481,7 +1483,7 @@ int populate_value(struct ref_array_item *ref)
 			ref->symref = "";
 	}
 
-	if (cat_file_info && check_and_fill_for_cat(ref))
+	if (is_cat && check_and_fill_for_cat(ref))
 		return -1;
 
 	/* Fill in specials first */
diff --git a/ref-filter.h b/ref-filter.h
index e41d2913c0fff..c848370bed84a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -126,6 +126,7 @@ struct ref_format {
 	 * hopefully would be reduced later.
 	 */
 	struct expand_data *cat_file_data;
+	int is_cat;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/452
