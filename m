From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] diff: don't read index when --no-index is given
Date: Mon,  9 Dec 2013 13:05:45 +0100
Message-ID: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 13:05:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpzay-0007jH-Rb
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 13:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542Ab3LIMFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 07:05:44 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:39888 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392Ab3LIMFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 07:05:43 -0500
Received: by mail-bk0-f49.google.com with SMTP id my13so1302248bkb.8
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 04:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4LP6s6V83VK6WDbCfY7AjfxpLATvf/Tay3TIKcCTHqM=;
        b=A6e3xK61YU/hstdudZWvjwA4cHGv/jvyCxfM28pmr7GW2fyzbLjjO2SN+12lm2lYTn
         zj4URNA2Lrz1HtWKOcITPH34Tp5sbG7HHZFRxUkrW7f9k/CJRJuCs5Z9Lq/DI/KBQWTN
         IDhrkHDkFsxhPQXr2wWZNukY9LM3CVCMw7yzeOnyJZiRV9E4wCXFu+J0w+Ly9rAAAIMR
         kJOAl/SHcI6NcZB7x1HaCCo9sm6dta6D7jJOmbYOFoUp+JMxG/AdCdyY0CQvL7ybAAMX
         dzG8XFKBNjq6jZNVaWd0d7u5XcsCghkdvYBgTuGoLFA5aDtg/hXIqdlfGH+8Av9hx7MH
         oaYA==
X-Received: by 10.204.56.201 with SMTP id z9mr2161947bkg.77.1386590741977;
        Mon, 09 Dec 2013 04:05:41 -0800 (PST)
Received: from localhost ([2001:6b0:1:1041:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id sx5sm8484044bkb.0.2013.12.09.04.05.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2013 04:05:41 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239068>

git diff --no-index ... currently reads the index, during setup, when
calling gitmodules_config().  In the usual case this gives us some
performance drawbacks, but it's especially annoying if there is a broken
index file.

Avoid calling the unnecessary gitmodules_config() when the --no-index
option is given.  Also add a test to guard against similar breakages in the future.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/diff.c           | 13 +++++++++++--
 t/t4053-diff-no-index.sh |  6 ++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index adb93a9..47c0833 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -257,7 +257,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
-	int nongit;
+	int nongit, no_index = 0;
 	int result = 0;
 
 	/*
@@ -282,9 +282,18 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 *
 	 * Other cases are errors.
 	 */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--"))
+			break;
+		if (!strcmp(argv[i], "--no-index")) {
+			no_index = 1;
+			break;
+		}
+	}
 
 	prefix = setup_git_directory_gently(&nongit);
-	gitmodules_config();
+	if (!no_index)
+		gitmodules_config();
 	git_config(git_diff_ui_config, NULL);
 
 	init_revisions(&rev, prefix);
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 979e983..a24ae4d 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -29,4 +29,10 @@ test_expect_success 'git diff --no-index relative path outside repo' '
 	)
 '
 
+test_expect_success 'git diff --no-index with broken index' '
+	cd repo &&
+	echo broken >.git/index &&
+	test_expect_code 0 git diff --no-index a ../non/git/a
+'
+
 test_done
-- 
1.8.4.2
