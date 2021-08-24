Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A43C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAD56125F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhHXOER (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbhHXOEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 10:04:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E1C0613D9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 07:03:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id e21so28687056ejz.12
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOV8/WzEzTszNwRDQvfxP8dMQDutsUcCswXHCd7Zh1Q=;
        b=Gy8g+8fJ+cQVKevFUPkJuqH/AJwIh6Jl9lDgPiAXaRt2+DM2XdZWGvqXBBjJYXckjj
         30Xkq/2aLZnkEZwGaMu17JIcSCM4lY87pMxYQ+K8C5VDtdn4tsAWojPJ0NaCfjZl3f56
         1GbHuoQtTYy7YDFK1lCRvIS6cdGK5BcJi+n6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOV8/WzEzTszNwRDQvfxP8dMQDutsUcCswXHCd7Zh1Q=;
        b=I/dwX98nAUlrDmsfW7SZZIW/GzzVDqdDOeSUM+va3Icz83fGTOTks6602M3tS+zCJz
         6SxNKjkey+ZkaFDV80N60dNLo8n6cz7QW5xAetKe+v3LKprr2mLjCI2ga1t2igT5lvB0
         M0odRWWjT2PjoLH1rDPGirIBndvZgn8Gj43RGG7yRTn9MtdvKjsyh8zAgGYyjRHJK3nt
         SSQsbzIY9jy7Q/AZtoXrsN56CjaowGlDKXR/cmTRWKinRswUPg9kw6pajZ/aB2BdXA2g
         lobHKwNnKNLBQ83lO5wXRaM11iTIetru1kpH+/z/73yXAyl/Tz931SOtx2BDf2Bty3xa
         N/gA==
X-Gm-Message-State: AOAM5303kdIHm0Tu8+sms8uQIT4ld2mYBGfdzrowovdF9Bci+k6fzAaQ
        BxRcbKeaC0TmI0BFESXBGN18RP1VytUXBQ==
X-Google-Smtp-Source: ABdhPJwuJPHkewjqs9MJhTGr24itoeKVotouANmejQiaBdOKqt3Pubca71GJAWu6gl8juKfgBs41Dg==
X-Received: by 2002:a17:906:24c1:: with SMTP id f1mr40587083ejb.314.1629813804115;
        Tue, 24 Aug 2021 07:03:24 -0700 (PDT)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id ca4sm9341400ejb.1.2021.08.24.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:03:23 -0700 (PDT)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 1/1] upload-pack: buffer ref advertisement writes
Date:   Tue, 24 Aug 2021 16:02:59 +0200
Message-Id: <20210824140259.89332-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In both protocol v0 and v2, upload-pack writes one pktline packet per
advertised ref to stdout. That means one or two write(2) syscalls per
ref. This is problematic if these writes become network sends with
high overhead.

This change adds a strbuf buffer to the send_ref callbacks of the v0
ref advertisement and v2's ls-refs. Instead of writing directly to
stdout, send_ref now writes into the buffer, and then checks if there
are more than 32768 bytes in the buffer. If so we flush the buffer to
stdout.

To give an example: I set up a single-threaded loop that calls
ls-remote (with HTTP and protocol v2) on a local GitLab instance, on a
repository with 11K refs. When I switch from Git v2.32.0 to this
patch, I see a 50% reduction in CPU time for Git, and 75% for Gitaly
(GitLab's Git RPC service).

So having these buffers not only saves syscalls in upload-pack, it
also saves time in things that consume upload-pack's output.
---
 ls-refs.c     | 13 ++++++++++++-
 upload-pack.c | 18 +++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d..7b9d5813bf 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -7,6 +7,8 @@
 #include "pkt-line.h"
 #include "config.h"
 
+#define OUT_WRITE_SIZE 32768
+
 static int config_read;
 static int advertise_unborn;
 static int allow_unborn;
@@ -65,6 +67,7 @@ struct ls_refs_data {
 	unsigned peel;
 	unsigned symrefs;
 	struct strvec prefixes;
+	struct strbuf out;
 	unsigned unborn : 1;
 };
 
@@ -105,7 +108,12 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	}
 
 	strbuf_addch(&refline, '\n');
