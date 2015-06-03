From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 19/19] pull: remove redirection to git-pull.sh
Date: Wed,  3 Jun 2015 14:49:03 +0800
Message-ID: <1433314143-4478-20-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:51:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Vr-00052N-2C
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbbFCGuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:50 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35012 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbbFCGum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:42 -0400
Received: by padjw17 with SMTP id jw17so705146pad.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A8qrKeJr7SpOWuaDeoHgxWzpPYanof5FsBSfRcPogJE=;
        b=TqpJkLbldJLBGHjjbCG5hVe9oc4hbgO3dtRXhiFLnnK1tgDnZ93ygBDN/8iLjtTVin
         Ji8ghZykyZtoFnm6aUaJ0h+PW8rbELcNIRLvnshpoYdukAplc+SzICDxb9htjnhe2VxW
         oVPvs9goV/fD6UgGT9einTiiFcJtX6vOynmyjQoKsCQbMjXMR6vksIBnCgSHE2M4W392
         05HU/Tj19N7JB7nvskwAXf8oWfEVerWfhoovWH1hbRtRwvxe+sTWpcakCCJBZO8mFcy3
         SQ+SOC/6kGuuMO9rKepOF5hAN2dvjz8lfmEmFoQWfLrJm0wc7lCfcKHhixVD1UXt9Ev+
         qOqQ==
X-Received: by 10.66.147.228 with SMTP id tn4mr58219015pab.117.1433314241628;
        Tue, 02 Jun 2015 23:50:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:40 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270658>

At the beginning of the rewrite of git-pull.sh to C, we introduced a
redirection to git-pull.sh if the environment variable
_GIT_USE_BUILTIN_PULL was not defined in order to not break test scripts
that relied on a functional git-pull.

Now that all of git-pull's functionality has been re-implemented in
builtin/pull.c, remove this redirection, and retire the old git-pull.sh
into contrib/examples/.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile                                    | 1 -
 builtin/pull.c                              | 7 -------
 git-pull.sh => contrib/examples/git-pull.sh | 0
 3 files changed, 8 deletions(-)
 rename git-pull.sh => contrib/examples/git-pull.sh (100%)

diff --git a/Makefile b/Makefile
index 2057a9d..67cef1c 100644
--- a/Makefile
+++ b/Makefile
@@ -474,7 +474,6 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
-SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
diff --git a/builtin/pull.c b/builtin/pull.c
index 4e1ab5b..dad49cf 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -805,13 +805,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
 	unsigned char rebase_fork_point[GIT_SHA1_RAWSZ];
 
-	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
-		const char *path = mkpath("%s/git-pull", git_exec_path());
-
-		if (sane_execvp(path, (char**) argv) < 0)
-			die_errno("could not exec %s", path);
-	}
-
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
diff --git a/git-pull.sh b/contrib/examples/git-pull.sh
similarity index 100%
rename from git-pull.sh
rename to contrib/examples/git-pull.sh
-- 
2.1.4
