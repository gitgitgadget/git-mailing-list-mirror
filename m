From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 11/11] branch.c: replace `git_config()` with `git_config_get_string()
Date: Mon,  4 Aug 2014 11:33:49 -0700
Message-ID: <1407177229-30081-12-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN6V-0008Se-Vu
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbaHDSfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:35:21 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55154 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbaHDSfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:35:20 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so10038778pdb.41
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KF3vYMCPBe0rYNTFhMQ4bTXDHN7KJlqrkp2WNLnZeiU=;
        b=q3G+hL4jWTq9wxmB3kDBIawEfS47zh8vzE5SBrYyAanKzvGmcU35cbb3Y0e3MUf8of
         yywDHPHEa9/k98WNHSy3VuGiONauELWMED2Q/N8TZ1BWP7Rugw0RkCj3PfqocdIWMHh/
         u3yhr1AO9abDfEswRI6TyXSekfR/ugDwFOGfrEgy69d/LsbdOnK0XIsPRiG3S2HrKM79
         zc6cetGtkSy3IbJIY+jLmieN69OIfzRr2CCkPBuALVXCccIws6AeysiE81d9qCZwEhuk
         w425QH2Y5Z6ZxDE5ofXnkuqjPvqRtY4ItLGPvPz8upxrc8StHi8tGSS6bDceOpn0DPwo
         gr1w==
X-Received: by 10.66.100.200 with SMTP id fa8mr25641135pab.23.1407177319778;
        Mon, 04 Aug 2014 11:35:19 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.35.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:35:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254763>

Use `git_config_get_string()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
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
-- 
1.9.0.GIT
