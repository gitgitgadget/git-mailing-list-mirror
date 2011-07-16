From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 15/23] transport-helper: check status code of finish_command
Date: Sat, 16 Jul 2011 15:03:35 +0200
Message-ID: <1310821424-4750-16-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4YW-0005RE-Ht
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab1GPNEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:04:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57335 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab1GPNEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:53 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996062ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8xKRbXKY9iGNyihC65xrYGBOVM2cY0RndxkIDCVO4qw=;
        b=W/cSaBPs5oXs/B6eBBGnWbqZYnC/8BOkhKQaGHWFhKrzQDk6Fw2bjXMuqs1TPE3Ar7
         O/sbhlWCGm1pBweVVztvsRJWt2ADIhk+SUN3/EBDJQWSNrqBVeKKpZJsxy4UeNXEgdSp
         Jn4TKCa4F2QSAwvGlXIIkKx/XwCpmK2w9lkRY=
Received: by 10.213.27.6 with SMTP id g6mr1601412ebc.37.1310821492458;
        Sat, 16 Jul 2011 06:04:52 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177263>

Previously the status code of all helpers were ignored, allowing
errors that occur to go unnoticed if the error text output by the
helper is not noticed.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged

 transport-helper.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index dd8dd2c..e02f4a3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -209,6 +209,7 @@ static int disconnect_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
+	int res = 0;
 
 	if (data->helper) {
 		if (debug)
@@ -220,13 +221,13 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->in);
 		close(data->helper->out);
 		fclose(data->out);
-		finish_command(data->helper);
+		res = finish_command(data->helper);
 		free((char *)data->helper->argv[0]);
 		free(data->helper->argv);
 		free(data->helper);
 		data->helper = NULL;
 	}
-	return 0;
+	return res;
 }
 
 static const char *unsupported_options[] = {
@@ -304,12 +305,13 @@ static void standard_options(struct transport *t)
 
 static int release_helper(struct transport *transport)
 {
+	int res = 0;
 	struct helper_data *data = transport->data;
 	free_refspec(data->refspec_nr, data->refspecs);
 	data->refspecs = NULL;
-	disconnect_helper(transport);
+	res = disconnect_helper(transport);
 	free(transport->data);
-	return 0;
+	return res;
 }
 
 static int fetch_with_fetch(struct transport *transport,
@@ -415,8 +417,11 @@ static int fetch_with_import(struct transport *transport,
 		sendline(data, &buf);
 		strbuf_reset(&buf);
 	}
-	disconnect_helper(transport);
-	finish_command(&fastimport);
+	if (disconnect_helper(transport))
+		die("Error while disconnecting helper");
+	if (finish_command(&fastimport))
+		die("Error while running fast-import");
+
 	free(fastimport.argv);
 	fastimport.argv = NULL;
 
@@ -760,8 +765,10 @@ static int push_refs_with_export(struct transport *transport,
 		die("Couldn't run fast-export");
 
 	data->no_disconnect_req = 1;
-	finish_command(&exporter);
-	disconnect_helper(transport);
+	if (finish_command(&exporter))
+		die("Error while running fast-export");
+	if (disconnect_helper(transport))
+		die("Error while disconnecting helper");
 	return 0;
 }
 
-- 
1.7.5.1.292.g728120
