Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15D11FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 00:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbcLAAyh (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 19:54:37 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35401 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbcLAAyg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 19:54:36 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so87962464pga.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 16:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cWMCoC/IO61RBlnFF5W/PFiiKG1NtTPfXyTWB7NUmHE=;
        b=BlXiodxFcrofZrsq4dsB5EBYA8/e5Y/rj0Z4rzn0d3hvNC19He9HOflANJ+Zl0WIao
         4bcxwtNrf6Dje1LhFitcS+U4DJsjUHNMR5407xwQhL+qdgqqe29cciz/ofXvFkHuFKFp
         BPWGy5fFTfuz/qJmuJnx7eDLhvoXd8sYeowpMu26yausQZeNYyz6RWqNtPpHTaC0oXZb
         KT8GlF86FFazQ4SMeSUsIvsZZB6WEg9jZArwdwasqg36dVqDxMNQKcmBymyc8lUr+qgm
         4gRUG+fBtlkP5CioBIOBMoClpTzYuOu4HoPwD60bHdkVGCVy0L+e50URJjZ+/5q1VrkS
         cx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cWMCoC/IO61RBlnFF5W/PFiiKG1NtTPfXyTWB7NUmHE=;
        b=Ed9C8k36+laRPNUOHvispcoy8RfiPol08/AwpjPbwp9f1zAY99JJI0nWqKEevSY2Ag
         ztMGq5XfpMV2AWY0fBkjmuqg42f9c/1102fwb4nTrxYNJBLKdU71dHVgk8uLYQFL4ePr
         RCQjZ0PL958SD5JPCxX023mvThHJKgrGYZnElefIaQ2lhVkL3HvF0iUP7Zh+OOGgf1Kt
         8d9Qmf7yAnmD09b+lGBJYfyVWc5l/G31vxdKKV9uEiyJdEJ+kSHaJN961rRidK9LX5Hf
         iFnsNiF62OfspKH5aaX90xdCXhTniPuXdPjx57L6terFwdEkpaSQgkJh6CyA62IiQGnW
         tUFw==
X-Gm-Message-State: AKaTC01c6H20WzD+ut5KHA+QmUWOhW8VyLWaR3MD1359Gu8kj+2RVJDSwvfOqUzzIL7rdIgg
X-Received: by 10.98.21.148 with SMTP id 142mr35902897pfv.38.1480553675601;
        Wed, 30 Nov 2016 16:54:35 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.12])
        by smtp.gmail.com with ESMTPSA id s197sm87802457pgc.38.2016.11.30.16.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 16:54:33 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, barkalow@iabervon.org
Subject: [BUG?] Remote helper's wrong assumption of unchanged ref
Date:   Wed, 30 Nov 2016 16:54:24 -0800
Message-Id: <1480553664-12804-1-git-send-email-jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit f8ec916 ("Allow helpers to report in "list" command that the ref
is unchanged", 2009-11-17) allowed a remote helper to report that a ref
is unchanged even if it did not know the contents of a ref. However,
that commit also made Git assume that such a remote ref has the contents
of the local ref of the same name. If I'm not missing anything, this
assumption seems wrong; the attached test illustrates one case of local
edits being made after cloning with default parameters.

The original e-mail thread [1] seems to indicate that this feature is
meant for a remote helper with no Git-specific code (which is possible
if it supports "import" but not "fetch" - in this case, it would not
deal with SHA-1s at all) to nevertheless indicate "unchanged", most
likely to support optimizations on the client side.

But it seems to me that Git cannot perform this optimization. In other
words, it should just ignore "unchanged". If this makes sense, I'll
prepare a patch to do this.

[1] "[PATCH 00/13] Native and foreign helpers"
    <alpine.LNX.2.00.0908050052390.2147@iabervon.org>
---
 git-remote-testgit.sh     |  8 +++++++-
 t/t5801-remote-helpers.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 752c763..6357868 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -52,7 +52,13 @@ do
 		echo
 		;;
 	list)
-		git for-each-ref --format='? %(refname)' 'refs/heads/'
+		if test -n "$GIT_REMOTE_TESTGIT_UNCHANGED_BRANCH_REGEX"
+		then
+			git for-each-ref --format='? %(refname)' 'refs/heads/' |
+				sed "/${GIT_REMOTE_TESTGIT_UNCHANGED_BRANCH_REGEX}/s/$/ unchanged/"
+		else
+			git for-each-ref --format='? %(refname)' 'refs/heads/'
+		fi
 		head=$(git symbolic-ref HEAD)
 		echo "@$head HEAD"
 		echo
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 362b158..4a48f2b 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -301,4 +301,44 @@ test_expect_success 'fetch url' '
 	compare_refs server HEAD local FETCH_HEAD
 '
 
+test_expect_success 'setup remote repository and divergent clone' '
+	git init s2 &&
+	(
+		cd s2 &&
+		test_commit M1 &&
+		git checkout -b mybranch &&
+		test_commit B1
+	) &&
+	git clone "testgit::${PWD}/s2" divergent &&
+
+	(
+		cd divergent &&
+		git checkout master &&
+		test_commit M2 &&
+		git checkout mybranch &&
+		test_commit B2
+	)
+'
+
+test_expect_success 'fetch with unchanged claims' '
+	rm -rf local &&
+	cp -r divergent local &&
+
+	# No unchanged branches
+
+	GIT_REMOTE_TESTGIT_UNCHANGED_BRANCH_REGEX=ABCDE git -C local fetch &&
+	compare_refs s2 M1 local refs/remotes/origin/master &&
+	compare_refs s2 B1 local refs/remotes/origin/mybranch &&
+
+	# One unchanged branch
+
+	GIT_REMOTE_TESTGIT_UNCHANGED_BRANCH_REGEX=mybranch git -C local fetch &&
+	compare_refs s2 M1 local refs/remotes/origin/master &&
+
+	# I (Jonathan Tan) would expect refs/remotes/origin/mybranch to be B1,
+	# but it is B2.
+	test_must_fail compare_refs s2 B1 local refs/remotes/origin/mybranch &&
+	compare_refs local B2 local refs/remotes/origin/mybranch
+'
+
 test_done
-- 
2.8.0.rc3.226.g39d4020

