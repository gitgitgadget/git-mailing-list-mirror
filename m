From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 14/20] transport-helper: check status code of finish_command
Date: Sun, 19 Jun 2011 17:18:39 +0200
Message-ID: <1308496725-22329-15-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnb-00042G-CO
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab1FSPU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:28 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52873 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab1FSPUD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:20:03 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so294388eyx.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=TgLABhYiqIVqUKKtGHvhsSFGY7c9spZxPXOLAntRdeI=;
        b=CwtDaRJo6j6ELrlgR2fxpsyc40HAMbnjwktW47M0SEVBZZSAGBQy411eQkNLP11nsr
         vLjPFduh99SwQ/f7gysQh7TJwR6lv5V9NB5U4Te8d3U4OVCZVuO/+/n74PkkbeJelo56
         SioygZlM9QnoWRVdsJH9Bo4GQFwuaaxmRJrMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oOMZuxgl/zf+9RKD0ipK0fVnJHUsabuWpo4U7y1W0huioLYQXSweOkUj3ayHQRJpLh
         l6JHd+x2w3xXkYTc6/hzIR4DTgP2fuKo5RQ8e9gbYKJxxOGe4SEU/+x6En+ixcG9VgAp
         QLWsMDlNKXCdNMmf3xyp9mfa10MXt4EFypIJA=
Received: by 10.14.3.150 with SMTP id 22mr1634273eeh.196.1308496802613;
        Sun, 19 Jun 2011 08:20:02 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.20.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:20:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176019>

Previously the status code of all helpers were ignored, allowing
errors that occur to go unnoticed if the error text output by the
helper is not noticed.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 transport-helper.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index ecb44f6..7f3c6c6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -204,6 +204,7 @@ static int disconnect_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
+	int res = 0;
 
 	if (data->helper) {
 		if (debug)
@@ -215,13 +216,13 @@ static int disconnect_helper(struct transport *transport)
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
@@ -299,12 +300,13 @@ static void standard_options(struct transport *t)
 
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
@@ -410,8 +412,11 @@ static int fetch_with_import(struct transport *transport,
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
 
@@ -755,8 +760,10 @@ static int push_refs_with_export(struct transport *transport,
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
