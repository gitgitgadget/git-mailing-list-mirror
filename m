Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B9120286
	for <e@80x24.org>; Sat,  9 Sep 2017 06:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755645AbdIIG5r (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:57:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35600 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdIIG5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 02:57:46 -0400
Received: by mail-wr0-f196.google.com with SMTP id n64so2076360wrb.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2017 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERDO+hhdLORYd8y5ne7Mhr8a7UNX5YEEmVDfIcE9Iz0=;
        b=TtK9xMJ8fMff3OotodJUcfXpHdAhZYAiieYJ73P3FsEcP7apZSa741Djq7FPLTAAzj
         5a720AOk1B731fsKyUCTz0qaoLrCd8Mze1kwqvDLolHYfXlpG6V3qY/i6PwMRPTqXnw6
         7hTfzHs8ArDYfc3tjJwDe8ZXfy5tkfoXAdXEqCi73Fy5zagMxgLV09A2qwOrmYVZ7XsJ
         d00F+BEwxJ+v/avpM1B9hsTCacMf5fZjEPhkP2iO7uXznk059ImP71PUxpSC0ITHc5YX
         CLeuy2u0eWnqb7f1204eE5cKZJGwi59uXwhkSht0D9vDGR5XqRzapdilDJYiRL+XZ4eE
         ukZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERDO+hhdLORYd8y5ne7Mhr8a7UNX5YEEmVDfIcE9Iz0=;
        b=kbUbODaAbtBZiJ+iBbzmSteXK/sQfNd2X20gUyQoEcQs5KHPAxyMhw2eV5tC4YLur0
         yfBfHStA33CeiF2nd0DhT3CbDw/wlDoQMeAldNorhGrI6I4xsQu0lxvGWQsYHbuXwB8z
         hrOmcc0nn4Q3+htU7GkECfPFIYpt7trsgcdasXepUBFlI3PXf1tzfUYPdAx8IquEKs5E
         x17858LgSeHg3EPPC4HFhRhygWvu6969YytTAavJsyI0kdDvzXQkY5aRubl+/HxxrmYD
         Km4g2NmgnIDB2YRPhr9bHDpgtOcqaYAKu7uDfPPO++muE3zWFFHcrx1vZdurYMZuyNwo
         8u3Q==
X-Gm-Message-State: AHPjjUhD5IWeWF0ycSc0Rdad5iQFWOn/e1z9/+e3UT3zRIk6/bmGUMuA
        eq5CyJVwBqMGIVsU
X-Google-Smtp-Source: ADKCNb4JUgxrcblH1mnbBqqHs2JcPSdukhTolVOMBN/hrlA1qq3F1x55xGzKGmZK1qJgirXLq+3sLg==
X-Received: by 10.223.168.105 with SMTP id l96mr3834009wrc.248.1504940264501;
        Fri, 08 Sep 2017 23:57:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id v82sm4269403wmd.44.2017.09.08.23.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Sep 2017 23:57:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 2/4] refs/files-backend: fix memory leak in lock_ref_for_update
Date:   Sat,  9 Sep 2017 08:57:16 +0200
Message-Id: <f06c7cab8e335f5459388d20776c19d5384ebc29.1504939825.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.460.g848a19d64
In-Reply-To: <cover.1504939825.git.martin.agren@gmail.com>
References: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com> <cover.1504939825.git.martin.agren@gmail.com>
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

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs/files-backend.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index baceef3b3..3d6363966 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2756,7 +2756,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
 		!is_null_oid(&update->old_oid);
-	int ret;
+	int ret = 0;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
@@ -2768,7 +2768,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		ret = split_head_update(update, transaction, head_ref,
 					affected_refnames, err);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = lock_raw_ref(refs, update->refname, mustexist,
@@ -2782,7 +2782,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		strbuf_addf(err, "cannot lock ref '%s': %s",
 			    original_update_refname(update), reason);
 		free(reason);
-		return ret;
+		goto out;
 	}
 
 	update->backend_data = lock;
@@ -2801,10 +2801,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2818,13 +2820,15 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2861,7 +2865,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				    "cannot update ref '%s': %s",
 				    update->refname, write_err);
 			free(write_err);
-			return TRANSACTION_GENERIC_ERROR;
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
 		} else {
 			update->flags |= REF_NEEDS_COMMIT;
 		}
@@ -2875,10 +2880,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
2.14.1.460.g848a19d64

