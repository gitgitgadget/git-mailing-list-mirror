From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] config: allow ~/ and ~user/ in include.path value
Date: Tue, 24 Apr 2012 20:33:16 +0200
Message-ID: <1335292396-8502-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1335265689-2270-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 24 20:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMkYl-0001hr-T9
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 20:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901Ab2DXSdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 14:33:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44288 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825Ab2DXSdt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 14:33:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3OIR59p011606
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Apr 2012 20:27:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMkYK-0003xb-Oc; Tue, 24 Apr 2012 20:33:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMkYK-0002Dp-NM; Tue, 24 Apr 2012 20:33:28 +0200
X-Mailer: git-send-email 1.7.10.235.gb2edec.dirty
In-Reply-To: <1335265689-2270-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 24 Apr 2012 20:27:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3OIR59p011606
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335896829.64627@U2+d3H1AhgRvBaSkkTy7CA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196234>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Just added a free(path) before must_free_path = 0. Not that the memory
leak is really problematic, but let's be clean.

 config.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index bfe0c79..f054a35 100644
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
@@ -52,6 +55,8 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		if (slash)
 			strbuf_add(&buf, cf->name, slash - cf->name + 1);
 		strbuf_addstr(&buf, path);
+		free(path);
+		must_free_path = 0;
 		path = buf.buf;
 	}
 
@@ -63,6 +68,8 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		inc->depth--;
 	}
 	strbuf_release(&buf);
+	if (must_free_path)
+		free(path);
 	return ret;
 }
 
-- 
1.7.10.235.gb2edec.dirty
