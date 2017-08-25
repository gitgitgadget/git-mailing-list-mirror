Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA999208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 18:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758055AbdHYStv (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 14:49:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35186 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756477AbdHYStv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 14:49:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id a47so351191wra.2
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2FLL6tNlI4T/FcW3xusYNVb/j0vASlwe6hKOvM0b0w=;
        b=cSijimRVOOt1Ib7JCESN32oXR0Q2v41NWvGvaqffmnOqjYZbGDbgMEMerS2VE1b3Uj
         fONIvjxVU9cpG+m7I0CLz6cC/xpT2Dw/vaI+TlsNT73YYRQxIT0YIrZo5chasvrzEEbV
         NqWm0XVBhTqe0J13nVQwcv3joXQNYqwv+kdfwrK90wmrSNpbeXDsbKT5mrXyE5DGjOoR
         QOsPNr40gsPeMoh5UWCigAb0j4vLpjyTCm692LsP5Ge4lyV5H3ltQ+aGCK6JMcNUJfMI
         5TkP87w/KN7KzE7sdI1vX3oamoYvgcF1sVBGNENdgztJsT9cuWHguegqxh3sGBnsFlEN
         Olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2FLL6tNlI4T/FcW3xusYNVb/j0vASlwe6hKOvM0b0w=;
        b=jAtVYItfMydCVmufRZLpVo5qa5HPVkFQGO+fcHpNclYPfo5XoDhKxnfmH61v3AEgKq
         ir/BNVAJq2+ZJHdbqHkLo7YjsTs43tUrFP8lVXrlCaOxc+BF5XUlcM1z6mQmi2ofrIKV
         0y3qQ32UDeUUaerT80VgZbaZOJSTDgPfIUHmw5MRvw5IihoPfoEbaMxu6a37rDRFOsjz
         3pCr+YPiGmGqOTD4aZAmzUDe8izjPxNQxCZVmJB2zEtwzaidbrTr+YRuPEv+PFruSQzL
         ldvpa0aioA9uQ5Nx5CkGaQ5EcJfv5XCvOZYdiLPO63yF5pFlnvLlVKEm2J7Vjwws2y2J
         bPQg==
X-Gm-Message-State: AHYfb5gta+62TErfYu7bLDBhg2xM63Ry73zbFFGkeaAYMOoQO7LJoCBQ
        mszg0ZJtxcrBYa1x
X-Received: by 10.223.151.141 with SMTP id s13mr6084191wrb.231.1503686989309;
        Fri, 25 Aug 2017 11:49:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id m10sm2638762wrf.69.2017.08.25.11.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 11:49:48 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] refs/files-backend: fix memory leak in lock_ref_for_update
Date:   Fri, 25 Aug 2017 20:49:16 +0200
Message-Id: <fb9c0866cedac8c1d8fcf143641ebbee70d07ad7.1503496797.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
In-Reply-To: <40c5e954dd84ff42552bccfea00144eecdbd1c7e.1503496797.git.martin.agren@gmail.com>
References: <40c5e954dd84ff42552bccfea00144eecdbd1c7e.1503496797.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We hand over the "referent" string (buffer) to several different
functions, one of which would sometimes keep the raw pointer,
referent.buf. (When split_symref_update calls string_list_insert.) The
previous patch removed that behavior, so we can now safely release the
string buffer before returning.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I appreciate Git's stance on memory leaks ("if we're about to exit or
die, why bother?") but this one feels different since
lock_ref_for_update is called in a loop rather deep down the call stack.
Feel free to tell me I'm wrong. Patch 1/2 does introduce some
malloc-churning. An alternative would be to call strbuf_release only
when we know it's safe, but that feels really ugly.

 refs/files-backend.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 22daca2ba..6af07c404 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2252,7 +2252,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
 		!is_null_oid(&update->old_oid);
-	int ret;
+	int ret = 0;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
@@ -2264,7 +2264,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		ret = split_head_update(update, transaction, head_ref,
 					affected_refnames, err);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = lock_raw_ref(refs, update->refname, mustexist,
@@ -2278,7 +2278,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		strbuf_addf(err, "cannot lock ref '%s': %s",
 			    original_update_refname(update), reason);
 		free(reason);
-		return ret;
+		goto out;
 	}
 
 	update->backend_data = lock;
@@ -2297,10 +2297,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2314,13 +2316,15 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2357,7 +2361,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				    "cannot update ref '%s': %s",
 				    update->refname, write_err);
 			free(write_err);
-			return TRANSACTION_GENERIC_ERROR;
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
 		} else {
 			update->flags |= REF_NEEDS_COMMIT;
 		}
@@ -2371,10 +2376,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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

