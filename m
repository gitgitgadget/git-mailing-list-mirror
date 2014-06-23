From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH V2] branch.c: replace git_config with git_config_get_string
Date: Mon, 23 Jun 2014 03:41:41 -0700
Message-ID: <1403520105-23250-2-git-send-email-tanayabh@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1hs-00021U-Se
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbaFWKmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:42:32 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34166 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaFWKmb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:42:31 -0400
Received: by mail-pa0-f53.google.com with SMTP id ey11so5727204pad.12
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1bO1/F6A6HUPPa9OGpR1AgvbCAj9wGfyC8fRvEIgWlk=;
        b=N40jOnt6lyMd+oMqCaqONM7ExEH6+BI06U9hymZwzJFz4RrVyOkQxEClZJzIE76TxK
         MGgGU91omwNnVuEg/irBFhGAhdXTbtt8Ld3+Le3ZWpqvuTFJ7SWZ5AZ1gSSjXI4toCJ8
         hsVTkkUQxh5O8YfjtAZckRVZX3HsyRBg+Ye6xux0JEpyyiTS81+vFNcX7gtOUlYtjT7E
         5ylInkieMxwgDKg0q6S6Zw2I9Wkk9Cnp78mmiOTWXEAW44tH/Sg87F1X7AepUls7Jwsi
         bt4grom6BUR1bgfpbE9KoQfiYGJzZwMfB81XOJtbaAs+kNjLUATJQexIW4TxfQvjm7Fc
         Kg5Q==
X-Received: by 10.68.139.194 with SMTP id ra2mr27589787pbb.20.1403520151249;
        Mon, 23 Jun 2014 03:42:31 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id zc10sm91487896pac.46.2014.06.23.03.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:42:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252335>

Use git_config_get_string instead of git_config to take advantage of
the config hash-table api which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 branch.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..c9a2a0d 100644
--- a/branch.c
+++ b/branch.c
@@ -140,33 +140,25 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	return 0;
 }
 
-struct branch_desc_cb {
+struct branch_desc {
 	const char *config_name;
 	const char *value;
 };
 
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
+	const char *value = NULL;
+	struct branch_desc desc;
 	struct strbuf name = STRBUF_INIT;
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	cb.config_name = name.buf;
-	cb.value = NULL;
-	if (git_config(read_branch_desc_cb, &cb) < 0) {
+	desc.config_name = name.buf;
+	desc.value = NULL;
+	git_config_get_string(desc.config_name, &value);
+	if (git_config_string(&desc.value, desc.config_name, value) < 0) {
 		strbuf_release(&name);
 		return -1;
 	}
-	if (cb.value)
-		strbuf_addstr(buf, cb.value);
+	strbuf_addstr(buf, desc.value);
 	strbuf_release(&name);
 	return 0;
 }
-- 
1.9.0.GIT