-	packet_write(1, refline.buf, refline.len);
+
+	packet_buf_write_len(&data->out, refline.buf, refline.len);
+	if (data->out.len >= OUT_WRITE_SIZE) {
+		write_or_die(1, data->out.buf, data->out.len);
+		strbuf_reset(&data->out);
+	}
 
 	strbuf_release(&refline);
 	return 0;
@@ -145,6 +153,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 
 	memset(&data, 0, sizeof(data));
 	strvec_init(&data.prefixes);
+	strbuf_init(&data.out, OUT_WRITE_SIZE);
 
 	ensure_config_read();
 	git_config(ls_refs_config, NULL);
@@ -171,7 +180,9 @@ int ls_refs(struct repository *r, struct strvec *keys,
 		strvec_push(&data.prefixes, "");
 	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
 				     send_ref, &data, 0);
+	write_or_die(1, data.out.buf, data.out.len);
 	packet_flush(1);
+	strbuf_release(&data.out);
 	strvec_clear(&data.prefixes);
 	return 0;
 }
diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb4..15f9aab4f6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -42,6 +42,8 @@
 #define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
 		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
 
+#define SEND_REF_OUT_WRITE_SIZE 32768
+
 /* Enum for allowed unadvertised object request (UOR) */
 enum allow_uor {
 	/* Allow specifying sha1 if it is a ref tip. */
@@ -58,6 +60,7 @@ enum allow_uor {
  */
 struct upload_pack_data {
 	struct string_list symref;				/* v0 only */
+	struct strbuf send_ref_out;				/* v0 only */
 	struct object_array want_obj;
 	struct object_array have_obj;
 	struct oid_array haves;					/* v2 only */
@@ -126,6 +129,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
 	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
+	struct strbuf send_ref_out = STRBUF_INIT;
 
 	memset(data, 0, sizeof(*data));
 	data->symref = symref;
@@ -141,6 +145,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->allow_filter_fallback = 1;
 	data->tree_filter_max_depth = ULONG_MAX;
 	packet_writer_init(&data->writer, 1);
+	data->send_ref_out = send_ref_out;
 
 	data->keepalive = 5;
 	data->advertise_sid = 0;
@@ -158,6 +163,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 	string_list_clear(&data->allowed_filters, 0);
+	strbuf_release(&data->send_ref_out);
 
 	free((char *)data->pack_objects_hook);
 }
@@ -1207,7 +1213,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 		format_symref_info(&symref_info, &data->symref);
 		format_session_id(&session_id, data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
+		packet_buf_write(&data->send_ref_out, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
@@ -1223,11 +1229,15 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		strbuf_release(&symref_info);
 		strbuf_release(&session_id);
 	} else {
-		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_buf_write(&data->send_ref_out, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
 	if (!peel_iterated_oid(oid, &peeled))
-		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+		packet_buf_write(&data->send_ref_out, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+	if (data->send_ref_out.len >= SEND_REF_OUT_WRITE_SIZE) {
+		write_or_die(1, data->send_ref_out.buf, data->send_ref_out.len);
+		strbuf_reset(&data->send_ref_out);
+	}
 	return 0;
 }
 
@@ -1346,8 +1356,10 @@ void upload_pack(struct upload_pack_options *options)
 
 	if (options->advertise_refs || !data.stateless_rpc) {
 		reset_timeout(data.timeout);
+		strbuf_grow(&data.send_ref_out, SEND_REF_OUT_WRITE_SIZE);
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
+		write_or_die(1, data.send_ref_out.buf, data.send_ref_out.len);
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-- 
2.32.0

