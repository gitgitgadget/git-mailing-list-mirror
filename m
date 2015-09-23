From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 05/14] run-command: factor out return value computation
Date: Tue, 22 Sep 2015 18:45:23 -0700
Message-ID: <1442972732-12118-6-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8b-0007bf-5q
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934660AbbIWBqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:46:17 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33825 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759959AbbIWBpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:43 -0400
Received: by padhy16 with SMTP id hy16so25283690pad.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PXxtC06GJdbVH1hQMlUYkIJ90F1tdtBibcqywQTmDfk=;
        b=FQDyyH18tdu+HfwjAvb7ElZEWa+qVRJMs725OWlrxmQmvhrCkbJFyX4U6MiwXFSTBJ
         nHI3Ey/Ta7Lb/WL1u+npjRnJxM+Wj0KHWQgt23yGUYIbro10F/jmOMxbOs/d6e1/jE9H
         ZZUkI9SNKLmxe/nX+iUNMZx1r72SkXXd7I4k/kxJpjEExTBfNQC5zHOC5dabChaCXM3o
         U16R8raOC6CecJwW4IZLHkwmJONHUWM6E7/dTW5K2ilA2cEO3ZMbEcYSqX4rPod+Icc9
         ZywFe9JKI9f+fMWq6920G82WSxBZM6F4GWq8be2jjUViPwThg4dNM70EeRydUKohhvIX
         gK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PXxtC06GJdbVH1hQMlUYkIJ90F1tdtBibcqywQTmDfk=;
        b=agoFwKIvLU73SSCvpokEXpowir7wHc1pYoXY39cHs+nD/DBcg3GQMVhNi1kIzk5EGf
         Ep7WCEjyhBkrMsnG28aoHtR3R7Ny8vn7M0770151X85qnMzpS8X7uwb1rAByaz1WeXUU
         BCHuUd51EK1Yy2IfVNWoNhZoVs1WwffdLa7FAWGz/vYHYEDx3WqjZJ1xiUa+z2Vukgnl
         ID0xDEVujwOeVxlgqhIaJLTIBT8+f+zgQB4swfxBRAbuRP6RLcB02eLHHmS4asXargWc
         UsJIOjgZXCrTzdGu1BvLj9r7GANILcgB0VFBHUTnJ7H6gl/eS5Dp6+jTHYY8OYEbQxnt
         aTxg==
X-Gm-Message-State: ALoCoQmxFV9VEV2QAVsxpFNRsduxBBAjxvcFgyUYBX+/g/1njY0wjNGszKUkzpwExR1rnOGWOrlF
X-Received: by 10.66.216.105 with SMTP id op9mr34242529pac.60.1442972742685;
        Tue, 22 Sep 2015 18:45:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id rz10sm4585547pab.42.2015.09.22.18.45.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278465>

We will need computing the return value in a later patch without the
wait.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 56 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/run-command.c b/run-command.c
index 28e1d55..2bf1aba 100644
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
+		return -1;
+	return 0;
+}
+
 static int wait_or_whine(pid_t pid, const char *argv0)
 {
 	int status, code = -1;
@@ -244,29 +273,12 @@ static int wait_or_whine(pid_t pid, const char *argv0)
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
+		if (waiting != pid || (determine_return_value(status,
+							      &code,
+							      &failed_errno,
+							      argv0) < 0))
+			error("waitpid is confused (%s)", argv0);
 	}
 
 	clear_child_for_cleanup(pid);
-- 
2.5.0.272.ga84127c.dirty
