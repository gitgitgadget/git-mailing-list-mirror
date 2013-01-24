From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] sha1_file: refuse to write commits referring to external objects
Date: Thu, 24 Jan 2013 15:42:16 +0700
Message-ID: <1359016940-18849-3-git-send-email-pclouds@gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 09:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIP4-0002n3-Hm
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 09:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab3AXInB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 03:43:01 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:53972 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3AXInA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 03:43:00 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so4174706dal.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 00:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CliY2P20OSe5U8vxsNlaIKSGnPI3lBoe/tLMG2Y528s=;
        b=D+tbaigt2si1NhiXtB4+CrzmOI6cTxoLs2VmI1nX9syN1hJtKFSbntHJUPUx4SM6y7
         ViNT4v2D0RPf7t7UZwOkhvJlwzVJt3jnLpY5TGpDGUpRI6CnclkUMS/k5V0xA56sti+5
         1AGcVUYmEcLR23u9YFYh6zGsH2v1j/4jK93uzngdVxcXPuFnAzQlJ9uW8dJWpptxaw2L
         hurYNNWk3qyEJV1NlqRQfjbpwLPsMnCfhO+J2clh7sOSftAhNn9WcMlzIa5wpE2zEBIK
         sZdOqW39I7HUtmbqCjd8Lr0GQP9FGS2rWqAoSsaqIAZQvLEsGrG7MZNKd3fR9yv7nyFJ
         uuAQ==
X-Received: by 10.66.73.167 with SMTP id m7mr2654257pav.68.1359016979818;
        Thu, 24 Jan 2013 00:42:59 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id oi3sm14497361pbb.1.2013.01.24.00.42.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 00:42:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jan 2013 15:42:36 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
In-Reply-To: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214414>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index af71122..5948dcb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2615,12 +2615,46 @@ static int write_loose_object(const unsigned ch=
ar *sha1, char *hdr, int hdrlen,
 	return move_temp_to_file(tmp_file, filename);
 }
=20
+static void check_sha1_file_for_external_source(const char *buf,
+						unsigned long len,
+						const char *type)
+{
+	struct object_info oi;
+	unsigned char sha1[20];
+
+	/*
+	 * It is assumed that the object is well formatted. Otherwise
+	 * die() is waiting..
+	 */
+	if (!strcmp(type, "commit")) {
+		const char *tail =3D buf + len;
+		if (get_sha1_hex(buf + 5, sha1) < 0 ||
+		    sha1_object_info_extended(sha1, &oi) !=3D OBJ_TREE ||
+		    (oi.alt && oi.alt->external))
+			die("cannot create a commit with external tree %s",
+			    sha1_to_hex(sha1));
+		buf +=3D 46; /* "tree " + "hex sha1" + "\n" */
+
+		while (buf + 48 < tail && !memcmp(buf, "parent ", 7)) {
+			if (get_sha1_hex(buf + 7, sha1) < 0 ||
+			    sha1_object_info_extended(sha1, &oi) !=3D OBJ_COMMIT ||
+			    (oi.alt && oi.alt->external))
+				die("cannot create a commit with external parent %s",
+				    sha1_to_hex(sha1));
+			buf +=3D 48; /* "parent " + hex sha1 + "\n" */
+		}
+	}
+}
+
 int write_sha1_file(const void *buf, unsigned long len, const char *ty=
pe, unsigned char *returnsha1)
 {
 	unsigned char sha1[20];
 	char hdr[32];
 	int hdrlen;
=20
+	if (object_database_contaminated)
+		check_sha1_file_for_external_source(buf, len, type);
+
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
--=20
1.8.0.rc3.18.g0d9b108
