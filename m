From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 2/7] refs: Break out check for reflog autocreation
Date: Tue, 21 Jul 2015 17:04:51 -0400
Message-ID: <1437512696-14672-2-git-send-email-dturner@twopensource.com>
References: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhaggerty@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 23:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHeiz-0001Tw-Br
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933500AbbGUVFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:05:09 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36316 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933408AbbGUVFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:05:08 -0400
Received: by qkdv3 with SMTP id v3so141585347qkd.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jS5UsZKOaaRrcP0SdSl2Qt+O2MrYuJ09E9j/aZ8nJ2Y=;
        b=MvWJDH9la8AOOgj+Bqe+P6R49Ax2bglKZz9qi2xxJRWtaEUm06UxHdss6lAeqvSjHr
         IqLvxXkkUzRTb65HBKv1aalniYVOR09/6nOCDlpFldKXLaaR2/A80yEEZ4gcEGlbvh6+
         NSqw+AA6ZlH/1bb1mVoXuI2COk+P+swkIDS3jLSgPqrO6g7aaQvxdohV+1F+oxzRqj8l
         JGpNU+I7uhs7iGtrubBe2GCkdYB+NElR+9YzplIo8loRKNHOTE85rHhK9kyOiAubzTcT
         Ygl0zCdKMavfnP8CIJGcYUaIaxbYRcC+Md/oxvF4TycEdNYNpaVWpwUcD4CxxSr2oYHI
         Pa6g==
X-Gm-Message-State: ALoCoQmSgqg9in+JclN2G1eaT2/bc3JTQkKxmz0X1LZ31jqHQSF/a4uKYkuIxfWEfq/1T8HbWG3N
X-Received: by 10.55.17.102 with SMTP id b99mr44342095qkh.38.1437512707373;
        Tue, 21 Jul 2015 14:05:07 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id x137sm13430413qkx.28.2015.07.21.14.05.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 14:05:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274419>

This is just for clarity.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index ca68509..cf1abeb 100644
--- a/refs.c
+++ b/refs.c
@@ -3118,6 +3118,16 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+static int should_autocreate_reflog(const char *refname)
+{
+	if (!log_all_ref_updates)
+		return 0;
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /* This function will fill in *err and return -1 on failure */
 int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
 {
@@ -3128,11 +3138,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	logfile = sb_logfile->buf;
 	/* make sure the rest of the function can't change "logfile" */
 	sb_logfile = NULL;
-	if (log_all_ref_updates &&
-	    (starts_with(refname, "refs/heads/") ||
-	     starts_with(refname, "refs/remotes/") ||
-	     starts_with(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	if (should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			strbuf_addf(err, "unable to create directory for %s: "
 				    "%s", logfile, strerror(errno));
-- 
2.0.4.315.gad8727a-twtrsrc
