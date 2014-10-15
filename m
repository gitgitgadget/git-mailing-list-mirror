From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/25] refs.c: make write_ref_sha1 static
Date: Tue, 14 Oct 2014 17:51:25 -0700
Message-ID: <20141015005125.GQ32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:51:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCoQ-0002T2-MB
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbaJOAvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:51:31 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38606 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820AbaJOAva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:51:30 -0400
Received: by mail-pa0-f48.google.com with SMTP id eu11so222299pac.35
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YnxZ9WA9nv/ihUh1oMy+HyxsX5bmAEmHQY/lm+0/w3g=;
        b=CaB8AUX5yNhsL0/UfTuw8gQzURX6B/3l13Evluo6qrDQ7/dAK86icWFUr/sv3ZDIOi
         yx6EUdtpKlD0qvVX5j7P3iYkQFgP9JBv8i+gRD1nP5HmH09XWXIRYoMf3H/ghWWasXe3
         W62Y/ze+j6+fs0V1O6C79WaMJefPn4NwxzRM5Vn0nUFrjiO/8sHPRRbpzn7KHdFdoU1j
         5RbZzU++L9C3BowQ31UOQFcGwmwYwO2AabeUraQX6KvpActXQLnQAx1rd3GNibgcoXI8
         KR6CGpfekS4dTWBzOclk55Z6PcCCTtjLT7sug5w0PyeejjP8DD4uiUsTIWpfK3UElZnp
         edvA==
X-Received: by 10.66.65.162 with SMTP id y2mr8324619pas.57.1413334290342;
        Tue, 14 Oct 2014 17:51:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id ic3sm14423109pbc.26.2014.10.14.17.51.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:51:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 15:36:58 -0700

No external users call write_ref_sha1 any more so let's declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 9d9bbeb..6b4236a 100644
--- a/refs.c
+++ b/refs.c
@@ -2706,6 +2706,9 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	return ret;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2950,8 +2953,11 @@ int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-/* This function must return a meaningful errno */
-int write_ref_sha1(struct ref_lock *lock,
+/*
+ * Write sha1 into the ref specified by the lock. Make sure that errno
+ * is sane on error.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index 50b115a..eea1044 100644
--- a/refs.h
+++ b/refs.h
@@ -197,9 +197,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.1.0.rc2.206.gedb03e5
