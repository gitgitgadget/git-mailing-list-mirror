From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/10] run-command: factor out return value computation
Date: Wed, 16 Sep 2015 18:39:00 -0700
Message-ID: <1442453948-9885-3-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAZ-00065I-I2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbIQBjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:20 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34383 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbbIQBjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:15 -0400
Received: by padhy16 with SMTP id hy16so4688172pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d489piW6X1gIJQBJTTLkQNGAMaPwNF03dYSvzV+KgiA=;
        b=AnqBgUcqHX2TyRYggJYXkvDxNqvOkTbwrV9xi0aFZiFPPaIDvYWffHmNQuMMJK09A9
         aRlDmN/sQ35k1oBbGM79lofcbQSXQNWrp9aLz9xXoj8g++MVHyETROKdHW+oqUV0SeUd
         ynOcEfhyChlW2fEtQTnV7pYEea0wmz6RqKfANwTVi/SUFiSEfiy/UWX70Gl4s8bNWl0u
         tsbSV3uIuTM6cg5WGJfcd5n6kJv9WnPRWnmYP/xwMNzIW/ZTouVDuUT1Sc9bDmGILbac
         WaOB4FKcXP+vfEK3zeJ7fgbFP4K4yChZ9zK3YtbPF2RycNBFDnNRImnituqk2lsll8zH
         ZBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d489piW6X1gIJQBJTTLkQNGAMaPwNF03dYSvzV+KgiA=;
        b=NZX8W/ZAZ/pXrsHNxi8A9XxdPSVv5PipwX+nj8YF2M7hdkyCLbKn8IRg7JrBbfgt+I
         ZYR2LBOvrgGz/AkVM0LqaBfaNKGiqmWY8EdD3G8k1bt0U0AMLlSoh35OCkCFvB8dJPs2
         bSMdbZJRMVxIS4C3J67e0mes4em2rh+i3KOaZQLMN8gldgZncCGx8VFX+xq3Iv0Z4/IX
         V4E0hWbvo7LxpISg3Yg6afLQZY9nuOxwxOVXGLqQ8bRCDJNiFwMLeFu7Zd0EHD3q0MXI
         TUB7UHTk0ehYQA5pg48kczFe3OiKA07rgtJGtRMOinxnzKBWTseSBm4nJuUgyt01H29j
         EEog==
X-Gm-Message-State: ALoCoQmLLqKgVCFjZFU1JnUKJIn5UIrY6nANHUSQwJX8UhsEv4Fec2WgRWY89vWR5WgP4i0amFVk
X-Received: by 10.68.197.196 with SMTP id iw4mr66367965pbc.153.1442453955297;
        Wed, 16 Sep 2015 18:39:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id pi9sm542528pbb.96.2015.09.16.18.39.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:14 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278092>

We will need computing the return value in a later patch without the
wait.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 54 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/run-command.c b/run-command.c
index 28e1d55..c892e9a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -232,6 +232,35 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
+static int determine_return_value(int wait_status,
+				  int *result,
+				  int *error_code,
+				  const char *argv0)
+{
+	if (WIFSIGNALED(wait_status)) {
+		*result = WTERMSIG(wait_status);
+		if (*result != SIGINT && *result != SIGQUIT)
+			error("%s died of signal %d", argv0, *result);
+		/*
+		 * This return value is chosen so that code & 0xff
+		 * mimics the exit code that a POSIX shell would report for
+		 * a program that died from this signal.
+		 */
+		*result += 128;
+	} else if (WIFEXITED(wait_status)) {
+		*result = WEXITSTATUS(wait_status);
+		/*
+		 * Convert special exit code when execvp failed.
+		 */
+		if (*result == 127) {
+			*result = -1;
+			*error_code = ENOENT;
+		}
+	} else
+		return 1;
+	return 0;
+}
+
 static int wait_or_whine(pid_t pid, const char *argv0)
 {
 	int status, code = -1;
@@ -244,29 +273,10 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 	if (waiting < 0) {
 		failed_errno = errno;
 		error("waitpid for %s failed: %s", argv0, strerror(errno));
-	} else if (waiting != pid) {
-		error("waitpid is confused (%s)", argv0);
-	} else if (WIFSIGNALED(status)) {
-		code = WTERMSIG(status);
-		if (code != SIGINT && code != SIGQUIT)
-			error("%s died of signal %d", argv0, code);
-		/*
-		 * This return value is chosen so that code & 0xff
-		 * mimics the exit code that a POSIX shell would report for
-		 * a program that died from this signal.
-		 */
-		code += 128;
-	} else if (WIFEXITED(status)) {
-		code = WEXITSTATUS(status);
-		/*
-		 * Convert special exit code when execvp failed.
-		 */
-		if (code == 127) {
-			code = -1;
-			failed_errno = ENOENT;
-		}
 	} else {
-		error("waitpid is confused (%s)", argv0);
+		if (waiting != pid
+		   || (determine_return_value(status, &code, &failed_errno, argv0) < 0))
+			error("waitpid is confused (%s)", argv0);
 	}
 
 	clear_child_for_cleanup(pid);
-- 
2.6.0.rc0.131.gf624c3d
