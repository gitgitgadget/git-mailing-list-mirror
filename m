Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863AAC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhLMNYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 08:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbhLMNYn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 08:24:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9FC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 05:24:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x10so34652900edd.5
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 05:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjYKSSKMQToS8I7wJJoC+w4qj1U3TYyQrLeGnxOekrk=;
        b=AnKG18KJToQi5fyC1Q8ATp3ESluCA3M7pVepjonDQ+1oPJWhTI17pjmQTYHUCjaKMa
         tBdiWSK2kD+/mOazpUDEGkum+QbOJED5ccuDEkrGH16jgVkHxqGdE6c9F7uCCsUJytI7
         HI7B1Y9/Y8mPGJH4ZID9tRWNKzA+22FWPEBmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjYKSSKMQToS8I7wJJoC+w4qj1U3TYyQrLeGnxOekrk=;
        b=N5Qb24IU1DDS1e8B99SKNHHCqX8UGUeAuXVUnZHL6OSMeSDTYK3+4jk1NKgcHJqvt/
         JjhSPxR+ZVvqTNPEhaAq4wq+FVEQejLeWdvWz9FBWEzu5I6jMUcFk5kX02AAG3SRMHux
         ZIXn/q07uDJM7zBybSA4rzNfaZtDUf7GK74b14LUB9eLnN0250xVrtoR5JDlsKU7kJiC
         PI/2EmAOXKPkppwi92d5Qi0XaRUXgFX3w/rVT/HNnOc38Bsy+PKnozfTSw3BP3wREiqd
         aAIgvnAkpVWBQg+PvTks6AeWe+8NWHG0F0bPFkot8W4D44xx7DthyVBVa6nt068AzEwx
         Wxyw==
X-Gm-Message-State: AOAM5330YIkjkZAC/xCUm0hSTPaxgrdBwVuUp9SzIHtyYtmamVzDILXR
        U4vRFQmIm6N9bbK77qQYJlVL56v5J3MVng==
X-Google-Smtp-Source: ABdhPJxeikwOwKv1aAasremBo/j3tnATt33l3hm8J6YEL81yJwxSymiTMi7vxLfjervEhAFg/zCkkA==
X-Received: by 2002:a50:9b05:: with SMTP id o5mr66072499edi.66.1639401881852;
        Mon, 13 Dec 2021 05:24:41 -0800 (PST)
Received: from localhost.localdomain (a164154.upc-a.chello.nl. [62.163.164.154])
        by smtp.gmail.com with ESMTPSA id di5sm5838739ejc.45.2021.12.13.05.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 05:24:41 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 1/1] upload-pack.c: make output buffer size configurable
Date:   Mon, 13 Dec 2021 14:23:45 +0100
Message-Id: <20211213132345.26310-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213132345.26310-1-jacob@gitlab.com>
References: <20211213132345.26310-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new compile time constant UPLOAD_PACK_BUFFER_SIZE that makes the
size of the static buffer in output_state configurable.

The current size of the buffer is 8192+1. The '+1' is a technical
detail orthogonal to this change. On GitLab.com we use GitLab's
pack-objects cache which does writes of 65515 bytes. Because of the
default 8KB buffer size, propagating these cache writes requires 8
pipe reads and 8 pipe writes from git-upload-pack, and 8 pipe reads
from Gitaly (our Git RPC service). If we increase the size of the
buffer to the maximum Git packet size, we need only 1 pipe read and 1
pipe write in git-upload-pack, and 1 pipe read in Gitaly to transfer
the same amount of data. In benchmarks with a pure fetch and 100%
cache hit rate workload we are seeing CPU utilization reductions of
over 30%.

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 upload-pack.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index c78d55bc67..b799fbe628 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -42,6 +42,10 @@
 #define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
 		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
 
+#ifndef UPLOAD_PACK_BUFFER_SIZE
+#define UPLOAD_PACK_BUFFER_SIZE 8192
+#endif
+
 /* Enum for allowed unadvertised object request (UOR) */
 enum allow_uor {
 	/* Allow specifying sha1 if it is a ref tip. */
@@ -194,7 +198,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 }
 
 struct output_state {
-	char buffer[8193];
+	char buffer[UPLOAD_PACK_BUFFER_SIZE+1];
 	int used;
 	unsigned packfile_uris_started : 1;
 	unsigned packfile_started : 1;
-- 
2.33.0

