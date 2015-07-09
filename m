From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 2/7] refs: Break out check for reflog autocreation
Date: Thu,  9 Jul 2015 18:50:55 -0400
Message-ID: <1436482260-28088-3-git-send-email-dturner@twopensource.com>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Fri Jul 10 00:51:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKfF-00072W-4a
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbbGIWv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:51:28 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35381 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbGIWvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:51:25 -0400
Received: by pactm7 with SMTP id tm7so157484627pac.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xC8OEAD1STA4IJFSwlbjjNKDbYfwAO/DSDH884Wv/ek=;
        b=dZ8UuYGnx7MwxyluHwS5YnETJdyDHEpCoW0CkLx06NvUQYhgi6rrm10Cl133c7dj8Z
         w29cspHwmeaiEhqPxkIOVIt7iwNr9xmWGWE1IlU3+Ie8J2lAutOZ77L2OW/L4fQaYlV1
         G7obxz/ab/s9zi+sdQIgk0e5tWANgtUJEEJfutsYI1zf3NroELnrrSHNg/Ztz784C+Fs
         jg7143uyChOTivMIBv2rfOiyRw1aqcH0SYIm7j8eibEKDuhr4M5t801h2MYZWXZuHnQj
         lhZmHwwdQEP8F/pmG++MS9WdQK7DzTGVtY7PV0AkNURl7WrR497mtxkAACbdPyRyWAQb
         /ErA==
X-Gm-Message-State: ALoCoQkSHuCrq87h/YlDCLf4GvR39wyLjBOhlZI8vOUV8vBiV5Kh2ZWW45Z2HMehqkuvKxWKThNc
X-Received: by 10.70.91.136 with SMTP id ce8mr35889475pdb.29.1436482284515;
        Thu, 09 Jul 2015 15:51:24 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id fr2sm7129684pdb.22.2015.07.09.15.51.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 15:51:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273787>

This is just for clarity.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 03e7505..903b401 100644
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
2.0.5.499.g01f6352.dirty-twtrsrc
