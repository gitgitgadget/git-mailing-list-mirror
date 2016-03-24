From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] submodule: fix recursive execution from non root directory
Date: Thu, 24 Mar 2016 16:34:26 -0700
Message-ID: <1458862468-12460-3-git-send-email-sbeller@google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 00:34:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEmC-0005nC-QH
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbcCXXeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:34:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33978 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbcCXXen (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:34:43 -0400
Received: by mail-pa0-f47.google.com with SMTP id fe3so33545540pab.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fgx4Ruu9WzkCMl2Rv8uIyGXJ1kT4gyImzgezibRRt+A=;
        b=WPVpmhfWYqE3n5y+P+b0CrMpf50ZcpS7Q6aVwdeSde///z3aW1u5lws9+uWLP0WJyZ
         T7wgT/bCV4+l4F/SO5QU3DL+xB5XXZ0Ua+eq1WDoI4dKV4L7+3JpTQFTGSXj3YMtvP/8
         TTKST1PVH2WKGBMWGX8FO6TaiCmaMowDoChTxVIw4WDu5yPVEgc6K7+BMWvoQBt43fK9
         DHIvGaK23M6swA0OATDX4qZxzVqRHK6aEQQwdVuKkOtcUqk06uIEwAVZ3wnjVpVFzy6E
         yH6sCKIVztvIFe6tHwyOj6q+BAxcQI2ZYdbj27Lb2gKrcxwyuzUtsd9hgCfJYIJpXuj1
         yeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fgx4Ruu9WzkCMl2Rv8uIyGXJ1kT4gyImzgezibRRt+A=;
        b=bHTjf0jlB1ymXKqlytNGsLjfjcR122mk4qBbduNpGupcoEfUj4/TTXbTIlUXJGY+uk
         3a3AXLnS1jCsIR85SX+/MWN1FPwV3BrAp5j5iHBT7ER/yKOZRhYkcP0KfZRehePRSQge
         3vYE4zMF1pKCrS7b3n2LnlEDbzEZ0/llnxdjK0AYSxgLvHIRlbZl9i++gB7fr61JonRa
         iT/SBEO5IGITbBlfDUO15mG1VF+U3AiV4tQo4Gg5n/5Jj1YJk9xYhi4sZU/sslMC1eSQ
         3YyLQ5xLPgbV2nT4EfrvwQvyVTOl3YGXKnIS3bSXVKoTFeic/dZTMKuXtPzw2t2MyRft
         suxg==
X-Gm-Message-State: AD7BkJLhKN9h8W9irltl1gALFMCPY3SDSDHctbAKhk80SY+ZOF5MGMz1qHtnaWe+I1fH35FV
X-Received: by 10.66.246.165 with SMTP id xx5mr16527664pac.87.1458862482211;
        Thu, 24 Mar 2016 16:34:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a88b:7b22:8e5b:edac])
        by smtp.gmail.com with ESMTPSA id y7sm12376627pfa.82.2016.03.24.16.34.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 16:34:41 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33
In-Reply-To: <1458862468-12460-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289824>

One of the first things that happens in most submodule sub commands is

    git submodule--helper list --prefix "$wt_prefix"

Currently the passed --prefix is used for doing path calculation
as if we were in that path relative to the repository root, which is
why we need to pass "$wt_prefix". The more common way in Git however
would be to use

    git -C "$wt_prefix" submodule--helper list

which I want to change later. That way however does not just
pass the prefix into the submodule command, but also changes
into that directory.

Say you have the following setup

repo/ # a superproject repository
repo/untracked/ # an untracked dir in repo/
repo/sub/ # a submodule
repo/sub/subsub # a submodule of a submodule

When in repo/untracked/ and invoking "git submodule status --recursive",
the recursed instance of the latter version for listing submodules would
try to change into the directory repo/sub/untracked, which is a bug.
This happens as we cd into the submodule in git-submodule.sh without
clearing wt_prefix, which is the assumed relative path inside the working
directory.

Most times that directory doesn't exist and we error out. Fix this bug
by clearing wt_prefix, such that any recursive instances of will assume
to operate from the respective root of the respective submodule.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 536ba68..6b18a03 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -827,6 +827,7 @@ Maybe you want to use 'update --init'?")"
 			(
 				prefix="$(relative_path $prefix$sm_path)/"
 				clear_local_git_env
+				wt_prefix=
 				cd "$sm_path" &&
 				eval cmd_update
 			)
@@ -1159,6 +1160,7 @@ cmd_status()
 			(
 				prefix="$displaypath/"
 				clear_local_git_env
+				wt_prefix=
 				cd "$sm_path" &&
 				eval cmd_status
 			) ||
@@ -1240,6 +1242,7 @@ cmd_sync()
 
 				if test -n "$recursive"
 				then
+					wt_prefix=
 					eval cmd_sync
 				fi
 			)
-- 
2.8.0.rc4.10.g52f3f33
