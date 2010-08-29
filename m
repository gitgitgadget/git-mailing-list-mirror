From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 04/13] transport-helper: check status code of finish_command
Date: Sat, 28 Aug 2010 22:45:31 -0500
Message-ID: <1283053540-27042-5-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:46:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYqn-0006e4-EX
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab0H2Dqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab0H2DqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:17 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nNhP2u7fCjI1cwdbXx9FUCASvQD7TIEArMjamOJ53hM=;
        b=mY22ZXuQE3KYkqzHm342dU2diZQ8CC5HUHj2FCGpZgXGuHZ/ef1ED70avwRtRIZ8Hi
         RfuzfuTsXw8N+AK2O8DMCfy5jk+a4GBLgg3LelsqSP2z8wPtf1CrMCD3XYlsVfRqdgGS
         gkGwNqmsdCpHo5jxcW3142Pz+p1skt0Icdis8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PdrXeaNYg2eI785lEHsW4DAGEdPfIkLcTjtwHnb7b3hCd64ibvPItcUTC750V+Xw70
         g+bENVg0/Xzuc6kfjltHThjQ+pdzh0ICaGKgP6umrLVwLwJkozFtHqGxVrhKdoNhFhZn
         71mNV7+HZVr2oi+gd4e/duQfRK4wMtsbUPf8E=
Received: by 10.231.31.135 with SMTP id y7mr3276025ibc.139.1283053576774;
        Sat, 28 Aug 2010 20:46:16 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154671>

Previously the status code of all helpers were ignored, allowing
errors that occur to go unnoticed if the error text output by the
helper is not noticed (or was not present at all).
---

  I'm surprised nobody fixed this sooner.

 transport-helper.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 9f2ad00..4a2826d 100644
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
+	if(disconnect_helper(transport))
+		die("Error while disconnecting helper");
+	if (finish_command(&fastimport))
+		die("Error while running fast-import");
+
 	free(fastimport.argv);
 	fastimport.argv = NULL;
 
@@ -751,8 +756,10 @@ static int push_refs_with_export(struct transport *transport,
 		die("Couldn't run fast-export");
 
 	data->no_disconnect_req = 1;
-	finish_command(&exporter);
-	disconnect_helper(transport);
+	if(finish_command(&exporter))
+		die("Error while running fast-export");
+	if(disconnect_helper(transport))
+		die("Error while disconnecting helper");
 	return 0;
 }
 
-- 
1.7.2.1.240.g6a95c3
