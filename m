Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 614161F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeJaHDv (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:03:51 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:48782 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeJaHDv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:03:51 -0400
Received: by mail-vk1-f201.google.com with SMTP id q9so6424545vkq.15
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mE77VqErJkZ6tm2ocITNyv0qJQ5oZq2d/KqboojHHZI=;
        b=rE9MjU63Uzdt/rsobylJNu6DEk0xavu/RBbKPiWgAH8HXDX8erOWSI1+M6ggjuA+5V
         eeuI4cHIq076+wcILV/Q0wgMmUwJxcVXPzEypS0W2PD6azoIeNDzp0OK3g5sNxiJmQwD
         G+oU3CZCPPoWbB5zTnMRHPpUn0DQITOk85Q9bIq1OqGPdogWvtVPgv7XWHCr5lGK9tvD
         ZtxenC0+9BQtri0uq9vWzWbH+cd5d00ylqS2wjp6625DCWnOqRx+pV7USmNX0JEhbSPU
         Wr9K8WlkDLIrQCPjJZqniPIDxgmNOAq5akLwDaNA2YYJcDAfjITVWFpmsZESIOar86uG
         GD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mE77VqErJkZ6tm2ocITNyv0qJQ5oZq2d/KqboojHHZI=;
        b=kBKiGrr6SZ1T+U3+50NbQQLwhnIdmjpRSudC4ldEirzh4K+vlW0pdQi4DeyCfSMbQX
         M9Dxynny/M3BCvhpNigiWTcLySz2pmn7URJqNE1dx5+zCB8P7bCiGde1RvrxBhUJLpta
         72Rr4OTB6fvopPcM+spr2T/0gPRQAmsmdCEf2iZpCko/xxiLetJht8KHu+Mt2Br1JblR
         mgrWa6zKkdDtjbWSVkWg38SpAyfIwC82Q7gsjdfYxzgXz3otA7dO6fcPUWD8ffXDCSGd
         Ax48cyJmapOx4mvHyExyjf7/CDUFdN0pn8iPqIHz4eRTx9HJ7ubzUGyXZOSRJAOFZryY
         Xx8Q==
X-Gm-Message-State: AGRZ1gKWtuuPczla0TLGkkvQU2KS1kCkj683e2hEGy2R98/bgKlj6sqT
        0PJbIHrp0y0lIYrR4SV1LJEu4TwWohwxCFlUdchd98p5gzUZvxZvmOJDlUVhKlqTIiGxehfh9qe
        Wsff8wR11sCzqGqpY8kxpjET9WCWLHved+x+ech0smWqj9M0GcMg66mA9dMU0
X-Google-Smtp-Source: AJdET5dTIhrhdlNIrXF0I0YVKqlxyF8PwACqRe/oRGBhoOjgM5qNwuUxKD1ZrUWX9FzNTarka+qioLqXbV/B
X-Received: by 2002:a1f:fc0b:: with SMTP id a11mr488633vki.23.1540937315860;
 Tue, 30 Oct 2018 15:08:35 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:07:55 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 02/24] sha1_file: allow read_object to read objects in
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow read_object (a file local functon in sha1_file) to
handle arbitrary repositories by passing the repository down
to oid_object_info_extended.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1-file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..b8ce21cbaf 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1361,7 +1361,9 @@ int oid_object_info(struct repository *r,
 	return type;
 }
 
-static void *read_object(const unsigned char *sha1, enum object_type *type,
+static void *read_object(struct repository *r,
+			 const unsigned char *sha1,
+			 enum object_type *type,
 			 unsigned long *size)
 {
 	struct object_id oid;
@@ -1373,7 +1375,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 
 	hashcpy(oid.hash, sha1);
 
-	if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
+	if (oid_object_info_extended(r, &oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1414,7 +1416,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		lookup_replace_object(the_repository, oid) : oid;
 
 	errno = 0;
-	data = read_object(repl->hash, type, size);
+	data = read_object(the_repository, repl->hash, type, size);
 	if (data)
 		return data;
 
@@ -1755,7 +1757,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
 	if (has_loose_object(oid))
 		return 0;
-	buf = read_object(oid->hash, &type, &len);
+	buf = read_object(the_repository, oid->hash, &type, &len);
 	if (!buf)
 		return error(_("cannot read sha1_file for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
-- 
2.19.1.930.g4563a0d9d0-goog

