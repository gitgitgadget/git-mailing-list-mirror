From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 01/27] refs: Move head_ref{,_submodule} to the common code
Date: Thu, 18 Feb 2016 00:17:24 -0500
Message-ID: <1455772670-21142-2-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGz1-0000ze-79
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbcBRFS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:28 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:32790 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbcBRFS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:26 -0500
Received: by mail-qg0-f45.google.com with SMTP id b35so29341677qge.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UpGDHe2g6rP7J3fTyReG7T2DpwNbl8MHwXC38Uow7WQ=;
        b=du5n41j4U9M9aSVmSGPQHcrULt7HWyFtU87jWK9hfbbEq81zoDQVsGdGUON8nauX2H
         b66R9YvuMaZsfw5Cr91Yz5sMnT1X/aDvZKFNCrSkucZE29Csr9iEbaMbcJl6P94QiIjl
         8attH4GUjHnpWSHp7Y4ctCXIBtKW6uDuwET89NPISFLnaqZdGZ04HRn2tRNQvTeOFsdu
         9Q1IYuiL962TLtsQGeQ/j+YzOdu6KAkn/K2DryzBcw/OM5p9XeT3T39fqC9ISw1260Lh
         irv3Eqw7FbnsX0QOiZxYWrlpw4PBUIKhA4tloS4j4YaDwOW+pskP9SwtitKqrWrsnlnU
         eQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UpGDHe2g6rP7J3fTyReG7T2DpwNbl8MHwXC38Uow7WQ=;
        b=m5oFlYHFFAARA8hjcrZ8qkieWBatitHw3R91TqOK7QegOoohRQ50JkMzT7TZPMFKSy
         uBBrkgzTvhvcDSrVJ8VEDouovk/A4xRPuf3NIFhT65W80hymB6S4N6lX7UxTOtcXWwl0
         skYY+fqnbogvRphIoVb4kmcutyEslv+MtfZMMc+6PQT4jGAfatWcOKK8d7ie4mOTmSCY
         MCtxNbCySbhuMdyfMOKvJ/+DR58hM6p+7utrzOvZuBXizWUulkQ3Mifl99PPMs2DDNAN
         0ySuJUYfo14deYyTXwunOpvcUwtjR8RjSUYRElN4YQZ+v/2R/dpk5HTvhOUyQgGIq0QR
         n3cg==
X-Gm-Message-State: AG10YOT0vxKJ6BJKczAZzVPM6vxyRGC+BdLIVm1kMJS5lSReLwoDKHd2BMzTnHlexcRQsQ==
X-Received: by 10.140.93.65 with SMTP id c59mr6532787qge.101.1455772705509;
        Wed, 17 Feb 2016 21:18:25 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:24 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286573>

These don't use any backend-specific functions.  These were previously
defined in terms of the do_head_ref helper function, but since they
are otherwise identical, we don't need that function.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 23 +++++++++++++++++++++++
 refs/files-backend.c | 28 ----------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index e2d34b2..4367c14 100644
--- a/refs.c
+++ b/refs.c
@@ -1082,3 +1082,26 @@ int rename_ref_available(const char *oldname, const char *newname)
 	strbuf_release(&err);
 	return ret;
 }
+
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	struct object_id oid;
+	int flag;
+
+	if (submodule) {
+		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
+			return fn("HEAD", &oid, 0, cb_data);
+
+		return 0;
+	}
+
+	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+		return fn("HEAD", &oid, flag, cb_data);
+
+	return 0;
+}
+
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return head_ref_submodule(NULL, fn, cb_data);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b569762..2e2a6d9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1753,34 +1753,6 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	struct object_id oid;
-	int flag;
-
-	if (submodule) {
-		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
-			return fn("HEAD", &oid, 0, cb_data);
-
-		return 0;
-	}
-
-	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
-		return fn("HEAD", &oid, flag, cb_data);
-
-	return 0;
-}
-
-int head_ref(each_ref_fn fn, void *cb_data)
-{
-	return do_head_ref(NULL, fn, cb_data);
-}
-
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return do_head_ref(submodule, fn, cb_data);
-}
-
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
-- 
2.4.2.767.g62658d5-twtrsrc
