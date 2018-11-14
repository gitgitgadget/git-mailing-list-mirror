Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F161F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeKNKOR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:17 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:32864 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNKOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:16 -0500
Received: by mail-vs1-f74.google.com with SMTP id t25so6275490vsk.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jwIa1zFDXQD9Y2fwo2/hJ0BhA1b0pg6o98pFDlcBpw0=;
        b=Jd99LbtE5PUc1nBCg/oKQGstCd+rO+JbNddXtfCF+1JogNltyIcM8ICRLCb+B+5Xkk
         0hcj8aan058mOTz6i6fPkY/9Ss/gVS12AsU6zRizUxf7SFnKkWbnl+WhMSDI9PlyiDUV
         kreQ5zoLAlbv+rhWmmQU2hY7lYSL975++hRdnSJd+7rxO0EIl4Vru4Gw217PgZdgjEM6
         UlguO0YJHs6iSeITBK9Z55a049CXvOrxatRDqe1Lvb84BYUR42gTwkoPkSZX9+T6Fk46
         60dp0buTjI1ZBD018FK3JiDV/UPMU9/PIpTLTuWfgu/4If5VClCExv5tE8sklB8HI+3d
         z3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jwIa1zFDXQD9Y2fwo2/hJ0BhA1b0pg6o98pFDlcBpw0=;
        b=pXlr3imEIk9eSPalHLga/NzsvkHBUnRwfB8Ns0bcBc9KWzXDOyiM1Oi2YpTKKIzYav
         YBSZwoCySF4rH6sS7NI7Mr9yHxGUcuwXfDo+bZTmFqbLHyxABSgCvh74oveXpdw+IW79
         4MSTDJQpkmO0jiZhDLAayDGo3/RQKL/lAgqciX5DTbP7lIID0LiTm/ImqGHNbatrXf9j
         Y0cLFnfXNJuw+m625R3h32fkpJfgUZF5wSCJWJfAMzaKmk33GtuybiG9vQT001SFcELR
         wJIlPegJuK3Cv84RT9n/dgmvGpNje4sPw3SP9oiEc7NkafpCFwklMaPAbBNZD52RXZqB
         jiDw==
X-Gm-Message-State: AGRZ1gJIPq38Qgtaq9kRrEN+nQFcLidzEidq5iaY9imkjl8fwexqphgP
        bnOCdgGaXOc/Ef0+90GxDu58E79Ty7X/
X-Google-Smtp-Source: AJdET5cNmu8+HlcLd0SD9b+grSoi5qf2I/n3wLXvC6mdFQyNJqHyM3p8Eun8q7wUsxT3mC4gxiDp9/r6AHdu
X-Received: by 2002:a1f:9d53:: with SMTP id g80mr6043887vke.3.1542154413357;
 Tue, 13 Nov 2018 16:13:33 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:44 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 01/23] sha1_file: allow read_object to read objects in
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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
2.19.1.1215.g8438c0b245-goog

