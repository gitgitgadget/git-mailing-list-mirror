From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 19/19] pull: remove redirection to git-pull.sh
Date: Sun, 14 Jun 2015 16:42:06 +0800
Message-ID: <1434271326-11349-20-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43WL-0006kw-6V
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbbFNIn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:56 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34547 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbFNInZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:25 -0400
Received: by pdbki1 with SMTP id ki1so51411692pdb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1HQN5aLFBv9xmdTWdpvfGwTf8dq03ecXLuUjbpchCBw=;
        b=pw9XQzRSEKLEBKqlC43XtYGPYdrYzI6ZmAOyQtl4KWjWIEiuCAtEYnquVUD0VJcboV
         ib8cmo8jRvGNnFPccpuDqWpJ/Ru5i0KD3uvi6WLmR3lDrFBKDJC2PEnwiDdIX3RPiKgA
         MYC7NXIRTJS4S6NB01NoRAgDYUbdiWBxFSqKAI338D6lrP/FU5DpppXg0hpiS3v2eL6O
         AvMpriv9L8IZZCzRrS19OPxnQcVTmGdLm/i5dneqHWBtnXB75RbOB17U1CndFfi5IeXm
         ypHfEotQ75Z3FsAfamgJVtYSA2Z3/KK/uTkd2PBXCnEe+tATdJdXmx69b/aQg0mGgtZG
         S1zQ==
X-Received: by 10.66.252.227 with SMTP id zv3mr38825692pac.154.1434271404963;
        Sun, 14 Jun 2015 01:43:24 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.43.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:43:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271633>

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
index b78c67c..d690aee 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -797,13 +797,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
 	unsigned char rebase_fork_point[GIT_SHA1_RAWSZ];
 
-	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
-		const char *path = mkpath("%s/git-pull", git_exec_path());
-
-		if (sane_execvp(path, (char **)argv) < 0)
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
