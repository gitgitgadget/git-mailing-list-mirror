From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 03/10] fetch: refactor verbosity option handling into transport.[ch]
Date: Thu, 18 Feb 2010 20:37:04 +0800
Message-ID: <1266496631-3980-4-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5e3-0004Ez-FZ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162Ab0BRMho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:37:44 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:60410 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758149Ab0BRMhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:42 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so6323162yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Hw/XvGhKZK7S+rNVTrp9QqByH1eaT98Ldkud4qOIyyE=;
        b=nuwzZyYynqoT5r/y9J60S+ni9xU5ur5Kg6FIbY82pgiDmdeHWinkOhh59Yrezgrm0P
         l0N0AWqnVYjuFpAi2SFYSO7UnV74nNDnrY6p4yWP55jbgTzJYtBPyddoq6h3GWBibpoz
         7i8Ad3sZ3EbkAMzeKBhcEHnoyw2Mzt3k/fGvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MdR4z/CiOt6ACuFKK/NfS3vEMwP8YA22ToAY8+3LVLnnu+LHy/BllKbvhx09cLHRu5
         bMqNNADHQpJP+Zj9iA/dQMML3npzQFS1T4h61DuHXbyFr5OoiTxCaaO7doNfl7NDOmh5
         wibRQI0jVFjohWNz/annxpyvfoUMDQf509kn4=
Received: by 10.150.213.18 with SMTP id l18mr12341039ybg.157.1266496662366;
        Thu, 18 Feb 2010 04:37:42 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:41 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140325>

transport_set_verbosity() is now provided to transport users.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-fetch.c |    5 +----
 transport.c     |    8 ++++++++
 transport.h     |    1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 8654fa7..d23ea2a 100644
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
index 3846aac..1632c4d 100644
--- a/transport.c
+++ b/transport.c
@@ -1013,6 +1013,14 @@ int transport_set_option(struct transport *transport,
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
index 7cea5cc..7d1a0b6 100644
--- a/transport.h
+++ b/transport.h
@@ -122,6 +122,7 @@ struct transport *transport_get(struct remote *, const char *);
  **/
 int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
+void transport_set_verbosity(struct transport *transport, int verbosity);
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-- 
1.7.0.27.g5d71b
