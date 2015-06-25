From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
Subject: [PATCH v2] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 11:50:07 -0300
Message-ID: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com>
Cc: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 16:50:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z88U3-0004yz-AK
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 16:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbbFYOuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 10:50:25 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34417 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbbFYOuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 10:50:17 -0400
Received: by pdbep18 with SMTP id ep18so33125766pdb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JLwZiAwRyrKBxrF69JZiCMt4VvwMIqUq8UptHYoujPY=;
        b=YyzYtv58cquBajVPcsIrscgaH67jwDBc47YMRNvZfPO4kg3xdAC32MuYHkVHSZT4pe
         kNRsM5zyMpXshpeujYCFZLPAiLqV3hG24QqO2WzTwAw9d3l8b280CJfPqwEc8LELsK3S
         zvp5PJadc9OU6f/2KZGOYWFZlh6c8NCwuju7WvQAnaHvFopzHkMJE9I2ald6T/lfwmf7
         +m42+Wa59XAcivlbZsCgxm7gKpeQy0OM5MBQ/yoUb8lOT6tsFTlCRwyjGYBnyq/4p2hi
         327Cbi+mntQ+smIgEduKrwPMaFfTuscXPlJwmc5U9ofGR8Tq2jJiq3eM7jUBYy/wP+Tk
         oinw==
X-Received: by 10.70.42.101 with SMTP id n5mr92617231pdl.93.1435243816461;
        Thu, 25 Jun 2015 07:50:16 -0700 (PDT)
Received: from gray.localdomain (205.158.165.99.ptr.us.xo.net. [205.158.165.99])
        by mx.google.com with ESMTPSA id u7sm27176664pdo.49.2015.06.25.07.50.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 07:50:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.4.489.g5bc41de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272678>

In projects that use Signed-off-by, it's convenient to include that line
in the commit message by default. The commit.signoff config option
allows to add that line in all commits automatically.

Document that this config option can be overriden by using
--no-signoff.

Signed-off-by: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
---

Differences from v1:
* Use test_config helper in the test
* Add bash completion for commit and config

 Documentation/config.txt               |  6 ++++++
 Documentation/git-commit.txt           |  5 +++++
 builtin/commit.c                       |  4 ++++
 contrib/completion/git-completion.bash |  4 +++-
 t/t7500-commit.sh                      | 20 ++++++++++++++++++++
 5 files changed, 38 insertions(+), 1 deletion(-)

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
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c97c648..7a79a89 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1123,7 +1123,8 @@ _git_commit ()
 		;;
 	--*)
 		__gitcomp "
-			--all --author= --signoff --verify --no-verify
+			--all --author=
+			--signoff --no-signoff --verify --no-verify
 			--edit --no-edit
 			--amend --include --only --interactive
 			--dry-run --reuse-message= --reedit-message=
@@ -2009,6 +2010,7 @@ _git_config ()
 		color.status.untracked
 		color.status.updated
 		color.ui
+		commit.signoff
 		commit.status
 		commit.template
 		core.abbrev
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 116885a..949272d 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -179,6 +179,26 @@ test_expect_success '--signoff' '
 	test_cmp expect output
 '
 
+test_expect_success 'commit.signoff config option' '
+	test_config commit.signoff true &&
+	echo "yet another content *narf*" >> foo &&
+	echo "zort" | git commit -F - foo &&
+	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+no signed off by here
+EOF
+
+test_expect_success '--no-signoff' '
+	test_config commit.signoff true &&
+	echo "yet another content *narf*" >> foo &&
+	echo "no signed off by here" | git commit --no-signoff -F - foo &&
+	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
+	test_cmp expect output
+'
+
 test_expect_success 'commit message from file (1)' '
 	mkdir subdir &&
 	echo "Log in top directory" >log &&
-- 
2.4.4.489.g5bc41de
