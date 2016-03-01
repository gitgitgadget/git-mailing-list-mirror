From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 20/33] refs: don't dereference on rename
Date: Mon, 29 Feb 2016 19:52:53 -0500
Message-ID: <1456793586-22082-21-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYaJ-0007ZN-LD
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbcCAAyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:39 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33711 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcCAAxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:50 -0500
Received: by mail-qg0-f42.google.com with SMTP id d32so74638708qgd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HtecaJmwJ5GdYUxAHiaeQn+8JV1yDGCqqxmkHmyFC24=;
        b=r2Nef9UpjDTuqkfijC9gH9dk9g28Ij/VxrIzGqGRs+WDgk376O1ahxq+xfK+vKM6E7
         oorr2fBRAHWDDhFU3PGUzkRnl7LF2Bb7+4b8kO/uzCYh769RERf2q0wZoisfTiUbE2KR
         ADz1/pxqiSVRJ+wjijOcVMTMALzEfS+EAfVnMdVDirh8bxJCI10wMURgnM/TNV0mZ5AK
         p/ydoKrY741tGvvd7H4POrkLQTgGVhzTvfaaJ2fwEUn8hx7TwaPsUvwhGSBjErQ7rndK
         k2g5yXtupuML/hj5V1eRxZpLjLO3qbDh23nmTb9DQdL4UCvrOTt+TLOm3Np2H/kx/GU9
         etAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HtecaJmwJ5GdYUxAHiaeQn+8JV1yDGCqqxmkHmyFC24=;
        b=e0Ow2+mfizxCUv+sWab4fo/zcbukC4s/K/J6bEVSu50xqmpVdhQAlAJs64kSIJKyiN
         FzKlyWLAwDE2NSQhiCHvWxES9HwaQT+Q1XfnBsGWR2sayXNeUvOiQ87oH26YOLbcisdB
         Jj3rhlDayogkOpjif8pDAlL9bkI7uPrSSTIAPx1MWcpsoETdEivk5c444O8JvqS4RmWH
         /mKMD3Se+mE+L0kcGU43LdfqMFmAebJQpuBub123lRvxeF4ET5VwTG3KUJFRfRoD+71z
         ft2Odu+GWwcLGmJHdq5ekkeQZPLU3XPK80MKrMv2ILfaQaJaPB38GKywaNtsbxoL74bd
         8YWw==
X-Gm-Message-State: AD7BkJKRYj5OLnroxmpzhWf7TmbHdCAYRT2iw+/k5b8wo1fG/A8o07dPjb5xqPZL7ikTDw==
X-Received: by 10.140.235.137 with SMTP id g131mr24744906qhc.43.1456793629405;
        Mon, 29 Feb 2016 16:53:49 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:48 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287970>

When renaming refs, don't dereference either the origin or the destination
before renaming.

The origin does not need to be dereferenced because it is presently
forbidden to rename symbolic refs.

Not dereferencing the destination fixes a bug where renaming on top of
a broken symref would use the pointed-to ref name for the moved
reflog.

Add a test for the reflog bug.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 15 +++++++++------
 t/t3200-branch.sh    |  9 +++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 189b86e..7c557b2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2363,7 +2363,7 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
-	int flag = 0, logmoved = 0;
+	int flag = 0, logmoved = 0, resolve_flags;
 	struct ref_lock *lock;
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
@@ -2373,7 +2373,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
+	resolve_flags = RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE;
+	symref = resolve_ref_unsafe(oldrefname, resolve_flags,
 				    orig_sha1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
@@ -2393,8 +2394,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
-	    delete_ref(newrefname, sha1, REF_NODEREF)) {
+	if (!read_ref_full(newrefname, resolve_flags, sha1, NULL) &&
+	    delete_ref(newrefname, NULL, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -2418,7 +2419,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2436,7 +2438,8 @@ static int files_rename_ref(const char *oldrefname, const char *newrefname,
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a897248..144e9ce 100755
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
