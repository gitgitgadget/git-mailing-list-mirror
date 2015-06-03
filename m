From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 18/19] pull --rebase: error on no merge candidate cases
Date: Wed,  3 Jun 2015 14:49:02 +0800
Message-ID: <1433314143-4478-19-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:51:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Vq-00052N-G5
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbbFCGus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36751 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbbFCGuj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:39 -0400
Received: by pabqy3 with SMTP id qy3so671532pab.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UEECg1SKe5xlnWFJRp7WtlPiGxPByST+y5NWQnLRL0I=;
        b=QY/cisvVHy2pAFhwySNNKlUYCwWxjyxVdyJhOSSUmKGWylOfElr8MZSruSzxUPG4Af
         PkV4Q0jiXAXezG5KlxrFtGm6ytUlpbApgCZpj/lqy6QtG6uv5Gtf1BZ3gqns4Y4zvZdU
         woP7Z04+AVDVMoS/S4Q7iUw3aXNXJ/u4LBbVA1J4cMWECHP2Tp3jpSs/2WzHzZYC5n3b
         S2S7ITgGm0fv84SfqCvwXrJYuPTpKWVsOX0oimqxlRS4d21Z4yod8W1F4VphvGFS++UD
         6RDAdASqpuKB3jVDABNZ4dbv68T6S4escE5gLGXhZCQRUfdG3J/K8PnVVAL4jnFs7qMs
         N8+w==
X-Received: by 10.68.130.98 with SMTP id od2mr4432613pbb.73.1433314238706;
        Tue, 02 Jun 2015 23:50:38 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:37 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270657>

Tweak the error messages printed by die_no_merge_candidates() to take
into account that we may be "rebasing against" rather than "merging
with".

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Decided to use fprintf_ln() for the sake of code consistency, and for
      the added trailing newline.

 builtin/pull.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index f5d437a..4e1ab5b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -439,7 +439,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
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
@@ -449,7 +452,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
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
@@ -461,7 +467,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
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
