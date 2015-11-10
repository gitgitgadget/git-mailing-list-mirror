From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 06/12] push_refs_with_export: convert to struct object_id
Date: Tue, 10 Nov 2015 02:22:24 +0000
Message-ID: <1447122150-672570-7-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:23:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvyaR-0000rb-1t
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbbKJCXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:23:00 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58410 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751066AbbKJCWy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:22:54 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3B3322809A;
	Tue, 10 Nov 2015 02:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122173;
	bh=QKtZ78iJCemsRmCcWK8/yNp+l2CPeWOELaUz1GFBHI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/95Va5RmMry0sh6hKs156G9rk6PLz5L1Msv3QloJIDId8Jkv0KkcRYXja2nIJSWq
	 GF57115zqXqvYWBcEFgViJ5wW8dRykx5XOGHrpVrIJdoSKKn1K9+HxZ/Auyud2Ue0E
	 CI9IErLUtoR0+YzHpsDa5xzof700o0zKfkq7ecdb2kitiExMBz40XZxACN5Y6v8E7z
	 pqZZ2JuCGteNsYEXwEb0hJy7TrHXG9WRXhbzx4Y7wlzx4en0lO1Yr9fBR2pmTh9UpJ
	 PKyNp054BzyxFWg0rEIPuZ/LS1DoRNxhl2wk8vhMlcxSi/SmBevRYB/BgLwb6kWGpg
	 DWOay8XSrlkqafL5Ps+Ui8+gl4xNpo6kyrStxf75hTXD59uTUkj2yCB5jadJ98yc3O
	 xVY0XvpkCw8c8GPeW5A3rePey8Vs5HMUQdjqCf1hrjsfGRGZbzB7+n9oc1fnZZYOZD
	 Rsco0epGKWtjfkB4aMGSa6cBaVbaA44lahSRGqIPUwFpxShLkXf
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_FILL_THIS_FORM_SHORT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281093>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 transport-helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 91cb0e72..0eb3cf01 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -878,13 +878,13 @@ static int push_refs_with_export(struct transport *transport,
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *private;
-		unsigned char sha1[20];
+		struct object_id oid;
 
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
-		if (private && !get_sha1(private, sha1)) {
+		if (private && !get_sha1(private, oid.hash)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
-			hashcpy(ref->old_oid.hash, sha1);
+			oidcpy(&ref->old_oid, &oid);
 		}
 		free(private);
 
@@ -898,7 +898,7 @@ static int push_refs_with_export(struct transport *transport,
 					name = resolve_ref_unsafe(
 						 ref->peer_ref->name,
 						 RESOLVE_REF_READING,
-						 sha1, &flag);
+						 oid.hash, &flag);
 					if (!name || !(flag & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
-- 
2.6.2.409.gb049f0a
