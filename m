From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Wed, 26 Dec 2012 14:31:14 +0100
Message-ID: <1356528674-2730-1-git-send-email-apelisse@gmail.com>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 26 14:31:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnr59-0002xb-HL
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 14:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400Ab2LZNbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 08:31:22 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:64728 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab2LZNbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 08:31:20 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so4814934wib.15
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 05:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Ul5gnkg4SylFVQE7M6dxZtEjV7H8NwUhDR/tsBDkgkY=;
        b=bGkWbGdq/2z8OWEtraabfoH7oycvr9lHN9Wrjj4j+3bOpKE7NpZHpN6ev69WzrJ/dU
         06C9KL7UebY4Nw5Xpm8CPeXivvYWtUQn+Wz7gwdnNs5tHC8o/X33jPj5AyKFseUpLLJK
         z62GUXcUQXMexvgT4ud02UBXBJt7Xw03SxXHHpc/I/9XCHssIwWGIBWXPtrGR/nmJSnA
         8gbCaLpFbDQ2wCm7GqpNN1mMlSxFc56HlEquRolYfMjRzQ9mAq1Sl6cI3r/b1CP7WvCI
         kdDWdtFaG9R/BbuziyXF+udNHaHC1iWio7kUYpnCTLziiNznngqpZQAs/pyGNdFxpbaa
         uKfw==
X-Received: by 10.180.81.39 with SMTP id w7mr43279048wix.15.1356528679534;
        Wed, 26 Dec 2012 05:31:19 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id fv2sm52618546wib.4.2012.12.26.05.31.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Dec 2012 05:31:17 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.12.g8864e38
In-Reply-To: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212136>

When looking for ignored files, we do not recurse into untracked
directory, and simply consider the directory ignored status.
As a consequence, we don't see ignored files in those directories.

Change that behavior by recursing into untracked directories, if not
ignored themselves, searching for ignored files.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
Actually, the previous patch breaks the case where the directory is ignored.
This one should fix both issues.
Let me know if you see any other use case that could be an issue.

 dir.c       | 7 +++++++
 wt-status.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 5a83aa7..2863799 100644
--- a/dir.c
+++ b/dir.c
@@ -1042,6 +1042,13 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 			return path_ignored;
 	}

+	/*
+	 * Don't recurse into ignored directories when looking for
+	 * ignored files, but still show the directory as ignored.
+	 */
+	if (exclude && (dir->flags & DIR_SHOW_IGNORED) && dtype == DT_DIR)
+		return path_handled;
+
 	switch (dtype) {
 	default:
 		return path_ignored;
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..7c41488 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -516,7 +516,7 @@ static void wt_status_collect_untracked(struct wt_status *s)

 	if (s->show_ignored_files) {
 		dir.nr = 0;
-		dir.flags = DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
+		dir.flags = DIR_SHOW_IGNORED;
 		fill_directory(&dir, s->pathspec);
 		for (i = 0; i < dir.nr; i++) {
 			struct dir_entry *ent = dir.entries[i];
--
1.8.1.rc3.12.g8864e38
