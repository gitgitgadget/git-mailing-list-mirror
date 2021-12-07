Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E31C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbhLGRs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbhLGRs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:48:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD6C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j3so31179471wrp.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=a2dxhXN6orm9sJI4kDhmpwxrEQQVoBlS1kp5gKf3u5AiPzDxzhguwj+AGwB8v9gsvL
         zJYCl7rOAWoZYy0sLno81oG3sZ4NXLtURI4PBbOXaNWmYCQMfdAhqM9JfF+IilAVIBn8
         5aF0blvLSyOUr2yfnhJ+0WOispKWuk7mS/sAolKggp4g9nQoENfa14ju06pFIzFDJaPv
         J/xWyKZ/4JoKTaBE7z2AzeCJwFOoPyqst2PP9nzOOkLBRCeqUk3d6BZjsGpFCmUeaHrX
         J/HFaEwIoYGxYmgt7wder72tKQNFWb8F5sx2wwNQcxFz3/1ylQj8J7IqVr1TxOyP5tFS
         /2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=zjILVqXkukrNcD1CeYdJb7O+8HLV/oqfOPGDvqQcZFu1nwpL7yBxwOtTaSEgr/clkr
         4qhw9y0U/xcF+MVklloqG/I0PWr2GljZUIax+0dTb1j6/aC9jmuKpynxtTkVMpQyKa6Y
         UXLE6w3/N94n0JAoJS4q5Ais7JYLx71IxJhkM6gBYY2+ZPuqHpfn77FrOMAYgxRa+eUi
         UHr609tD/PX8n7TBumzHh0MowSA/yi0vjYkU6lvBe3KH493cfXCB+wA9llXsh981RCJI
         /IHd5Sfupoj57d1vyPdfRc4z/m4Bl8aepOy8JpeKfPrl35f4G5iOuqrhUM1mqxol8zkY
         AAtQ==
X-Gm-Message-State: AOAM531HqcLUfq0ADPN5Kv1rsq1CkbuavcpRIkCjrMRupSliyLXpjxqD
        U25VwRkRFCIRm/hoQjLiTxBL9foPdTk=
X-Google-Smtp-Source: ABdhPJxiQ4dQLG2XLno3+sxH4r9gWVNzLCEVqlRy/zDyHoHV+/5QJvMURoonioyBSoi+hbqnMEqXYQ==
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr51075456wrx.378.1638899126806;
        Tue, 07 Dec 2021 09:45:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm344033wmq.12.2021.12.07.09.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:26 -0800 (PST)
Message-Id: <7c033815183cc8ad7a76bc2b9456b17041107c2c.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:15 +0000
Subject: [PATCH 01/10] reftable: fix OOB stack write in print functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 6a5dac32dc6..8536bd03aa9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -254,7 +254,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
 void reftable_ref_record_print(struct reftable_ref_record *ref,
 			       uint32_t hash_id)
 {
-	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
 	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
 	switch (ref->value_type) {
 	case REFTABLE_REF_SYMREF:
@@ -586,7 +586,7 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 void reftable_log_record_print(struct reftable_log_record *log,
 			       uint32_t hash_id)
 {
-	char hex[GIT_SHA256_RAWSZ + 1] = { 0 };
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
 
 	switch (log->value_type) {
 	case REFTABLE_LOG_DELETION:
-- 
gitgitgadget

