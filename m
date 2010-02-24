From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 04/10] fetch: refactor verbosity option handling into transport.[ch]
Date: Wed, 24 Feb 2010 20:50:23 +0800
Message-ID: <1267015829-5344-5-git-send-email-rctay89@gmail.com>
References: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:51:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGi3-0005M5-L8
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab0BXMu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:50:56 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64550 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab0BXMuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:50:54 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so338835qyk.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/d2eLQWpfLmWaNh4ibQ+3EBSIl7kHtQTCZqRGokREVg=;
        b=psx7YK+uv24zPsakhMDA6CSIufSAP4GSHKGvdGkGplpKCzPlrXGZ6RVpSZgncUHhrY
         V4BtGUN3Vv+7fsfFntYo1Oty9UvTDjElPkSIzrF9+sY0aYORg86fiPLOKpbhK9fxfDKA
         qW+hC94lwHK3o9MBNcAoOpdIHPdQDT8IeHn3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JAMqCpfVfpIai1wPxL2TloCnGMmIfw+qi0R6b563FYeuxCEgNIvmjNfBvvgWGqaMmA
         EK/CIaAUamlBXLmxFS4cIYUZyi6IcAi8DtAe3XsK35rdIVZjtDn8RvlwjRpGNRDi1PiW
         ArqnSKr7ngTS9Z9V+5A3b1QPUEu1nAee97oqA=
Received: by 10.224.79.200 with SMTP id q8mr7670884qak.341.1267015854505;
        Wed, 24 Feb 2010 04:50:54 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.50.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:50:54 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140939>

transport_set_verbosity() is now provided to transport users.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-fetch.c |    5 +----
 transport.c     |    8 ++++++++
 transport.h     |    1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index d3b9d8a..a7c7e67 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -823,10 +823,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die("Where do you want to fetch from today?");
 
 	transport = transport_get(remote, NULL);
-	if (verbosity >= 2)
-		transport->verbose = verbosity <= 3 ? verbosity : 3;
-	if (verbosity < 0)
-		transport->verbose = -1;
+	transport_set_verbosity(transport, verbosity);
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/transport.c b/transport.c
index 1a360cf..54f5ede 100644
--- a/transport.c
+++ b/transport.c
@@ -1012,6 +1012,14 @@ int transport_set_option(struct transport *transport,
 	return 1;
 }
 
+void transport_set_verbosity(struct transport *transport, int verbosity)
+{
+	if (verbosity >= 2)
+		transport->verbose = verbosity <= 3 ? verbosity : 3;
+	if (verbosity < 0)
+		transport->verbose = -1;
+}
+
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   int *nonfastforward)
diff --git a/transport.h b/transport.h
index 096f6e9..5a5ce3a 100644
--- a/transport.h
+++ b/transport.h
@@ -129,6 +129,7 @@ struct transport *transport_get(struct remote *, const char *);
  **/
 int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
+void transport_set_verbosity(struct transport *transport, int verbosity);
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-- 
1.7.0.20.gcb44ed
