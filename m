Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204D020A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbeLOAJt (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:09:49 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:44239 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:09:48 -0500
Received: by mail-pl1-f202.google.com with SMTP id b24so4696512pls.11
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RnV5H1Ni8WnGohtGXcw8YDUBD8u8JlncOSimCee42yw=;
        b=wS2csN46jvHL1QqNMbZu+sItmM02pcHWMkVzjnmU8UQ45tKVX0SBNjy5uhiIslMfwF
         SPlGhW5Dc25znCyKN3xog6KoD6IXKwpzRjFL52/qcnd9Vs5HuK1wqBCPi2UXDBC00JKB
         OANieiQC2Na3Gu8I/DMZzjr3GzRmNZOOS2Iw/S2565J5p5budx7th4vE8QwHQJUvjws+
         3RTZlf59vPTP3ZCKpkJyTpIJ/AsQLzQWrqGRQ6sRYYLZ/xy/C3GfP6OP+El9frvvrjeS
         y0FDWaQ+aO6oJ6RcvjJ9bknDwCIdLaa8ExPl1V8zGYaqOo74lIuJs79awUkDs2FFzZLe
         yTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RnV5H1Ni8WnGohtGXcw8YDUBD8u8JlncOSimCee42yw=;
        b=Zkv8lpM5K+20IZcrxGAthFQ/CSFHsw6t0vVCI6BoqfQAH4l1hg6SiJKAjCxBpSCzID
         KuJu2yNicwaQdkg6fRzkbG4hXs2p3qul/mBGdJhFvaNdHm50Podzi7D5s0A65e1/PtEi
         ue0ElDbpVhlMWavtvFMVfw9FKi/Uz2vxTZYMIqaSMCs3sINxzmeDSFCzvd7H7S7wHp0G
         6TGbqRpd3PXvwUIGUWlScxNOJtckp8ITN7mcBG3T/9Z3lM1cYcyVp/CN4d18RpH9BQHV
         wDLy5uxCSAPP0SqM+jZDHW0miAHTDW4uKVdHHR2gwEyTngGpo/kRpsrC7KHplc8Q//85
         lFVg==
X-Gm-Message-State: AA+aEWZK04uYbaqYKPSsrx8lS7sH4a6d0p9+oufhjm606eK6ColHUVd1
        iCjIBwpub7jcMKZMPcxcWrignn385TuhP+OY6aheuQAbRhrob/vexz0hF1ZpPrvKVsc7e2HC2N/
        fsaMabU+e6fnf/totQY/pbTJ+YnGMSrXlVTYWRPhEs93V5ilnK7in2/A0h+dr
X-Google-Smtp-Source: AFSGD/XZ5ZtqNpEtuETwFeZU1o0mRFlSnLQ7XJ6yjZLgofQu3Tke4oP0k0+OlCmjQP8KP/XzTQ+1SuplJbGw
X-Received: by 2002:a62:d70e:: with SMTP id b14mr2792124pfh.86.1544832587718;
 Fri, 14 Dec 2018 16:09:47 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:20 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 01/23] sha1_file: allow read_object to read objects in
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
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
2.20.0.405.gbc1bbc6f85-goog

