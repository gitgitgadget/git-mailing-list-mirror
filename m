From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gc: remove gc.pid file at end of execution
Date: Fri, 27 Sep 2013 17:33:20 -0700
Message-ID: <20130928003319.GR9464@google.com>
References: <1380187098-8519-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Sep 28 02:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPiTT-0005kL-Dn
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 02:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab3I1Ad0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 20:33:26 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56198 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213Ab3I1AdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 20:33:24 -0400
Received: by mail-pa0-f51.google.com with SMTP id kp14so3437342pab.24
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gXXtM0gnMPfKSTUUAGWi5rdGY/BqPb7e2d01o0ODsV0=;
        b=0Nsk+UdBjLUHtmx5gkdFX0DKBFmWVL1dXStN2YEvkQld+z45nIHHXHSNQBwmUYCqch
         3umesqnRCELIwZISE5YqtpJwE4u8SDB0jIcFlg544N2osJEZ+/R/bCkqRxI+vUv550Lq
         ohqy8sEJi6Ux5kpUM8qogQ0kSF/QFCeg3PVHiJB9K6xqdcO/nlYbmEMuAAR32AlRdxww
         OFmHcbe9aQCu+k8kELxxIf/si1L3wXWVY7BkAmZRtB9Jf8p+CVWMgGDDeaJWx3Kf4PU8
         l8p8JSxTIf7efq6mCpuNmohhklCpxc27tZ/m7mbxx7Fr5b44DhynAFWJcWLPE3ZqTRXh
         LRjA==
X-Received: by 10.68.90.1 with SMTP id bs1mr10283240pbb.169.1380328404186;
        Fri, 27 Sep 2013 17:33:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ha10sm11379335pbc.23.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 17:33:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380187098-8519-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235482>

Matthieu Moy wrote:

> This file isn't really harmful, but isn't useful either, and can create
> minor annoyance for the user:

Would something like the following make sense, to ensure the gc.pid file is
always removed on normal exit?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git c/builtin/gc.c i/builtin/gc.c
index 6e0d81a..fbbc144 100644
--- c/builtin/gc.c
+++ i/builtin/gc.c
@@ -14,6 +14,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "sigchain.h"
 #include "argv-array.h"
 
 #define FAILED_RUN "failed to run %s"
@@ -167,6 +168,21 @@ static int need_to_gc(void)
 	return 1;
 }
 
+static char *pidfile;
+
+static void remove_pidfile(void)
+{
+	if (pidfile)
+		unlink(pidfile);
+}
+
+static void remove_pidfile_on_signal(int signo)
+{
+	remove_pidfile();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 /* return NULL on success, else hostname running the gc */
 static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 {
@@ -179,13 +195,19 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	FILE *fp;
 	int fd, should_exit;
 
+	if (pidfile)
+		/* already locked */
+		return NULL;
+
 	if (gethostname(my_host, sizeof(my_host)))
 		strcpy(my_host, "unknown");
 
-	fd = hold_lock_file_for_update(&lock, git_path("gc.pid"),
+	pidfile = git_pathdup("gc.pid");
+
+	fd = hold_lock_file_for_update(&lock, pidfile,
 				       LOCK_DIE_ON_ERROR);
 	if (!force) {
-		fp = fopen(git_path("gc.pid"), "r");
+		fp = fopen(pidfile, "r");
 		memset(locking_host, 0, sizeof(locking_host));
 		should_exit =
 			fp != NULL &&
@@ -208,6 +230,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 		if (should_exit) {
 			if (fd >= 0)
 				rollback_lock_file(&lock);
+			pidfile = NULL;
 			*ret_pid = pid;
 			return locking_host;
 		}
@@ -219,6 +242,9 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	strbuf_release(&sb);
 	commit_lock_file(&lock);
 
+	sigchain_push_common(remove_pidfile_on_signal);
+	atexit(remove_pidfile);
+
 	return NULL;
 }
 
