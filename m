Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDE01F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 17:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdH2RSx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 13:18:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37810 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdH2RSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 13:18:52 -0400
Received: by mail-wr0-f195.google.com with SMTP id n37so2695443wrf.4
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tIZPHI1W+B2w4ZGJLthzVBov0b1kf/WF9remY0IvVA=;
        b=RUmKHvNPA2g/RPFMn6xyi2nIvuCyeNUrAx160BSnsuFp/Fh1cubyJiEGOM0gp7HdwD
         40ZxZR7Kq/TRUcUyPGS1+2UoKT6n1i8IDBmIJgJaDU4q2r0/Lu1pzjTjbeJ6GbclW9Ja
         iYIPjeujks/7WOwn4eMKK/7qOBdJTjtQNIOmRYqQEr9bUTvsMX4WvP15gBUOy0qX+edH
         LPFyS82GkmTNAXyBQ08/BiQo0mbNs866k8Bkh2RebHAYYBTbc8zwTtVgoLkIzJgZrX5w
         HvOjpQFi5jPdVdifD5OB/54m6zXRitydxSjMXjxoefiQzoal4TatAHEvAVisIPUduDhr
         FY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tIZPHI1W+B2w4ZGJLthzVBov0b1kf/WF9remY0IvVA=;
        b=h+dsnE9PSQWLK4z8aWxMTbaCXtHAdoOgaOu5zuaBef4n56a1mW4cfSmEpDL2cL6BfO
         uaXKZiQ2BZRKay1o8X2i1/yj3BAdGmEFuW37jC/1+aP0mGCHElMZbC2pzaXrF35tIInp
         T1Yxn7cP+dDXtu0SISckEiWiBn8frogGcpfhNZv/3QpYm0Djvd4+vGFnjTxiAqZBMBnO
         KhdScL93Y9Kubv5TEMvVWm2Fz2T7HHMj6WFBFsFkuuCKiBsdDTV2KEphbDJ54a8uw1BU
         /gWqUhsmky57q8Dz6HaCxHK5JE7SGG2/NGIuZoZc5cfq879muwka4urmeIobxDSbHD7/
         /S5A==
X-Gm-Message-State: AHYfb5hZs9+dtjkNStLml4V57J6sn8xG3EGT0hox1juYRgasWVBwlaPa
        bN9oQwKxj3HA7XlR
X-Received: by 10.223.169.52 with SMTP id u49mr626250wrc.281.1504027131283;
        Tue, 29 Aug 2017 10:18:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id r12sm3054921wrr.28.2017.08.29.10.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 10:18:50 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/3] refs/files-backend: fix memory leak in lock_ref_for_update
Date:   Tue, 29 Aug 2017 19:18:23 +0200
Message-Id: <f136e83168453af7a0d1eba45c8ad47d01dd9a41.1504024261.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
In-Reply-To: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
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
v3: identical to v2

 refs/files-backend.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 73615d869..a2b3df21b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2266,7 +2266,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
 		!is_null_oid(&update->old_oid);
-	int ret;
+	int ret = 0;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
@@ -2278,7 +2278,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		ret = split_head_update(update, transaction, head_ref,
 					affected_refnames, err);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = lock_raw_ref(refs, update->refname, mustexist,
@@ -2292,7 +2292,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		strbuf_addf(err, "cannot lock ref '%s': %s",
 			    original_update_refname(update), reason);
 		free(reason);
-		return ret;
+		goto out;
 	}
 
 	update->backend_data = lock;
@@ -2311,10 +2311,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2328,13 +2330,15 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2371,7 +2375,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				    "cannot update ref '%s': %s",
 				    update->refname, write_err);
 			free(write_err);
-			return TRANSACTION_GENERIC_ERROR;
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
 		} else {
 			update->flags |= REF_NEEDS_COMMIT;
 		}
@@ -2385,10 +2390,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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

