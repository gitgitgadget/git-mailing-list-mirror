From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/20] checkout: generalize die_if_checked_out() branch name argument
Date: Thu, 16 Jul 2015 04:20:10 -0400
Message-ID: <1437034825-32054-6-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:23:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeSG-0000zE-VT
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbbGPIXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:23:23 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37618 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbbGPIUw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:52 -0400
Received: by igbpg9 with SMTP id pg9so8106639igb.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hNbveexSLN8HIYNSjJuKNzwXOFqXvQKONdDeoEe76mo=;
        b=BGsbLg19rcC7zK4s7a1P5+V6jMZV53dKzZY7W9Z488yiDvenM32e5dFnyE/4V6LAOr
         21JPvasX0SbX0binqyZOnkQV28G22JprCebKE7VQK2sKWKy762glik7fh8h/vOqrHJMx
         1bG6IbxxFNcKlOeKJQI0ECosfeykh8+v/zttqBodN4/zUZHu3Ir71QfzTQ3ywt6djqHX
         6xc+qyf2CCxcXUVHf8cpMq2LbgnaasuUiBTAc2DEZ3ZGqOMF1eh4dAD7cPDeb+JLl7Sb
         XE3eoBeLakCnvF9FFaj6RIKsniU39Zky6Q2XKNoSVNO2mKkucohVyLcfz+laeDwfeAcq
         j71w==
X-Received: by 10.107.137.96 with SMTP id l93mr10038550iod.60.1437034852176;
        Thu, 16 Jul 2015 01:20:52 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.51
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274029>

The plan is to publish die_if_checked_out() so that callers other than
git-checkout can take advantage of it, however, those callers won't have
access to git-checkout's "struct branch_info". Therefore, change it to
accept the full name of the branch as a simple string instead.

While here, also give the argument a more meaningful name ("branch"
instead of "new").

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

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
