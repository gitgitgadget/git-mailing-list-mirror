From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/11] fsck: use streaming interface for writing lost-found blobs
Date: Mon, 27 Feb 2012 14:55:15 +0700
Message-ID: <1330329315-11407-12-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:57:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vSj-0007Xl-Sy
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab2B0H5d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:57:33 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61348 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab2B0H5c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:57:32 -0500
Received: by daed14 with SMTP id d14so835349dae.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:57:32 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.134.198 as permitted sender) client-ip=10.68.134.198;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.134.198 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.134.198])
        by 10.68.134.198 with SMTP id pm6mr34827531pbb.147.1330329452276 (num_hops = 1);
        Sun, 26 Feb 2012 23:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JE/drYy5PFCCRYqWh3DUsAGB0zS084DO1L3g5W41yHg=;
        b=IqwtgUGanttoocosg1cly2y8GAG9T2FNB/EP8NegTX51Sx2ZemOiFEyoMGiJXW4Kjg
         fbtw8zvNzPkMQNiDXbeLRSo0soTVxxW+K/F5y9Ly5zo9eeGkUSf+scDABXeGNghcK15+
         p2B0b/dROsLM1PteYv+uXAV1oC8msraynx1/o=
Received: by 10.68.134.198 with SMTP id pm6mr29713926pbb.147.1330329452252;
        Sun, 26 Feb 2012 23:57:32 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id x1sm12037094pbp.50.2012.02.26.23.57.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:57:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:57:09 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191616>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fsck.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8c479a7..319b5c7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -236,13 +236,9 @@ static void check_unreachable_object(struct object=
 *obj)
 			if (!(f =3D fopen(filename, "w")))
 				die_errno("Could not open '%s'", filename);
 			if (obj->type =3D=3D OBJ_BLOB) {
-				enum object_type type;
-				unsigned long size;
-				char *buf =3D read_sha1_file(obj->sha1,
-						&type, &size);
-				if (buf && fwrite(buf, 1, size, f) !=3D size)
+				if (streaming_write_sha1(fileno(f), 1,
+							 obj->sha1, OBJ_BLOB, NULL))
 					die_errno("Could not write '%s'", filename);
-				free(buf);
 			} else
 				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
 			if (fclose(f))
--=20
1.7.3.1.256.g2539c.dirty
