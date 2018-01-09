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
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DAE1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757226AbeAINGJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:06:09 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:37322
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756988AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=LHy6A5+yLlmCXfqkXKi3Gk7egTSV9M0yb+DYG3suqlk=;
        b=Etg+XJobTukHCUTxCsSO/2eifRxBGnxp/xsZsa2w9HXF57xfNIJ8j7AzEBKDslKz
        QSsahynFBbLVf475sX/WYaC/HfBseXtWu2trjRSuuSB2hz6e5r3aJEV3/jKZVq6d0gN
        ZlA0x0Y3TA322YqKE55ZjdUODhsFpsjVEr5VIKWM=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067b66-c22a78cb-5297-426b-9b11-a20a8c27f74e-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 06/20] cat-file: start migrating to ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start moving all formatting stuff from cat-file to ref-filter.
Start from simple moving, it would be integrated into
all ref-filter processes further.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c |  5 ++---
 ref-filter.c       | 42 +++++++++++++++++++++++++++++++++++++-----
 ref-filter.h       |  6 ++++++
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7fd5b960ad698..0a3f4a47bf1ae 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -420,9 +420,8 @@ static int batch_objects(struct batch_options *opt)
 	 * object.
 	 */
 	memset(&data, 0, sizeof(data));
-	data.mark_query = 1;
-	strbuf_expand(&buf, opt->format->format, expand_format, &data);
-	data.mark_query = 0;
+	opt->format->cat_file_data = &data;
+	verify_ref_format(opt->format);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
 
diff --git a/ref-filter.c b/ref-filter.c
index 2d6e81fe1ab00..98bb10185ae96 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -693,6 +693,31 @@ static const char *find_next(const char *cp)
 	return NULL;
 }
 
+static int is_atom(const char *atom, const char *s, int slen)
+{
+	int alen = strlen(atom);
+	return alen == slen && !memcmp(atom, s, alen);
+}
+
+static void expand_atom_into_fields(const char *atom, int len,
+				    struct expand_data *data)
+{
+	if (is_atom("objectname", atom, len))
+		; /* do nothing */
+	else if (is_atom("objecttype", atom, len))
+		data->info.typep = &data->type;
+	else if (is_atom("objectsize", atom, len))
+		data->info.sizep = &data->size;
+	else if (is_atom("objectsize:disk", atom, len))
+		data->info.disk_sizep = &data->disk_size;
+	else if (is_atom("rest", atom, len))
+		data->split_on_whitespace = 1;
+	else if (is_atom("deltabase", atom, len))
+		data->info.delta_base_sha1 = data->delta_base_oid.hash;
+	else
+		die("unknown format element: %.*s", len, atom);
+}
+
 /*
  * Make sure the format string is well formed, and parse out
  * the used atoms.
@@ -709,12 +734,19 @@ int verify_ref_format(struct ref_format *format)
 		if (!ep)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_ref_filter_atom(format, valid_atoms,
-					   ARRAY_SIZE(valid_atoms), sp + 2, ep);
-		cp = ep + 1;
 
-		if (skip_prefix(used_atoms[at].name, "color:", &color))
-			format->need_color_reset_at_eol = !!strcmp(color, "reset");
+		if (format->cat_file_data)
+			expand_atom_into_fields(sp + 2, ep - sp - 2,
+						format->cat_file_data);
+		else
+		{
+			at = parse_ref_filter_atom(format, valid_atoms,
+						   ARRAY_SIZE(valid_atoms), sp + 2, ep);
+			if (skip_prefix(used_atoms[at].name, "color:", &color))
+				format->need_color_reset_at_eol = !!strcmp(color, "reset");
+		}
+
+		cp = ep + 1;
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
 		format->need_color_reset_at_eol = 0;
diff --git a/ref-filter.h b/ref-filter.h
index 16d00e4b1bded..97169548939cd 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -119,6 +119,12 @@ struct ref_format {
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+
+	/*
+	 * Helps to move all formatting logic from cat-file to ref-filter,
+	 * hopefully would be reduced later.
+	 */
+	struct expand_data *cat_file_data;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/450
