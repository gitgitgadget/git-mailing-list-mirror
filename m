From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/15] cmd_diff: respect submodule groups
Date: Tue, 26 Apr 2016 13:50:32 -0700
Message-ID: <1461703833-10350-15-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wu-0006bb-LS
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbcDZUvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:51:08 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33815 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbcDZUvF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:51:05 -0400
Received: by mail-pf0-f171.google.com with SMTP id y69so11425074pfb.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QUASvFPrmHRFKNCSaC3r0Z1cGF0c0G06xk7p/AV9w+M=;
        b=WpZZk0XuzHUn3D0EyP26+A7/u7R+lXo6sXq2H659adk9L2/VxHc0o0XkHQHEyzF8fv
         07abqZJBacxN9RmOX5Nbggum7wlyGaFbPeQhkW5c6JoJVdyOk3+bIgXfk0eZNprIwnxR
         sHpBktUwhn8so/To60ThVYEYrbQy7VnZuHwf0JFfx8V0pQeQ3OLG9+yPEdF/bh+RPBu8
         tJD6S9ZOHfmRvVT7hTAzAKlBgvyvXhGJRCzmIkvM4quZhHln+e9t9v8jx8xn9GprkqyL
         AhYaYZHZN5sDNPg8UeEGAwNo+wH7IXfND6xLumNOSH4ZX8soNu2KpfnmIOUtjGGN0loo
         1lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QUASvFPrmHRFKNCSaC3r0Z1cGF0c0G06xk7p/AV9w+M=;
        b=EEU7TXLBEg30VdRvbmQKFJr5x2BPFviFTs1QFeSgYyMoP3qiREvw6Yhxeuoh1sskKD
         GDGrmo4ofMATTwdL0DSvRDqXqN5mEG7Ax49hkq19884Yq3RoJstPsHNsx0cin3HM+/4B
         X+ZJGCz72aumiC7wDe0TmGqdYPS6KMSv4n0w4x5aaXWnepdCBxlodYdSW7Te2PnHYUMV
         ZOVmVbRk3agthLIDFiBhOr4YC9mXHcCO+swFn9MAaRaFfES1qDUjG+M8tlG1QrjDGRDM
         sh17E2JPjnW/AfnhbifFHz2qkhACDZop7fG1A4EDUEMdDfsncO2lcKMRufxz6doKLRI0
         hmCg==
X-Gm-Message-State: AOPr4FU6qycc68KdNqoXyUvtGmjmG11tjwv4+pZ588ZNSajcODX7wo9Brhqp7/fIHnl5S8zu
X-Received: by 10.98.101.198 with SMTP id z189mr6701546pfb.76.1461703864693;
        Tue, 26 Apr 2016 13:51:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id r191sm486547pfr.36.2016.04.26.13.51.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:51:04 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292674>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/diff.c               |  2 ++
 t/t7413-submodule--helper.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index 52c98a9..1c6abd5 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -366,6 +366,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	setup_diff_pager(&rev.diffopt);
 
+	rev.diffopt.submodule_groups = string_list_duplicate(
+		git_config_get_value_multi("submodule.defaultGroup"), 1);
 	/*
 	 * Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
diff --git a/t/t7413-submodule--helper.sh b/t/t7413-submodule--helper.sh
index a3dbfea..1ca7878 100755
--- a/t/t7413-submodule--helper.sh
+++ b/t/t7413-submodule--helper.sh
@@ -267,4 +267,19 @@ test_expect_success 'git status respects groups' '
 	test_i18ngrep "modified:   sub3" actual
 '
 
+test_expect_success 'git diff respects groups' '
+	# use setup from previous test
+	(
+		cd super_clone &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git diff >../actual
+		git config --unset-all submodule.defaultGroup
+	) &&
+	test_i18ngrep "diff --git a/sub0 b/sub0" actual &&
+	test_i18ngrep "diff --git a/sub1 b/sub1" actual &&
+	test_i18ngrep ! "diff --git a/sub2 b/sub2" actual &&
+	test_i18ngrep "diff --git a/sub3 b/sub3" actual
+'
+
 test_done
-- 
2.8.0.41.g8d9aeb3
