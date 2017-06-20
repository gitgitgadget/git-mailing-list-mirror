Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31EE21FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbdFTBDl (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:41 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36135 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbdFTBDi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:38 -0400
Received: by mail-pf0-f171.google.com with SMTP id x63so61537115pff.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=s4kZ5BWiYn4NjfCEwl9xYvxkdcFH+hBG53hbH2qodvY=;
        b=lnLz4UDTg74zqf7gv7cXQzl/t04ps87mdwFbPbMu6S160tCcuHap/or9gA8X2v39XD
         wBwH2LbNk0M9e5b/C9YMaQILymN5ovt289rBOff5zOoeD+eeBbkenCCHdOvco2w8HOof
         td8p82LFBTs1LWWyuRKwHxvwI+L+guaV7dlOKnZzs2z8tHyb1LSYVO5iQNr3HwFmaBn/
         5LJa7hkvDFKr/u/qLfs7Eq5j4x3Ho9PA4+Un/gxkl8HvcGYu/03VkrAwmVrmMEvcBHu2
         Trhm/MNOLM/xngwdAimWKzZxWagcSE5M0yBD9tKhsKy+beWeRHQQwTNf239JkpIik959
         9TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=s4kZ5BWiYn4NjfCEwl9xYvxkdcFH+hBG53hbH2qodvY=;
        b=aamLHCzzK3BWibjzgzYRMfmxGuIMSlUMmGd6l4USYYvcR5V9tpmc888TMb2a4+kNa6
         APXfy0eLYGPS33iPm9j1rpMqrM60jAY45nHwgWIpD6Q356EbowXgISctM2aSXMKMJVeL
         zWgnEDf93bWSymcDhPmhAKLkH2iVT2zcFvzoDE9nlDY/4jbSeBy99sow+c7h46Ec95m/
         KlrxTgavfZ3KVj+YgZDiEOEQE1MV7BnCge9/x2y6s6YgcuSd7GPW1AS1vNQdhQJENmKJ
         xehmIGeIrmTYbh35JF9zkuRQ2WQ+DrfF5rXFrBIbgRaNIS1h33heqIf6JbD7K/sCzDzn
         0BLQ==
X-Gm-Message-State: AKS2vOysal/XzyBr5hATqZgZnfzmsElhMCmd9lcaeHG5DVU36fDwvScd
        glqhOPve3VYKfdoCi/61cA==
X-Received: by 10.99.147.19 with SMTP id b19mr25095449pge.154.1497920612360;
        Mon, 19 Jun 2017 18:03:32 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:31 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 7/8] sha1_file: do not access pack if unneeded
Date:   Mon, 19 Jun 2017 18:03:14 -0700
Message-Id: <fb656dfeb96e3c69f612fed924d0d9dec592c772.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497920092.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option to struct object_info to suppress population of additional
information about a packed object if unneeded. This allows an
optimization in which sha1_object_info_extended() does not even need to
access the pack if no information besides provenance is requested. A
subsequent patch will make use of this optimization.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 +
 sha1_file.c | 17 +++++++++++++----
 streaming.c |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 7cf2ca466..2e1cc3fe2 100644
--- a/cache.h
+++ b/cache.h
@@ -1828,6 +1828,7 @@ struct object_info {
 	unsigned char *delta_base_sha1;
 	struct strbuf *typename;
 	void **contentp;
+	unsigned populate_u : 1;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index 24f7a146e..68e3a3400 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3020,6 +3020,13 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
+	if (!oi->typep && !oi->sizep && !oi->disk_sizep &&
+	    !oi->delta_base_sha1 && !oi->typename && !oi->contentp &&
+	    !oi->populate_u) {
+		oi->whence = OI_PACKED;
+		return 0;
+	}
+
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
@@ -3028,10 +3035,12 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		oi->whence = OI_DBCACHED;
 	} else {
 		oi->whence = OI_PACKED;
-		oi->u.packed.offset = e.offset;
-		oi->u.packed.pack = e.p;
-		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-					 rtype == OBJ_OFS_DELTA);
+		if (oi->populate_u) {
+			oi->u.packed.offset = e.offset;
+			oi->u.packed.pack = e.p;
+			oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
+						 rtype == OBJ_OFS_DELTA);
+		}
 	}
 
 	return 0;
diff --git a/streaming.c b/streaming.c
index 9afa66b8b..deebc18a8 100644
--- a/streaming.c
+++ b/streaming.c
@@ -113,6 +113,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 
 	oi->typep = type;
 	oi->sizep = &size;
+	oi->populate_u = 1;
 	status = sha1_object_info_extended(sha1, oi, 0);
 	if (status < 0)
 		return stream_error;
-- 
2.13.1.611.g7e3b11ae1-goog

