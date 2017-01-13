Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DD620756
	for <e@80x24.org>; Fri, 13 Jan 2017 19:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbdAMTnd (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 14:43:33 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34905 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdAMTnc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 14:43:32 -0500
Received: by mail-pf0-f169.google.com with SMTP id f144so35576035pfa.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hKM0JAkLDpE3Trp8KD300l54ng+N6mHg+Ty6b+LkxPk=;
        b=QJ+uvXgHr2yf7ODUAsgCEVbQuQpKlLYffZEGJF0ja5yoDFSv7Ct/xAc35jePvEJt7l
         hqVCV6U9Nkug2G0f/kYPSJT4jDMUQWgEKqSsGdc4ihMptmudUdx7pGPntvdpevsqz+bW
         zIuiiR0zkiaBxKF154c9uDw+7KTJzGPigMds7Hrysa4iCyeHwGFjI4ZIrSFPEPxlrHpK
         llipvG2X+waq5LQ6spt1yu1yLcU+wZBeCvZ2vuvAnNTtee/UEBdAc4kZfodAasM4gkkQ
         YLMHV9B+Zaki/nzvjkhBCUVPq63pdvck7czAbZnHLdrnIzOEPfJI2DNkSxfAMKXRksiU
         xtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hKM0JAkLDpE3Trp8KD300l54ng+N6mHg+Ty6b+LkxPk=;
        b=d70QbW+6eoS6Y+q16kKp5Xxm05Vha2svwgigQLWLXh6Tnk0RbJAWKESymsliZLwUNK
         +/VjbkvKi2Q03lDSpcD03utQ9+zhELvQMGr06bi+fS0IACzD4os/JPXDxsd6EA5UmUfi
         9eOPgQVn6sReI1YaUmQ4Msx8itV1V0yRSDvLC6kXLYP7ULYDTH8HKd6Ic3wmRiBsB9po
         bzqE4U4T8jh7rZVwcc4j0UGj1WItPlPxfzV8jm+e8qRUIwFxyfsIQDFW2JXo+q7q38VO
         xAwSCfXnLpH8YvSBEzpO+upSfOnKUMD+ju+GKZqffrEMSiWKGzqY6634RLkhDShn6pL/
         wf/Q==
X-Gm-Message-State: AIkVDXJMRp7mzyHXFRfU5v/dyaaecoYZwcYLU5RDNQ/BQgiiovEwOk4ps8U/5YagAqKhD55Z
X-Received: by 10.84.231.193 with SMTP id g1mr32101572pln.12.1484336611365;
        Fri, 13 Jan 2017 11:43:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5403:279a:3262:7e9c])
        by smtp.gmail.com with ESMTPSA id x2sm31052704pfa.71.2017.01.13.11.43.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 11:43:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com, judge.packham@gmail.com,
        olsonse@umich.edu
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule update: run custom update script for initial populating as well
Date:   Fri, 13 Jan 2017 11:43:26 -0800
Message-Id: <20170113194326.13950-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.300.g08194d1431.dirty
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
 git-submodule.sh            |  7 ++++++-
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 554bd1c494..aeb721ab7e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -606,7 +606,12 @@ cmd_update()
 		if test $just_cloned -eq 1
 		then
 			subsha1=
-			update_module=checkout
+			if test "$update_module" = "merge" ||
+			   test "$update_module" = "rebase" ||
+			   test "$update_module" = "none"
+			then
+				update_module=checkout
+			fi
 		else
 			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 64f322c4cc..1407fa6098 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -424,6 +424,19 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 	test_i18ncmp actual expect
 '
 
+test_expect_success 'submodule update - command run for initial population of submodule' '
+	cat <<-\ EOF >expect
+	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
+	EOF
+	(
+		cd super &&
+		rm -rf submodule
+		test_must_fail git submodule update >../actual
+	)
+	test_cmp expect actual
+	git -C super submodule update --checkout
+'
+
 cat << EOF >expect
 Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
 Failed to recurse into submodule path '../super'
@@ -476,6 +489,7 @@ test_expect_success 'submodule init picks up merge' '
 '
 
 test_expect_success 'submodule update --merge  - ignores --merge  for new submodules' '
+	test_config -C super submodule.submodule.update checkout &&
 	(cd super &&
 	 rm -rf submodule &&
 	 git submodule update submodule &&
@@ -488,6 +502,7 @@ test_expect_success 'submodule update --merge  - ignores --merge  for new submod
 '
 
 test_expect_success 'submodule update --rebase - ignores --rebase for new submodules' '
+	test_config -C super submodule.submodule.update checkout &&
 	(cd super &&
 	 rm -rf submodule &&
 	 git submodule update submodule &&
-- 
2.11.0.300.g08194d1431.dirty

