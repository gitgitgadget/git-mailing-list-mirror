From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/16] checkout: improve die_if_checked_out() robustness
Date: Fri, 10 Jul 2015 20:05:33 -0400
Message-ID: <1436573146-3893-4-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDp52-00052d-IX
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbbGKHUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:20:07 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38305 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbGKHUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:20:06 -0400
Received: by igrv9 with SMTP id v9so27399696igr.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8s0EOH3jTOJiRAaDE799KeIeMVbg8o5MNe/hbkIMhxM=;
        b=OJOkTiqDbprhYCyw1meYFTXc45+KYfDe77FEBKJ0cyDJG1yuCz0vz+QySF+iS/7z2J
         41X6jRpmRTM/q2MNOTwbV4Frapv2x2Y8SMXfuYMPFBF9ks3khUIHOKIsickpwx61f03i
         ecYYrGBs5kv9AQkIrjsgkiTLAa512aGcNL74gROQ8efo35VCS1NVzhuUQbM4bWhmHuVg
         6uqbunMs0tIVY1/jwg/XL+o3UUdqo1FICh/f5OrmV5pgLAkMwg3PaXufN3+iFHc82Sw4
         hyv2bPzNhevJ/ACSow3U+qJbQmYDwVwvg8qiPdUFdg7FbLUQQgOewMGw3+EUPn3SQEvx
         UZfQ==
X-Received: by 10.50.164.233 with SMTP id yt9mr1339406igb.41.1436573190625;
        Fri, 10 Jul 2015 17:06:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.29
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273862>

die_if_checked_out() is intended to check if the branch about to be
checked out is already checked out either in the main worktree or in a
linked worktree. However, if .git/worktrees directory does not exist,
then it never bothers checking the main worktree, even though the
specified branch might indeed be checked out there, which is fragile
behavior.

This hasn't been a problem in practice since the current implementation
of "git worktree add" (and, earlier, "git checkout --to") always creates
.git/worktrees before die_if_checked_out() is called by the child "git
checkout" invocation which populates the new worktree.

However, git-worktree will eventually be retrofitted to populate the new
worktree via "git reset --hard" rather than "git checkout", and it will
want to use die_if_checked_out() to perform this check as well. But,
the reliance upon order of operations (creating .git/worktrees before
checking if a branch is already checked out) is fragile, and, as a
general function, callers should not be expected to abide by this
undocumented and unwarranted restriction. Therefore, make
die_if_checked_out() more robust by checking the main worktree whether
.git/worktrees exists or not.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e75fb5e..fc8bd79 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -916,12 +916,6 @@ static void die_if_checked_out(struct branch_info *new)
 	DIR *dir;
 	struct dirent *d;
 
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
-	if ((dir = opendir(path.buf)) == NULL) {
-		strbuf_release(&path);
-		return;
-	}
-
 	/*
 	 * $GIT_COMMON_DIR/HEAD is practically outside
 	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
@@ -929,6 +923,12 @@ static void die_if_checked_out(struct branch_info *new)
 	 */
 	check_linked_checkout(new, NULL);
 
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	if ((dir = opendir(path.buf)) == NULL) {
+		strbuf_release(&path);
+		return;
+	}
+
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-- 
2.5.0.rc1.201.ga12d9f8
