From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 2/6] branch.c: replace `git_config()` with `git_config_get_string()`
Date: Mon, 21 Jul 2014 04:12:21 -0700
Message-ID: <1405941145-12120-3-git-send-email-tanayabh@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 13:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9BXP-0008Lh-1I
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 13:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbaGULNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 07:13:34 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47867 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaGULNd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 07:13:33 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so9145245pab.0
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 04:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T666wXxk8fVRbCTkMvMS8LJmufeTD4l/GAqnhWzvUTg=;
        b=DXj6KRMuCGdLy+0fyiqmCsdT9QYWftLbInR+Y0+XON3EPlajFBfdijkL/rNz0bxmKH
         KHxGQ3yiibP50Pi/b2+8yAFUh5C692o2lhVfAvMTDn+/aDOjQfnvT5h3edsfgTCCQH+P
         xo7legwyuQciv5wLK+fmzghbFaR0rmKYwCwBdPySZK4nKrlrFhkjNXt8HYxlLzmZUG5q
         fLyRBIpZM4706Xogcqor+ec23AGT94V9UHaDIUtVsqTHe3mvR2paP433Sh2eU/Oq6pbe
         cJOhPDA190Fpv1zTMY66qAANJdLRU1sGxe7R63FFpbiMJ53fDcAy0hOsGz2mKRk1CxUN
         Udhg==
X-Received: by 10.68.171.193 with SMTP id aw1mr8463273pbc.117.1405941212969;
        Mon, 21 Jul 2014 04:13:32 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.202])
        by mx.google.com with ESMTPSA id bl12sm2603688pac.44.2014.07.21.04.13.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 04:13:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253952>

Use `git_config_get_string()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 branch.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/branch.c b/branch.c
index 46e8aa8..827307f 100644
--- a/branch.c
+++ b/branch.c
@@ -140,33 +140,17 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
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
+	const char *v = NULL;
 	struct strbuf name = STRBUF_INIT;
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	cb.config_name = name.buf;
-	cb.value = NULL;
-	if (git_config(read_branch_desc_cb, &cb) < 0) {
+	if (git_config_get_string(name.buf, &v)) {
 		strbuf_release(&name);
 		return -1;
 	}
-	if (cb.value)
-		strbuf_addstr(buf, cb.value);
+	strbuf_addstr(buf, v);
+	free((char*)v);
 	strbuf_release(&name);
 	return 0;
 }
-- 
1.9.0.GIT
