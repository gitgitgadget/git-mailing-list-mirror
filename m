Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A851FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 01:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbdC1BkH (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 21:40:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35134 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbdC1BkF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 21:40:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id p52so15262669wrc.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 18:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9Vs/AD0D02AzB22MtfaqriZRjeciYbsrBMAL/s+KXm0=;
        b=hEUoOFuR0/YzP0YDLYdxKFUypIXWkdXoR2n7bfhLgRJtZgCNNsh6VSrMxVtao/oUOG
         JMkKUWcYhhOftntUTy/CIA9vGvioIzxsr9jpwO5yrbpBWVBAAgmgg8FZcAybCwa6EExe
         C+n6qVlF8i0nHeJtFw7u7OZ2d2AedHlKX25lFuJp3ttTO1siQpIQ14gAxTHLURi638OH
         3lQoRJPwQ7jafEBuz4y9G8vSiQux+SRLkusE7gzDLsliOa+RwAt6WgMPUhVcqqU9rRjd
         IVEcoQRR6RM+dTV3t/9fDWWe4gBAnLALobr/APvDkVUARtg8GJZA9o3ikY3LruTlg+S5
         OS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Vs/AD0D02AzB22MtfaqriZRjeciYbsrBMAL/s+KXm0=;
        b=Eu0gb0GUOVkucnlzC7QwLqZ9FLEvmmZn4aB+IW3/5/FQf04D+Y5EAXIy+kR/O9SFZp
         QdMp2cHHBCP5RcB9H5yW7bqi09khJ043eqRVtP/p0YlXcpYhflhNphCRah1nse6mxxBv
         PSJkApoLdg/YV6PO0v5QJr6hoCtp8sW3mFVFlxBwcMNSCKSrD2F4qICCieE5ErmZhDwW
         JjYhlMkRbyjSCRgq2ZXZd5fPsWqK+MqJLI2YahPpNRwzlFHH8SZeJ7/HdqJQ9+WTaT91
         XQB5yGtp00J2ZCkvG9D+UkiSJavHV6GXsYLPzyquUPWqZJzzFKWlRDXP3M1qYn1VShfq
         mE/Q==
X-Gm-Message-State: AFeK/H3Q65VxnOevVXuHnlnvG4eZtJ84lz5cFStz26EacRJKhvkR3mddCbpJtMP2fUsFfg==
X-Received: by 10.28.19.207 with SMTP id 198mr11241841wmt.49.1490665198536;
        Mon, 27 Mar 2017 18:39:58 -0700 (PDT)
Received: from localhost.localdomain ([178.156.154.74])
        by smtp.gmail.com with ESMTPSA id u63sm1495889wmu.22.2017.03.27.18.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Mar 2017 18:39:57 -0700 (PDT)
From:   Robert Stanca <robert.stanca7@gmail.com>
To:     git@vger.kernel.org
Cc:     Robert Stanca <robert.stanca7@gmail.com>
Subject: [PATCH] [GSOC] get_non_kept_pack_filenames(): reimplement using iterators
Date:   Tue, 28 Mar 2017 04:39:45 +0300
Message-Id: <1490665185-11809-1-git-send-email-robert.stanca7@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replaces recursive traversing of opendir with dir_iterator.

Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
---
 builtin/repack.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 677bc7c..27a5597 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -7,6 +7,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "iterator.h"
+#include "dir-iterator.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -86,26 +88,21 @@ static void remove_pack_on_signal(int signo)
  */
 static void get_non_kept_pack_filenames(struct string_list *fname_list)
 {
-	DIR *dir;
-	struct dirent *e;
+	struct dir_iterator *diter = dir_iterator_begin(packdir);
 	char *fname;
 
-	if (!(dir = opendir(packdir)))
-		return;
-
-	while ((e = readdir(dir)) != NULL) {
+	while (dir_iterator_advance(diter) == ITER_OK) {
 		size_t len;
-		if (!strip_suffix(e->d_name, ".pack", &len))
+		if (!strip_suffix(diter->relative_path, ".pack", &len))
 			continue;
 
-		fname = xmemdupz(e->d_name, len);
+		fname = xmemdupz(diter->relative_path, len);
 
 		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
 			string_list_append_nodup(fname_list, fname);
 		else
 			free(fname);
 	}
-	closedir(dir);
 }
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
-- 
2.7.4




Hi , this is my first patch submission for Git Gsoc. I ran full tests and local tests with
prove --timer --jobs 15 ./t*pack*.sh .

Have a great day,
             Robert.
