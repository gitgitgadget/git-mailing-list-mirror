From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 4/7] refs: Break out check for reflog autocreation
Date: Thu, 25 Jun 2015 20:29:05 -0400
Message-ID: <1435278548-3790-4-git-send-email-dturner@twopensource.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jun 26 02:29:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8HWb-000591-6L
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 02:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbbFZA3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 20:29:40 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34289 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbFZA3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 20:29:35 -0400
Received: by igcsj18 with SMTP id sj18so21055470igc.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+XMF1c7IG2TrRzRXka9FyDodYqChZGJYdZZmtHI0dM=;
        b=e4qygJyVmaXlDSOkSpQOvHvOsmezAv3Y0xNdKpb+3wjOzkua9dqoI8h1oJqSaAIyk1
         StvMVOJI3buwpAVJS4x84fV91p9/et78awCFpdNcxnZWYZyQg72wRGp/dOhlYJf6s7+G
         4uecSUnSurwqxTe95NQb6sjik3ulW0z8/L3C9262ZP7bTzO62YLgvKibwgSsTrrwpTG3
         vPdsDOXAreSmbnWer/Myua3rRDHmiZLzrlQKO+dpXPhqmdiVm0+QdUM+mefz8L/4PS+v
         KjT1Xr6DuGamRFfdRJnUy5dMiLg8yRj+OGoJGFXqlXO+PPs9wIdCZCoUr1ql5fIzjHoK
         D3Og==
X-Gm-Message-State: ALoCoQnN+KWiGmPjDTUi8oPZ9UKbgNYIgSMJE3vyDCQQHLZ2nXCYq9FbsVVQfmCLgSFXF2Tkq0kx
X-Received: by 10.43.169.137 with SMTP id nm9mr298597icc.82.1435278574923;
        Thu, 25 Jun 2015 17:29:34 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id i85sm20714344iod.41.2015.06.25.17.29.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 17:29:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272750>

This is just for clarity.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index b34a54a..dff91cf 100644
--- a/refs.c
+++ b/refs.c
@@ -3118,6 +3118,14 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+static int should_autocreate_reflog(const char *refname)
+{
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /* This function will fill in *err and return -1 on failure */
 int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
 {
@@ -3128,11 +3136,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	logfile = sb_logfile->buf;
 	/* make sure the rest of the function can't change "logfile" */
 	sb_logfile = NULL;
-	if (log_all_ref_updates &&
-	    (starts_with(refname, "refs/heads/") ||
-	     starts_with(refname, "refs/remotes/") ||
-	     starts_with(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	if (log_all_ref_updates && should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			strbuf_addf(err, "unable to create directory for %s. "
 				    "%s", logfile, strerror(errno));
-- 
2.0.4.314.gdbf7a51-twtrsrc
