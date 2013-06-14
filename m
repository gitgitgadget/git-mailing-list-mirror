From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 14:26:17 +0530
Message-ID: <1371200178-9927-2-git-send-email-artagnon@gmail.com>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 10:54:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnPmK-0001Hq-Vn
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 10:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab3FNIya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 04:54:30 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:50830 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3FNIy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 04:54:27 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so372823pbc.12
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=P9mSGR3bttNnQyxJTkOt5aLzsMMJbnCvUGd2JXw6HrA=;
        b=Ecei+yIwIUe4WV0vLYqbT4ExQdNgrhXyUm6GXzsGFGa/3/H0U1C0buGe8IFyaBjaBX
         SEuG3Ji2xrGcny8pZBaGPJTfDaA9Ujwx46frIKRnUxLzW3/BRabw6o3Stxd/Y5zHR3sv
         mQjmSJDybxRZYaCaT7pWDzsu3Hd+i/mnMp+UVbPYXNSe15U4O0/tMjcgCN5GR7wCPA9y
         Xno1LiVHWEjzHurgeo7CI3kOMnTW9rbL8Fo4jKhZf25lMG6fvZODpN818EzVg5SMdTIp
         7xtuekJEeXxJZPLKyVjTmv+Sw24h9s7wHAsQhuFAYJkG2at6YUG3WGdpWTv5E+QIpXzA
         c8eg==
X-Received: by 10.68.125.135 with SMTP id mq7mr1539260pbb.159.1371200067463;
        Fri, 14 Jun 2013 01:54:27 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id fr1sm1506848pbb.26.2013.06.14.01.54.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 01:54:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.379.gb74074e.dirty
In-Reply-To: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227798>

If a rebasing pull is requested, pull unconditionally runs
require_clean_worktree() resulting in:

  # dirty worktree or index
  $ git pull
  Cannot pull with rebase: Your index contains uncommitted changes.
  Please commit or stash them.

It does this to inform the user early on that a rebase cannot be run on
a dirty worktree, and that a stash is required.  However,
rr/rebase-autostash lifts this limitation on rebase by providing a way
to automatically stash using the rebase.autostash configuration
variable.  Read this variable in pull, and take advantage of this
feature.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-pull.sh     |  2 ++
 t/t5520-pull.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..fb01763 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -44,6 +44,7 @@ merge_args= edit=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
+autostash=$(git config --bool rebase.autostash)
 if test -z "$rebase"
 then
 	rebase=$(git config --bool pull.rebase)
@@ -203,6 +204,7 @@ test true = "$rebase" && {
 			die "$(gettext "updating an unborn branch with changes added to the index")"
 		fi
 	else
+		test true = "$autostash" ||
 		require_clean_work_tree "pull with rebase" "Please commit or stash them."
 	fi
 	oldremoteref= &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 6af6c63..08afd25 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -102,6 +102,17 @@ test_expect_success 'pull.rebase' '
 	test new = $(git show HEAD:file2)
 '
 
+test_expect_success 'pull --rebase respects rebase.autostash' '
+	git reset --hard before-rebase &&
+	test_config pull.rebase true &&
+	test_config rebase.autostash true &&
+	echo dirty >>file2
+	git pull . copy &&
+	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
+	test new = $(git show HEAD:file2) &&
+	grep dirty file2
+'
+
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
-- 
1.8.3.1.379.gb74074e.dirty
