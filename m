From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 19/19] pull: remove redirection to git-pull.sh
Date: Thu, 18 Jun 2015 18:54:12 +0800
Message-ID: <1434624852-6869-20-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:07:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XfF-0004Cf-80
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbbFRLHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:07:17 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33757 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142AbbFRKzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:40 -0400
Received: by pdjn11 with SMTP id n11so64307840pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1z9tSS6mztMZhW03O8ukCCLen/eRewMpVftQDbQeY8=;
        b=RXpYEg/OLTyqHzY/B1bamz/J3x4TSl/ascomqDjRA+IrXELQHngRNncMcCsHIKju/L
         EpF3VbuNvyNyIz/qNFJGo2AyMmtryfk5b6IPFBJz9DEEjD4wLeQOmhb+mqNmt+fF1ECQ
         14u0fAkTki3049YJIWETzGW0NNCX474e5Hmf7eQYYuePy4CrGZ0+lwcaf7VF0eJm/olb
         0ymofI3AI9DRX/g7mhhJZqNydyZyeevnOzvngD5YCSfsSEcagYt7AlIViDPAALCCEyAK
         7F86SSO4Zs1yHn5WpQbHbr3EEy3H1y3HMDBpUBnVDshuhK6pFfK9Rys86dFHc5JGm9Pu
         Vm4g==
X-Received: by 10.67.23.44 with SMTP id hx12mr20361417pad.16.1434624940171;
        Thu, 18 Jun 2015 03:55:40 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:38 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271958>

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
index 17e1136..93e4fa2 100644
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
index 421a34d..722a83c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -798,13 +798,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
