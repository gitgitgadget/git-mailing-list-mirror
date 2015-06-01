From: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
Subject: [PATCH] receive-pack: Create a HEAD ref for ref namespace
Date: Mon,  1 Jun 2015 23:24:43 +0200
Message-ID: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
Cc: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 23:31:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzXJ8-0004SA-DF
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 23:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbbFAVbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 17:31:39 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:36163 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbFAVbh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 17:31:37 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2015 17:31:36 EDT
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 39a0104f;
	for <git@vger.kernel.org>;
	Mon, 1 Jun 2015 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id; s=theos; bh=a/91HGLGZM1VBcc0CozINbzZW6
	8=; b=JFyPfvQ40maFYeHgte6j3ikHu3IXbRgIxTh2z2ctwKPiMvHEof0sljyuxT
	Ohmm3FwPKHh3mHnrtH8bHAUotk6xEYC5IH0XOP4ezIs78ydIpVEYAbNtW3GXe+z4
	qPWEJVIIpccxfEo9OFi+0ZzTizPcOMjgfb2M3N5pt11hYg49A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=theos; b=HQEUNysaVXdflmkaMwga
	bfY5t1S2SJbCvwSb15zGVM9bav8qOKCi419fsgkU9+QpMN3ttokLV0GR74XnK6s2
	SH9Q8aAY7o+pXd9jiq8X9gStySS0VNHcwKpH3VOZgAyzkx0jTQOSl6bffl3zL1VQ
	tZthbTA3/6ed2a/Yft5QXZU=
Received: from leeloo.kyriasis.com (m77-218-248-206.cust.tele2.se [77.218.248.206]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 7dda5040;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Mon, 1 Jun 2015 21:24:51 +0000 (UTC)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270472>

Each ref namespace have their own separate branches, tags, and HEAD, so
when pushing to a namespace we need to make sure that there exists a
HEAD ref for the namespace, otherwise you will not be able to check out
the repo after cloning from a namespace
---

So, I have absolutely no clue where this should actually be put, so I 
just put it where it fit for now.

Any comments on where to put it, or comments on the patch in general?

 builtin/receive-pack.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5292bb5..c189838 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -864,7 +864,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
-	const char *namespaced_name, *ret;
+	struct strbuf namespaced_head_buf = STRBUF_INIT;
+	const char *namespaced_name, *ret, *namespace;
+	const char *namespaced_head_path;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
 
@@ -981,6 +983,14 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		namespace = get_git_namespace();
+		if (strcmp(namespace, "refs/namespaces/")) {
+			strbuf_addf(&namespaced_head_buf, "%s%s", namespace, "HEAD");
+			namespaced_head_path = strbuf_detach(&namespaced_head_buf, NULL);
+
+			create_symref(namespaced_head_path, namespaced_name, NULL);
+		}
+
 		struct strbuf err = STRBUF_INIT;
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
-- 
2.4.2
