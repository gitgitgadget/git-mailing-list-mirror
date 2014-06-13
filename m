From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] blame: factor out get_next_line()
Date: Fri, 13 Jun 2014 21:53:03 +0200
Message-ID: <539B569F.1090800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvXXe-000263-DP
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 21:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbaFMTxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 15:53:34 -0400
Received: from mout.web.de ([212.227.17.12]:55351 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbaFMTxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 15:53:33 -0400
Received: from [192.168.178.27] ([79.253.165.171]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGRVU-1WzxNf35kG-00DE2E; Fri, 13 Jun 2014 21:53:19
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:RLA0Pjny8JzMiBtdfJdmDiUER3CltgLKqExyA+cPQyPT8seFtWR
 OhvcV7jPGKA5bpJre9LuOlal2FxNtJUxb5Guc1DNbZvbV7Qsl/29k+J4q2NPXMqD6BTTXDs
 +Hkm/imyo99g2ssm446owmlIEfO+7M5XMQWFBe91mZtoUaP8ySmjKIX+1UFv8OrjxB8OcPa
 y9W0HAWi+uK4gCzc7mp1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251632>

Move the code for finding the start of the next line into a helper
function in order to reduce duplication.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/blame.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a52a279..ad37edc 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2008,6 +2008,12 @@ static void output(struct scoreboard *sb, int option)
 	}
 }
 
+static const char *get_next_line(const char *start, const char *end)
+{
+	const char *nl = memchr(start, '\n', end - start);
+	return nl ? nl + 1 : NULL;
+}
+
 /*
  * To allow quick access to the contents of nth line in the
  * final image, prepare an index in the scoreboard.
@@ -2021,15 +2027,8 @@ static int prepare_lines(struct scoreboard *sb)
 	int *lineno;
 	int num = 0, incomplete = 0;
 
-	for (p = buf;;) {
-		p = memchr(p, '\n', end - p);
-		if (p) {
-			p++;
-			num++;
-			continue;
-		}
-		break;
-	}
+	for (p = get_next_line(buf, end); p; p = get_next_line(p, end))
+		num++;
 
 	if (len && end[-1] != '\n')
 		incomplete++; /* incomplete line at the end */
@@ -2038,15 +2037,8 @@ static int prepare_lines(struct scoreboard *sb)
 	lineno = sb->lineno;
 
 	*lineno++ = 0;
-	for (p = buf;;) {
-		p = memchr(p, '\n', end - p);
-		if (p) {
-			p++;
-			*lineno++ = p - buf;
-			continue;
-		}
-		break;
-	}
+	for (p = get_next_line(buf, end); p; p = get_next_line(p, end))
+		*lineno++ = p - buf;
 
 	if (incomplete)
 		*lineno++ = len;
-- 
2.0.0
