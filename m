Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05BBB20401
	for <e@80x24.org>; Thu, 22 Jun 2017 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbdFVAlI (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 20:41:08 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33258 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdFVAk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 20:40:58 -0400
Received: by mail-pg0-f50.google.com with SMTP id f127so823173pgc.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 17:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FXizvd1QvCwzdor3BuKP0VdNKKv1gt7F1zUqgXR9XrU=;
        b=Z3TQFBouyj/CE9LutnycM9MVWdGGVV+JVeAoTh253K/JYQ4Vyk8JitX6nlaMscFGpa
         E03O5w4bU/u7vdFPE09XBa6BWAzhmDIsY5LkUNqy5dhz321ubqCwkTF9mpt9z0LTRntL
         yIcfoFY+w5DUvzcIgJdlf4KFAj9wp53RmmZZ6CRzan2XV/bqWAyebaBSyV7aEg7CMbX/
         3QmcRTTBk9s7I0sSje2OmmWuxYl2ltFMzSgLqG8upEVS0k62YDcL3OXPQsdnT+AtUj8m
         SejkryyuqjtX6S6+2sew+wsSnG/rquc0OiHvKAx9WAWl5uSORKRxI4sC36s4occe+rok
         znnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FXizvd1QvCwzdor3BuKP0VdNKKv1gt7F1zUqgXR9XrU=;
        b=m191TtkHAvItKvbBlCZze9cD5M+wSroqWa8tUD7nVA/g5in9lYCANs3SJP7Ncyvc/N
         RlK0FLM56nyVj+eAJnYSV+QmOtAfDEPDb9Y9Cfr8yV9i4iVCUyGmiqnfEvq6acMO/xhs
         91xruyAa+jbqXzv/ioDDoxZ6pztDYfnbgbvVnLNavpTnOwBAKwniCJqEr1fBm2VIgrqw
         mgoFGb6XmnfZoSofmx01YLHzkYjrf9Wva6jgkr/pKyhKmV5QHxaMGQD+3zlzycjNifUt
         x56yTSp0LycNBX2Pie1TK4Yiqc8WIV1WD1x0fsh0Q2UYjYgKt/7UEmzQRaq0v85onswJ
         x6LQ==
X-Gm-Message-State: AKS2vOxUOZCWNkLS2TYz5gtMTmqoV7dyO5PzN92RK590QNumYc6MM/v8
        CigzHtpzi7RANqdPHpgnMw==
X-Received: by 10.84.229.79 with SMTP id d15mr36322918pln.4.1498092042356;
        Wed, 21 Jun 2017 17:40:42 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c205sm34658213pfb.74.2017.06.21.17.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 17:40:41 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v5 7/8] sha1_file: do not access pack if unneeded
Date:   Wed, 21 Jun 2017 17:40:23 -0700
Message-Id: <ddbbc86204c131c83b3a1ff3b52789be9ed2a5b1.1498091579.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1498091579.git.jonathantanmy@google.com>
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1498091579.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, regardless of the contents of the "struct object_info" passed
to sha1_object_info_extended(), that function always accesses the
packfile whenever it returns information about a packed object, since it
needs to populate "u.packed".

Add the ability to pass NULL, and use NULL-ness of the argument to
activate an optimization in which sha1_object_info_extended() does not
needlessly access the packfile. A subsequent patch will make use of this
optimization.

A similar optimization is not made for the cached and loose cases as it
would not cause a significant performance improvement.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index b6bc02f09..bf6b64ec8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2977,12 +2977,16 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
+	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
 
+	if (!oi)
+		oi = &blank_oi;
+
 	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
 		struct cached_object *co = find_cached_object(real);
 		if (co) {
@@ -3020,6 +3024,13 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
+	if (oi == &blank_oi)
+		/*
+		 * We know that the caller doesn't actually need the
+		 * information below, so return early.
+		 */
+		return 0;
+
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-- 
2.13.1.611.g7e3b11ae1-goog

