From: David Turner <dturner@twopensource.com>
Subject: [PATCH] untracked-cache: support sparse checkout
Date: Fri, 31 Jul 2015 13:35:01 -0400
Message-ID: <1438364101-6597-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 31 19:36:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLEEA-0006Q4-EE
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 19:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbbGaRgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 13:36:09 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35121 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbbGaRgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 13:36:08 -0400
Received: by qgii95 with SMTP id i95so50527850qgi.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 10:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jNFihkvk6Z92aTZYwBSDuv2gMeqOce1GQAs8jXMTwQc=;
        b=hSMb7vzdz+EhTeUmluB3bY09Wfb2Cx+ESnXubjMRRUNGpezbI4CVWpTavnKoZuUil4
         fEh+JfEz2Dd8W5ukIEUosMnXgsba+YCWXaSYAcs9g5xIMhd+uon2X9SYVyj6kucwAZVI
         Q3IBNDOcagIlFixLkLR7E3Q641CNyHLQmTw25ity0gLNkMy+h9JRmJb4gddTBfDN3JxP
         BlCiz1ITN9k8UHcCsFp/toobbl8vL9whI0BUuOT7pgC9lI9q3F38+TUjxMNNH/a3o0SP
         vIuYCB+bnYlVmGiBT+TqMU1VwUgp1gUYyk9mg/Z1Da+6a+Jz8vPdvpZ2NX2sZ33fBoL3
         JW6A==
X-Gm-Message-State: ALoCoQmsFTya4KtMWO0y4nME3yfgpRLQ80NgrOaFGl2h9QioveH93di1ECUWOV5fMK9qkkmyAQWx
X-Received: by 10.140.27.143 with SMTP id 15mr6112989qgx.64.1438364167066;
        Fri, 31 Jul 2015 10:36:07 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 67sm2531042qhy.25.2015.07.31.10.36.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Jul 2015 10:36:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275055>

Remove a check that would disable the untracked cache for sparse
checkouts.  Add tests that ensure that the untracked cache works with
sparse checkouts -- specifically considering the case that a file
foo/bar is checked out, but foo/.gitignore is not.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 dir.c                             |  17 +-----
 t/t7063-status-untracked-cache.sh | 119 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index 8209f8b..e7b89fe 100644
--- a/dir.c
+++ b/dir.c
@@ -1078,10 +1078,9 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		    (!untracked || !untracked->valid ||
 		     /*
 		      * .. and .gitignore does not exist before
-		      * (i.e. null exclude_sha1 and skip_worktree is
-		      * not set). Then we can skip loading .gitignore,
-		      * which would result in ENOENT anyway.
-		      * skip_worktree is taken care in read_directory()
+		      * (i.e. null exclude_sha1). Then we can skip
+		      * loading .gitignore, which would result in
+		      * ENOENT anyway.
 		      */
 		     !is_null_sha1(untracked->exclude_sha1))) {
 			/*
@@ -1880,7 +1879,6 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 						      const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *root;
-	int i;
 
 	if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
 		return NULL;
@@ -1932,15 +1930,6 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	if (dir->exclude_list_group[EXC_CMDL].nr)
 		return NULL;
 
-	/*
-	 * An optimization in prep_exclude() does not play well with
-	 * CE_SKIP_WORKTREE. It's a rare case anyway, if a single
-	 * entry has that bit set, disable the whole untracked cache.
-	 */
-	for (i = 0; i < active_nr; i++)
-		if (ce_skip_worktree(active_cache[i]))
-			return NULL;
-
 	if (!ident_in_untracked(dir->untracked)) {
 		warning(_("Untracked cache is disabled on this system."));
 		return NULL;
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index bd4806c..ff23f4e 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -354,4 +354,123 @@ EOF
 	test_cmp ../expect ../actual
 '
 
+test_expect_success 'set up for sparse checkout testing' '
+	echo two >done/.gitignore &&
+	echo three >>done/.gitignore &&
+	echo two >done/two &&
+	git add -f done/two done/.gitignore &&
+	git commit -m "first commit"
+'
+
+test_expect_success 'status after commit' '
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+?? .gitignore
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 1
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'untracked cache correct after commit' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'set up sparse checkout' '
+	echo "done/[a-z]*" >.git/info/sparse-checkout &&
+	test_config core.sparsecheckout true &&
+	git checkout master &&
+	git update-index --untracked-cache &&
+	git status --porcelain >/dev/null && # prime the cache
+	test_path_is_missing done/.gitignore &&
+	test_path_is_file done/one
+'
+
+test_expect_success 'create files, some of which are gitignored' '
+	echo three >done/three && # three is gitignored
+	echo four >done/four && # four is gitignored at a higher level
+	echo five >done/five # five is not gitignored
+'
+
+test_expect_success 'test sparse status with untracked cache' '
+	: >../trace &&
+	avoid_racy &&
+	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../status.actual &&
+	cat >../status.expect <<EOF &&
+?? .gitignore
+?? done/five
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../status.actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 1
+directory invalidation: 2
+opendir: 2
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'untracked cache correct after status' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
+five
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'test sparse status again with untracked cache' '
+	avoid_racy &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../status.actual &&
+	cat >../status.expect <<EOF &&
+?? .gitignore
+?? done/five
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../status.actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 0
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
 test_done
-- 
2.0.4.315.gad8727a-twtrsrc
