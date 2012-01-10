From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/10] clone: factor out remote ref writing
Date: Tue, 10 Jan 2012 16:57:02 +0700
Message-ID: <1326189427-20800-6-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYT4-0005L3-V2
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab2AJJ6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:58:05 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48718 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab2AJJ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:58:04 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so664914iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ILeMaTwUpU5KeZ7OuoFGNRxo15cKmOUf59UtYksp4P8=;
        b=irsx7QPVk6/SEaiAYQZPcq62H7vCFGBSaRcVwavWRXHpZ/EL+YhxA+kiV4BlYgb+/y
         agK66NVJdlrBSp0Ars3xnWJ6xWDexy5MzZqUHlooCtXe4ZMa0jo9GRbU5bkgNcQhcWAs
         qC4fDuicZY3ngR6InmUtL2Y+mMaKLKmGdeOkY=
Received: by 10.42.135.138 with SMTP id p10mr19254558ict.25.1326189484066;
        Tue, 10 Jan 2012 01:58:04 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id b20sm261421643ibj.7.2012.01.10.01.57.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:58:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:57:55 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188237>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 26a037c..73d07ed 100644
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
@@ -735,10 +757,6 @@ int cmd_clone(int argc, const char **argv, const c=
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
@@ -772,14 +790,8 @@ int cmd_clone(int argc, const char **argv, const c=
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
