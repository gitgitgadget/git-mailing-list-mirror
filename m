From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] run-command: simplify wait_or_whine
Date: Sat,  1 Jun 2013 08:51:55 -0500
Message-ID: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 15:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UimFc-0000O4-3u
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 15:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab3FANxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 09:53:40 -0400
Received: from mail-ye0-f172.google.com ([209.85.213.172]:61070 "EHLO
	mail-ye0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab3FANxj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 09:53:39 -0400
Received: by mail-ye0-f172.google.com with SMTP id m15so648366yen.31
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JMB2fKZCuz97Mc/91aJhjB2eUl0ythKsip66w/qEgH0=;
        b=y7Bo+PMT3fXOxZXLKJpoSwyYv9dnrfqWwjIdcuDYpKB1GCqJBCCGTqNtGgtEdvUtyZ
         5K9ytIsjtrBO7zs2UurrtGZlF9cA7ePQ6V92qlQObxBDtP9wQY+qgbKFH+Mw3s55HhB7
         Tgo14WRIbEfGImEmmLGTmmuPyFF63yNPqVSEwfeekfLmvkplVxEteHZYDtCw9z84jqm+
         JbX9XM+4ZL6/gU7OXAgV7Kj25dfan6l13TeX38JuDIby9wUYR95VwOgdilIYgXQtgFjx
         +C6lWje7QLZh95CGnW8ME/oIDbzYpOtlO+9BQkYXyIENJHJ2HRm28CeCItFFZXxWO2wT
         3DiQ==
X-Received: by 10.236.83.173 with SMTP id q33mr9802999yhe.148.1370094818707;
        Sat, 01 Jun 2013 06:53:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j64sm75779577yhj.25.2013.06.01.06.53.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 01 Jun 2013 06:53:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226125>

Nobody is checking for specific error codes; it's the errno that's
important.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 run-command.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1b32a12..e54e943 100644
--- a/run-command.c
+++ b/run-command.c
@@ -244,21 +244,11 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 		code = WTERMSIG(status);
 		if (code != SIGINT && code != SIGQUIT)
 			error("%s died of signal %d", argv0, code);
-		/*
-		 * This return value is chosen so that code & 0xff
-		 * mimics the exit code that a POSIX shell would report for
-		 * a program that died from this signal.
-		 */
-		code += 128;
 	} else if (WIFEXITED(status)) {
 		code = WEXITSTATUS(status);
-		/*
-		 * Convert special exit code when execvp failed.
-		 */
-		if (code == 127) {
-			code = -1;
+		/* convert special exit code when execvp failed. */
+		if (code == 127)
 			failed_errno = ENOENT;
-		}
 	} else {
 		error("waitpid is confused (%s)", argv0);
 	}
-- 
1.8.3.358.g5a91d05
