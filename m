From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Thu,  8 Aug 2013 12:38:12 -0500
Message-ID: <1375983492-32282-2-git-send-email-stephen@exigencecorp.com>
References: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com>
Cc: Johannes.Schindelin@gmx.de, avarab@gmail.com
To: stephen@exigencecorp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 19:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7UBJ-00076G-40
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966054Ab3HHRjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:39:11 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:65131 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966050Ab3HHRjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:39:09 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so3762961pab.20
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=viGBBU9JfP+i5nCj1QsyatT7wJNRQxobZ6aTgrXbRSg=;
        b=a2HvQthbPqKxrsjiydpxoUhMeiOUKJwwMGbZmp3ennpSE3PUW8Zig5TBU74TK93f3g
         12nsHjcbgyVZHmat1wfxbisZSZXxVMkC2WTYVydzrlaLroxmtcxKsPWxoL4Its7k3OHi
         6dbO+4GVoFDrFfHxmqNs8A+X+6OICu5HK3j4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=viGBBU9JfP+i5nCj1QsyatT7wJNRQxobZ6aTgrXbRSg=;
        b=crn0KGtwsuISGDIDIrQhkN+w2kuuctXJatB0YiH6FTukNvuO2zHlaLcl3hcNOCrvQe
         wfZaS/mqFTy38VxVu340v4ufmP6o8GJkh0fCND8mI2Pg5cpj5NNq/NH5LkFB5zyKGWBq
         rjDWRR7fQpPkeg4vxoBQsQr7GPsSu9Ogzcz3aMvPJVKfDQWl0piVAP6Bt+2SxQ00B8Pv
         JnMcZOB+SQjyWqdLnSvTwQT8TEbqnqyrNZX0pjqMKJt8Cf6dAVp/SybvoH0B6rHwIV03
         Cg19CJSi4FhhLHxhOIWCkV/76mvkMyZztbIZzBv7dQ9cZI4xvrEQ7b8koz/d5kGk6pdl
         49IQ==
X-Gm-Message-State: ALoCoQkWINvR3LijfQyMWFcKfNN9jUwavAuFnXaeeIoDwzUrHv2dXtB0Xe70NkiaIYsMuigZb7A1
X-Received: by 10.68.111.34 with SMTP id if2mr7258716pbb.83.1375983549187;
        Thu, 08 Aug 2013 10:39:09 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPSA id ts6sm15408024pbc.12.2013.08.08.10.39.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 10:39:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231910>

If a user is working on master, and has merged in their feature branch, but now
has to "git pull" because master moved, with pull.rebase their feature branch
will be flattened into master.

This is because "git pull" currently does not know about rebase's preserve
merges flag, which would this behavior, and instead replay on the merge commit
of the feature branch onto the new master, and not the entire feature branch
itself.

Add a -p/--preserve-merges, to pass along git rebase if --rebase is in affect.

Also add a new pull.preserve-merges config setting, to enable this behavior as
the default.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-pull.sh     | 11 +++++++++--
 t/t5520-pull.sh | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index f0df41c..61d1efb 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -40,7 +40,7 @@ test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity= progress= recurse_submodules= verify_signatures=
-merge_args= edit=
+merge_args= edit= rebase_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
@@ -48,6 +48,10 @@ if test -z "$rebase"
 then
 	rebase=$(git config --bool pull.rebase)
 fi
+if [ $(git config --bool pull.preserve-merges) = "true" ] ;
+then
+	rebase_args=--preserve-merges
+fi
 dry_run=
 while :
 do
@@ -116,6 +120,9 @@ do
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
 		;;
+	-p|--preserve-merges)
+		rebase_args=--preserve-merges
+		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
 		;;
@@ -292,7 +299,7 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
-	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
+	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ed4d9c8..2a2ee97 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -148,6 +148,21 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = $(git show HEAD:file2)
 '
 
+test_expect_success 'preserve merges' '
+	git reset --hard before-rebase &&
+	test_config pull.rebase true &&
+	test_config pull.preserve-merges true &&
+	git checkout -b keep-merge second^ &&
+	echo new > file3 &&
+	git add file3 &&
+	git commit -m "new file3" &&
+	git checkout to-rebase &&
+	git merge keep-merge &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+'
+
 test_expect_success '--rebase with rebased upstream' '
 
 	git remote add -f me . &&
-- 
1.8.1.2
