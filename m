From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 1/2] sha1-name: pass len argument to interpret_branch_name()
Date: Sun,  8 Sep 2013 21:06:33 -0500
Message-ID: <1378692394-27096-2-git-send-email-felipe.contreras@gmail.com>
References: <1378692394-27096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 04:11:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqx6-0005xN-3o
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 04:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649Ab3IICLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 22:11:41 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:34816 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3IICLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 22:11:39 -0400
Received: by mail-oa0-f45.google.com with SMTP id m6so5968034oag.18
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 19:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WLz3/TAYBri91Xf1p+78iv+WzjBlGjWmdM/L3FCOOH0=;
        b=ZxbFFueku68LhlHaJJ7uUUrhO/yLdDoqzfne9QSHN3k4jK4eCW+VSpzkBd1PXIqR8F
         TRRAvDyeozwgRPMx8a2voaUYxX9o4DvCqa3rAbvCLIhzj5Fo5BTib6ZqwvS7n3no8j3h
         X/O5m6TS8oCwLOiMeO/RLZXl3yqj1tXsEHlAewRF/aPMkw/pHXgHEVjW5CH8X65H92OV
         BBVfLr439fr+xFBCWDG7DO1vOfzlFNdqU9nhaiz8aj+mpSWXbRWnTK/JM46ydXViF/Xn
         qJIvNEYOZhqdiiqTZBWiRnjfpo+42uYBgyKYP9QR/dBLqjrWyrLU+hxmwIl0WcQ5tBGr
         VI3w==
X-Received: by 10.60.17.136 with SMTP id o8mr9747289oed.7.1378692699452;
        Sun, 08 Sep 2013 19:11:39 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm11168918oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 19:11:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378692394-27096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234305>

This is useful to make sure we don't step outside the boundaries of what
we are interpreting at the moment. For example while interpreting
foobar@{u}~1, the job of interpret_branch_name() ends right before ~1,
but there's no way to figure that out inside the function, unless the
len argument is passed.

So let's do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 cache.h     |  2 +-
 refs.c      |  2 +-
 revision.c  |  2 +-
 sha1_name.c | 10 ++++++----
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 85b544f..9fbc5fa 100644
--- a/cache.h
+++ b/cache.h
@@ -893,7 +893,7 @@ extern char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, i
 
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
-extern int interpret_branch_name(const char *str, struct strbuf *);
+extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
 extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
diff --git a/refs.c b/refs.c
index 7922261..8fd5faf 100644
--- a/refs.c
+++ b/refs.c
@@ -1951,7 +1951,7 @@ static int remove_empty_directories(const char *file)
 static char *substitute_branch_name(const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, &buf);
+	int ret = interpret_branch_name(*string, *len, &buf);
 
 	if (ret == *len) {
 		size_t size;
diff --git a/revision.c b/revision.c
index 84ccc05..3ef1384 100644
--- a/revision.c
+++ b/revision.c
@@ -200,7 +200,7 @@ static void add_pending_object_with_mode(struct rev_info *revs,
 		revs->no_walk = 0;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
-		int len = interpret_branch_name(name, &buf);
+		int len = interpret_branch_name(name, 0, &buf);
 		int st;
 
 		if (0 < len && name[len] && buf.len)
diff --git a/sha1_name.c b/sha1_name.c
index 65ad066..93197b9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1012,7 +1012,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 	int ret;
 
 	strbuf_add(buf, name + len, namelen - len);
-	ret = interpret_branch_name(buf->buf, &tmp);
+	ret = interpret_branch_name(buf->buf, buf->len, &tmp);
 	/* that data was not interpreted, remove our cruft */
 	if (ret < 0) {
 		strbuf_setlen(buf, used);
@@ -1046,14 +1046,16 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
  * If the input was ok but there are not N branch switches in the
  * reflog, it returns 0.
  */
-int interpret_branch_name(const char *name, struct strbuf *buf)
+int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *cp;
 	struct branch *upstream;
-	int namelen = strlen(name);
 	int len = interpret_nth_prior_checkout(name, buf);
 	int tmp_len;
 
+	if (!namelen)
+		namelen = strlen(name);
+
 	if (!len) {
 		return len; /* syntax Ok, not enough switches */
 	} else if (len > 0) {
@@ -1100,7 +1102,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 int strbuf_branchname(struct strbuf *sb, const char *name)
 {
 	int len = strlen(name);
-	int used = interpret_branch_name(name, sb);
+	int used = interpret_branch_name(name, len, sb);
 
 	if (used == len)
 		return 0;
-- 
1.8.4-338-gefd7fa6
