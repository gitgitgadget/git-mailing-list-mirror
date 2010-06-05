From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 1/2] commit.c - provide commit-type to the hooks/pre-commit script
Date: Sat,  5 Jun 2010 13:39:50 -0400
Message-ID: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 19:42:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKxOB-0007cF-Vv
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 19:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784Ab0FERj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 13:39:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45950 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702Ab0FERjz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 13:39:55 -0400
Received: by vws5 with SMTP id 5so1255730vws.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=r+m97Q2khfZqB1YHGERS7ET15S5AbaZpLwRpJD1cZl4=;
        b=VOpvIQzpa/ZshYeDP83vLmJnHkCjEhEDuxYKYRXpqZv2n4/Bn9luhcRfGol9Rn+LfE
         Pr6rNoxYdt9zvNHAjNdAxZgZ/nxvi3k561hKLxEaSDeT0y6ng9S2cWGD8Li4EkVKmCTn
         497wTdQ03qo/H/oz1iOJhdizou3tiiMw3dhqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ubMjb61qftEJOYgfivL7jh4/6QEJpdDOyaYSbBE2K64kuVAEtCJR26VoRqgBzAl8/j
         R2I4v7QQ9zzmOpKuN2BbleUPgIZYItgji8S2BFqtAR6gPPA8lSdorX4RSydSvMQdAfQb
         U166wWhOcnwKWTy9vC2Spwd20wh2G5J1XeOcM=
Received: by 10.224.61.69 with SMTP id s5mr6327233qah.189.1275759594521;
        Sat, 05 Jun 2010 10:39:54 -0700 (PDT)
Received: from mark-laptop.lan (pool-71-191-167-79.washdc.fios.verizon.net [71.191.167.79])
        by mx.google.com with ESMTPS id 26sm2330957qwa.2.2010.06.05.10.39.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 10:39:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.270.g2a29a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148479>

If hooks/pre-commit acts based upon the changes to be checked in
rather than just the resulting content, the script needs to know which
commit to use. For a normal commit, this is HEAD, but when amending this
is HEAD~1. So, this modifies commit.c to pass $1 as normal|amend depending
upon the commit type. Existing scripts are unaffected as they did not
expect any argument so will silently ignore this extra bit of info.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/githooks.txt         |    8 +++++---
 builtin/commit.c                   |    2 +-
 templates/hooks--pre-commit.sample |   10 ++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 7183aa9..dbe1a1a 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -73,9 +73,11 @@ pre-commit
 ~~~~~~~~~~
 
 This hook is invoked by 'git commit', and can be bypassed
-with `\--no-verify` option.  It takes no parameter, and is
-invoked before obtaining the proposed commit log message and
-making a commit.  Exiting with non-zero status from this script
+with `\--no-verify` option.  It takes a single parameter indicating
+the commit type (normal|amend), and is invoked before obtaining the
+proposed commit log message and making a commit.  For $1=normal,
+the commit is against HEAD, while for $1=amend, the commit is
+against HEAD~1.  Exiting with non-zero status from this script
 causes the 'git commit' to abort.
 
 The default 'pre-commit' hook, when enabled, catches introduction
diff --git a/builtin/commit.c b/builtin/commit.c
index ddf77e4..8543f09 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -544,7 +544,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int ident_shown = 0;
 
-	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+	if (!no_verify && run_hook(index_file, "pre-commit", amend ? "amend" : "normal", NULL))
 		return 0;
 
 	if (message.len) {
diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index b187c4b..0c0c79f 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -1,7 +1,8 @@
 #!/bin/sh
 #
 # An example hook script to verify what is about to be committed.
-# Called by "git commit" with no arguments.  The hook should
+# Called by "git commit" with a single argument indicating the
+# commit-type (normal|amend). The hook should
 # exit with non-zero status after issuing an appropriate message if
 # it wants to stop the commit.
 #
@@ -9,7 +10,12 @@
 
 if git rev-parse --verify HEAD >/dev/null 2>&1
 then
-	against=HEAD
+	if test "$1" = "amend"
+	then
+		against=HEAD~1
+	else
+		against=HEAD
+	fi
 else
 	# Initial commit: diff against an empty tree object
 	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-- 
1.7.1.270.g2a29a
