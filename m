From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 3/3] Windows: teach getenv to do a case-sensitive search
Date: Mon, 06 Jun 2011 09:08:13 +0200
Message-ID: <4DEC7CDD.10403@viscovery.net>
References: <4DEC7A65.7020207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 09:08:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTTvE-0005no-Kx
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 09:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208Ab1FFHIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 03:08:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46829 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752108Ab1FFHIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 03:08:16 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QTTv4-0000su-ED; Mon, 06 Jun 2011 09:08:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 28A381660F;
	Mon,  6 Jun 2011 09:08:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DEC7A65.7020207@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175097>

From: Johannes Sixt <j6t@kdbg.org>

getenv() on Windows looks up environment variables in a case-insensitive
manner. Even though all documentations claim that the environment is
case-insensitive, it is possible for applications to pass an environment
to child processes that has variables that differ only in case. Bash on
Windows does this, for example, and sh-i18n--envsubst depends on this
behavior.

With this patch environment variables are first looked up in a
case-sensitive manner; only if this finds nothing, the system's getenv() is
used as a fallback.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ee480f9..6e5af32 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1116,14 +1116,31 @@ char **make_augmented_environ(const char *const *vars)
 }
 
 #undef getenv
+
+/*
+ * The system's getenv looks up the name in a case-insensitive manner.
+ * This version tries a case-sensitive lookup and falls back to
+ * case-insensitive if nothing was found.  This is necessary because,
+ * as a prominent example, CMD sets 'Path', but not 'PATH'.
+ * Warning: not thread-safe.
+ */
+static char *getenv_cs(const char *name)
+{
+	size_t len = strlen(name);
+	int i = lookup_env(environ, name, len);
+	if (i >= 0)
+		return environ[i] + len + 1;	/* skip past name and '=' */
+	return getenv(name);
+}
+
 char *mingw_getenv(const char *name)
 {
-	char *result = getenv(name);
+	char *result = getenv_cs(name);
 	if (!result && !strcmp(name, "TMPDIR")) {
 		/* on Windows it is TMP and TEMP */
-		result = getenv("TMP");
+		result = getenv_cs("TMP");
 		if (!result)
-			result = getenv("TEMP");
+			result = getenv_cs("TEMP");
 	}
 	return result;
 }
-- 
1.7.6.rc0.1186.gfb4fd
