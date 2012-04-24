From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] config: allow ~/ and ~user/ in include.path value
Date: Tue, 24 Apr 2012 13:08:09 +0200
Message-ID: <1335265689-2270-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 24 13:08:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMdbv-0004gi-5I
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 13:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab2DXLIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 07:08:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42906 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab2DXLI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 07:08:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3OB1fUv008927
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Apr 2012 13:01:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMdbO-00035R-Um; Tue, 24 Apr 2012 13:08:10 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMdbO-0000bZ-Qr; Tue, 24 Apr 2012 13:08:10 +0200
X-Mailer: git-send-email 1.7.10.235.gb2edec
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 24 Apr 2012 13:01:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3OB1fUv008927
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335870104.0034@HZaAAoPhXgQUU3PlXRAwbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196218>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 config.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index bfe0c79..dd8b9bf 100644
--- a/config.c
+++ b/config.c
@@ -33,11 +33,14 @@ static const char include_depth_advice[] =
 "from\n"
 "	%s\n"
 "Do you have circular includes?";
-static int handle_path_include(const char *path, struct config_include_data *inc)
+static int handle_path_include(const char *raw_path, struct config_include_data *inc)
 {
 	int ret = 0;
 	struct strbuf buf = STRBUF_INIT;
-
+	int must_free_path = 1;
+	char *path = expand_user_path(raw_path);
+	if (!path)
+		return error("Could not expand include path '%s'.", raw_path);
 	/*
 	 * Use an absolute path as-is, but interpret relative paths
 	 * based on the including config file.
@@ -52,6 +55,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		if (slash)
 			strbuf_add(&buf, cf->name, slash - cf->name + 1);
 		strbuf_addstr(&buf, path);
+		must_free_path = 0;
 		path = buf.buf;
 	}
 
@@ -63,6 +67,8 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		inc->depth--;
 	}
 	strbuf_release(&buf);
+	if (must_free_path)
+		free(path);
 	return ret;
 }
 
-- 
1.7.10.235.gb2edec
