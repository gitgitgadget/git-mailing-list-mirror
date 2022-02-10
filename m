Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC75C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiBJJ25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:28:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiBJJ2z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:28:55 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1801F10B2
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z144-20020a627e96000000b004e057a71cf5so2971088pfc.21
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=1q5oLNtDReJ7p0+YX28Bu8psSH2hz+Z8tqtHbnD/3Rs=;
        b=i7X3v+eWhFCq70yj5diBqXk8uluc04X8836ruTfmGQL1ME8caGV3xsEKx5vyznEQG5
         P3RQttYun4soRMYCeSDLWeWcdXUedQRnNK0Yla3g77rtikbfeSVdWL45a/Kus69ETOJ6
         dOt7UunOQLFDgKvkxF+4Fl175usplW/hDpZFa7iByojY0bPoD+RbcukGCqOKXH3FsXE/
         M6vU098j9UVSqoXlYHvpOV2A2qfOAuFAxntvKidXalse6GRcZ2q0sUHftPaxZk4dsZje
         U1AK9xm+L8GgkdsETct7c+sjtKU0dQ62dz/PftGaOiTiScyysDoMIeNkT9NaOu1E082n
         A10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=1q5oLNtDReJ7p0+YX28Bu8psSH2hz+Z8tqtHbnD/3Rs=;
        b=4FBLAGl682jAoZvKqV3mIisJJdXnGIjDeLCv0PYRkHkGlY0mgC4hnkaQsq0cVkZhT6
         6jsomu5r7Y2mGirLhE0IAzgo3kOKsiXKNOzH+1nvNOdymxBv0JHmb6x9cPaCCjofAJMn
         O7iIrjZmJI1Mn2uj7skiT/flV9YebXZd2JyxIGRxCzTrzyLf8HtDWJWRugMP4hw6H9Xg
         Uagl85Dd8I46zy5x+/F+4ikG2qvEib0YoAmp9CT+lgYyIL+pP/5VOb7qUk6KCuKxuoyw
         Sk+74QkYlL+y7T6ecMiV7NuvcX4MoHI924r0qnWnoB4R6NsUPQ5IdtOOyn0cPJcuW97R
         SRDA==
X-Gm-Message-State: AOAM533sMm5XxUsWuYKvSyYSu/MdvWijZDXIeV9q1hhRa60h2BhNJyhB
        kgazskgPNgvtzOA7Fhgp/U8GfIfir1hdMYxJ1r9IuurCAyvsz7SRpOz7+zIL42lD8WwO1R68iUN
        t1goq4ugzTCciHiXaxwXLd5IkXlXhBEYG8fXtG8lPuhNCiq046NUUbU51bBA2HOA=
X-Google-Smtp-Source: ABdhPJyvkqC3jLzTu6e5T6xTqEIIxE4urWr6yq3ydJi8f3aJJ3hRBECYv6O0orbxQw2G4HE2VeDf2aZaQ0E/SA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e885:: with SMTP id
 w5mr6502827plg.147.1644485336379; Thu, 10 Feb 2022 01:28:56 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:17 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 04/20] submodule--helper: run update using child process struct
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We switch to using the run-command API function that takes a
'struct child process', since we are using a lot of the options. This
will also make it simple to switch over to using 'capture_command()'
when we start handling the output of the command completely in C.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 09cda67c1e..db71e6f4ec 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2344,47 +2344,45 @@ static int fetch_in_submodule(const char *module_pa=
th, int depth, int quiet, str
=20
 static int run_update_command(struct update_data *ud, int subforce)
 {
-	struct strvec args =3D STRVEC_INIT;
-	struct strvec child_env =3D STRVEC_INIT;
+	struct child_process cp =3D CHILD_PROCESS_INIT;
 	char *oid =3D oid_to_hex(&ud->oid);
 	int must_die_on_failure =3D 0;
-	int git_cmd;
=20
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
-		git_cmd =3D 1;
-		strvec_pushl(&args, "checkout", "-q", NULL);
+		cp.git_cmd =3D 1;
+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
 		if (subforce)
-			strvec_push(&args, "-f");
+			strvec_push(&cp.args, "-f");
 		break;
 	case SM_UPDATE_REBASE:
-		git_cmd =3D 1;
-		strvec_push(&args, "rebase");
+		cp.git_cmd =3D 1;
+		strvec_push(&cp.args, "rebase");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure =3D 1;
 		break;
 	case SM_UPDATE_MERGE:
-		git_cmd =3D 1;
-		strvec_push(&args, "merge");
+		cp.git_cmd =3D 1;
+		strvec_push(&cp.args, "merge");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure =3D 1;
 		break;
 	case SM_UPDATE_COMMAND:
-		git_cmd =3D 0;
-		strvec_push(&args, ud->update_strategy.command);
+		cp.use_shell =3D 1;
+		strvec_push(&cp.args, ud->update_strategy.command);
 		must_die_on_failure =3D 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
 		    submodule_strategy_to_string(&ud->update_strategy));
 	}
-	strvec_push(&args, oid);
+	strvec_push(&cp.args, oid);
=20
-	prepare_submodule_repo_env(&child_env);
-	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SH=
ELL,
-				     ud->sm_path, child_env.v)) {
+	cp.dir =3D xstrdup(ud->sm_path);
+	prepare_submodule_repo_env(&cp.env_array);
+	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			printf(_("Unable to checkout '%s' in submodule path '%s'"),
--=20
2.33.GIT

