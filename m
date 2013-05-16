From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/3] remote: don't override default if cur head remote is '.'
Date: Wed, 15 May 2013 22:43:46 -0500
Message-ID: <1368675828-27418-2-git-send-email-felipe.contreras@gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 05:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucp8H-0007PV-A1
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720Ab3EPDpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:45:25 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:61809 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab3EPDpV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:45:21 -0400
Received: by mail-ob0-f177.google.com with SMTP id wn6so2594149obc.8
        for <git@vger.kernel.org>; Wed, 15 May 2013 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EM+d3vZtWoKLPObX32D26spU9XQwaDcG5gDCeEp3YDI=;
        b=WTYTCHfVHcGTTnYtfeyfmuHopqEGlDfq2dQH6hLf6shQRZgnn3AqpcAPutrlbVVy5Z
         qHnK0eLpzqq2VnBJalNyMyx/wp0IVq/QPaxO78tDE+aDrr49zC3GijaIgQhSvCp1BtJI
         QVby4Ontpk9SRpdBtGE2EdXASAGO9ItDZM4A00jBmRvk02S8FnVW+Ez0fdHrKm0DPF/9
         M0NFKi7ElVMBVsEpESRPygBnGmXJUgtbpTXpdo0AGKL1008YVaMY9FbL5cNLWUVLjuLO
         m5SkCASNInGWB6wQCn5CSUvm0HwtVXfu3RWd4lxJoh8J4ksOZO7pmY3OFsivcq109qUr
         +Yyw==
X-Received: by 10.60.142.7 with SMTP id rs7mr7271310oeb.106.1368675921230;
        Wed, 15 May 2013 20:45:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm6284734obl.1.2013.05.15.20.45.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 20:45:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224472>

'git fetch .' makes no sense, so let's keep using the default ('origin')
when the current branch's remote is '.'.

Also update 'git pull' so that pulling works the same way as before.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 9 ++++++++-
 remote.c    | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..75297c7 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -220,7 +220,14 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
+# get the default remote
+remote="$(git config "branch.$curr_branch_short.remote")"
+if test $# == 0 && test -n "$remote"
+then
+	git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$remote" || exit 1
+else
+	git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
+fi
 test -z "$dry_run" || exit 0
 
 curr_head=$(git rev-parse -q --verify HEAD)
diff --git a/remote.c b/remote.c
index 68eb99b..322a1b6 100644
--- a/remote.c
+++ b/remote.c
@@ -360,7 +360,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!strcmp(subkey, ".remote")) {
 			if (git_config_string(&branch->remote_name, key, value))
 				return -1;
-			if (branch == current_branch) {
+			if (branch == current_branch && strcmp(branch->remote_name, ".")) {
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
 			}
-- 
1.8.3.rc1.579.g184e698
