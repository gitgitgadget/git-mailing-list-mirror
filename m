Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64ED51F933
	for <e@80x24.org>; Sat, 14 Jul 2018 21:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbeGNWFZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37817 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeGNWFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so12351814wmh.2
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gXtGvf9zVaFjMg2V8uyDhOWhjF/ACdwxgUEkxMChyI=;
        b=Zhj5puh/ypQ5wJeAUsUxHGsLSLb0d8Xvs/9b0X2gwtVEv5a4HDOgV/IFix/3FQTthO
         Cm0R92c8AMFoQ648n1f7vq+9ekPrnRVOMGP4q+v620j8z9L6cHidtenDXJ/cFNl5tk7j
         fZrSKI+UfIIF8EjsG+hEXb3wdvKzdcOu6mWSU6RoCeJIM4Yn4lWbvuQu8Ra7zh3ytnz0
         Sj7UCGwxOIyk+mZP1s5VgtUwwzlIINo7I76wgtU7znuoSdkix3Tgr7veKGHc0Sy2jVMC
         N5ADOBuOYYe/BwoTBZGffvmlRBnHzZuHikwO6wU7thJOYelUaGVL1hw+yF36NBqAU7Xk
         TJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+gXtGvf9zVaFjMg2V8uyDhOWhjF/ACdwxgUEkxMChyI=;
        b=gShdtXDleYAGT8/6DVeGt+6aq7fYti688h4hT+oAGO6T+sbZnCSCROLnh5HW7xV4a9
         3SdPBQl0IBJw+Kd8k9rGAkUSRGR2d3yiAkU+Vu3nseuMkGzpjyRmGZpV1PjUnQwnB2sE
         MBy1DbkFdRrmIKNuRsgjTpBpQaAtuxxnxBZ18Ghk1O7pNQPT4eVcoWfTW3VgYOqMY0I1
         UC+R8u/SI9gMC4629pdQQ2BgKudJcQyScAz5fSHA2B2ZxoGcszUP/AXg4CUaUgNXZaZB
         yoAmxG5IrHqIPhwMLNcpyusb/j1frKZda/cgN8AJVLuZjCXK44B0pZUmdSrvsb9NxibE
         6ypg==
X-Gm-Message-State: AOUpUlGedGM4t7Eb1gaw19OUHy40yLwF7CdskERuOSuAXOBaDxmxJLJZ
        sgGOeEMibKYSxaTNNc5BZ6y7nxT2
X-Google-Smtp-Source: AAOMgpdMwzmLcLPr/efWhYU7dpCa/MYU4/6zxn7u7UVuVBa5juiemuEtpFkS5XK8onLCwaF3YNGh0Q==
X-Received: by 2002:a1c:afd4:: with SMTP id y203-v6mr6244511wme.55.1531604698319;
        Sat, 14 Jul 2018 14:44:58 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id g15-v6sm20553559wrh.48.2018.07.14.14.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:44:57 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 06/11] rerere: fix crash when conflict goes unresolved
Date:   Sat, 14 Jul 2018 22:44:38 +0100
Message-Id: <20180714214443.7184-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when a user doesn't resolve a conflict in a file, but
commits the file with the conflict markers, and later the file ends up
in a state in which rerere can't handle it, subsequent rerere
operations that are interested in that path, such as 'rerere clear' or
'rerere forget <path>' will fail, or even worse in the case of 'rerere
clear' segfault.

Such states include nested conflicts, or an extra conflict marker that
doesn't have any match.

This is because the first 'git rerere' when there was only one
conflict in the file leaves an entry in the MERGE_RR file behind.  The
next 'git rerere' will then pick the rerere ID for that file up, and
not assign a new ID as it can't successfully calculate one.  It will
however still try to do the rerere operation, because of the existing
ID.  As the handle_file function fails, it will remove the 'preimage'
for the ID in the process, while leaving the ID in the MERGE_RR file.

Now when 'rerere clear' for example is run, it will segfault in
'has_rerere_resolution', because status is NULL.

To fix this, remove the rerere ID from the MERGE_RR file in the case
when we can't handle it, and remove the corresponding variant from
.git/rr-cache/.  Removing it unconditionally is fine here, because if
the user would have resolved the conflict and ran rerere, the entry
would no longer be in the MERGE_RR file, so we wouldn't have this
problem in the first place, while if the conflict was not resolved,
the only thing that's left in the folder is the 'preimage', which by
itself will be regenerated by git if necessary, so the user won't
loose any work.

Note that other variants that have the same conflict ID will not be
touched.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c          | 12 +++++++-----
 t/t4200-rerere.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/rerere.c b/rerere.c
index da1ab54027..895ad80c0c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -823,10 +823,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		struct rerere_id *id;
 		unsigned char sha1[20];
 		const char *path = conflict.items[i].string;
-		int ret;
-
-		if (string_list_has_string(rr, path))
-			continue;
+		int ret, has_string;
 
 		/*
 		 * Ask handle_file() to scan and assign a
@@ -834,7 +831,12 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * yet.
 		 */
 		ret = handle_file(path, sha1, NULL);
-		if (ret < 1)
+		has_string = string_list_has_string(rr, path);
+		if (ret < 0 && has_string) {
+			remove_variant(string_list_lookup(rr, path)->util);
+			string_list_remove(rr, path, 1);
+		}
+		if (ret < 1 || has_string)
 			continue;
 
 		id = new_rerere_id(sha1);
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 8417e5a4b1..34f0518a5e 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -580,4 +580,26 @@ test_expect_success 'multiple identical conflicts' '
 	count_pre_post 0 0
 '
 
+test_expect_success 'rerere with unexpected conflict markers does not crash' '
+	git reset --hard &&
+
+	git checkout -b branch-1 master &&
+	echo "bar" >test &&
+	git add test &&
+	git commit -q -m two &&
+
+	git reset --hard &&
+	git checkout -b branch-2 master &&
+	echo "foo" >test &&
+	git add test &&
+	git commit -q -a -m one &&
+
+	test_must_fail git merge branch-1 &&
+	sed "s/bar/>>>>>>> a/" >test.tmp <test &&
+	mv test.tmp test &&
+	git rerere &&
+
+	git rerere clear
+'
+
 test_done
-- 
2.17.0.410.g65aef3a6c4

