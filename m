From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
Subject: [PATCH] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 04:32:38 -0300
Message-ID: <1435217558-5866-1-git-send-email-cmarcelo@gmail.com>
Cc: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 09:33:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z81em-0007gg-6a
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 09:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbFYHdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 03:33:03 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36587 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbFYHcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 03:32:55 -0400
Received: by paceq1 with SMTP id eq1so44722520pac.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4k8aWpK3elGfd9Lfs/oiPRyK0mKfA0w6EB1M4sDMvjk=;
        b=ohu4mVMMVC4Nqq2empEI3VpgsEKF00TfXvPTc8J9j5LquH3c+qQPXbxra2nEMGW369
         a0RN1aq87Osm792GraK0+Ha5HnR/TgGhSxHzrRMHOIbjKvb4TBbkFnFcJMegS8zzq3k6
         w0WHJr42Pi0m1wZuVlA/5eF2X2yDf8NB3LlZyEBClDxVl9RCsBoKvIBSNCpaFWwSOFvM
         3tY9BOXwkbWX9y2Y9IIipGNuDILXICSzhYo2vlunxk/Ijhvz3k8x76xBrXNas0Vu3ID9
         OUne1spOAJMe1kuz+embfr4uTwSdJAWy4x3+aH6364kD+CaGHvyMo/PvYwZCJ7KKcBAW
         7gZw==
X-Received: by 10.68.198.101 with SMTP id jb5mr89328555pbc.84.1435217574294;
        Thu, 25 Jun 2015 00:32:54 -0700 (PDT)
Received: from gray.localdomain (205.158.165.99.ptr.us.xo.net. [205.158.165.99])
        by mx.google.com with ESMTPSA id qs8sm28948812pbc.38.2015.06.25.00.32.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 00:32:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.4.489.gc2a2b54.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272636>

In projects that use Signed-off-by, it's convenient to include that line
in the commit by default. The commit.signoff config option allows to add
that line in all commits automatically.

Document that this config option can be overriden by using
--no-signoff.

Signed-off-by: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
---
 Documentation/config.txt     |  6 ++++++
 Documentation/git-commit.txt |  5 +++++
 builtin/commit.c             |  4 ++++
 t/t7500-commit.sh            | 22 ++++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93..e019f62 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1089,6 +1089,12 @@ commit.gpgSign::
 	convenient to use an agent to avoid typing your GPG passphrase
 	several times.
 
+commit.signoff::
+
+	A boolean to enable/disable whether Signed-off-by line by the
+	committer should be added to all commits at the end of the
+	commit log messages.  Defaults to false.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 904dafa..7546c7a 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -156,6 +156,11 @@ OPTIONS
 	Add Signed-off-by line by the committer at the end of the commit
 	log message.
 
+--no-signoff::
+	Countermand `commit.signoff` configuration, preventing a
+	Signed-off-by line to be added at the end of the commit log
+	message.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 254477f..5cfbe57 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1505,6 +1505,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.signoff")) {
+		signoff = git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 116885a..fcb39b4 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -179,6 +179,28 @@ test_expect_success '--signoff' '
 	test_cmp expect output
 '
 
+test_expect_success 'commit.signoff config option' '
+	git config commit.signoff true &&
+	echo "yet another content *narf*" >> foo &&
+	echo "zort" | git commit -F - foo &&
+	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
+	git config --unset commit.signoff &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+no signed off by here
+EOF
+
+test_expect_success '--no-signoff' '
+	git config commit.signoff true &&
+	echo "yet another content *narf*" >> foo &&
+	echo "no signed off by here" | git commit --no-signoff -F - foo &&
+	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
+	git config --unset commit.signoff &&
+	test_cmp expect output
+'
+
 test_expect_success 'commit message from file (1)' '
 	mkdir subdir &&
 	echo "Log in top directory" >log &&
-- 
2.4.4.489.gc2a2b54.dirty
