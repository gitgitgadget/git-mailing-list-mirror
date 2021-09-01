Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C4C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A7960FED
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbhIANHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346576AbhIANHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:07:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF0BC061764
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 05:55:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bt14so6468924ejb.3
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bY1Wp4oNwBRZhj4THnTnAs92eRU8Aba+EnS1qIF6CDI=;
        b=V1tulQFVpbH0NPgkrLJu5ihTDZFkblAzb+EWYb718ZcjEf/YKZ4Cqnyl49qcYrM1iR
         0wkVltuE42Ta/qhik1Q+qeevxJZs4B5QHyaCPfuAZY4U/wg3yprK2MMF5d+sVNzgBfxa
         ak2ctminp3jS2ItamZ1wrryOJqp0PLe4DWre4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bY1Wp4oNwBRZhj4THnTnAs92eRU8Aba+EnS1qIF6CDI=;
        b=GWnESGPXiIA6EUb7LgLNqpbzy58mq5iIkj44lcr1b/5wHetpGqVaardmCxdx3A9E4e
         W7iMwIMtiYpCgZa4uwbVE1ioZ7Xxd/34rzP+6fKxPy8mZnd453utoBPj+GVXeCf5YRdp
         KLk+U5s7pi2vJAqiraby7030r2boAQ7mpSvfGDLm3bO/CuVrqUyRdJeaMdFn9Vn9+whz
         cKhvPM4u3F7e/W1UcjI4hHrEqL683lwh608wYAoKxPebH9BBrtUCcdEyqHuZ4GPtr5VY
         9DkChQFpx4YLfPbDXPbt9HZlvKfZdyWNcqR6Cw3qpBPT52U/bdOFAcFkyVr43NEez1SW
         pIxw==
X-Gm-Message-State: AOAM531zkskjKbxta+RI50EuG17Mlmp5iOWH7hMxHVR/QjtOV/PGjobt
        rKksBXa7wH++q8D8F0mK6UDgOA==
X-Google-Smtp-Source: ABdhPJy3XF4l61ia7CoBHjLoWnjtm4OUu0gJXT3mGSIbhLDK+kH7+a/+apOtaKDlGpNomdrnOan5fg==
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr36704411ejf.50.1630500902714;
        Wed, 01 Sep 2021 05:55:02 -0700 (PDT)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id r8sm723207eds.39.2021.09.01.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 05:55:02 -0700 (PDT)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        git@vger.kernel.org, ps@pks.im
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v4 2/2] upload-pack: use stdio in send_ref callbacks
Date:   Wed,  1 Sep 2021 14:54:42 +0200
Message-Id: <20210901125442.34446-3-jacob@gitlab.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210901125442.34446-1-jacob@gitlab.com>
References: <xmqqy28htrc6.fsf@gitster.g>
 <20210901125442.34446-1-jacob@gitlab.com>
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
stdio.

To give an example of the impact: I set up a single-threaded loop that
calls ls-remote (with HTTP and protocol v2) on a local GitLab
instance, on a repository with 11K refs. When I switch from Git
v2.32.0 to this patch, I see a 40% reduction in CPU time for Git, and
65% for Gitaly (GitLab's Git RPC service).

So using buffered IO not only saves syscalls in upload-pack, it also
saves time in things that consume upload-pack's output.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 ls-refs.c     |  4 ++--
 upload-pack.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d..e6a2dbd962 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -105,7 +105,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	}
 
 	strbuf_addch(&refline, '\n');
-	packet_write(1, refline.buf, refline.len);
+	packet_fwrite(stdout, refline.buf, refline.len);
 
 	strbuf_release(&refline);
 	return 0;
@@ -171,7 +171,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 		strvec_push(&data.prefixes, "");
 	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
 				     send_ref, &data, 0);
-	packet_flush(1);
+	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	return 0;
 }
diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb4..2fdd73dfcb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1207,7 +1207,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 		format_symref_info(&symref_info, &data->symref);
 		format_session_id(&session_id, data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
+		packet_fwrite_fmt(stdout, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
@@ -1223,11 +1223,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		strbuf_release(&symref_info);
 		strbuf_release(&session_id);
 	} else {
-		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
 	if (!peel_iterated_oid(oid, &peeled))
-		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+		packet_fwrite_fmt(stdout, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return 0;
 }
 
@@ -1348,6 +1348,11 @@ void upload_pack(struct upload_pack_options *options)
 		reset_timeout(data.timeout);
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
+		/* 
+		 * fflush stdout before calling advertise_shallow_grafts because send_ref
+		 * uses stdio.
+		 */
+		fflush_or_die(stdout);
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-- 
2.32.0

