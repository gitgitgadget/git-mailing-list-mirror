Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E23D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 20:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeBFUgV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 15:36:21 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:39846 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeBFUgU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 15:36:20 -0500
Received: by mail-pl0-f50.google.com with SMTP id o13so1995749pli.6
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 12:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zodYpGzM28wR/DoUGeyi8qNIb4ovyuaYzaEqDi6UkL4=;
        b=cuZfkYvf9FACVTvKbIzbFz8vLiHzZGGeFEAfMiepmxrF6SquLArocno6QqD9oHSdMa
         HeVimqKbPrO9LzCN+LAY0pc2XxORtVKBa5YWU4g5Nf43KgYt6ddRhoav3kTFzMO9j0H4
         Dc+QDf4Xu29EWngybfMUvCAii62Dt4OwT//ghkhJxCPwCDnmZOmNseCdgPqSoCrbzQk1
         /n83YqDvtJvKRyUv92AeQa8G1AvWE/gGaAbFqU8Ar+NAKaMqoIW2+pT6UTtB7uwXwhvy
         LefbZ7SztlEiFlAXLGZHsq8f66jteUTf7YfRrqXAU7BExTzgFlzMGK6S4qYiSNu6qFji
         jqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zodYpGzM28wR/DoUGeyi8qNIb4ovyuaYzaEqDi6UkL4=;
        b=BU/2EqFK3Oi6SmIleerksZysEL4aBQl8/RW19IFSIZjhHOV4sGBvdPlfxTSQToEdnR
         a+s72rpKekZvy/OVt07wsdpYhSI/tjT8gYQ6iBasz8XYb9AXBUwWTsbM7uRdqoPMIems
         wFe6xLZyUD05GrsXIPEMgQki+OOGSjHlYTIEI3gcUVt+zg5FH8blMjsNTM4UTz4U7W+i
         FpPhYgT5LRBC2DwH93W27u5TXVyM0RV8i6pDz/ZZp7vGTVD98uoN49aaiWgD4zn/hJnw
         mOKfIKiJ1lGsH61TVjU+wl2xeu91T1MKguyRgGvEcn0UMhR4Sdc/qCzT+w8nTbMb5vnX
         y3AA==
X-Gm-Message-State: APf1xPCNR54L1waJct6owKtcBCyr2VHX9wzGRLVyJPPouB+IPVTFbfVQ
        NCMoO5ictZ2MXBPVJFEb/uq3idEXIz8=
X-Google-Smtp-Source: AH8x227o6W395QvTtc3UPtDo7neDKryN+B1l2QpqQRjGdzCk1sN9MTWOnhpmeU8MkqKdK/9AXPj2qA==
X-Received: by 2002:a17:902:3381:: with SMTP id b1-v6mr3639474plc.20.1517949379230;
        Tue, 06 Feb 2018 12:36:19 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a13sm13883295pgd.1.2018.02.06.12.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2018 12:36:18 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, mhagger@alum.mit.edu
Subject: [PATCH] files-backend: unlock packed store only if locked
Date:   Tue,  6 Feb 2018 12:36:15 -0800
Message-Id: <20180206203615.68504-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 42c7f7ff9685 ("commit_packed_refs(): remove call to
`packed_refs_unlock()`", 2017-06-23), a call to packed_refs_unlock() was
added to files_initial_transaction_commit() in order to compensate for
removing that call from commit_packed_refs(). However, that call was
added in the cleanup section, which is run even if the packed_ref_store
was never locked (which happens if an error occurs earlier in the
function).

Create a new cleanup goto target which runs packed_refs_unlock(), and
ensure that only goto statements after a successful invocation of
packed_refs_lock() jump there.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I noticed this when one of our servers sent duplicate refs in its ref
advertisement (noticed through GIT_TRACE_PACKET). With this change (and
before the aforementioned commit 42c7f7ff9685), the error message is
"fatal: multiple updates for ref '<ref>' not allowed", which gives a
bigger clue to the problem. Currently, it is "fatal: BUG:
packed_refs_unlock() called when not locked".

(I couldn't replicate this problem in C Git.)
---
 refs/files-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f75d960e1..89bc5584a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2931,13 +2931,14 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 
 	if (initial_ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
+		goto locked_cleanup;
 	}
 
+locked_cleanup:
+	packed_refs_unlock(refs->packed_ref_store);
 cleanup:
 	if (packed_transaction)
 		ref_transaction_free(packed_transaction);
-	packed_refs_unlock(refs->packed_ref_store);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	string_list_clear(&affected_refnames, 0);
 	return ret;
-- 
2.16.0.rc1.238.g530d649a79-goog

