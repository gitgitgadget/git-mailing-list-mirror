From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 16/27] refs: don't dereference on rename
Date: Thu, 18 Feb 2016 00:17:39 -0500
Message-ID: <1455772670-21142-17-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:19:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGza-0001XI-00
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424950AbcBRFTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:19:00 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:36309 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424865AbcBRFSt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:49 -0500
Received: by mail-qg0-f45.google.com with SMTP id y9so29818800qgd.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=So2N63p6cvb4HgQMU9d8l/tce3YIW0lm6YBnoDo/108=;
        b=V8OyuSJBb/NakGunGJFyTkltvIqcZ653znDpEylpmwv5fUmk59xWKMZPOZ/MUtVRy9
         kwqJh4T2JqclecIZk2GfPhaIOKvJD8mEA7tqmapZ0jd77etYt64g0tBuRkYp9Gou6LxD
         NSSbvpy5fiPdP/DuUublUJDQb3SGI+TAm3L8Uy1SyYn1LuBGJz9b+CvqlvXI7wntPHt+
         y4Rl4GQWKAydJzXn2UEzZeeM/0cGY2uTjrrxuuMzlBh9tnJjfPX6YnPUrG13dj/mGgeg
         m5/w/6cYDHWYBQE0TdYUMfTSxQsW2MnVE1A1NiYZxwXYEX8LyqUdJCOwtuat+FaloRYq
         PUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=So2N63p6cvb4HgQMU9d8l/tce3YIW0lm6YBnoDo/108=;
        b=WpWxtZ0UGUMcoNjy6//zw353PUdcUtXoHLZLMI3l5wmTks90L3DWFNuTgOPytB5trr
         9OqVVKqBu3UPpnF9HI3gkiPbrfZCjfOSVQPVSfu3eMKQyezuw4VGKZcAFla3oG4h9pdo
         5GDcOonrxM6lCSEYimUj4WuNlbJMn3eMwM7Dq25f3AI4UPOc/rcDvgd/1o07XXQ/qZHq
         FqO+vV0+yNGj6tcRIuhQyQOqwrugwy7iSNe3obvpN3jakFoi+4yPAUtutguW7iOsKul1
         9LFLK6bL8gLmk/QiR3l4EImaMoVquhSSKeEHkUDMcG9B8N6nBktfEd8w3anQBi5sAKOZ
         EgeQ==
X-Gm-Message-State: AG10YOSt9anwYE3B+K8vYQHvp42DrEFNcYO9ZFRSvYFEuTGiPFXbEHjSHeYfRQKoJq3TXA==
X-Received: by 10.140.136.210 with SMTP id 201mr7072663qhi.6.1455772728959;
        Wed, 17 Feb 2016 21:18:48 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:48 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286584>

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
index 592d0ff..4863b21 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2428,7 +2428,7 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
-	int flag = 0, logmoved = 0;
+	int flag = 0, logmoved = 0, resolve_flags;
 	struct ref_lock *lock;
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
@@ -2438,7 +2438,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
+	resolve_flags = RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE;
+	symref = resolve_ref_unsafe(oldrefname, resolve_flags,
 				    orig_sha1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
@@ -2458,8 +2459,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
-	    delete_ref(newrefname, sha1, REF_NODEREF)) {
+	if (!read_ref_full(newrefname, resolve_flags, sha1, NULL) &&
+	    delete_ref(newrefname, NULL, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -2483,7 +2484,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2501,7 +2503,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
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
