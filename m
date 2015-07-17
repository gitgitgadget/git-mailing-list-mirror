From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/22] checkout: generalize die_if_checked_out() branch name argument
Date: Fri, 17 Jul 2015 19:00:00 -0400
Message-ID: <1437174017-81687-6-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:02:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdq-0002fs-Tv
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbbGQXBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:21 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35857 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbbGQXBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:17 -0400
Received: by iehx8 with SMTP id x8so6248654ieh.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zynpFQ5YzfWvS+A3fS8FRMJmjmSyc9YlsjnKjEdJ+4M=;
        b=PEzq14JmAXrlEcgO2yhQyr6Papp/JG6anmHsUP3yJ7UdrQ6d7ILUfnXcu1tRC+kMbQ
         a4pHOdoET+hTWozcJM4P5ism0VvHEV0cGTBPo05X0DZh7xvT9o9I5ycvn7aUWOoG3zGM
         0jxyJUvKBP4OZjDrysKXAR8Kj5eYzPxyGUhlXKw34k2bFHANRMAB3LOaA2pI4l2/8JIK
         r+Lyk1GYZJq/eKIJ8jniYZQMvJf3kiyt6d0gZo/gJU0gfPaAEAdf+LlteRTmDeUSmx80
         f0zSA4nxMPqu9a9RHvRb4+FnGYE9A8bckeHrA1U6GJu7yUYO2m1GBZ3lZ3soU2bLSGQ6
         vL7Q==
X-Received: by 10.107.16.169 with SMTP id 41mr19739849ioq.117.1437174076922;
        Fri, 17 Jul 2015 16:01:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.15
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274147>

The plan is to publish die_if_checked_out() so that callers other than
git-checkout can take advantage of it, however, those callers won't have
access to git-checkout's "struct branch_info". Therefore, change it to
accept the full name of the branch as a simple string instead.

While here, also give the argument a more meaningful name ("branch"
instead of "new").

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

 builtin/checkout.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c36bf8a..177ad6a 100644
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
@@ -898,7 +898,7 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
 	end = start;
 	while (*end && !isspace(*end))
 		end++;
-	if (strncmp(start, new->path, end - start) || new->path[end - start] != '\0')
+	if (strncmp(start, branch, end - start) || branch[end - start] != '\0')
 		goto done;
 	if (id) {
 		strbuf_reset(&path);
@@ -908,20 +908,21 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
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
 	struct dirent *d;
 
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
2.5.0.rc2.378.g0af52e8
