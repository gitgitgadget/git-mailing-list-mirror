Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87AE71F51C
	for <e@80x24.org>; Sun, 20 May 2018 21:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeETVMV (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 17:12:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33703 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeETVMP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 17:12:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12-v6so9765351wmc.0
        for <git@vger.kernel.org>; Sun, 20 May 2018 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WB0ni9xqdn1TSoHgyPrWyjEABXozzoCVYnyhlEvPq3A=;
        b=X69uEuVBd+9AILX/l4vVs0OzzZ3E1ray5kFwq3fAehCdYJWiyEiWjzTNyShYEwFiY2
         zABSmtu/dA/cWPfmiuku7M3AvjoJQxAnRGQt8sSlvHo1Ee5BmgAU59DteUM0YXoSNmHm
         OmjBRUF2sTSp9pqmJ9Y+KS/j4gnaednaIAVuvywwm0ipMg5VWAvuBvOrp2taOWQ53rR+
         0t41tHWl0+Hs+F7KTMgFQEUdj6N+CASycY+g2SaTjDFfev8Vhmqx9kCXCndNphhT5aet
         wUxVYzmcGzzn/bPAYEMsObERsOm0GL7G5kc5oyg0NtAWjbNsj4FmAzf/F76N980UqT9d
         ltFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WB0ni9xqdn1TSoHgyPrWyjEABXozzoCVYnyhlEvPq3A=;
        b=lsa7wRt1g38/iQsw0UKg4Z+87u8P74cLTIeRqd4N0W0U4KayoGdAlMxl5rQ40uSLUx
         Y/uKwCjDzmQ7FiVqZJFZK+9dSk74PcNUJZRXyzS6iKlMXw074dKww4CzegZ/7coBRO5a
         MGUrUDpXPPLIW4L2rVfKNijOaAJWBO152mCQ69WISafmxooq/8LNJ7tY2zDOEFi3+4eQ
         5RMZ/bws4xNzFNdSCZchW8CmAEnVmJ3XoeIygagPjkMgsBnZpRK7xX+91vfSfjAmoRjZ
         tiGf/xmUQ92hlF7UEfQRuQg4BczOYrlNEZMl1pjqVOtvLnQ9G3PHvqO4Rdd700H2kZbo
         fsLA==
X-Gm-Message-State: ALKqPwfMy/gyUo7/XpUfjJoBqjXxiwPTFUwxcHRx5jwvY2RoNebccPKd
        vUssRtCkwxVdNQ0PnNGpzKZFoGvf
X-Google-Smtp-Source: AB8JxZr9inNp4F+LmWKJGJBSFNALoH727qqIn0WeU8jmu7/ccTRZWYZURamTIsFDapcYxOd+dxo63g==
X-Received: by 2002:a1c:87d4:: with SMTP id j203-v6mr8793203wmd.119.1526850733988;
        Sun, 20 May 2018 14:12:13 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r10-v6sm1930799wrn.6.2018.05.20.14.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 14:12:13 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/PATCH 4/7] rerere: fix crash when conflict goes unresolved
Date:   Sun, 20 May 2018 22:12:07 +0100
Message-Id: <20180520211210.1248-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.588.g4d217cdf8e.dirty
In-Reply-To: <20180520211210.1248-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
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

To fix this, remove the rerere ID from the MERGE_RR file in case we
can't handle it, and remove the folder for the ID.  Removing it
unconditionally is fine here, because if the user would have resolved
the conflict and ran rerere, the entry would no longer be in the
MERGE_RR file, so we wouldn't have this problem in the first place,
while if the conflict was not resolved, the only thing that's left in
the folder is the 'preimage', which by itself will be regenerated by
git if necessary, so the user won't loose any work.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I realize the test here may not be as complete as we would want it to
be.  But I first wanted to get some feedback on the approach, before
spending too much time on a proper test (I did test it manually, and
the test does show that the original problem is fixed, but it probably
deserves some cleanup).

 rerere.c          | 12 +++++++-----
 t/t4200-rerere.sh | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/rerere.c b/rerere.c
index a02a38e072..49ace8e108 100644
--- a/rerere.c
+++ b/rerere.c
@@ -824,10 +824,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
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
@@ -835,7 +832,12 @@ static int do_plain_rerere(struct string_list *rr, int fd)
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
index eaf18c81cb..27f8afc0b4 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -580,4 +580,29 @@ test_expect_success 'multiple identical conflicts' '
 	count_pre_post 0 0
 '
 
+test_expect_success 'rerere with extra conflict markers keeps working' '
+	git reset --hard &&
+
+	git checkout -b branch-1 master &&
+	echo "bar" >test &&
+	git add test &&
+	git commit -q -m two &&
+	echo "baz" >test &&
+	git add test &&
+	git commit -q -m three &&
+
+	git reset --hard &&
+	git checkout -b branch-2 master &&
+	echo "foo" >test &&
+	git add test &&
+	git commit -q -a -m one &&
+
+	test_must_fail git merge branch-1~ &&
+	git add test &&
+	git commit -q -m "will solve conflicts later" &&
+	test_must_fail git merge branch-1 &&
+
+	git rerere clear
+'
+
 test_done
-- 
2.17.0.588.g4d217cdf8e.dirty

