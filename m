From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 2/7] refs: Break out check for reflog autocreation
Date: Tue, 21 Jul 2015 11:44:59 -0400
Message-ID: <1437493504-3699-3-git-send-email-dturner@twopensource.com>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 17:45:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHZju-0004Fo-IA
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 17:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbbGUPps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 11:45:48 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34528 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbbGUPpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 11:45:13 -0400
Received: by qgeu79 with SMTP id u79so33928420qge.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 08:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GcRvKzGLRh23GJYoL9oNJ/G/WSsokxyZvCV79YQy6Mg=;
        b=SbllZC4JW4glhj5bhth1ahP8TQr+hyhuYGTEnlAGaFSC5OtTA1l/q6psJvQaBIVOuL
         Gh5N5uWROEi70TUjETA43U5vOhl+LyyR0EjRgr4OH0sA3MPIDF9S6d2P2QdzHrspOi2W
         an30n1NScdJlNnIewnt5Vnsl5ChMGDkYrd9cC2GSUpVgf61RhcNJdfnFyARINBPpXZDg
         AylReO3HDjANjBxOw15+sB+G0uISZ6UcY8OMNzQPfSGZOxnhuRV8II7XYIzQmrEOe8w3
         5x5jKv3v6Mx0vcl9aP6HU1rVgmfyYPHI+gRRgNpMoIHVALmckU9oujYxa8xsosMrVfVj
         lyUg==
X-Gm-Message-State: ALoCoQmL2BCIkaCIAsaKJg3wqhFFK/v/FPYHMhB1Ox+UvbHcMA7LePpBeINhQBRS2AEzFwQ1xRFF
X-Received: by 10.140.82.180 with SMTP id h49mr54700798qgd.29.1437493512953;
        Tue, 21 Jul 2015 08:45:12 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g33sm12941288qgg.4.2015.07.21.08.45.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 08:45:12 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.586.g889ef79-twtrsrc
In-Reply-To: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274386>

This is just for clarity.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index f090720..2efa2dc 100644
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
2.4.2.586.g889ef79-twtrsrc
