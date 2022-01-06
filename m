Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE37EC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 15:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiAFPDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 10:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbiAFPDF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 10:03:05 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB7C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 07:03:05 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id m25so2499910qtq.13
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 07:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAK5Fovq0x8VwpI9SzF3DtoApBum4VGQqGC0ApO9LHQ=;
        b=RrzEedFfa0lGhNQdug99qnTELNHlROfSSI0QaHfgQmt9e7Fir3EHRnRFjrl8LmG3eg
         471ajQjNoGpEBqbYZIXh9RFphCsmiz48v/XC+rd9TRsW3pcFb3zIu92/ZOyg9nmWxidB
         anpP8EQzxeXiZcQNBvBF8yJgL9XQVMYDz/gEKyVn8LC7YVj4S2KgsukxiLgh78YUWrR8
         XLy4i1XXdXsaiDG6ffZY477oq2JcRryqporZYoFd+X7XUDesYy3ZNC2XxqSB30XYCaRB
         /bi9UmRJG8SWn7NHUnrmIolszaGcyO/CVgQre5/LrCbaHbceigKWzijYzs7KbMDwoAwO
         fTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAK5Fovq0x8VwpI9SzF3DtoApBum4VGQqGC0ApO9LHQ=;
        b=mEDWXdu8c8XNc+sy1IPXOT+1TzFUFjv1xQSOrvplIogWSMgVbCj+DOKwhB/giQU6DF
         PdMfTiv/yg17j/D3RIQwpPAOWGW/Mtb3okRixhc9FXdzTe1kKllCi4PsfD/ct5lpX+uL
         90aOlkdBPjt/EFiFebMvGOrCozso/rmFGXwmgJnwbGW/JnIipyY52BtymZS4gzSG4+vz
         nfJtKGyXTI734HfkLjTnYg94jMFx+/MQ6YgFc1xe5yKZ7EKKADLAUe10XqaxOZoVv6YL
         0NuINizgp9OJL4X6yXQPWQ4SJe857Nlte6H7BrRbsvNZRvo78RJbEjkJ0oM6XPY9BTYl
         YSmg==
X-Gm-Message-State: AOAM530zuP9gSKjmZFo3IGjhm8PnJreIxqTodThsq6dO0W4flmE5wwQZ
        oX+mkRKFVmhYVmBd/r6GMbYz8e5D883BsQ==
X-Google-Smtp-Source: ABdhPJys2kyf2W7m/A3Op6gfClN+ajZFZJMmL10BHJtaIGwm2JADb2m0tNn8jrf37ioQMBwRQsfThA==
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr51978778qtk.351.1641481383935;
        Thu, 06 Jan 2022 07:03:03 -0800 (PST)
Received: from Johns-MBP.myfiosgateway.com (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id r15sm1579113qtm.55.2022.01.06.07.03.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Jan 2022 07:03:03 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     levraiphilippeblain@gmail.com, phillip.wood123@gmail.com,
        John Cai <johncai86@gmail.com>,
        "Tilman Vogel" <tilman.vogel@web.de>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v3] builtin/pull.c: teach run_merge() to honor rebase.autostash config
Date:   Thu,  6 Jan 2022 10:02:26 -0500
Message-Id: <20220106150226.77458-1-johncai86@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a git pull --rebase, if fast forward is possible we run merge.
However, merge will not honor rebase.autostash if it is configured. This
has the unfortunate result of

$ git config rebase.autostash true
$ git pull --rebase

to ignore the rebase.autostash value.

Allow run_merge() to honor rebase.autostash by passing in
config_autostash if --autostash or --no-autostash flags are not
explicitly set.

Reported-by: "Tilman Vogel" <tilman.vogel@web.de>
Co-authored-by: "Junio C Hamano" <gitster@pobox.com>
Signed-off-by: "John Cai" <johncai86@gmail.com>
---

Notes:
    Fix a bug that prevents git pull --rebase from honoring the rebase.autostash
    config value.

    Changes since V2:
    - fixed Junio's email in trailer

    Changes since V1:
    - used simpler fix as proposed by Junio
    - removed redundant test cases

 builtin/pull.c          |  9 ++++++++-
 t/t5521-pull-options.sh | 12 ++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 100cbf9fb8..8423e420ee 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1133,7 +1133,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("cannot rebase with locally recorded submodule modifications"));
 
 		if (can_ff) {
-			/* we can fast-forward this without invoking rebase */
+			/*
+			* We can fast-forward without invoking
+			* rebase, by calling run_merge().  But we
+			* have to allow rebase.autostash=true to kick
+			* in.
+			*/
+			if (opt_autostash < 0)
+				opt_autostash = config_autostash;
 			opt_ff = "--ff-only";
 			ret = run_merge();
 		} else {
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 66cfcb09c5..66fac99d2b 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -252,4 +252,16 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
 	test_must_fail git -C dst pull --no-ff --no-verify --verify
 '
 
+test_expect_success 'git pull --rebase --autostash succeeds on ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
+	echo "dirty" >>dst/file &&
+	git -C dst pull --rebase --autostash >actual 2>&1 &&
+	grep -q "Fast-forward" actual &&
+	grep -q "Applied autostash." actual
+'
+
 test_done
-- 
2.34.1

