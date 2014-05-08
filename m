From: dturner@twopensource.com
Subject: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Thu,  8 May 2014 10:23:34 -0700
Message-ID: <1399569814-20644-3-git-send-email-dturner@twopensource.com>
References: <536B4680.1010806@web.de>
 <1399569814-20644-1-git-send-email-dturner@twopensource.com>
Cc: gitster@pobox.com, David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 19:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiS3J-0002Zs-R5
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 19:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbaEHRYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 13:24:10 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:35982 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128AbaEHRYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 13:24:08 -0400
Received: by mail-qa0-f44.google.com with SMTP id j7so2920149qaq.3
        for <git@vger.kernel.org>; Thu, 08 May 2014 10:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gtW+NwmOj64jielSOSHLOGdBDQkrYldOc1D849LA1xE=;
        b=Q32flhVCQHfde4pHtQZj8ATsehYZNUQVcbCZYHzPUWBKbc3WyryTkQivs474lowsxN
         /B/YkeC5sc+RPRiw4VCnehKYZ7F4+1tbG8ICFyo9q1IltbP9kziG0NEx0QUnmBGv6zHp
         htB0s3CTPMugazavzxB5R9RHd4ShMPQzTL8NAcA/4AYsc5Yq9TJZC1cNTtGKnSk2+bc7
         WjLL3a7Yk3WRXmkY2PMpmQlChQi/o6KuLhMTqke9hYIYhWSqo3+me2D735vgKEzczj/i
         kwHNbmLDhRWs9g1WPUXyt/p2U8j+JfAgPs5vpzbwFU7H/mhCJvv5j6pvkk1EtqQp7QHD
         E8ew==
X-Gm-Message-State: ALoCoQnBYJ1OZXCk/zqj6TsxjgGKvnGDgUkY0157P0z4WenQ/0gqYWW9ftoHOvTlVU7sIWCa7vMa
X-Received: by 10.224.53.194 with SMTP id n2mr6744776qag.48.1399569847586;
        Thu, 08 May 2014 10:24:07 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id w8sm2339093qag.30.2014.05.08.10.24.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 May 2014 10:24:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.33.g27630aa
In-Reply-To: <1399569814-20644-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248423>

From: David Turner <dturner@twitter.com>

Make it possible to change the case of a filename on a
case-insensitive filesystem using git mv.  Change git mv to allow
moves where the destination file exists if the destination file has
the same name as the source file ignoring case.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/mv.c                | 3 ++-
 t/t6039-merge-ignorecase.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 45e57f3..f4d89d0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -202,7 +202,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			}
 		} else if (cache_name_pos(src, length) < 0)
 			bad = _("not under version control");
-		else if (lstat(dst, &st) == 0) {
+		else if (lstat(dst, &st) == 0 &&
+			 (!ignore_case || strcasecmp(src, dst))) {
 			bad = _("destination exists");
 			if (force) {
 				/*
diff --git a/t/t6039-merge-ignorecase.sh b/t/t6039-merge-ignorecase.sh
index dfc9f17..a977653 100755
--- a/t/t6039-merge-ignorecase.sh
+++ b/t/t6039-merge-ignorecase.sh
@@ -35,7 +35,7 @@ test_expect_success 'merge with case-changing rename on both sides' '
 	git reset --hard baseline &&
 	git branch -D with-camel &&
 	git checkout -b with-camel &&
-	git mv --force TestCase testcase &&
+	git mv TestCase testcase &&
 	git commit -m "recase on branch" &&
 	>foo &&
 	git add foo &&
-- 
2.0.0.rc0.33.g27630aa
