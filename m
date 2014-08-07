From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 11/11] branch.c: replace `git_config()` with `git_config_get_string()
Date: Thu,  7 Aug 2014 09:21:26 -0700
Message-ID: <1407428486-19049-12-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQTd-0006b4-1W
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbaHGQXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:34 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:60435 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbaHGQXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:30 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5462615pdj.40
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KF3vYMCPBe0rYNTFhMQ4bTXDHN7KJlqrkp2WNLnZeiU=;
        b=dDabrRyqXEw0tb7AKRjwl3UkDejlQopqabt7x+1LuW98QBjLtUW/rQRS0N8CsRf45S
         i1afCCGXf44DVy5E76D75OL1s1efmD3G5oL6X5KWbGp5NIbGQSAKYNOVY7D1DwmAiKgE
         gRKuPlAyFMPWGF27yXfPdef120x8auxKJ5IXUbaLSgN1oSD801BdYg06Uy7PdyBU6pMt
         QCfwDg0MnlcFF6dL6a8IE8q+lD1/3Jfb1bRLum7oCHgKeGJOnBtJAgeOvEovUWb/Sdbx
         nj07tDGPjj8Nh6cxKY2KteWvVTrbBiFVG0kwOlnDkYyDGib9IcIM3kXewemVK/PFCeE7
         rG0w==
X-Received: by 10.70.35.207 with SMTP id k15mr18553349pdj.5.1407428609993;
        Thu, 07 Aug 2014 09:23:29 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.23.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254974>

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
