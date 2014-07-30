From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 4/5] branch.c: replace `git_config()` with `git_config_get_string()
Date: Wed, 30 Jul 2014 06:39:08 -0700
Message-ID: <1406727549-22334-5-git-send-email-tanayabh@gmail.com>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 15:40:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCU7N-0000pi-0E
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 15:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbaG3Nk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 09:40:29 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:44710 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaG3Nk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 09:40:27 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so1528618pad.21
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SgTyeFLVrkdfhsaCNEOB1PGLMmHUlMhqUn11U2JTXK0=;
        b=FNRf3CVNwFqRxIHhOSlP2x9uUBKcjiB0NPFbIhfsGiZbnaWNQokmp0gxS4Hu6RFuDA
         /BEtu6lTWlnxbLiWwKnKFn7Ku+VJENKctF4s91iu40MONfm6rImaJnHjZExbEw3SmnT1
         65o/Box6Z6ET72kyGdEYRKwZGN1F4yb4gpTLK0S5cV+8qQKd7ni4TN805E53Gfe6U83H
         yw2A65Ip8/XkdRFu0MUv9CLRvXaNp2i+F4nn0QmBfDX4Lwn25h3TZMTX+yAy70C5Z4vY
         2dbaJ47k4pDNUvxNrVjpNqBltcn6Oi7He1RI4rmfaSawtsOARfCLOiMoyATZmQlNkSYn
         UzYw==
X-Received: by 10.70.60.226 with SMTP id k2mr4836941pdr.130.1406727627265;
        Wed, 30 Jul 2014 06:40:27 -0700 (PDT)
Received: from localhost.localdomain ([223.184.63.185])
        by mx.google.com with ESMTPSA id y4sm2397686pbt.60.2014.07.30.06.40.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 06:40:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254490>

Use `git_config_get_string()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 branch.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/branch.c b/branch.c
index 46e8aa8..df6b120 100644
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
+	char *v = NULL;
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
+	free(v);
 	strbuf_release(&name);
 	return 0;
 }
-- 
1.9.0.GIT
