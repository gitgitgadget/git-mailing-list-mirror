From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 18/19] pull --rebase: error on no merge candidate cases
Date: Thu, 18 Jun 2015 18:54:11 +0800
Message-ID: <1434624852-6869-19-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:09:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xgm-0005ac-NK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbbFRLHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:07:19 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33937 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbbFRKzh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:37 -0400
Received: by pdbki1 with SMTP id ki1so64225943pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j6DFtJS1KdTm3uS84Y9ybXtXco9w8wf5pPpkE1BfyA4=;
        b=Vvqqa0bLu5jW3eClhNofTU9QQXtlBQcRtGX5LEIvVhQjaHtIjR38stkZIOGpPN4pKf
         siOeDj+ZLcH5tIKq7lBfWIlsdO4dLabunubJ4AHofoCmAmzpWAF/NvEPsONlhE5EjpTN
         C34YNEsVp7x79JkRpJr1GbTqkXGbEzTDaXq8NPFC1OV7BezlqbqjcGaV/z5Zvru8tmPI
         JlaQ9Q2B7NttG6/iHQ5NNAz30geEcYScQMYMAQW9ACH20cVyK0kY8vNGpFIAGXYVco13
         FMqe3Wm8uwe5m9jMtsPe3UM3cNg5no1HZ4+5H+qouNO3dfjE6rDhSMVeJ/YbO6TzcsMp
         bjDg==
X-Received: by 10.70.132.195 with SMTP id ow3mr19811107pdb.87.1434624937416;
        Thu, 18 Jun 2015 03:55:37 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:36 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271962>

Tweak the error messages printed by die_no_merge_candidates() to take
into account that we may be "rebasing against" rather than "merging
with".

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index eb2a28f..421a34d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -431,7 +431,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
+		if (opt_rebase)
+			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
+		else
+			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
 		fprintf_ln(stderr, _("Generally this means that you provided a wildcard refspec which had no\n"
 					"matches on the remote end."));
 	} else if (repo && curr_branch && (!remote || strcmp(repo, remote))) {
@@ -441,7 +444,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
+		if (opt_rebase)
+			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
+		else
+			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, "    git pull <remote> <branch>");
@@ -453,7 +459,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = "<remote>";
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
+		if (opt_rebase)
+			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
+		else
+			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, "    git pull <remote> <branch>");
-- 
2.1.4
