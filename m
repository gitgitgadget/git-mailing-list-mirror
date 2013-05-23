From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] sha1_name: remove upstream_mark()
Date: Thu, 23 May 2013 20:42:46 +0530
Message-ID: <1369321970-7759-4-git-send-email-artagnon@gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 23 17:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXB6-0003im-DO
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834Ab3EWPLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:11:35 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:40278 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759213Ab3EWPLO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:11:14 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so3028096pbc.30
        for <git@vger.kernel.org>; Thu, 23 May 2013 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=O7UCU8OLKQbW3AsKcczrl+ldTV8kmxxEd0dRHYsGbYc=;
        b=GhRIV2nTCZv5KAbuXjv2sMl+pkgh1Az1pPts6j+tOKgfNv5XiKlenOJpxsnAao3yNP
         CNbLwOIS/RC6FPn9CPI1YssRIYOhuEzBoHOM9c/euTZBY9p1KMkC4sM3PTXOfSJZY8uc
         OmptSFb4DhBahhU7B7p8YWYmykfi+iibByR/k5PlKNiUEFBy8VDvqJakz5W+KvWORyE3
         IfUV0Ediu5khUNR6z4y4zrQexCHigG0SA/JHJkqSSV7VTk31wuu5aZQbE+q2bkAWtVAS
         QfxqYmHjpk3a7FurHD7mI3vp4vUYVhpZUvAQFqxpba9AJWJ6GT4vw/ErSYbeUwCMoRgo
         H6ww==
X-Received: by 10.68.172.36 with SMTP id az4mr13160005pbc.211.1369321873877;
        Thu, 23 May 2013 08:11:13 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vb8sm12099173pbc.11.2013.05.23.08.11.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 08:11:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225261>

The first caller get_sha1_basic() just wants to make sure that no
non-numerical @{...} form was matched, so that it can proceed with
processing numerical @{...} forms.  Since we're going to introduce more
non-numerical @{...} forms, replace this upstream_mark() call with a
call to at_mark() passing NULL as the last argument; we don't care what
the kind is: all we need to know is if the return value is zero (parse
failure).

The second caller interpret_branch_name() will be expanded in the future
to handle all possible AT_KIND_* values.  So, replace the
upstream_mark() call with an upstream_mark() call capturing at_kind and
using it in a switch statement to perform the appropriate action.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 7aabd94..106716e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -443,15 +443,6 @@ static inline int at_mark(const char *string, int len, int *kind)
 	return 0;
 }
 
-static inline int upstream_mark(const char *string, int len)
-{
-	int suffix_len, kind;
-	suffix_len = at_mark(string, len, &kind);
-	if (suffix_len && kind == AT_KIND_UPSTREAM)
-		return suffix_len;
-	return 0;
-}
-
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
@@ -469,7 +460,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (len && str[len-1] == '}') {
 		for (at = len-2; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
-				if (!upstream_mark(str + at, len - at)) {
+				if (!at_mark(str + at, len - at, NULL)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1044,6 +1035,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	int namelen = strlen(name);
 	int len = interpret_nth_prior_checkout(name, buf);
 	int tmp_len;
+	int at_kind;
 
 	if (!len)
 		return len; /* syntax Ok, not enough switches */
@@ -1072,15 +1064,21 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	cp = strchr(name, '@');
 	if (!cp)
 		return -1;
-	tmp_len = upstream_mark(cp, namelen - (cp - name));
+	tmp_len = at_mark(cp, namelen - (cp - name), &at_kind);
 	if (!tmp_len)
 		return -1;
 	len = cp + tmp_len - name;
 	cp = xstrndup(name, cp - name);
 	branch = branch_get(*cp ? cp : NULL);
-	die_no_upstream(branch, cp);
-	free(cp);
-	cp = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+
+	switch (at_kind) {
+	case AT_KIND_UPSTREAM:
+		die_no_upstream(branch, cp);
+		free(cp);
+		cp = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+		break;
+	}
+
 	strbuf_reset(buf);
 	strbuf_addstr(buf, cp);
 	free(cp);
-- 
1.8.3.rc3.17.gd95ec6c.dirty
