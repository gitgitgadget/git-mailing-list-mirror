From: David Turner <dturner@twopensource.com>
Subject: [PATCH 4/6] refs: replace log_ref_write with create_reflog
Date: Wed, 24 Jun 2015 15:16:26 -0400
Message-ID: <1435173388-8346-5-git-send-email-dturner@twopensource.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jun 24 21:17:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qAY-0000Is-H6
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbbFXTRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:17:07 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32884 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbbFXTRA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:17:00 -0400
Received: by igbqq3 with SMTP id qq3so121922623igb.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xnQH92rJwuFOpm0ISo95/pZtZOlZFjCvsApReefVoug=;
        b=lctazhFvz/SdVtx+Y6RoCa1yt7miq4loppVRXfrK8v10upNJChX2F62B5+F40Cr/3L
         M8hiJKl7XTJLgNI27RlgAiP/km/xB0oG6A6IYVv5Nwuj9jFdD4t9jVC1WpS9VeTz5af+
         0aFgXCdB+yqoRijCGorll3Au4I5QPfQ2Z5gRjGtRuXw6yEsxqv3JD8H84f8wKZA9k4YD
         k7U/EpaXNbOC5KpZ9HQVqx5J5Qe0CFXgPT4tDSQnKxzX31J5YVGQ6mBug5oKIbJjM3eE
         6NSRvHu1YrTkrDFIt3jd+GOIV9NaOUB7E1UR6UAVQ9zGnsS/BDTi6rr3ebMfne690CFt
         8oMA==
X-Gm-Message-State: ALoCoQkNSznm/00mWRGQ9/vKAwKp3JAxUkNFojTEz1NdlE3/Ckq356n/X2vK6MkHeTyyhZFemuIN
X-Received: by 10.107.137.228 with SMTP id t97mr42719848ioi.16.1435173420026;
        Wed, 24 Jun 2015 12:17:00 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id p8sm1644609iga.13.2015.06.24.12.16.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:16:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272581>

In a moment, we will use this to add reflog creation commands to
git-reflog.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/checkout.c | 2 +-
 refs.c             | 4 ++--
 refs.h             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ac4d10a..7549ae2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -629,7 +629,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 				temp = log_all_ref_updates;
 				log_all_ref_updates = 1;
-				ret = log_ref_setup(ref_name, &log_file, &err);
+				ret = create_reflog(ref_name, &log_file, &err);
 				log_all_ref_updates = temp;
 				strbuf_release(&log_file);
 				if (ret) {
diff --git a/refs.c b/refs.c
index c1a563f..93412ee 100644
--- a/refs.c
+++ b/refs.c
@@ -3119,7 +3119,7 @@ static int copy_msg(char *buf, const char *msg)
 }
 
 /* This function will fill in *err and return -1 on failure */
-int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
+int create_reflog(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char *logfile;
@@ -3203,7 +3203,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, sb_log_file, err);
+	result = create_reflog(refname, sb_log_file, err);
 
 	if (result)
 		return result;
diff --git a/refs.h b/refs.h
index eee99f6..d4f75a9 100644
--- a/refs.h
+++ b/refs.h
@@ -233,7 +233,7 @@ int pack_refs(unsigned int flags);
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
-int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err);
+int create_reflog(const char *refname, struct strbuf *logfile, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-- 
2.0.4.314.gdbf7a51-twtrsrc
