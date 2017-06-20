Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8294320D11
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdFTH4i (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35058 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdFTH4e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id d64so21286599wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dEoM6dhtvcJoKvimYSLqZlSzne5e3GNxzfzBcfII5MI=;
        b=MAOmZn4qoo2iHpE7Xu3mvOiJWz1L0xZfCzS9hQA97i38xBxn9f9EGIQB8KhfrOuCRQ
         K0Yp5gi183fEURENmn9CfNCtDnE7zjQY+PpM9pAmevnNHEGqq+1DuYOXcv6k/thXcci+
         2DBvcP21Pwjo/PkX1drTcvABadsATfy7L3W270msKvW1095CP6Zrp7R5e4gUhqORyURR
         j9wLw4tBUUB5vCs4jEWGrKauFDEWUfAy+CX9zk8WjmMSL1J6Xun8CermfcFlWoIyVwLv
         HQUZTyfl9Bk8I2AEEvbwFUm/MtkOe6GbHQitNDqbQwTnoP07/m1frghcYVReN0uVlELE
         a1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dEoM6dhtvcJoKvimYSLqZlSzne5e3GNxzfzBcfII5MI=;
        b=HU1uXFgSdbYgGEvUcCPVaB9gcOIMdMsykYl/3Hfs3TOI6WFlsERia3bw2UsS16nH31
         3vpNSuWrd6jrDz8pO4LT48IxEzorFEJ80QDBKBRJE8GNNVNCZbmrOTUvR+s9zrKVhYaD
         KvNRukwQhNuUc2iBbJxQOQIDcW8Al6GwOCThPWfSjoTfRWQh0r3/AatzONSK+nm380Bu
         yhYcx3/rNDoIohTu5Ou3+SJF6Ew1TmeApfOb5rzD6MtuuctE1nI9KYrb2jX8eGybjXB1
         XJ28c0FWl0DiqooiwNtxznq1FJROAUWCWHwdNVL3juG5K3EFv9/iYoq5j3Ivcaxo2vIw
         1uXA==
X-Gm-Message-State: AKS2vOwRuxYjpDFHGgiE0mhlBrN5LHAXCjaBzzEec6TnY00Fd+N0rydq
        +CjSKcFox5HpaI4T
X-Received: by 10.28.207.133 with SMTP id f127mr1651825wmg.84.1497945393366;
        Tue, 20 Jun 2017 00:56:33 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 34/49] odb-helper: fix odb_helper_fetch_object() for read_object
Date:   Tue, 20 Jun 2017 09:55:08 +0200
Message-Id: <20170620075523.26961-35-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index 910c87a482..0017faa36e 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -584,15 +584,19 @@ int odb_helper_fetch_object(struct odb_helper *o,
 			    const unsigned char *sha1,
 			    int fd)
 {
-	switch(o->fetch_kind) {
-	case ODB_FETCH_KIND_PLAIN_OBJECT:
-		return odb_helper_fetch_plain_object(o, sha1, fd);
-	case ODB_FETCH_KIND_GIT_OBJECT:
-		return odb_helper_fetch_git_object(o, sha1, fd);
-	case ODB_FETCH_KIND_FAULT_IN:
-		return 0;
-	default:
-		BUG("invalid fetch kind '%d'", o->fetch_kind);
+	if (o->script_mode) {
+		switch(o->fetch_kind) {
+		case ODB_FETCH_KIND_PLAIN_OBJECT:
+			return odb_helper_fetch_plain_object(o, sha1, fd);
+		case ODB_FETCH_KIND_GIT_OBJECT:
+			return odb_helper_fetch_git_object(o, sha1, fd);
+		case ODB_FETCH_KIND_FAULT_IN:
+			return 0;
+		default:
+			BUG("invalid fetch kind '%d'", o->fetch_kind);
+		}
+	} else {
+		return read_object_process(o, sha1, fd);
 	}
 }
 
-- 
2.13.1.565.gbfcd7a9048

