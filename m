From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 04/10] abspath: use strbuf_getcwd() to remember original
 working directory
Date: Mon, 28 Jul 2014 20:37:56 +0200
Message-ID: <53D69884.7000307@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:38:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpoK-0007Ht-1h
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbaG1SiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:38:08 -0400
Received: from mout.web.de ([212.227.17.11]:56034 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaG1SiG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:38:06 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MWj2N-1X0dpO2hzP-00XtET; Mon, 28 Jul 2014 20:37:57
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:nAoKSQOf0ftPnuUslBJjmPoD5M1oYHFuC49SZnySWPRa1761Ojt
 Viul75vHnRQ578DkHx9WOfj6HVPLGZsWObcbd3ZGJDzm4GT7QiCq3Pbk+nCxTLEj6/ZDbJd
 vx/qCNUy2c38HJbd16vvq4/xx83TyBFjPshqSJ+H+5mrfjkv+LVGi6P5TfNfiCw5M+9vizz
 zc+7tCJKIeXfNnvtQDFHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254344>

Store the original working directory in a strbuf instead of in a
fixed-sized buffer, in order to be able to handle longer paths.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Resent with corrected subject.

 abspath.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/abspath.c b/abspath.c
index ca33558..911e931 100644
--- a/abspath.c
+++ b/abspath.c
@@ -41,7 +41,7 @@ static const char *real_path_internal(const char *path, int die_on_error)
 	 * here so that we can chdir() back to it at the end of the
 	 * function:
 	 */
-	char cwd[1024] = "";
+	struct strbuf cwd = STRBUF_INIT;
 
 	int buf_index = 1;
 
@@ -80,7 +80,7 @@ static const char *real_path_internal(const char *path, int die_on_error)
 		}
 
 		if (*buf) {
-			if (!*cwd && !getcwd(cwd, sizeof(cwd))) {
+			if (!cwd.len && strbuf_getcwd(&cwd)) {
 				if (die_on_error)
 					die_errno("Could not get current working directory");
 				else
@@ -142,8 +142,9 @@ static const char *real_path_internal(const char *path, int die_on_error)
 	retval = buf;
 error_out:
 	free(last_elem);
-	if (*cwd && chdir(cwd))
-		die_errno("Could not change back to '%s'", cwd);
+	if (cwd.len && chdir(cwd.buf))
+		die_errno("Could not change back to '%s'", cwd.buf);
+	strbuf_release(&cwd);
 
 	return retval;
 }
-- 
2.0.2
