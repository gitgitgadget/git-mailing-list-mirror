From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 09/19] refs.c: make sure log_ref_setup returns a meaningful errno
Date: Mon, 14 Jul 2014 13:58:51 -0700
Message-ID: <1405371541-32121-10-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLQ-0002z1-BU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915AbaGNU7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:19 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:59754 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-yk0-f202.google.com with SMTP id q9so104104ykb.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/9UZxgw2XlvbQZr9m5TKuGT/8r9XIBdDNWtBqnLeQYQ=;
        b=Lv3wbhSiLSRudct1nNbfhOG9a25DzOXSjtZYInvD1SnLZ//0ZiQQ1aWbaJcWpaDY0/
         6YtivRGR3yZPFiXx7V9vQvm4z7c/fZ4dFcKF/bkdvas1e9wlgWYqhs6TC9K7csb3Yg3B
         FUB78hO8YIFx/DxZ9BtyeFEArBV6Oo/p3AIz8W7dMVmGskmoHOoKhIQzE0NMF8OP46rT
         T3UAoQNz3+LTm3oDQKaNWfiOAGB3fKKeJx3H+n+dnhy189cdPhPrHAAP6Xdx93nnGi1F
         E5G/9CyS3VBHhBMWejd8oS5EivNgVQKmoV4tq69hZInEqceF+GkTMbXBWZ0qLqhDZwTO
         M1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/9UZxgw2XlvbQZr9m5TKuGT/8r9XIBdDNWtBqnLeQYQ=;
        b=PtuVxo5wcx+H3OAx43QlnjZfLXF/wJGP5gVvnND4SRcZG+zFJId3daOKVb7gLvCJRh
         GqboO39Q5QvCWR80a9Sb0+Zj08RYG3Te/ZkY/ijjmwHlAZdk6mJn6VEYtGpakfA4VjHV
         c3AVacJZe3s3DA5EC2/kzNPsb2fv3s7YD1KG3JG9vBQHFuEDrYKpCFeDhNTsoJO1VIEM
         86cTKqRmg13XvRfZaXbEy8bur85tp4EwVgmNQ05rSm9nLImWnoSu8S1GvE7B5/RNuuVS
         I1E823Uyb5lCTKP3iD24pCEgJMgzxhFG7n23lJcnLYRf+kYrCmgnMMKWrdnNbH2E99VB
         41Kw==
X-Gm-Message-State: ALoCoQk/q0uZ5tzZMO1Ssqgb1GMy5Cd/aivOKzdU6Wj6fG/nUKLnQVkSZynFgfVU5loa2GS1bsXt
X-Received: by 10.236.161.8 with SMTP id v8mr7943671yhk.0.1405371545916;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si821465yhk.4.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C18FD5A4309;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 97937E0328; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253519>

Making errno when returning from log_ref_setup() meaningful,

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 27 +++++++++++++++++++--------
 refs.h |  4 +++-
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 67a0217..9ea519c 100644
--- a/refs.c
+++ b/refs.c
@@ -2751,6 +2751,7 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+/* This function must set a meaningful errno on failure */
 int log_ref_setup(const char *refname, char *logfile, int bufsize)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
@@ -2761,9 +2762,12 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(logfile) < 0)
-			return error("unable to create directory for %s",
-				     logfile);
+		if (safe_create_leading_directories(logfile) < 0) {
+			int save_errno = errno;
+			error("unable to create directory for %s", logfile);
+			errno = save_errno;
+			return -1;
+		}
 		oflags |= O_CREAT;
 	}
 
@@ -2774,15 +2778,22 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				return error("There are still logs under '%s'",
-					     logfile);
+				int save_errno = errno;
+				error("There are still logs under '%s'",
+				      logfile);
+				errno = save_errno;
+				return -1;
 			}
 			logfd = open(logfile, oflags, 0666);
 		}
 
-		if (logfd < 0)
-			return error("Unable to append to %s: %s",
-				     logfile, strerror(errno));
+		if (logfd < 0) {
+			int save_errno = errno;
+			error("Unable to append to %s: %s", logfile,
+			      strerror(errno));
+			errno = save_errno;
+			return -1;
+		}
 	}
 
 	adjust_shared_perm(logfile);
diff --git a/refs.h b/refs.h
index 65f7637..82cc5cb 100644
--- a/refs.h
+++ b/refs.h
@@ -158,7 +158,9 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
-/** Setup reflog before using. **/
+/*
+ * Setup reflog before using. Set errno to something meaningful on failure.
+ */
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
 /** Reads log for the value of ref during at_time. **/
-- 
2.0.1.546.gf603308
