From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 05/10] clone: factor out remote ref writing
Date: Fri, 13 Jan 2012 14:21:57 +0700
Message-ID: <1326439322-15648-6-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:23:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbTc-00082Y-6O
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab2AMHXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:23:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab2AMHW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 02:22:59 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so3939442iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3AKZlFOHjo4Ec1KGuYBw9OHaHyv33eLXRvIwGi3t7RU=;
        b=LzvUYg1HL7jRjg5Emtl4a4RsuYhRWhWWf7ZsOqRFwpexa93gDCx3sCJyUA2SXZnV5c
         VdcMiDqWzU0G0oW7yvCEIj8FfnX5oEBWDaTVC9SYihDPi708ZD1IM848ZIcWKi/XZQKj
         Uapa/2g7hVXxNYIcn1oEdR43aAW9gL5ClpaBU=
Received: by 10.42.73.138 with SMTP id s10mr1587424icj.38.1326439379163;
        Thu, 12 Jan 2012 23:22:59 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id lu10sm13105600igc.0.2012.01.12.23.22.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:22:58 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:22:48 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188502>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index baed5ae..d1d6dca 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -448,6 +448,28 @@ static void write_remote_refs(const struct ref *lo=
cal_refs)
 	clear_extra_refs();
 }
=20
+static void update_remote_refs(const struct ref *refs,
+			       const struct ref *mapped_refs,
+			       const struct ref *remote_head_points_at,
+			       const char *branch_top,
+			       const char *msg)
+{
+	if (refs) {
+		clear_extra_refs();
+		write_remote_refs(mapped_refs);
+	}
+
+	if (remote_head_points_at && !option_bare) {
+		struct strbuf head_ref =3D STRBUF_INIT;
+		strbuf_addstr(&head_ref, branch_top);
+		strbuf_addstr(&head_ref, "HEAD");
+		create_symref(head_ref.buf,
+			      remote_head_points_at->peer_ref->name,
+			      msg);
+	}
+
+}
+
 static void update_head(const struct ref *our, const struct ref *remot=
e,
 			const char *msg)
 {
@@ -740,10 +762,6 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	if (refs) {
-		clear_extra_refs();
-
-		write_remote_refs(mapped_refs);
-
 		remote_head =3D find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =3D
 			guess_remote_head(remote_head, mapped_refs, 0);
@@ -777,14 +795,8 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 					      "refs/heads/master");
 	}
=20
-	if (remote_head_points_at && !option_bare) {
-		struct strbuf head_ref =3D STRBUF_INIT;
-		strbuf_addstr(&head_ref, branch_top.buf);
-		strbuf_addstr(&head_ref, "HEAD");
-		create_symref(head_ref.buf,
-			      remote_head_points_at->peer_ref->name,
-			      reflog_msg.buf);
-	}
+	update_remote_refs(refs, mapped_refs, remote_head_points_at,
+			   branch_top.buf, reflog_msg.buf);
=20
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
=20
--=20
1.7.3.1.256.g2539c.dirty
