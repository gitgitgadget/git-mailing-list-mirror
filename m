From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Get correct column with for options in command usage
Date: Tue,  5 Feb 2013 15:40:32 +0800
Message-ID: <0b035132df6de2cac56ac59d66b04f30e90ad760.1360049671.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 08:41:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2d9c-0005py-IU
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 08:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab3BEHk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 02:40:58 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:43038 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab3BEHk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 02:40:57 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so5824943ieb.39
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 23:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=wa5ov/D5icwNtq3MyzsUy2ay7MPDdxcyCqz/VslWocE=;
        b=ykWdQ6bMCikINKFgtCkOZNCxLDeRH918/deSyOv8p0/WMdVi92To519Ig15+FCaf1J
         oGxJ2P/oCZ5J2ty5BOVZMvcLP7Xy1LP6mvN427tRl6r7lFyy84ssHDLpq68af+B6PpZb
         vR2Qf1vSRDYLX+DJ6HXqpX7pPLLPchiMihIRRhyrA/Wl6Ja6Vol0dMnSCYha03TX1J0R
         v3mKJ+OGPH5iTl9kGYsCSLJQLEv8RcPytyh1eyiaFiEnMclHAixnulMq3afqCBOO5uEf
         RkBNxLYpJT5ZPj30y4YAZ0v9K7LmuCbkQCMEO/lkRMcbVh5YbNeNb0O3XpNy+OJxvBIF
         4xUg==
X-Received: by 10.50.10.130 with SMTP id i2mr11330940igb.63.1360050056980;
        Mon, 04 Feb 2013 23:40:56 -0800 (PST)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPS id x7sm21482290igk.8.2013.02.04.23.40.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 23:40:55 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g57acac9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215464>

Command usage would not align well if command options are translated,
especially to CJK. Call utf8_strwidth in function usage_argh, so that
the caller will get correct column width.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 parse-options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 67e98..ca0e6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -473,7 +473,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
-	const char *s;
+	const char *s, *p;
 	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
@@ -482,7 +482,9 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 			s = literal ? "[%s]" : "[<%s>]";
 	else
 		s = literal ? " %s" : " <%s>";
-	return fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
+	p = opts->argh ? _(opts->argh) : _("...");
+	fprintf(outfile, s, p);
+	return utf8_strwidth(p) + strlen(s) - 2;
 }
 
 #define USAGE_OPTS_WIDTH 24
-- 
1.8.1.1.367.g57acac9.dirty
