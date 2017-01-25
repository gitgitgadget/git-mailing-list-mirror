Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4571F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbdAYXsz (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:48:55 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34145 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdAYXsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:48:54 -0500
Received: by mail-pf0-f181.google.com with SMTP id e4so61308642pfg.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 15:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VwjGet3Y21N73o6x44ZLrK0s3Lh/Mfu+Yx11983sck=;
        b=Oxi2838MiCCwwAL9xZWSbFRX77qpp8OCDFHIebsbwY8i882mKar9i+1Bi05nicSX4F
         uf4g04D+Mpv48iu9d1lA2B5sqE2BN9PYCxKV1YDo+2PT5+hK9AV4J6ajG7sLcLz5sXRt
         o4GIL8PIW3Y+HcM/rtnAF8RBZ6SoEZ6IPM2G1c5A2IQ2RQ9OEo69wKNBj6kNHu4WkPra
         Gm+b7pXqH8tuYKS1OdD0rmUOKZA+ChhvaeP097m3ywab1mj/TRpbxeRGj+X3JzU13nyh
         vJ0uWI8UTGWYgDzulV/d1Lczeg/2ZjgETHfPuMNHRbxp8iO09SeaDl/drZO79UuQiaA1
         Z7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VwjGet3Y21N73o6x44ZLrK0s3Lh/Mfu+Yx11983sck=;
        b=HlQgMiHTrHc+LAqGgyyUvtvihadFuYhG9RUfQwac2X0HMN3mOaDliRPvbNBhjQC7es
         x+FWr9lA5nyvwQGwcAsNi7NAZ56oCTOgYoaTZn1hvWrbWuRz+YajlVIH/yaBWbcOai1u
         V/lNc4A8x+I/0MChGkGTsmcCMvgin6LO3R+XPDdrnAamEhww2O3KHiNo6DeHkVbLlN+G
         JXn2dr9VHcTvfrFEMERQfY+r/j71IzT39k8PFF5/EAzahe9lle3ZjZz9NWLxrOjXR48I
         pOPSpJwKy+9SKt1uHdCkxs7aH4Qf49tmkQUxI2QzdGS8cyHLbp7klGNTZ/ek6HOkY6jN
         dcCA==
X-Gm-Message-State: AIkVDXLnPq8qO414oMcfeIF0lDp2KqNvOUyJ2X7ASWW59WALq+4CHxs7ANbINZHn54TRdGiK
X-Received: by 10.98.67.153 with SMTP id l25mr24706689pfi.91.1485388133781;
        Wed, 25 Jan 2017 15:48:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3993:32c0:4ba2:a648])
        by smtp.gmail.com with ESMTPSA id b83sm3583388pfe.12.2017.01.25.15.48.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 15:48:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, judge.packham@gmail.com,
        olsonse@umich.edu, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] submodule update: run custom update script for initial populating as well
Date:   Wed, 25 Jan 2017 15:48:51 -0800
Message-Id: <20170125234851.22644-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
In-Reply-To: <20170125234158.GE83343@google.com>
References: <20170125234158.GE83343@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1b4735d9f3 (submodule: no [--merge|--rebase] when newly cloned,
2011-02-17), all actions were defaulted to checkout for populating
a submodule initially, because merging or rebasing makes no sense
in that situation.

Other commands however do make sense, such as the custom command
that was added later (6cb5728c43, submodule update: allow custom
command to update submodule working tree, 2013-07-03).

I am unsure about the "none" command, as I can see an initial
checkout there as a useful thing. On the other hand going strictly
by our own documentation, we should do nothing in case of "none"
as well, because the user asked for it.

Reported-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Thanks, Brandon, for spotting the unneeded subshell.
 I also fixed the && chaining along the way.
 
 Thanks,
 Stefan

 git-submodule.sh            |  5 ++++-
 t/t7406-submodule-update.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9788175979..63fc4fe9bc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -607,7 +607,10 @@ cmd_update()
 		if test $just_cloned -eq 1
 		then
 			subsha1=
-			update_module=checkout
+			case "$update_module" in
+			merge | rebase | none)
+				update_module=checkout ;;
+			esac
 		else
 			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 725bbed1f8..347857fa7c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -441,6 +441,16 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 	test_i18ncmp actual expect
 '
 
+test_expect_success 'submodule update - command run for initial population of submodule' '
+	cat <<-\ EOF >expect
+	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
+	EOF &&
+	rm -rf super/submodule &&
+	test_must_fail git -C super submodule update >../actual &&
+	test_cmp expect actual &&
+	git -C super submodule update --checkout
+'
+
 cat << EOF >expect
 Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
 Failed to recurse into submodule path '../super'
@@ -493,6 +503,7 @@ test_expect_success 'submodule init picks up merge' '
 '
 
 test_expect_success 'submodule update --merge  - ignores --merge  for new submodules' '
+	test_config -C super submodule.submodule.update checkout &&
 	(cd super &&
 	 rm -rf submodule &&
 	 git submodule update submodule &&
@@ -505,6 +516,7 @@ test_expect_success 'submodule update --merge  - ignores --merge  for new submod
 '
 
 test_expect_success 'submodule update --rebase - ignores --rebase for new submodules' '
+	test_config -C super submodule.submodule.update checkout &&
 	(cd super &&
 	 rm -rf submodule &&
 	 git submodule update submodule &&
-- 
2.11.0.495.g04f60290a0.dirty

