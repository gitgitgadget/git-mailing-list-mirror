From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 05/16] checkout: generalize die_if_checked_out() branch name argument
Date: Fri, 10 Jul 2015 20:05:35 -0400
Message-ID: <1436573146-3893-6-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:12:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDoxQ-0000yP-0h
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbbGKHMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:12:14 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34975 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbbGKHMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:12:13 -0400
Received: by igcqs7 with SMTP id qs7so27039696igc.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IolAtRozjjDR39v1a5m5p/D1AAFG8UCluaoRyrY0Pu4=;
        b=Gp3Zp62HnNwvaNbNS2AHshT+V5g9LPIpnzqy6/Rqxnhj2uTOKFpdtg+cTcVoKCFJxk
         MQfTTa16gvZXkps7Wp60nlWDeOEt7GUCP2+OhQ8VYTU47xsmL0oLAChVWSLp2KV4zSR2
         hcyk8r0a0pJNK7gdQyRvmMc/C1Vg18X5+sXPaISFKjyfZfMblBWTFq65xlZqwCRigH4G
         068uAoSvVoDjaJkcr0LPA8L5LKivucENKlKuQ/igTPU+moVBVfQaw2Xk0trE0YyTkXsz
         DWz/3N/RophU7LrUjSSCkc1reQI8z5wPDTxSNMvx7eMEVfPzQO5nEznBHzCU9BTQoyaB
         rXOw==
X-Received: by 10.107.137.41 with SMTP id l41mr440553iod.60.1436573192332;
        Fri, 10 Jul 2015 17:06:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.31
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273857>

The plan is to publish die_if_checked_out() so that callers other than
git-checkout can take advantage of it, however, those callers won't have
access to git-checkout's "struct branch_info". Therefore, change it to
accept the full name of the branch as a simple string instead.

While here, also give the argument a more meaningful name ("branch"
instead of "new").

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ee33a20..673daa0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -873,7 +873,7 @@ static const char *unique_tracking_name(const char *name, unsigned char *sha1)
 	return NULL;
 }
 
-static void check_linked_checkout(struct branch_info *new, const char *id)
+static void check_linked_checkout(const char *branch, const char *id)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
@@ -893,7 +893,7 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
 	end = start;
 	while (*end && !isspace(*end))
 		end++;
-	if (strncmp(start, new->path, end - start) || new->path[end - start] != '\0')
+	if (strncmp(start, branch, end - start) || branch[end - start] != '\0')
 		goto done;
 	if (id) {
 		strbuf_reset(&path);
@@ -903,14 +903,15 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
 		strbuf_rtrim(&gitdir);
 	} else
 		strbuf_addstr(&gitdir, get_git_common_dir());
-	die(_("'%s' is already checked out at '%s'"), new->name, gitdir.buf);
+	skip_prefix(branch, "refs/heads/", &branch);
+	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
 done:
 	strbuf_release(&path);
 	strbuf_release(&sb);
 	strbuf_release(&gitdir);
 }
 
-static void die_if_checked_out(struct branch_info *new)
+static void die_if_checked_out(const char *branch)
 {
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
@@ -921,7 +922,7 @@ static void die_if_checked_out(struct branch_info *new)
 	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
 	 * uses git_path). Parse the ref ourselves.
 	 */
-	check_linked_checkout(new, NULL);
+	check_linked_checkout(branch, NULL);
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir = opendir(path.buf);
@@ -932,7 +933,7 @@ static void die_if_checked_out(struct branch_info *new)
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-		check_linked_checkout(new, d->d_name);
+		check_linked_checkout(branch, d->d_name);
 	}
 	closedir(dir);
 }
@@ -1151,7 +1152,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
-			die_if_checked_out(new);
+			die_if_checked_out(new->path);
 		free(head_ref);
 	}
 
-- 
2.5.0.rc1.201.ga12d9f8
