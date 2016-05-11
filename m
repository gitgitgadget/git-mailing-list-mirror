From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/7] submodule update: learn partial initialization
Date: Tue, 10 May 2016 17:59:56 -0700
Message-ID: <1462928397-1708-7-git-send-email-sbeller@google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed May 11 03:00:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IW2-0002HK-3l
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbcEKBAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:00:37 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35426 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbcEKBAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:00:16 -0400
Received: by mail-pa0-f47.google.com with SMTP id iv1so11170151pac.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/zELzyAhLaL4jncWDITUlU3MkIiq2UHJHnzNOVCXe2g=;
        b=MhhefifUCOvlseWV52d7c6yvnGww1D4hHQQz5nilWbbqG79JEHZ2AMaZjl4ml2Q9zq
         MQGxKiOilo9cM4Iiqq5TqWcG477CqXf2/Hy2G2IcdQSc0bxD0HECnlXIRSAb06OuOmZg
         SLCl9wyw9wINRBHF90kIwvaSVtGWFfnVvsfeEnckgBtdM2KBXPHYECTNBaxq/G3Ttb5n
         RtV3jGa6XOZECTbCuZOubL5PJrbCvC4uNPdoh9XaxlwKx4GRjO45GcHU8pLzeMqlyjJH
         zwPml3azw7B4ROosu8bRxhgwP14VnDWsnF8WtROMb031es+zvAmmyfVzBA9VS/voUezI
         SyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/zELzyAhLaL4jncWDITUlU3MkIiq2UHJHnzNOVCXe2g=;
        b=KCYzIWHrOhRj0y8p6rfXfTn3BH2EkJYsp9RO8UGrYhAmsOU6T0usBQFSbHCpthPIGH
         pYOjhDVDwEvInr28/l9uK6hCU3VUabIe3q97p5ILSc+NMPVUVuYQu7fS5H1+NBmCbYkC
         BEE7w91SoXgSOVT1e+MzT849v6UgqMeURBC97hd/1rvbSPxTwPbH0hp/VfYcjv5ehZRM
         2Hzhub7fFvE51lqnHDHsrR2gv9D8u0Or65mpYkjoIB+kVCVsOejyoW6M/gbD786kp9fU
         NhwVhc95Byq72escyP5ZUeG1KqBaevDriPLv4+aX9jCDUL/4AA7kNrfGDiKpQNDeg6kp
         MOpA==
X-Gm-Message-State: AOPr4FVEJZHijrCCPddZ7Ezs30OpPbWULAA4Sk3Hl2Sj0LiRVW8/am6tjo+vPuddgn0VAB5x
X-Received: by 10.66.141.73 with SMTP id rm9mr744508pab.84.1462928415384;
        Tue, 10 May 2016 18:00:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69ac:db78:a0d1:60da])
        by smtp.gmail.com with ESMTPSA id z17sm7223687pfi.61.2016.05.10.18.00.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 May 2016 18:00:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.35.g58985d9.dirty
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294216>

The new switch `--init-default-group` updates the submodules which are
configured in `submodule.updateGroup`

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt        |  5 ++++
 Documentation/git-submodule.txt |  4 ++--
 git-submodule.sh                | 14 +++++++++--
 t/t7400-submodule-basic.sh      | 53 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 59d7046..0f20019 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2735,6 +2735,11 @@ submodule.fetchJobs::
 	in parallel. A value of 0 will give some reasonable default.
 	If unset, it defaults to 1.
 
+submodule.updateGroup::
+	Specifies the group of submodules when `git submodule --init-group`
+	is called with no arguments. This setting is recorded in the initial
+	clone when `--init-submodule` was given.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 35ca355..e658d15 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,9 +14,9 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<submodulespec>...]
 'git submodule' [--quiet] init [--] [<submodulespec>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <submodulespec>...
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
+'git submodule' [--quiet] update [--init[-default-group]] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
+	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<submodulespec>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
diff --git a/git-submodule.sh b/git-submodule.sh
index c8e36c5..2b0b0cb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -522,7 +522,12 @@ cmd_update()
 			GIT_QUIET=1
 			;;
 		-i|--init)
-			init=1
+			test -z $init || test $init = by_args || die "$(gettext "Only one of --init or --init-default-group may be used.")"
+			init=by_args
+			;;
+		--init-default-group)
+			test -z $init || test $init = by_config || die "$(gettext "Only one of --init or --init-default-group may be used.")"
+			init=by_config
 			;;
 		--remote)
 			remote=1
@@ -585,7 +590,12 @@ cmd_update()
 
 	if test -n "$init"
 	then
-		cmd_init "--" "$@" || return
+		additional_init=
+		if test "$init" = "by_config"
+		then
+			additional_init=$(git config --get-all submodule.updateGroup)
+		fi
+		cmd_init "--" "$@" ${additional_init:+$additional_init} || return
 	fi
 
 	{
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 0adc4e4..41e65c2 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1139,4 +1139,57 @@ test_expect_success 'submodule add recording wrong labels reports an error' '
 	test_i18ngrep alphanumeric actual
 '
 
+test_expect_success 'setup superproject with labeled submodules' '
+	mkdir sub1 &&
+	(
+		cd sub1 &&
+		git init &&
+		test_commit test
+		test_commit test2
+	) &&
+	mkdir labeledsuper &&
+	(
+		cd labeledsuper &&
+		git init &&
+		git submodule add ../sub1 sub0 &&
+		git submodule add -l bit1 ../sub1 sub1 &&
+		git submodule add -l bit2 ../sub1 sub2 &&
+		git submodule add -l bit2 -l bit1 ../sub1 sub3 &&
+		git commit -m "add labeled submodules"
+	)
+'
+
+cat >expect <<-EOF
+-sub0
+ sub1 (test2)
+ sub2 (test2)
+ sub3 (test2)
+EOF
+
+test_expect_success 'submodule update --init with a group' '
+	test_when_finished "rm -rf labeledsuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/labeledsuper labeledsuper_clone &&
+	(
+		cd labeledsuper_clone &&
+		git submodule update --init \*bit1 ./sub2 &&
+		git submodule status |cut -c 1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update --init-default-group' '
+	test_when_finished "rm -rf labeledsuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/labeledsuper labeledsuper_clone &&
+	(
+		cd labeledsuper_clone &&
+		git config submodule.updateGroup \*bit1 &&
+		git config --add submodule.updateGroup ./sub2 &&
+		git submodule update --init-default-group &&
+		git submodule status |cut -c 1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.0.35.g58985d9.dirty
