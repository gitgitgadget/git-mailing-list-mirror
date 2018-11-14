Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564081F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbeKNKO3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:29 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:42337 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKNKO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:29 -0500
Received: by mail-oi1-f201.google.com with SMTP id s22-v6so8159600oie.9
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pzSH75vF8Pt4fUApXiNMhUdAF4OotqFSFPjKUaEZ3b0=;
        b=Zxm/M8t+AOHCMmeu+o/T9ZIHuRcuIA1/BsoUqNq/mlLPuOfNg6EIikrzK0YTyD8juy
         kQcS/ZhmMsUb1hiYuGz8S4k+l/KxXP3NTTmT+l7CnEaLgVpknA8yFbuGNF1mxgaX7CHQ
         8qcQpg8FhcXn1O16ckWdUeBjnABUUiQfEbDDPxci0phqQ+iqPWgQlPnxwqBJyzgDAUB8
         Mjd6x5kPlZWkQ95JKIH+U52Su1YUYQBA8IJUiFctrKgSkPnjv8DmAF82Z2sj5b4vuBa4
         HdrHzDCwzFFBtq8SgB3QVoGE3AXSJyY83Fg6ZE96U+/IF5VW7boncLiR7ijLTFJc4nsQ
         Kqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pzSH75vF8Pt4fUApXiNMhUdAF4OotqFSFPjKUaEZ3b0=;
        b=rIXzck02Ey+nQJKM+yMvwTqGROCidhMZNvODfcsJCdn82iKHBAU98y8B+22ba00pk/
         yo1P640HNCE08OLPXpaounuLyW4THXN696QJdwbdjblkTaVYu71xRWPVxqZCv16+icvj
         9Dlby5bYpM7Pc2QjgJgfb110Rx0QLLRQc9NDnSuhp1vEBgfgl+6BS1olrwn5O45EQQPv
         xyhTjqQuK/7xcw6bmAnaVUeXy6Wtew6STuBUg8Bejx3GbKcUokUK2XICQRRVoORE4QmS
         t3X/ldnpWiNVET62Wkd5N1Agrdu3nTfBa4WbQ6yV3Ka/TggczDW0AuhWxwIQlgfAOole
         eafg==
X-Gm-Message-State: AGRZ1gI/oLPTp3/vZzfVKQm5Xq03NFbbd+ZxrnDFNaNoK6RMsiUoRH0D
        kfmZJDynC6oR85DXtu2qrc6XpoHmSwQx
X-Google-Smtp-Source: AJdET5dDATkWpnTf7M9Iel2/WkRfsLg6Ts0mFATGaKdf+wufAQm1J5AZAqKr4OcRjSZo71OyKNc6jVAQCb6y
X-Received: by 2002:a9d:541e:: with SMTP id j30mr4974722oth.27.1542154426138;
 Tue, 13 Nov 2018 16:13:46 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:49 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-7-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 06/23] object: parse_object to honor its repository argument
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8e4b0b6047 (object.c: allow parse_object to handle
arbitrary repositories, 2018-06-28), we forgot to pass the
repository down to the read_object_file.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object.c b/object.c
index e54160550c..003f870484 100644
--- a/object.c
+++ b/object.c
@@ -259,8 +259,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if (obj && obj->parsed)
 		return obj;
 
-	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
-	    (!obj && has_object_file(oid) &&
+	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
+	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
 			error(_("sha1 mismatch %s"), oid_to_hex(oid));
@@ -270,7 +270,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 		return lookup_object(r, oid->hash);
 	}
 
-	buffer = read_object_file(oid, &type, &size);
+	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
-- 
2.19.1.1215.g8438c0b245-goog

