From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 1/2 v2] commit.c - provide base commit to the hooks/pre-commit script
Date: Mon,  7 Jun 2010 22:56:02 -0400
Message-ID: <1275965763-18940-1-git-send-email-mlevedahl@gmail.com>
Cc: peff@peff.net, jsixt@viscovery.net, spearce@spearce.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 04:56:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLozV-0006VI-Dj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 04:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377Ab0FHC4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 22:56:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57278 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab0FHC4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 22:56:16 -0400
Received: by vws17 with SMTP id 17so851376vws.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=X8pCAAdVQFuUhxLUTfYhF1ITTX30riD2v+dwyas69/A=;
        b=q8M9aihwGwlc6nKhu7xPeZtVIEsACQwtXh1E7gp66wJ8xTB9kzBkz7tMreSmRBJugR
         mM42qwJ02elsjPMm3vRM79K1+glBX5vEmchQ8MmXO6IDcaVGJLuafVHXYbb+9hNP0TGV
         Z8f63A7Y07hxivcYY4050r9BClIwqCoEVNoig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GfZwYcpZbrxlCFk2CuOHh4RfuBi+9MeTX8lhsjKqgBXqXt+ScATMY5xbsuV6wOMMZn
         KeWEV+OyyDffDDZjt9YQmaZUHt2Q90x8faYf/7A9liF5rJVdLomM1GISAUjUJrQjgJTf
         FVAeOUzAP/bJbxcAY3EQmN3kkJx3DosPdTkcE=
Received: by 10.224.75.81 with SMTP id x17mr9816800qaj.282.1275965775318;
        Mon, 07 Jun 2010 19:56:15 -0700 (PDT)
Received: from mark-laptop.lan (pool-71-191-167-79.washdc.fios.verizon.net [71.191.167.79])
        by mx.google.com with ESMTPS id 4sm8913147qwe.55.2010.06.07.19.56.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 19:56:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.269.g9fb6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148641>

If hooks/pre-commit acts based upon the changes to be checked in
rather than just the resulting content, the script needs to know which
commit to use. For a normal commit, this is HEAD, but when amending this
is HEAD~1. So, this modifies commit.c to pass $1 as HEAD|HEAD~1 depending
upon the commit type. Existing scripts are unaffected as they did not
expect any argument so will silently ignore this extra bit of info.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/githooks.txt         |   10 ++++++----
 builtin/commit.c                   |    2 +-
 templates/hooks--pre-commit.sample |    9 +++++----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 7183aa9..d785b6c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -73,10 +73,12 @@ pre-commit
 ~~~~~~~~~~
 
 This hook is invoked by 'git commit', and can be bypassed
-with `\--no-verify` option.  It takes no parameter, and is
-invoked before obtaining the proposed commit log message and
-making a commit.  Exiting with non-zero status from this script
-causes the 'git commit' to abort.
+with `\--no-verify` option.  It takes a single parameter naming
+the current commit's parent (HEAD | HEAD~1), and is invoked before
+obtaining the proposed commit log message and making a commit.
+Note that $1=HEAD~1 indicates an amended commit is in process.
+Exiting with non-zero status from this script causes the 'git
+commit' to abort.
 
 The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
diff --git a/builtin/commit.c b/builtin/commit.c
index ddf77e4..49f799e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -544,7 +544,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int ident_shown = 0;
 
-	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+	if (!no_verify && run_hook(index_file, "pre-commit", amend ? "HEAD~1" : "HEAD", NULL))
 		return 0;
 
 	if (message.len) {
diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index b187c4b..e72cf9c 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -1,15 +1,16 @@
 #!/bin/sh
 #
 # An example hook script to verify what is about to be committed.
-# Called by "git commit" with no arguments.  The hook should
-# exit with non-zero status after issuing an appropriate message if
-# it wants to stop the commit.
+# Called by "git commit" with a single argument indicating the
+# commit-base (HEAD|HEAD~1).  The hook should exit with non-zero
+# status after issuing an appropriate message if it wants to stop
+# the commit.
 #
 # To enable this hook, rename this file to "pre-commit".
 
 if git rev-parse --verify HEAD >/dev/null 2>&1
 then
-	against=HEAD
+	against=$1
 else
 	# Initial commit: diff against an empty tree object
 	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-- 
1.7.1.269.g9fb6
