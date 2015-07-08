From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 4/8] refs: Break out check for reflog autocreation
Date: Tue,  7 Jul 2015 20:55:59 -0400
Message-ID: <1436316963-25520-4-git-send-email-dturner@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 08 02:56:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdfL-0007Ge-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbbGHA4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:56:39 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33413 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517AbbGHA4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:56:21 -0400
Received: by qgef3 with SMTP id f3so43108006qge.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qDpkdlr7RTEIOUbxwLzFuws9Vya4jK+hScPb8nz9KtM=;
        b=eiJ7+0iuQT63gZJ5hFT0KtsOEh2mv+6m59+OqaGnjF0CpaCgtUsXLcTv9pT0VR0+Kv
         YubBcQ4yFOA4WgBWd3CreZu05byvLd1pcod6fwW/8i/4xlfC5vtTpK24tmHpj/0FC7ga
         cjHnC4gnWUosODxo2dzYDeJj/UkbDQOaPgEb8nQVIFhbGW91pR9huMmAwsdevi1rcq8C
         KGxMl5ALN1oQAuN43XzIB5pqQqSs9BxZyx/9D39FUKPNfzcrWLaeFI2SgMEoqPwPldZO
         o1CjQg7OHLnwpHt6KUsj1psfUWuyLm1/GeV0N1O6VPZQ9bjt8yS7irWnG2HDeIUn9tI5
         myyg==
X-Gm-Message-State: ALoCoQndkMlhQqzJvs/iWk8mqJ2uTjSwNdhXFt4oi2QgEY9i+H7H0gAsB61eh0IhRAT/2PcYOrFZ
X-Received: by 10.140.100.146 with SMTP id s18mr1629540qge.36.1436316980738;
        Tue, 07 Jul 2015 17:56:20 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z135sm278447qhd.29.2015.07.07.17.56.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 17:56:19 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273625>

This is just for clarity.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index e891bed..e694359 100644
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
