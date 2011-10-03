From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] daemon: return "access denied" if a service is not allowed
Date: Tue,  4 Oct 2011 08:55:09 +1100
Message-ID: <1317678909-19383-1-git-send-email-pclouds@gmail.com>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 23:55:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAqU0-000133-B7
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 23:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657Ab1JCVz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 17:55:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55481 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646Ab1JCVz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 17:55:27 -0400
Received: by yxl31 with SMTP id 31so3944122yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7MNs42gRbeK2bwcqoFRZ884P7G66u7sbXCc4guAH3kg=;
        b=xFqg44KxDMZDz6tBa8prWQadZwEsGQPKXC2kc9in0bcf8eA1P0Y8G0n/EpN4kXNE00
         yG3Ida70Vham8VSaL3KEEeWb3MwxMxtQOIIyao0zIjrqBSE2Q63AtTahlVlp6YNrfsqe
         yGuGZIvR+ULfAVwKoR9aapoVT0X/J28KJyaj0=
Received: by 10.236.187.35 with SMTP id x23mr2943098yhm.6.1317678926496;
        Mon, 03 Oct 2011 14:55:26 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id v20sm39728025anv.17.2011.10.03.14.55.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 14:55:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 04 Oct 2011 08:55:11 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182714>

The message is chosen to avoid leaking information, yet let users know
that they are deliberately not allowed to use the service, not a fault
in service configuration or the service itself.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 OK let's try again. I don't send ERR when faults happen in
 service->fn() (eventually run_service_command) because

  - if it's start_command(), it's likely due to service configuration
    fault (wrong --exec-path..)

  - if it's finish_command(), the service may have run and sent
    something back to users. We may break the protocol by sending ERR

 daemon.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4c8346d..f0cae24 100644
--- a/daemon.c
+++ b/daemon.c
@@ -257,11 +257,11 @@ static int run_service(char *dir, struct daemon_s=
ervice *service)
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
 		errno =3D EACCES;
-		return -1;
+		goto failed;
 	}
=20
 	if (!(path =3D path_ok(dir)))
-		return -1;
+		goto failed;
=20
 	/*
 	 * Security on the cheap.
@@ -277,7 +277,7 @@ static int run_service(char *dir, struct daemon_ser=
vice *service)
 	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
 		logerror("'%s': repository not exported.", path);
 		errno =3D EACCES;
-		return -1;
+		goto failed;
 	}
=20
 	if (service->overridable) {
@@ -291,7 +291,7 @@ static int run_service(char *dir, struct daemon_ser=
vice *service)
 		logerror("'%s': service not enabled for '%s'",
 			 service->name, path);
 		errno =3D EACCES;
-		return -1;
+		goto failed;
 	}
=20
 	/*
@@ -301,6 +301,10 @@ static int run_service(char *dir, struct daemon_se=
rvice *service)
 	signal(SIGTERM, SIG_IGN);
=20
 	return service->fn();
+
+failed:
+	packet_write(1, "ERR %s: access denied", dir);
+	return -1;
 }
=20
 static void copy_to_log(int fd)
--=20
1.7.3.1.256.g2539c.dirty
