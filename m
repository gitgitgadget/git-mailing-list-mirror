From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 7/8] update-index: prevent --untracked-cache from performing tests
Date: Tue,  1 Dec 2015 21:31:38 +0100
Message-ID: <1449001899-18956-8-git-send-email-chriscool@tuxfamily.org>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:33:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rbp-0000ON-Bw
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbbLAUdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:33:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33776 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393AbbLAUcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:45 -0500
Received: by wmuu63 with SMTP id u63so5079508wmu.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rLzmWufVumziQE3+mu8HC3CR4CzgrD4tG3iiqg0+eC0=;
        b=rGc1FvLzmQCWKwePxJANxAi+1+TapqpINqZi4MQqk8bU0+WquZ0xW1rJ6iAbyxaah2
         7FECWr30TFKuLxBWSiP/fIbilOGPqm1TRBFtbUD7CygxCnd7Z8byPPdEYV6YhIy2I0G1
         wS8gGJKjGWmm9/LHyWnYhEXzjEMhWh7CxzclP/snN4TiSWYCyR62jpg+v4VuOwT8Y0w4
         6B6MXH8U+XOO24ylEJ7LGFagofLE00Hy4iJRvD2vCv5jGcMvOvhh6gcuyGtYgFuVVdM/
         XyyT7amIZBZTfaZGF+klNX61V3f4Bqwy//TfX0pe1yy3kL0ZokA8BLqhLPwyWzsCvdQ2
         FLhA==
X-Received: by 10.28.225.84 with SMTP id y81mr40412225wmg.87.1449001964695;
        Tue, 01 Dec 2015 12:32:44 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:43 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
In-Reply-To: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281851>

`git update-index --untracked-cache` used to perform tests to
check that the underlying operating system and file system
change `st_mtime` field of a directory if files are added or
deleted in that directory. But those tests take a long time
and there is now `--test-untracked-cache` to perform them.

So to be more consistent with other git commands it's better
to make `--untracked-cache` not perform them, which is the
purpose of this patch.

Note that after this patch there is no difference any more
between `--untracked-cache` and `--force-untracked-cache`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 31 ++++++++++++++++---------------
 builtin/update-index.c             |  7 ++-----
 t/t7063-status-untracked-cache.sh  |  2 +-
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 4e6078b..5f74cc7 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -175,27 +175,28 @@ may not support it yet.
 --no-untracked-cache::
 	Enable or disable untracked cache extension. This could speed
 	up for commands that involve determining untracked files such
-	as `git status`. The underlying operating system and file
-	system must change `st_mtime` field of a directory if files
-	are added or deleted in that directory. If you want to always
-	enable, or always disable, untracked cache, you can set the
-	`core.untrackedCache` configuration variable to 'true' or
-	'false' respectively, (see linkgit:git-config[1]).
+	as `git status`.
++
+The underlying operating system and file system must change `st_mtime`
+field of a directory if files are added or deleted in that
+directory. You can test that using
+`--test-untracked-cache`. `--untracked-cache` used to test that too
+but it doesn't anymore. If you want to always enable, or always
+disable, untracked cache, you can set the `core.untrackedCache`
+configuration variable to 'true' or 'false' respectively, (see
+linkgit:git-config[1]).
 
 --test-untracked-cache::
 	Only perform tests on the working directory to make sure
 	untracked cache can be used. You have to manually enable
-	untracked cache using `--force-untracked-cache` (or
-	`--untracked-cache` but this will run the tests again)
-	afterwards if you really want to use it.
+	untracked cache using `--untracked-cache` or
+	`--force-untracked-cache` afterwards if you really want to use
+	it.
 
 --force-untracked-cache::
-	For safety, `--untracked-cache` performs tests on the working
-	directory to make sure untracked cache can be used. These
-	tests can take a few seconds. `--force-untracked-cache` can be
-	used to skip the tests. It cannot enable untracked cache if
-	`core.untrackedCache` configuration variable is set to false
-	(see linkgit:git-config[1]).
+	Same as `--untracked-cache`. Note that this option cannot
+	enable untracked cache if `core.untrackedCache` configuration
+	variable is set to false (see linkgit:git-config[1]).
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index bf697a5..fb0ea3d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1106,12 +1106,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
-	if (untracked_cache == 2 || (untracked_cache == 1 && use_untracked_cache == -1)) {
+	if (untracked_cache == 2) {
 		setup_work_tree();
-		if (!test_if_untracked_cache_is_supported())
-			return 1;
-		if (untracked_cache == 2)
-			return 0;
+		return !test_if_untracked_cache_is_supported();
 	}
 	if (untracked_cache > 0) {
 		if (!use_untracked_cache)
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 0e8d0d4..8c3e703 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -11,7 +11,7 @@ avoid_racy() {
 # It's fine if git update-index returns an error code other than one,
 # it'll be caught in the first test.
 test_lazy_prereq UNTRACKED_CACHE '
-	{ git update-index --untracked-cache; ret=$?; } &&
+	{ git update-index --test-untracked-cache; ret=$?; } &&
 	test $ret -ne 1
 '
 
-- 
2.6.3.391.g95a3a5c
