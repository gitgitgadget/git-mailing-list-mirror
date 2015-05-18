From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 14/14] pull --rebase: error on no merge candidate cases
Date: Mon, 18 May 2015 23:06:11 +0800
Message-ID: <1431961571-20370-15-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:09:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMf6-00051Z-NE
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbbERPIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:08:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36677 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbbERPIL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:08:11 -0400
Received: by pabts4 with SMTP id ts4so155772802pab.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dnZ9vYl+d1UfGfuXkdHxhCjLK+/uruY6b8yG9vJXxRc=;
        b=GVhgATdjO6J4c+eh95w9x7ZiLr5abfOfwN3mD1Fq7wACiCHD9QNvbdtkUVxtuPBXii
         Bv0lo0ty1mjTjbf/5/xI8GXqmmylarMOi4DJoJZb70UdT09qFBZ0G17sG8mFCJME42DW
         IQcQ+ZfyaprRMA6AIMKv6HRdEFwiTGqDVEiGeVBRHw8ZgXluoRH1c3giLWptp1fCkWYe
         39nAZusAF7/Yfn7tDjcwNniyZC9X11Oi9GvKMtWdAhmg9vUTcmfkDMAkvGpsBxeujAiB
         4PBRX3HVMobbPlFtygA2Qmav8Q3HGtlnIbtudkPlAojF408rORY+z24fhqhgJLsHtuTg
         YAMw==
X-Received: by 10.66.250.131 with SMTP id zc3mr45084435pac.136.1431961690679;
        Mon, 18 May 2015 08:08:10 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.08.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:08:09 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269273>

Tweak the error messages printed by die_no_merge_candidates() to take
into account that we may be "rebasing against" rather than "merging
with".

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index c8d673d..15b65a0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -474,10 +474,12 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		fprintf(stderr,
-			_("There are no candidates for merging among the refs that you just fetched.\n"
-			"Generally this means that you provided a wildcard refspec which had no\n"
-			"matches on the remote end.\n"));
+		if (opt_rebase)
+			fputs(_("There is no candidate for rebasing against among the refs that you just fetched."), stderr);
+		else
+			fputs(_("There are no candidates for merging among the refs that you just fetched."), stderr);
+		fputs(_("Generally this means that you provided a wildcard refspec which had no\n"
+			"matches on the remote end."), stderr);
 	} else if (repo && curr_branch && (!remote || strcmp(repo, remote))) {
 		fprintf(stderr,
 			_("You asked to pull from the remote '%s', but did not specify\n"
@@ -485,12 +487,15 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			"for your current branch, you must specify a branch on the command line.\n"),
 			repo);
 	} else if (!curr_branch) {
-		fprintf(stderr,
-			_("You are not currently on a branch. Please specify which\n"
-			"branch you want to merge with. See git-pull(1) for details.\n"
-			"\n"
-			"    git pull <remote> <branch>\n"
-			"\n"));
+		fputs(_("You are not currently on a branch."), stderr);
+		if (opt_rebase)
+			fputs(_("Please specify which branch you want to rebase against."), stderr);
+		else
+			fputs(_("Please specify which branch you want to merge with."), stderr);
+		fputs(_("See git-pull(1) for details."), stderr);
+		fputs("", stderr);
+		fputs("    git pull <remote> <branch>", stderr);
+		fputs("", stderr);
 	} else if (!curr_branch->merge_nr) {
 		struct known_remote *remotes = NULL;
 		const char *remote_name = "<remote>";
@@ -499,14 +504,17 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 		if (remotes && !remotes->next)
 			remote_name = remotes->remote->name;
 
+		fputs(_("There is no tracking information for the current branch."), stderr);
+		if (opt_rebase)
+			fputs(_("Please specify which branch you want to rebase against."), stderr);
+		else
+			fputs(_("Please specify which branch you want to merge with."), stderr);
+		fputs(_("See git-pull(1) for details."), stderr);
+		fputs("", stderr);
+		fputs("    git pull <remote> <branch>", stderr);
+		fputs("", stderr);
 		fprintf(stderr,
-			_("There is no tracking information for the current branch.\n"
-			"Please specify which branch you want to merge with.\n"
-			"See git-pull(1) for details.\n"
-			"\n"
-			"    git pull <remote> <branch>\n"
-			"\n"
-			"If you wish to set tracking information for this branch you can do so with:\n"
+			_("If you wish to set tracking information for this branch you can do so with:\n"
 			"\n"
 			"    git branch --set-upstream-to=%s/<branch> %s\n"
 			"\n"),
-- 
2.1.4
