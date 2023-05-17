Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7902BC7EE22
	for <git@archiver.kernel.org>; Wed, 17 May 2023 21:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjEQVKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQVKm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 17:10:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D5655A9
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:10:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64cfb8d33a5so258969b3a.2
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684357840; x=1686949840;
        h=mime-version:user-agent:message-id:date:cc:subject:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRehayxZ9PuKq9fyZHs/Qp5ak09d6w8ugEE2QmZLuRk=;
        b=oVzptOXFeEmNYps9ru9eocT9vpsG1JwoIlHb92faU5awDZ3OXW+L87Fw91dvwKNVSm
         Wx7NDTpj7lpele6Tt3OxPk6qBV/HKIvhL1tGoKltJx63uDsJIQQhE865l6RVJ5QX569e
         tq09iydDJXmoMdoVecC+pcbZWc7JEVTCyCL4QOgW/0ceaLcvwlpUamrTDUM2tWdDWeA2
         B0dnQtpooZIdvoV5Xe6zTSBapZTqNUNwOXf/xc1NDUWUaaKDXR+tsQen2LTx7zrlkXSA
         Di7W9gE3dWef3TYabSBQ8ZSiZne5Y2XJiLErZB4UtNovQeTZyBgwFxL+NUc/IXik/DBf
         p8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684357840; x=1686949840;
        h=mime-version:user-agent:message-id:date:cc:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRehayxZ9PuKq9fyZHs/Qp5ak09d6w8ugEE2QmZLuRk=;
        b=NQtggt+oMxdM4MpwlwXC13il2hZaWE39a6WALlHpndjyQVJDd3wkrAOxt15/LYaPd7
         sgpyDMTtSoaFWBO4hSY1FivDf0SHWosrxwYzJt518KcnXweIwIuSczIz/1cTES3hl/vD
         2gghXCxLU/fHZRIWLWW8JCsTxpBTdAHzcsfpkgdn4pG4W7B1eUDl3IvsxILMLyQLa3Jy
         lcTNwVmG4gz3QNfANT6MW85QUdQfM/ie0I0xQgsvbE+0rI+zpvi+94dVEcnl/sSw3b+B
         4hcbosDoxZgwl5GDa0yLRIuJ3PnE9wRLaxkSv+MvSyJqtEsJOCTHu7k4Ni+6CMHCf7xF
         fArQ==
X-Gm-Message-State: AC+VfDyqIJ810k+hT/GWQKz7+RsbHLUOoq6ZyNKEW+sk3SBtyackJjUz
        V2DyNBqOkDxXH0OO+DQvW0iTKZdmJZc=
X-Google-Smtp-Source: ACHHUZ66bozQsLOBDf96LX117+fVTCkEz241pCU9FqcSJO4yKPrcWD1JmZFuVwN+y6xmiL5LRYJM1Q==
X-Received: by 2002:a05:6a00:2185:b0:64b:f03b:2639 with SMTP id h5-20020a056a00218500b0064bf03b2639mr1361557pfi.22.1684357840293;
        Wed, 17 May 2023 14:10:40 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b005aa60d8545esm15560561pfo.61.2023.05.17.14.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:10:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] send-email: clear the $message_id after validation
cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Doug Anderson <dianders@chromium.org>,
        Emily Shaffer <nasamuffin@google.com>
Date:   Wed, 17 May 2023 14:10:39 -0700
Message-ID: <xmqqzg62oe9c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently git-send-email started parsing the same message twice, once
to validate _all_ the message before sending even the first one, and
then after the validation hook is happy and each message gets sent,
to read the contents to find out where to send to etc.

Unfortunately, the effect of reading the messages for validation
lingered even after the validation is done.  Namely $message_id gets
assigned if exists in the input files but the variable is global,
and it is not cleared before pre_process_file runs.  This causes
reading a message without a message-id followed by reading a message
with a message-id to misbehave---the sub reports as if the message
had the same id as the previously written one.

Clear the variable before starting to read the headers in
pre_process_file.

Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with a minimum test.  I eyeballed what variables are
   assigned in pre_process_file and it _appears_ to me that most of
   them are cleared in the function before it processes one file
   (except for $message_num that gets incremented per invocation for
   obvious reasons---and it does get reset to 0 before the real loop
   calls the function before sending each message).  So $message_id
   may indeed be the only one that needs fixing.

   But that can hardly qualify as an exhaustive verification X-<.

 git-send-email.perl   |  2 ++
 t/t9001-send-email.sh | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 10c450ef68..37dfd4b8c5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1768,6 +1768,8 @@ sub pre_process_file {
 	$subject = $initial_subject;
 	$message = "";
 	$message_num++;
+	undef $message_id;
+
 	# First unfold multiline header fields
 	while(<$fh>) {
 		last if /^\s*$/;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 36bb85d6b4..8d49eff91a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -47,7 +47,7 @@ clean_fake_sendmail () {
 
 test_expect_success $PREREQ 'Extract patches' '
 	patches=$(git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1) &&
-	threaded_patches=$(git format-patch -o threaded -s --in-reply-to="format" HEAD^1)
+	threaded_patches=$(git format-patch -o threaded --thread=shallow -s --in-reply-to="format" HEAD^1)
 '
 
 # Test no confirm early to ensure remaining tests will not hang
@@ -588,6 +588,21 @@ test_expect_success $PREREQ "--validate hook supports header argument" '
 		outdir/000?-*.patch
 '
 
+test_expect_success $PREREQ 'clear message-id before parsing a new message' '
+	clean_fake_sendmail &&
+	echo true | write_script my-hooks/sendemail-validate &&
+	test_config core.hooksPath my-hooks &&
+	GIT_SEND_EMAIL_NOTTY=1 \
+	git send-email --validate --to=recipient@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches $threaded_patches &&
+	id0=$(grep "^Message-ID: " $threaded_patches) &&
+	id1=$(grep "^Message-ID: " msgtxt1) &&
+	id2=$(grep "^Message-ID: " msgtxt2) &&
+	test "z$id0" = "z$id2" &&
+	test "z$id1" != "z$id2"
+'
+
 for enc in 7bit 8bit quoted-printable base64
 do
 	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '
-- 
2.41.0-rc0-4-g004e0f790f

