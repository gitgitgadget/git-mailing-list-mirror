From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 4/7] refs: Break out check for reflog autocreation
Date: Mon, 29 Jun 2015 16:17:53 -0400
Message-ID: <1435609076-8592-5-git-send-email-dturner@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 22:18:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fW5-0006eX-TT
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbbF2USx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:18:53 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33682 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbbF2USp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:18:45 -0400
Received: by qkhu186 with SMTP id u186so100423843qkh.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QMaY7g31VidJCXUSeyVWnjl3jgMzEuXk8BzAkYhbbtQ=;
        b=WXnEc2XJS7RXi8YwmnyjPl5ld6xljDnwOHEPlFJIZZHXRy0BFmxpe6Og8zHgUiVvbo
         YTCvydFlJu/QH/8/IZu6Mg6lH3h74OtrRg9vgCiHG7Jkm1PP4JDb0XbBCgAcIpou/WrI
         VxEXfDKVfW9s37hZ0hUlZxrHd/tuT5NiEVkJrqODq09shkL3Pl1SwmLEFisV78vCDHPo
         jZEAIFmCnBWSs64pvfPUhAuiln/SgVlEvY149K5yNr6IBicalWIlZFyK2k0C5YLfcTsQ
         K43sf0T3+XWMRE1JKLUGku/timnUHS5OZuHl+1OmUZ4sYiaqYtqA2gu1twTnk0YOgb4O
         x28Q==
X-Gm-Message-State: ALoCoQlvE2WrYxyeVkHcEc4zK8WgAA2tvzOQUQLwdceA3YB+/yd/FqW4KvY53MRseYmoDpCTdjKo
X-Received: by 10.55.18.102 with SMTP id c99mr35691849qkh.58.1435609124659;
        Mon, 29 Jun 2015 13:18:44 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id 139sm11906090qhx.22.2015.06.29.13.18.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 13:18:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273003>

This is just for clarity.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index c97ca02..30e81ba 100644
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
 			strbuf_addf(err, "unable to create directory for %s. "
 				    "%s", logfile, strerror(errno));
-- 
2.0.4.315.gad8727a-twtrsrc
