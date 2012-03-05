From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/11] fsck: use streaming interface for writing lost-found blobs
Date: Mon,  5 Mar 2012 10:43:47 +0700
Message-ID: <1330919028-6611-11-git-send-email-pclouds@gmail.com>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 04:45:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Ori-0004Ag-1E
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab2CEDpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 22:45:33 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52615 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab2CEDpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:45:32 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so4472065dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 19:45:32 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.130.138 as permitted sender) client-ip=10.68.130.138;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.130.138 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.130.138])
        by 10.68.130.138 with SMTP id oe10mr44886976pbb.24.1330919132192 (num_hops = 1);
        Sun, 04 Mar 2012 19:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Qd++lE8u1uw+Me5QF5u2ExRLK9vdXlYZybrAhzdafLo=;
        b=LaTyZnt0hGx0mcS4VGyRYdpcnPUNanZ5eixmqWmDZMna/voKw3qL/84LvqqeAsG3XG
         ABLWGFnXfzthk6BqsaGR0Ga9K8ydVwElclMQTQ07HGbDAmFfDx2l4vsFzI33tgoHU31R
         mwb5sn5mm3Y+c93gklLNC3SWAWVcf0GMRoRdGOIxHmJlRoWCF9smohw+i4OP+kpwJsaj
         mPLSHJNrFHpVNMdKy8uuHCxBXwjDn5H8G6fx3zXVDW8He7iCavHlKTRMudGUOcoRpJkq
         i3XqQqLNHKm63P4J1c5lp67KZoDIswTpInhfSgcexSgjI+UQMP/2UiIlAdITPyeH37mw
         2wjg==
Received: by 10.68.130.138 with SMTP id oe10mr38448350pbb.24.1330919132153;
        Sun, 04 Mar 2012 19:45:32 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id a1sm12085141pbj.72.2012.03.04.19.45.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 19:45:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Mar 2012 10:45:06 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192203>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fsck.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8c479a7..7fcb33e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "dir.h"
 #include "progress.h"
+#include "streaming.h"
=20
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -236,13 +237,8 @@ static void check_unreachable_object(struct object=
 *obj)
 			if (!(f =3D fopen(filename, "w")))
 				die_errno("Could not open '%s'", filename);
 			if (obj->type =3D=3D OBJ_BLOB) {
-				enum object_type type;
-				unsigned long size;
-				char *buf =3D read_sha1_file(obj->sha1,
-						&type, &size);
-				if (buf && fwrite(buf, 1, size, f) !=3D size)
+				if (stream_blob_to_fd(fileno(f), obj->sha1, NULL, 1))
 					die_errno("Could not write '%s'", filename);
-				free(buf);
 			} else
 				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
 			if (fclose(f))
--=20
1.7.3.1.256.g2539c.dirty
