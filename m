From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] git-init: autodetect core.ignorecase
Date: Tue, 25 Mar 2008 09:57:53 +0300
Message-ID: <1206428273-15926-1-git-send-email-dpotapov@gmail.com>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Frank <streamlake@tiscali.it>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 07:58:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je37J-0002bT-3C
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 07:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbYCYG57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 02:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbYCYG57
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 02:57:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:14672 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYCYG56 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 02:57:58 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3355359fgb.17
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A5r0tBQCqPOrNdk/aOmyM9/M93h1BCmDPRI0e3Y5/Ws=;
        b=WhrgRKqOwHk0Wxrju5DcSTNIWYGF0nPKoY1wpajqYm4s3924LSe3cO/RwbYXoEi+Az1cCQQhgvgOMsCj6eTU5fUSCjxUncqUPFFUDl5EWKYiMhmqnNPGSwhVfNoaOYm9ihiBngOw4xqxBRzC/xODZBkKCmqMzCG83MhfS3B184o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JNwMFEHFY2w6aEMmK58Ezj9DyyKdu6xHs0e9YfKS0k/XOXY521YUcJ76NffJ5KbNEDSWtkJ5LA+J4pJFLbpsrVItbdP8HsvfRMpzXzMqoYMBZMrnUU4JBHORELctm+43bytApIeoORNesb7h4oUNsffkU6WHwch+MdEuhsvuV+g=
Received: by 10.86.4.2 with SMTP id 2mr5215995fgd.9.1206428277450;
        Mon, 24 Mar 2008 23:57:57 -0700 (PDT)
Received: from localhost ( [83.237.187.35])
        by mx.google.com with ESMTPS id e20sm8996983fga.1.2008.03.24.23.57.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Mar 2008 23:57:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.rc1.10.g3948
In-Reply-To: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78152>

We already detect if symbolic links are supported by the filesystem.
This patch adds autodetect for case-insensitive filesystems, such
as VFAT and others.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

This patch goes on top of lt/case-insensitive

 builtin-init-db.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 79eaf8d..62f7c08 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -254,8 +254,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
 			git_config_set("core.worktree", work_tree);
 	}
 
-	/* Check if symlink is supported in the work tree */
 	if (!reinit) {
+		/* Check if symlink is supported in the work tree */
 		path[len] = 0;
 		strcpy(path + len, "tXXXXXX");
 		if (!close(xmkstemp(path)) &&
@@ -266,6 +266,12 @@ static int create_default_files(const char *git_dir, const char *template_path)
 			unlink(path); /* good */
 		else
 			git_config_set("core.symlinks", "false");
+
+		/* Check if the filesystem is case-insensitive */
+		path[len] = 0;
+		strcpy(path + len, "CoNfIg");
+		if (access(path, F_OK))
+			git_config_set("core.ignorecase", "true");
 	}
 
 	return reinit;
-- 
1.5.5.rc1.10.g3948
