From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 11/11] branch.c: replace `git_config()` with `git_config_get_string()
Date: Thu, 07 Aug 2014 23:26:42 +0530
Message-ID: <53E3BDDA.1090208@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com> <1407428486-19049-12-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 19:56:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFRvq-0004zn-Ix
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 19:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbaHGR4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 13:56:50 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:62469 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbaHGR4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 13:56:48 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so5578945pdj.21
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Z262wVcLT1ikFV2zrULewQ++FY925qwqcCtpQbUa4qc=;
        b=rOAzy2QO+BVrWu6NyG1IPafS2tXP9nIvSyvl/SP/ot20QQcodl3rd42hB4noWuvQek
         7aT/EuPS27FBIE7cMnNkxi4pobUBenC/+dH8UM2uqiuX/XAezqDf7soGuk7TL+NU00WU
         cZfpJD+4Rf+8TGZFfwIMY1z/GLCuwvQ4oJ83TfOBLJtlfzeEj2+pQvU4SEvaDj2tK/YT
         +RLNjstInVzXdZsgEwJ3kz50duwmL77yxurcdK3JZpWxnlV9w/iB4i6JgXxATglXX0Ad
         xoN4moftcQ/AgzMZUxbYuOE9pW+xyY5C9vT8iF+hvcF1tEDdT1EkhCpZZq132lOpsCwr
         rA1Q==
X-Received: by 10.68.229.166 with SMTP id sr6mr3481846pbc.33.1407434208289;
        Thu, 07 Aug 2014 10:56:48 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.226.83])
        by mx.google.com with ESMTPSA id za9sm615736pac.25.2014.08.07.10.56.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 10:56:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1407428486-19049-12-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254983>

Use `git_config_get_string()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow. While we are at
it, return -1 if we find no value for the queried variable. Original code
returned 0 for all cases, which was checked by `add_branch_desc()` in
fmt-merge-msg.c resulting in addition of a spurious newline to the `out`
strbuf. Now, the newline addition is skipped as -1 is returned to the caller
if no value is found.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
v3: Changed the commit message to a more appropriate one.

 branch.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/branch.c b/branch.c
index 735767d..df6b120 100644
--- a/branch.c
+++ b/branch.c
@@ -140,30 +140,17 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	return 0;
 }

-struct branch_desc_cb {
-	const char *config_name;
-	const char *value;
-};
-
-static int read_branch_desc_cb(const char *var, const char *value, void *cb)
-{
-	struct branch_desc_cb *desc = cb;
-	if (strcmp(desc->config_name, var))
-		return 0;
-	free((char *)desc->value);
-	return git_config_string(&desc->value, var, value);
-}
-
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
 {
-	struct branch_desc_cb cb;
+	char *v = NULL;
 	struct strbuf name = STRBUF_INIT;
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	cb.config_name = name.buf;
-	cb.value = NULL;
-	git_config(read_branch_desc_cb, &cb);
-	if (cb.value)
-		strbuf_addstr(buf, cb.value);
+	if (git_config_get_string(name.buf, &v)) {
+		strbuf_release(&name);
+		return -1;
+	}
+	strbuf_addstr(buf, v);
+	free(v);
 	strbuf_release(&name);
 	return 0;
 }
-- 1.9.0.GIT
