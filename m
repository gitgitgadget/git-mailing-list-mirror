Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F2F208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbdH1Uc6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 16:32:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33110 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdH1Uc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 16:32:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id e67so1735179wmd.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKsltzDksuvSrbQniE6zgYSmhxSk2wxMV8fGj3li97I=;
        b=MPR08rhSRf0ZRDYQq19nAxeeWP100/wqk9jI6gp1ogFQqzWAu2zmKTeQfNHASDgPk5
         y090tcLHYiyQaw/rf+zttYpYMsZqoHTOrtMTdRlz+VdjZV8XNcLDsCUMjQMfEiuBy8mV
         /lFvcRMWagEW+ytcbbH/016MaYbFCfQQazKQrEh4Fo8A/tLfyP5DIazocDTfgMoiCgPz
         +ixhGR4EK2eZB5EWkPqsarogbEByS3DaivlCgq1s2CbuEOcKcVgxwBlO4Cf3mvSpgEh4
         Pi4bFNY8Ss7yf9LE/yc3aB5FisGUfgYKtgwTN4C41yErKIbej9y77Hqul1/UVErGEuyp
         ScJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKsltzDksuvSrbQniE6zgYSmhxSk2wxMV8fGj3li97I=;
        b=aCQt25c5ziifhxflFACiRM6G3rzZMLWFAOuzPJxdD3eAfpIF4Sd6whtrj4PQTFX/UC
         eYY0oTwu7zzg4iBiY0b7z56qM8aiYUbhbPngYxa80y6Fla24czVSVMk0hG72O8Ah4GEN
         gVG+UzolbeIioIxtPM9f/BLzqURIWYHjw5o9ULOs/wu2C4kxIKYDlHMCsQSwNKgCN6DX
         +MJVojTejetU4Q0CkYX/LSN6Fmq23Tc5KFRZ6cKx5XNOe8rgfqR4lmKm+3ZVChcAqk2A
         QEKmSe5QLBipTCz/ivDBiWBQAHfaEm/HJnGUyk/J8ekt1WjY9CndxCooIfkrqN4EKBJv
         GF6g==
X-Gm-Message-State: AHYfb5iiNg+4Oa8DrLFsEJy5fknA9yY++0PpOPdO0PLMwikAP+/FR25h
        M4u3DJIWLsTHZCdaeS8=
X-Received: by 10.28.182.7 with SMTP id g7mr25878wmf.66.1503952375686;
        Mon, 28 Aug 2017 13:32:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id 13sm1232043wms.22.2017.08.28.13.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 13:32:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] refs/files-backend: fix memory leak in lock_ref_for_update
Date:   Mon, 28 Aug 2017 22:32:25 +0200
Message-Id: <fe842671061cea7972b0c8695a4b7f82f854453a.1503951733.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
In-Reply-To: <CAN0heSrkYL6OqVHHnDtA1DqE-FVqjB59bG2MsgxmJyxW33k9JA@mail.gmail.com>
References: <CAN0heSrkYL6OqVHHnDtA1DqE-FVqjB59bG2MsgxmJyxW33k9JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the previous patch, none of the functions we call hold on to
`referent.buf`, so we can safely release the string buffer before
returning.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs/files-backend.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bdb0e22e5..15f34b10e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2260,7 +2260,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
 		!is_null_oid(&update->old_oid);
-	int ret;
+	int ret = 0;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
@@ -2272,7 +2272,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		ret = split_head_update(update, transaction, head_ref,
 					affected_refnames, err);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = lock_raw_ref(refs, update->refname, mustexist,
@@ -2286,7 +2286,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		strbuf_addf(err, "cannot lock ref '%s': %s",
 			    original_update_refname(update), reason);
 		free(reason);
-		return ret;
+		goto out;
 	}
 
 	update->backend_data = lock;
@@ -2305,10 +2305,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
 						    original_update_refname(update));
-					return -1;
+					ret = -1;
+					goto out;
 				}
 			} else if (check_old_oid(update, &lock->old_oid, err)) {
-				return TRANSACTION_GENERIC_ERROR;
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto out;
 			}
 		} else {
 			/*
@@ -2322,13 +2324,15 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 						  referent.buf, transaction,
 						  affected_refnames, err);
 			if (ret)
-				return ret;
+				goto out;
 		}
 	} else {
 		struct ref_update *parent_update;
 
-		if (check_old_oid(update, &lock->old_oid, err))
-			return TRANSACTION_GENERIC_ERROR;
+		if (check_old_oid(update, &lock->old_oid, err)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
 
 		/*
 		 * If this update is happening indirectly because of a
@@ -2365,7 +2369,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				    "cannot update ref '%s': %s",
 				    update->refname, write_err);
 			free(write_err);
-			return TRANSACTION_GENERIC_ERROR;
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
 		} else {
 			update->flags |= REF_NEEDS_COMMIT;
 		}
@@ -2379,10 +2384,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		if (close_ref(lock)) {
 			strbuf_addf(err, "couldn't close '%s.lock'",
 				    update->refname);
-			return TRANSACTION_GENERIC_ERROR;
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
 		}
 	}
-	return 0;
+
+out:
+	strbuf_release(&referent);
+	return ret;
 }
 
 /*
-- 
2.14.1.151.g45c1275a3.dirty

