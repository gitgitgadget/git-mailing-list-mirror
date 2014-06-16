From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC] branch.c: Replace `git_config` with `git_config_get_string`
Date: Mon, 16 Jun 2014 01:52:30 -0700
Message-ID: <1402908750-24851-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 10:53:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwSfI-00089G-HH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 10:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbaFPIxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 04:53:16 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:49362 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbaFPIxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 04:53:15 -0400
Received: by mail-pb0-f53.google.com with SMTP id uo5so3990640pbc.12
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OsHRSIk/AAT+agT+8r6T30X9uGvhXocTvwgV8gDFV4s=;
        b=yvsIQ97wjo1sC0Lu5P56MheHPbjCUAWuNKfxwqfjveE+0bzLLXXOr3SQ+CjQWcGh36
         DtOgcnEoBtVhBvwn31bHb/3WSByEA6Jc6AXsycDa0FfIu/qFC4odz136mdly7oeVsZ8w
         zizwkpNjqRdP3ojVuDOGzYdFVHDG4WW0RM2SWVrHEBVxJ+DxsC7kgj0jsFTjwgh6hMym
         XqZJo0AThgQmLY5TEyrrHg7IdAu9e6b7G6WsBBUmQvdil5ud3qaOoYFlkTCxwVH5h/eQ
         sFCUXuXj8fc8MuD5RfvWh3ShSpePSzzTJmVjM9I2ccOMpPX5xwL1T3c9C1GAl44Yh4aL
         A5RA==
X-Received: by 10.68.247.65 with SMTP id yc1mr22256489pbc.68.1402908795525;
        Mon, 16 Jun 2014 01:53:15 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.96])
        by mx.google.com with ESMTPSA id jd5sm17423517pbb.18.2014.06.16.01.53.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 01:53:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251707>

Original implementation uses a callback based approach which has some
deficiencies like a convoluted control flow and redundant variables.
Use git_config_get_string instead of git_config to take advantage of
the config hash-table.

---

This patch builds on top of patch series[1]. It passes all the tests, and
this in first of series of patches that aim to replace all git_config
calls scattered arund the code base with appropriate non-callback based
calls.

There are total 111 calls in total in all of git codebase. How should I send
the patches, alphabetically or otherwise?

[1] http://thread.gmane.org/gmane.comp.version-control.git/251704

Cheers,
Tanay Abhra.

 branch.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..257b1bf 100644
--- a/branch.c
+++ b/branch.c
@@ -140,33 +140,26 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
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
+	const char *value;
+	struct branch_desc desc;
 	struct strbuf name = STRBUF_INIT;
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	cb.config_name = name.buf;
-	cb.value = NULL;
-	if (git_config(read_branch_desc_cb, &cb) < 0) {
+	desc.config_name = name.buf;
+	desc.value = NULL;
+	value = git_config_get_string(desc.config_name);
+	git_config_string(&desc.value, desc.config_name, value);
+	if (!desc.value) {
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
