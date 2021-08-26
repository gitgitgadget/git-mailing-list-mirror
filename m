Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2F3C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 10:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B6B610E9
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 10:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhHZKKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 06:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhHZKKm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 06:10:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAF2C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 03:09:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bt14so5089793ejb.3
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgLWzHLwXQQC2y2bjePQzQv7bB6tdxEyxfKqHQCTsqw=;
        b=fBB6Ox3+sSdv+JL1V5LgtEUvDDaCX4nVaoNq18sEEGHBtYQ+bmOcy4YUCaTeMgeuE3
         nqNI+xeqIjwOKe0O8hpuMa/F1vn9CxWE8NZeLrqK/donO1FP5wX8YkJHv6wmsoI5gdJV
         qlVmP8AKXNJyixvjimHqRE1C8KPwfAEO3SLIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgLWzHLwXQQC2y2bjePQzQv7bB6tdxEyxfKqHQCTsqw=;
        b=gFa1ne23hsU9qZcQnNl1zTe3wWSzCzfHHGkzITPiGj+w7T2wJ/C+2CjaTM7VWKrIHp
         ppoAjtJDOEnws1xZ2r/Ea+FOo6al7+C67C+N/PABm9uGr67zSBlkq0TL8yQRXckXPOzJ
         ijAQfq9UyjBt4pB5FcZzKELRODajk1zEzyekP8bXUemGBfqtEiqteKMb2OSxlTq5X+8s
         EFNdyrSsW/L7ud1K7h48orYPHkUNoqGVUTOQ3F6x+HifkVxT13pQovqQNQOY3/B0PDNp
         EaWXuZG3/NWInuOmzevAdc2zUUFTF1+slq2y/7b+CtmhOM9aTJKhWOXGOPiBM+/fGXvl
         Pj4w==
X-Gm-Message-State: AOAM530Jxoe/YBkBQ4cJCXSn0H6xBLTOr9Euo6QiSG+Pv+F27pO2bpWA
        6Bv92EpLGvclKJPO2bQRC8qSPIrqdixuBg==
X-Google-Smtp-Source: ABdhPJwxtsATqhKZktqXrOR0GQ2W/tCyPrCdJfG0ksfqaJvUTW5a6Z7J1hSqeaKISzmSGihcYh8O0g==
X-Received: by 2002:a17:906:3157:: with SMTP id e23mr3476969eje.29.1629972594257;
        Thu, 26 Aug 2021 03:09:54 -0700 (PDT)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id bt24sm1132649ejb.77.2021.08.26.03.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 03:09:53 -0700 (PDT)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, me@ttaylorr.com, git@vger.kernel.org,
        gitster@pobox.com, ps@pks.im
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 2/2] upload-pack: use stdio in send_ref callbacks
Date:   Thu, 26 Aug 2021 12:06:48 +0200
Message-Id: <20210826100648.10333-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210826100648.10333-1-jacob@gitlab.com>
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
 <20210826100648.10333-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In both protocol v0 and v2, upload-pack writes one pktline packet per
advertised ref to stdout. That means one or two write(2) syscalls per
ref. This is problematic if these writes become network sends with
high overhead.

This commit changes both send_ref callbacks to use buffered IO using
stdio. The default buffer size is usually 4KB, but with musl libc it
is only 1KB. So for consistent results we need to set a buffer size
ourselves. During startup of upload-pack, we set the stdout buffer
size to LARGE_PACKET_MAX, i.e. just shy of 64KB.

To give an example of the impact: I set up a single-threaded loop that
calls ls-remote (with HTTP and protocol v2) on a local GitLab
instance, on a repository with 11K refs. When I switch from Git
v2.32.0 to this patch, I see a 50% reduction in CPU time for Git, and
75% for Gitaly (GitLab's Git RPC service).

So using buffered IO not only saves syscalls in upload-pack, it also
saves time in things that consume upload-pack's output.

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 builtin/upload-pack.c | 10 ++++++++++
 ls-refs.c             |  5 ++++-
 upload-pack.c         | 15 ++++++++++++---
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 6da8fa2607..8033f84124 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -48,6 +48,16 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
 
+	/*
+	 * Increase the stdio buffer size for stdout, for the benefit of ref
+	 * advertisement writes. We are only allowed to call setvbuf(3) "after
+	 * opening a stream and before any other operations have been performed
+	 * on it", so let's call it before we have written anything to stdout.
+	 */
+	if (setvbuf(stdout, xmalloc(LARGE_PACKET_MAX), _IOFBF,
+			LARGE_PACKET_MAX))
+		die_errno("failed to grow stdout buffer");
+
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
 		serve_opts.advertise_capabilities = opts.advertise_refs;
diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d..83f2948fc3 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -105,7 +105,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	}
 
 	strbuf_addch(&refline, '\n');
-	packet_write(1, refline.buf, refline.len);
+	packet_fwrite(stdout, refline.buf, refline.len);
 
 	strbuf_release(&refline);
 	return 0;
@@ -171,6 +171,9 @@ int ls_refs(struct repository *r, struct strvec *keys,
 		strvec_push(&data.prefixes, "");
 	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
 				     send_ref, &data, 0);
+	/* Call fflush because send_ref uses stdio. */
+	if (fflush(stdout))
+		die_errno(_("write failure on standard output"));
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
 	return 0;
diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb4..b592ac6cfb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -58,6 +58,7 @@ enum allow_uor {
  */
 struct upload_pack_data {
 	struct string_list symref;				/* v0 only */
+	struct strbuf send_ref_buf;				/* v0 only */
 	struct object_array want_obj;
 	struct object_array have_obj;
 	struct oid_array haves;					/* v2 only */
@@ -126,6 +127,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
 	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
+	struct strbuf send_ref_buf = STRBUF_INIT;
 
 	memset(data, 0, sizeof(*data));
 	data->symref = symref;
@@ -141,6 +143,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->allow_filter_fallback = 1;
 	data->tree_filter_max_depth = ULONG_MAX;
 	packet_writer_init(&data->writer, 1);
+	data->send_ref_buf = send_ref_buf;
 
 	data->keepalive = 5;
 	data->advertise_sid = 0;
@@ -158,6 +161,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 	string_list_clear(&data->allowed_filters, 0);
+	strbuf_release(&data->send_ref_buf);
 
 	free((char *)data->pack_objects_hook);
 }
@@ -1201,13 +1205,14 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	if (mark_our_ref(refname_nons, refname, oid))
 		return 0;
 
+	strbuf_reset(&data->send_ref_buf);
 	if (capabilities) {
 		struct strbuf symref_info = STRBUF_INIT;
 		struct strbuf session_id = STRBUF_INIT;
 
 		format_symref_info(&symref_info, &data->symref);
 		format_session_id(&session_id, data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
+		packet_buf_write(&data->send_ref_buf, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
@@ -1223,11 +1228,12 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		strbuf_release(&symref_info);
 		strbuf_release(&session_id);
 	} else {
-		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_buf_write(&data->send_ref_buf, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
 	if (!peel_iterated_oid(oid, &peeled))
-		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+		packet_buf_write(&data->send_ref_buf, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+	fwrite_or_die(stdout, data->send_ref_buf.buf, data->send_ref_buf.len);
 	return 0;
 }
 
@@ -1348,6 +1354,9 @@ void upload_pack(struct upload_pack_options *options)
 		reset_timeout(data.timeout);
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
+		/* Call fflush because send_ref uses stdio. */
+		if (fflush(stdout))
+			die_errno(_("write failure on standard output"));
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-- 
2.32.0

