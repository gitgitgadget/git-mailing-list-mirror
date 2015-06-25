From: cmarcelo@gmail.com
Subject: [PATCH] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 04:30:54 -0300
Message-ID: <1435217454-5718-1-git-send-email-cmarcelo@gmail.com>
Cc: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 09:31:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z81d1-0006AM-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 09:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbbFYHbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 03:31:05 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35166 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbbFYHbB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 03:31:01 -0400
Received: by pactm7 with SMTP id tm7so44730593pac.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=501NZQr4KPrg4VU1AB1k4E1UeoBeE7xJM6PA2UDzIzw=;
        b=ai10ZLn86LIrFfJBKqSqdmEBDtwpsWd8utOQP3eumtHvzkmy9/qtZdG0RdXn2qBRYa
         gLmzsdo/Lq+ZNQ5D67sIMOFbM3U0/QoCYMASEK4jfchiaydma7ozwoIrl3rGzjj3OPvR
         s/2HvnE3a1fA1qb+iXsE1Q8JjYS4qEoOrBC3ESutl3F4Y5tl3aGzVq8oS+25jCI/1rt5
         bG2m0mv3j93ItYPOAF8H1OCf+FS/9n8SKwCiKpKpc10dxdc9Twn7HoRkaPWzQEH0Vo/o
         olinu7aYVPhFT9snWelGVxXAcaUUKpAkr5bfhktQE7vn5zdYvpQ6yqFeCszMjsGvoEEV
         Y1Hg==
X-Received: by 10.70.140.38 with SMTP id rd6mr87861091pdb.47.1435217460571;
        Thu, 25 Jun 2015 00:31:00 -0700 (PDT)
Received: from gray.localdomain (205.158.165.99.ptr.us.xo.net. [205.158.165.99])
        by mx.google.com with ESMTPSA id ve7sm20193018pab.26.2015.06.25.00.30.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 00:30:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.4.489.gc2a2b54.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272635>

From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>

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
