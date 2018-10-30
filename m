Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16F371F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeJaHEE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:04 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:53578 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbeJaHEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:04 -0400
Received: by mail-io1-f74.google.com with SMTP id z17-v6so12209503iol.20
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qLO1hb3VDzg+QvZCbuAypDEvdjntachOQbhLME79B8g=;
        b=VnfJXrSGRGzkWo0amkgwic87+ca7TgER2UKSQxtWv+0487dG5lU+Y+zc7vzLHpWNE4
         AActVO2SVpR8NxlUQNpE3OHRkzOSI99HVo0HamfIqM5pQJH9S+BNpAQY0Lo3dg4R7kb9
         EvITcefa0gVM0bj3ka5g3FF8feVsJ6AJN9hvFlz//OSj1PANGN+9bw5TkGa6BgT1jX8F
         MMivHX2EXEqCvNBEb5zHksn8Mr+RgxRz+UFiCNE/Do8gToP7vI01N8G2OaI2QLmsq5fQ
         ZDujtGYpP5nzoqW/M/sC0rycuNkmn26Bt+DYjlDo2XcfM6PhzhBuA3A9834FSiIXQo8L
         Odbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qLO1hb3VDzg+QvZCbuAypDEvdjntachOQbhLME79B8g=;
        b=NTZW0xPPJChSDPGIY815uPWeG6sJsO0zKaaQkgB7xKc4IRIWhCS6ouHOiyGYVWzLpI
         BXYB1a4o91Cl8NQTDAxhKZBSlsUKsFJWF754FHx3STm1fuXU1hDMz1Qby5eePb4/TmLB
         rAMqJrYciqa4jHLo14ITsqvQVJW4cnYEPUlKbQl31aFi6W7RyEfG69R9PW57dphQ4Kgy
         5uc2pJ3zkac9kKRZoYTTaIoy7bm8X7RjEtjDvb8AFZvf8+AL0ObcjAYHB7er1S4KdiNs
         EqPIUxK34h+pBOP3WCNE2gfPE/S0mU7DfwZPi9LpcJMOikSbXF34M9+6PVgvDs6uqwjd
         6P5Q==
X-Gm-Message-State: AGRZ1gKfcwx11xAMlkE9QGK0vmSPk9ZdMgwRkmWRhU7o0VT/0QkYZxNe
        9El4xI4K2qmzG4chsH/+lWq11Iw5D5w1K7jyaxMdk7s201FTdd6gzVnzqApsSdS75Cx88Teuivr
        YlKpiMB+GRHcpKaEZiH452G4OWkp9rJ66GRy5DLt5wVoSyeD7sGFfVmNv+lMw
X-Google-Smtp-Source: AJdET5c/lUMTquvrppsBEm3tQ2WDYgVg6Hgd8qu0yDaaCteMTlG3A80YVg98nBa0iz6u59T9jIIwXrkm93gR
X-Received: by 2002:a05:660c:8d1:: with SMTP id g17mr331927itl.1.1540937329082;
 Tue, 30 Oct 2018 15:08:49 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:00 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 07/24] object: parse_object to honor its repository argument
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
2.19.1.930.g4563a0d9d0-goog

