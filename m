Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139EE209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946827AbdEZDfm (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33146 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946754AbdEZDf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so43067366pfe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zl4+bcZySk6+hJQOkUEJD8OXJ2RrMHR/l/dqWiYZ1VI=;
        b=QdNsGr+irott5rqsc5XW+kQrfZID3JbV0GoH0UFqGaHnI318dBzvMynLw19q40JAJw
         1wY08/r438WMKv+v1yV5RAADpOq+rMQtmeCFODwDqtwn8B8nh8USP2QruYon6rxXgQbf
         W9VAWG+jJQfzRGPQ6tbd51UqUJH5PhF+OS4YpTj5VeECEQP4GbpGwaqfgAfPdTaJyDDP
         xyMDjkHYKB+fF4IzrtRzH2Z5oK0gheSugvAfOn756DSyncsCIjVEP7PfE5fsTIEdDWEs
         gnurAO2h3n99/JLaffBg7ZmHp4DAwzV5cv+zfZRGuCgKPqe115ciECAthQdqg3cqoZyd
         /uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zl4+bcZySk6+hJQOkUEJD8OXJ2RrMHR/l/dqWiYZ1VI=;
        b=uIV0FhrbrLz7UDovsJ7u2INxpB1VqPSPxEziDMLibfn+lCvmYpHzNcTOYC4+7RnIM4
         ssx3YfS5xh0KmGYMFUcGlB8J55m5UJJC0kATrIp3nm7Apmg/O0dOzX7JaYPtYheLQ5ok
         hfjHONKUFSEmYB+soSwKaHfSoVUYlA3gmL5dTUtQXQsMnvrlCSVgqPH6jLQ2enUE/Iqy
         Bg2Tc8J+p0xjSYaLGX0Mot9yUIcxSW3E0LENqJuqD5AAuPmkISMRDjNfwxJ/JTrD3+2i
         s6hV67tv+NG+0njYHUuU9QemSNayYqvBcct4x9ll1bHSzw3gDeu4GROauiUucbp6Lsy2
         n2rA==
X-Gm-Message-State: AODbwcB49je3IpBIE4MPBnrnOxNDkEJQkbXYIZ0knj5jpdfgGJKYaSyn
        XU/HSMnOjrqwKA==
X-Received: by 10.99.114.72 with SMTP id c8mr49067002pgn.81.1495769725812;
        Thu, 25 May 2017 20:35:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id e124sm15461499pgc.17.2017.05.25.20.35.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 11/13] log: fix memory leak in open_next_file()
Date:   Fri, 26 May 2017 12:35:08 +0900
Message-Id: <20170526033510.1793-12-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 26d6a3cf14..f075838df9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -842,8 +842,10 @@ static int open_next_file(struct commit *commit, const char *subject,
 	if (output_directory) {
 		strbuf_addstr(&filename, output_directory);
 		if (filename.len >=
-		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len)
+		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len) {
+			strbuf_release(&filename);
 			return error(_("name of output directory is too long"));
+		}
 		strbuf_complete(&filename, '/');
 	}
 
@@ -857,9 +859,11 @@ static int open_next_file(struct commit *commit, const char *subject,
 	if (!quiet)
 		printf("%s\n", filename.buf + outdir_offset);
 
-	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
-		return error_errno(_("Cannot open patch file %s"),
-				   filename.buf);
+	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL) {
+		error_errno(_("Cannot open patch file %s"), filename.buf);
+		strbuf_release(&filename);
+		return -1;
+	}
 
 	strbuf_release(&filename);
 	return 0;
-- 
2.13.0-491-g71cfeddc25

