From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] run-command: use internal argv_array of struct child_process
 in run_hook_ve()
Date: Wed, 16 Jul 2014 23:57:47 +0200
Message-ID: <53C6F55B.9000404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:58:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7XDK-0003U1-Cd
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 23:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbaGPV6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 17:58:09 -0400
Received: from mout.web.de ([212.227.15.3]:59837 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbaGPV6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 17:58:08 -0400
Received: from [192.168.178.27] ([79.250.168.234]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lmchn-1WXvTW0iv5-00aHop; Wed, 16 Jul 2014 23:57:53
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:Wr6WV1MpT5a4qlHYStdc0TAGBXr1zD+qE6Q64NB0hLgLWNlrqPC
 G/uJEV0PRqBBLvQVptLGp8Izh8ZZkH/LKEZFNByMyEy2NGAwqHyS9mwazHvNIkO2KwNv+FO
 TZziqYCbGWhYrYerFELOjhcwTiVqKKdc6zwBkxPaEXPz0Pk/myGaIcLgTlDXIW+29EaZnIW
 s/bMDGpKXYYpfChr+j/8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253696>

Use the existing argv_array member instead of providing our own.  This
way we don't have to initialize or clean it up explicitly.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 run-command.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/run-command.c b/run-command.c
index be07d4a..576dfea 100644
--- a/run-command.c
+++ b/run-command.c
@@ -770,28 +770,21 @@ char *find_hook(const char *name)
 int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook;
-	struct argv_array argv = ARGV_ARRAY_INIT;
 	const char *p;
-	int ret;
 
 	p = find_hook(name);
 	if (!p)
 		return 0;
 
-	argv_array_push(&argv, p);
-
-	while ((p = va_arg(args, const char *)))
-		argv_array_push(&argv, p);
-
 	memset(&hook, 0, sizeof(hook));
-	hook.argv = argv.argv;
+	argv_array_push(&hook.args, p);
+	while ((p = va_arg(args, const char *)))
+		argv_array_push(&hook.args, p);
 	hook.env = env;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
 
-	ret = run_command(&hook);
-	argv_array_clear(&argv);
-	return ret;
+	return run_command(&hook);
 }
 
 int run_hook_le(const char *const *env, const char *name, ...)
-- 
2.0.0
