Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41687C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiHJPqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiHJPqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:46:31 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3935166111
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:29 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id p132so18120337oif.9
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N6/+v7YsIIoNLmYY9A8UKjHmigNtTr/t21qDINvV20s=;
        b=XKVKFoAI2A/We6A4VW4mYJbTkhAyVQa8dm9ClAsHzsm0AnsltCUUoPGYrZHKTHUfA2
         gmp4DzpzETCKkSU31TK/xS1xsPfcowxw3KLWSAjHOEM95mgB/pCO5rJoTsj7BmaVNyYU
         LM7u51ZTvkhPUOxQPXFN1sO51jtmedTG2UmYT8Kdz8t6ZUq4hppuhyhICFVYhNL8Rnlf
         aU3NumPCZiBeDbsM2ODQqVEhMBQGDwoJwP/eMOTDnkiqJJExib5s1zsXWMNCJ8nd9fFE
         TZ8bJppHXWFHw9dISfhN/+dyUZsBu3gze5weoRK5hMnevr5PorU7x2khxSIkSqTsMALs
         sqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N6/+v7YsIIoNLmYY9A8UKjHmigNtTr/t21qDINvV20s=;
        b=Q7UwyCf8AUXDlKrZB0IyBDOaB7RApge7GtpUCClEIKPNeu5BrzqaRGZiFU4zM3NzCR
         2y2S5NZQiH+wNecaAQ5LBmSiS7pMJf/uxZL0EB/fDBmCgT2WhfFcD1bgfbg9Q94XGH8A
         4pTQXh0Mg/WI7F394FuB2OSnzayVWDt/XJR+coYoYTtolGeGZu0Sn3TNrkP8GYZ4xlRi
         NdNO+6hRejJ9UiurVtehjD1GO5jlZtOjTM6cb6FFpKpgxnsXM6NMv+FadNyQ/yNG2KA1
         +MpQ5cCtOiYXhF7kwCGQNJOUOJM4bVPjoSBe3bhEnnIk+/lB7UQxSuI4Nt2bmcOjXmia
         NyZg==
X-Gm-Message-State: ACgBeo2Qg+kIJ171OcAIV+p21yF/PD/QXzUqwKgwlO5qNz6rwzcExfIV
        6kAll1HJDu2Pq4yBDPg5j91mZgEYMLQ=
X-Google-Smtp-Source: AA6agR4Hr4UvdevJc47rXjoYNUVoekKAm/WpP0ncKq9OZg2NBsnWOClG31DYr0gebPVNJwciHgx3SQ==
X-Received: by 2002:a54:4e8d:0:b0:325:988d:afaf with SMTP id c13-20020a544e8d000000b00325988dafafmr1589131oiy.135.1660146388141;
        Wed, 10 Aug 2022 08:46:28 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h12-20020a056870538c00b0010e00041996sm3862718oan.14.2022.08.10.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:46:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 5/7] mergetools: vimdiff: rework tab logic
Date:   Wed, 10 Aug 2022 10:46:16 -0500
Message-Id: <20220810154618.307275-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810154618.307275-1-felipe.contreras@gmail.com>
References: <20220810154618.307275-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we treat tabs especially, the logic becomes much simpler.

Cc: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 50 ++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 2ecac41231..8334871417 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -66,11 +66,6 @@ gen_cmd_aux () {
 	debug_print "LAYOUT    : $LAYOUT"
 	debug_print "CMD       : $CMD"
 
-	if test -z "$CMD"
-	then
-		CMD="echo" # vim "nop" operator
-	fi
-
 	start=0
 	end=${#LAYOUT}
 
@@ -144,11 +139,10 @@ gen_cmd_aux () {
 
 	# Step 2:
 	#
-	# Search for all valid separators ("+", "/" or ",") which are *not*
+	# Search for all valid separators ("/" or ",") which are *not*
 	# inside parenthesis. Save the index at which each of them makes the
 	# first appearance.
 
-	index_new_tab=""
 	index_horizontal_split=""
 	index_vertical_split=""
 
@@ -182,14 +176,7 @@ gen_cmd_aux () {
 		then
 			current=$c
 
-			if test "$current" = "+"
-			then
-				if test -z "$index_new_tab"
-				then
-					index_new_tab=$i
-				fi
-
-			elif test "$current" = "/"
+			if test "$current" = "/"
 			then
 				if test -z "$index_horizontal_split"
 				then
@@ -219,14 +206,7 @@ gen_cmd_aux () {
 
 	terminate="false"
 
-	if ! test -z "$index_new_tab"
-	then
-		before="-tabnew"
-		after="tabnext"
-		index=$index_new_tab
-		terminate="true"
-
-	elif ! test -z "$index_horizontal_split"
+	if ! test -z "$index_horizontal_split"
 	then
 		before="leftabove split"
 		after="wincmd j"
@@ -333,7 +313,21 @@ gen_cmd () {
 
 	# Obtain the first part of vim "-c" option to obtain the desired layout
 
-	CMD=$(gen_cmd_aux "$LAYOUT")
+	CMD=
+	oldIFS=$IFS
+	IFS=+
+	for tab in $LAYOUT
+	do
+		if test -z "$CMD"
+		then
+			CMD="echo" # vim "nop" operator
+		else
+			CMD="$CMD | tabnew"
+		fi
+
+		CMD=$(gen_cmd_aux "$tab" "$CMD")
+	done
+	IFS=$oldIFS
 
 
 	# Adjust the just obtained script depending on whether more than one
@@ -565,12 +559,12 @@ run_unit_tests () {
 	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
-- 
2.37.1

