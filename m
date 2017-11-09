Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E6C201C8
	for <e@80x24.org>; Thu,  9 Nov 2017 19:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbdKIT62 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 14:58:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:56851 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdKIT6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 14:58:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id z184so168989pgd.13
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 11:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YjS3+4KDvVg6pUi3Rx/elvEuDFUqeNRWTBr2fXTqkzc=;
        b=pK3ul4AvSHbMMBu34HDVgkb7F1MbH2SlXKQdcYslxXqVnMEA5D3wQs9Y95iYbRbu7H
         F9gvuibbL4/tZ2SSP9puLfzui6l9B4LBbExLsmwsUkq1y+mDv4/oXwAj3Iq1k8asYMgg
         lBFzbM92jUNy7PLOWqZNFUS7gAhziY3QtR/LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YjS3+4KDvVg6pUi3Rx/elvEuDFUqeNRWTBr2fXTqkzc=;
        b=eH9QLFusRty391m7fmaXP1isAQ+DRA4NwDevyU/r9Swv81NSF18Owfi4DkvWE170PJ
         NvTXJ2GCmzYEVPfGDuIHrgyq99ZkmL2cCI/7VANm1VM698PZo2HP8nG6b63X4uKs1TZH
         4nsm0aLH7o6Cli4iujw/6yet+1iPtdNEE2rMeZ4+lG60W4xKdl4HODtpCpziluJdLLlR
         CCovnccHvWgnLC7PkYXBzWQgsUWshsS3AcmDE/+QwNq3JLA37N4Qdrm8sSbx+6jtknqT
         PsCEp9Odrh6CqLTKTm3fc/l9Ra5le/a9Q9iFEVmD1oLwpfS2Ue9/0T7dltsEhphljGC1
         8Qdw==
X-Gm-Message-State: AJaThX5RbGoELF7qP3qo++Dhpaf4W4z7MR+Z6trtRJSXeSnIxFbqNsBo
        380C9kV7nDUuSweTl9O+caDYua8sbAQ=
X-Google-Smtp-Source: ABhQp+RSKecdOZuIiuIJVAeZGPgQpL9eZhOy4+Dm+HZhp0Yy50vB8bVWgPcecdDQr2IVN/5S79yw5A==
X-Received: by 10.84.136.135 with SMTP id 7mr1473120pll.375.1510257504382;
        Thu, 09 Nov 2017 11:58:24 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id p83sm15150760pfd.61.2017.11.09.11.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Nov 2017 11:58:23 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 1/2] fsmonitor: Read from getcwd(), not the PWD environment variable
Date:   Thu,  9 Nov 2017 11:58:09 -0800
Message-Id: <1a8090dfa6f273bae68cfcdd62446944bedbc8a7.1510257457.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171109195810.30446-1-alexmv@dropbox.com>
References: <20171109195810.30446-1-alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Though the process has chdir'd to the root of the working tree, the
PWD environment variable is only guaranteed to be updated accordingly
if a shell is involved -- which is not guaranteed to be the case.
That is, if `/usr/bin/perl` is a binary, $ENV{PWD} is unchanged from
whatever spawned `git` -- if `/usr/bin/perl` is a trivial shell
wrapper to the real `perl`, `$ENV{PWD}` will have been updated to the
root of the working copy.

Update to read from the Cwd module using the `getcwd` syscall, not the
PWD environment variable.  The Cygwin case is left unchanged, as it
necessarily _does_ go through a shell.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 t/t7519/fsmonitor-watchman                 | 3 ++-
 templates/hooks--fsmonitor-watchman.sample | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index a3e30bf54..5fe72cefa 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -41,7 +41,8 @@ if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
 	$git_work_tree =~ s/[\r\n]+//g;
 	$git_work_tree =~ s,\\,/,g;
 } else {
-	$git_work_tree = $ENV{'PWD'};
+	require Cwd;
+	$git_work_tree = Cwd::cwd();
 }
 
 my $retry = 1;
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 9a082f278..ba6d88c5f 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -40,7 +40,8 @@ if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
 	$git_work_tree =~ s/[\r\n]+//g;
 	$git_work_tree =~ s,\\,/,g;
 } else {
-	$git_work_tree = $ENV{'PWD'};
+	require Cwd;
+	$git_work_tree = Cwd::cwd();
 }
 
 my $retry = 1;
-- 
2.15.0.rc1.413.g76aedb451

