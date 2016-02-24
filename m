From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 19/32] refs: don't dereference on rename
Date: Wed, 24 Feb 2016 17:58:51 -0500
Message-ID: <1456354744-8022-20-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPO-0003fn-BL
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759198AbcBXW7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:44 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35026 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759157AbcBXW7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:35 -0500
Received: by mail-qg0-f47.google.com with SMTP id y89so26982725qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pATkSLibOgj0iAOXo9jPM2ZfHRyxYVKhVr4uipQc8RI=;
        b=PdA6v5UghsxMW7pNcGrvemRZB6gW2A3JQFBzxYRd6fSV9z5eqmcog83ZT+GG9adHOX
         AQF4ZMeMp5tuIof+kjU/C4UYNelE849HqoVPr3aBJ7gsIKFNKDl0nwmUkd12Jm+8MklA
         GObzdKYpAfHyVdrX0rzO+SGbAsKJZzzwD5a6YIePNA/8P5jOZGIKS4EGtswr0MeKN2Fw
         5kkj4IOY/slS8nWOwmKy8TKsJD3rqm1cXZHBb9ub6mRrzPVB7FonYDGHYoiDTX3dCtgg
         eJPHZt9AhZgGPYsWqQy7IBykHqtIUndRsNn6q1rH/+nkKCUpBaKGxOxm3uhT3bzCKqmd
         k6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pATkSLibOgj0iAOXo9jPM2ZfHRyxYVKhVr4uipQc8RI=;
        b=kk6WQY2Ip0OXFRhEnFxo2U8y9hrX9ExGURWli2x8RzQGIMc4alPTKZ6YfGnrnpoE4n
         WdR9CG2RaiEVyaHPmw9LpxYzsXToQ1zRu8FfIZXQHqujF5Qws/P5wgGbtE0S7YNFel2D
         QTpZku1ZgzNBD/YhYR1iSCx90RU1AWAZYXnTpJ6aj353bvJBWr7BUvke/w8Pszs6tfBJ
         gpU6ZoNmIr0XwgrCdNjxN9HdLR7rbLjIkUI8pMlkLzFEH3xmLXos2HNVcmhcJS2ZiM/D
         1dKgogyWJ3rrSv80iW2TlFUiba2AbppfieaO8WzLUubcdrT0z7Bnituzuxi+GHSiSY1c
         Qiqw==
X-Gm-Message-State: AG10YOS5BnLUPNVU1DBn7hwmQYXutebXP+3JIR+AR7JS4ryNcFcJzPRO3XMKVX3movPs+Q==
X-Received: by 10.140.20.39 with SMTP id 36mr51514196qgi.15.1456354774767;
        Wed, 24 Feb 2016 14:59:34 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:34 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287252>

When renaming refs, don't dereference either the origin or the destination
before renaming.

The origin does not need to be dereferenced because it is presently
forbidden to rename symbolic refs.

Not dereferencing the destination fixes a bug where renaming on top of
a broken symref would use the pointed-to ref name for the moved
reflog.

Add a test for the reflog bug.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 +++++++++------
 t/t3200-branch.sh    |  9 +++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8dc80e2..7a3c9df 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2372,7 +2372,7 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
-	int flag = 0, logmoved = 0;
+	int flag = 0, logmoved = 0, resolve_flags;
 	struct ref_lock *lock;
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
@@ -2382,7 +2382,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
+	resolve_flags = RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE;
+	symref = resolve_ref_unsafe(oldrefname, resolve_flags,
 				    orig_sha1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
@@ -2402,8 +2403,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
-	    delete_ref(newrefname, sha1, REF_NODEREF)) {
+	if (!read_ref_full(newrefname, resolve_flags, sha1, NULL) &&
+	    delete_ref(newrefname, NULL, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -2427,7 +2428,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2445,7 +2447,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdaf6f6..07e9749 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -79,6 +79,15 @@ test_expect_success 'git branch -m dumps usage' '
 	test_i18ngrep "branch name required" err
 '
 
+test_expect_success 'git branch -m m broken_symref should work' '
+	test_when_finished "git branch -D broken_symref" &&
+	git branch -l m &&
+	git symbolic-ref refs/heads/broken_symref refs/heads/i_am_broken &&
+	git branch -m m broken_symref &&
+	git reflog exists refs/heads/broken_symref &&
+	test_must_fail git reflog exists refs/heads/i_am_broken
+'
+
 test_expect_success 'git branch -m m m/m should work' '
 	git branch -l m &&
 	git branch -m m m/m &&
-- 
2.4.2.767.g62658d5-twtrsrc
