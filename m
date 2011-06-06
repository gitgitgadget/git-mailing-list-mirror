From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 2/3] mingw.c: move definition of mingw_getenv down
Date: Mon, 06 Jun 2011 09:06:02 +0200
Message-ID: <4DEC7C5A.8020201@viscovery.net>
References: <4DEC7A65.7020207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 09:06:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTTt7-0005A5-E7
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 09:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab1FFHGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 03:06:09 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44218 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab1FFHGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 03:06:06 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QTTsx-0006g4-S9; Mon, 06 Jun 2011 09:06:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 967891660F;
	Mon,  6 Jun 2011 09:06:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DEC7A65.7020207@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175096>

From: Johannes Sixt <j6t@kdbg.org>

We want to use static lookup_env() in a subsequent change.

At first sight, this change looks innocent. But it is not due to the
#undef getenv. There is one caller of getenv between the old location and
the new location whose behavior could change. But as can be seen from the
defintion of mingw_getenv, the behavior for this caller does not change
substantially.

To ensure consistent behavior in the future, change all getenv callers
in mingw.c to use mingw_getenv.

With this patch, this is not a big deal, yet, but with the subsequent
change, where we teach getenv to do a case-sensitive lookup, the behavior
of all call sites is changed.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Erik, Dscho,

 the 4msysgit tree has additional calls of getenv in mingw.c. You might
 want to update them to call mingw_getenv() instead.

 But then not doing so would not have a dramatic effect. It is similar
 to GIT_ASK_YESNO: People can still set Git_Ask_YesNo, and it will
 work in the same way as usual, *unless* they also have GIT_ASK_YESNO
 set as well (and with a different value).

 compat/mingw.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e085e8b..ee480f9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -178,7 +178,7 @@ static int ask_yes_no_if_possible(const char *format, ...)
 	vsnprintf(question, sizeof(question), format, args);
 	va_end(args);
 
-	if ((retry_hook[0] = getenv("GIT_ASK_YESNO"))) {
+	if ((retry_hook[0] = mingw_getenv("GIT_ASK_YESNO"))) {
 		retry_hook[1] = question;
 		return !run_command_v_opt(retry_hook, 0);
 	}
@@ -599,19 +599,6 @@ char *mingw_getcwd(char *pointer, int len)
 	return ret;
 }
 
-#undef getenv
-char *mingw_getenv(const char *name)
-{
-	char *result = getenv(name);
-	if (!result && !strcmp(name, "TMPDIR")) {
-		/* on Windows it is TMP and TEMP */
-		result = getenv("TMP");
-		if (!result)
-			result = getenv("TEMP");
-	}
-	return result;
-}
-
 /*
  * See http://msdn2.microsoft.com/en-us/library/17w5ykft(vs.71).aspx
  * (Parsing C++ Command-Line Arguments)
@@ -711,7 +698,7 @@ static const char *parse_interpreter(const char *cmd)
  */
 static char **get_path_split(void)
 {
-	char *p, **path, *envpath = getenv("PATH");
+	char *p, **path, *envpath = mingw_getenv("PATH");
 	int i, n = 0;
 
 	if (!envpath || !*envpath)
@@ -1128,6 +1115,19 @@ char **make_augmented_environ(const char *const *vars)
 	return env;
 }
 
+#undef getenv
+char *mingw_getenv(const char *name)
+{
+	char *result = getenv(name);
+	if (!result && !strcmp(name, "TMPDIR")) {
+		/* on Windows it is TMP and TEMP */
+		result = getenv("TMP");
+		if (!result)
+			result = getenv("TEMP");
+	}
+	return result;
+}
+
 /*
  * Note, this isn't a complete replacement for getaddrinfo. It assumes
  * that service contains a numerical port, or that it is null. It
-- 
1.7.6.rc0.1186.gfb4fd
