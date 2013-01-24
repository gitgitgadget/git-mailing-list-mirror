From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] refs: do not update ref(log) referring to external objects
Date: Thu, 24 Jan 2013 15:42:20 +0700
Message-ID: <1359016940-18849-7-git-send-email-pclouds@gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 09:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIPS-00033B-Sc
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 09:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab3AXIn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 03:43:28 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:63894 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab3AXIn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 03:43:26 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so5403621pac.29
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 00:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iVlAkYZiLRPNdInmg98klvxwcM/0vK0D3wArns3SAlY=;
        b=hD9uTFcD63HWplFvTNGrRKyfuB2VkhebiOxXE68cW7w0C+kT6jREr3bGUBhfPIRdW6
         Ow1oBHWtGY7X9sxxM1ErnAeW1dlaIcakmo5UAyh2y48aq/5fT0aA2qDhm7Np6g+/KL6+
         QuKGNaFfkS3icGmZJL5xd9Dh34J57q6yY5Ad99i8sjI7mwVpY6xya7sl2RtpYWNqvaIg
         93pbSKWl1Phl/VUpCbe/ZrnFHrED9I4xB3dyJwdm8BIe/wtstQG9zDPzPdMrSVW1X8O+
         5NiHnvSZ19Ilq8cmW78SGmZpNKZ/WdnArViENHD0R4n8cRGi+JNmisBU6yQUT9NZ46GJ
         aqfw==
X-Received: by 10.68.125.195 with SMTP id ms3mr2704438pbb.149.1359017006357;
        Thu, 24 Jan 2013 00:43:26 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d1sm15305730pav.6.2013.01.24.00.43.23
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 00:43:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jan 2013 15:43:02 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
In-Reply-To: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214418>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/refs.c b/refs.c
index 541fec2..86003af 100644
--- a/refs.c
+++ b/refs.c
@@ -2014,6 +2014,18 @@ static int log_ref_write(const char *refname, co=
nst unsigned char *old_sha1,
 	char *logrec;
 	const char *committer;
=20
+	if (object_database_contaminated) {
+		struct object_info oi;
+		if (sha1_object_info_extended(old_sha1, &oi) =3D=3D -1 ||
+		    (oi.alt && oi.alt->external))
+			return error("cannot update reflog pointing to an external SHA-1 %s=
",
+				     sha1_to_hex(old_sha1));
+		if (sha1_object_info_extended(new_sha1, &oi) =3D=3D -1 ||
+		    (oi.alt && oi.alt->external))
+			return error("cannot update reflog pointing to an external SHA-1 %s=
",
+				     sha1_to_hex(new_sha1));
+	}
+
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates =3D !is_bare_repository();
=20
@@ -2054,6 +2066,18 @@ int write_ref_sha1(struct ref_lock *lock,
=20
 	if (!lock)
 		return -1;
+
+	if (object_database_contaminated) {
+		struct object_info oi;
+		if (sha1_object_info_extended(sha1, &oi) =3D=3D -1 ||
+		    (oi.alt && oi.alt->external)) {
+			error("cannot update ref pointing to an external SHA-1 %s",
+			      sha1_to_hex(sha1));
+			unlock_ref(lock);
+			return -1;
+		}
+	}
+
 	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
 		unlock_ref(lock);
 		return 0;
--=20
1.8.0.rc3.18.g0d9b108
