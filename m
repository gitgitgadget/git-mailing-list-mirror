From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 04/10] clone: factor out HEAD update code
Date: Fri, 13 Jan 2012 14:21:56 +0700
Message-ID: <1326439322-15648-5-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:22:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbTS-0007zA-Tj
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab2AMHWu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:22:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab2AMHWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 02:22:50 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so3939442iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=z9M1QgDXD0Eg+ljRRb3EgOJj6MVotZ/cCMV9tkpWXco=;
        b=dPPIz40KCuHG8KXs/QmfC79QlccVk/30g7F1/oHkApstToQRX/J43U043U3ATHzLv7
         HzRtmBK84GRlSNNxInYZV0oaL0mJ3MwFJ2NgphHOZt1jRL51fgyHb1NhrllOUuyO66QA
         26t5TR9XQic2xdzs0/RlOw+p72l+aF0l/8cVg=
Received: by 10.50.181.197 with SMTP id dy5mr1476959igc.13.1326439369801;
        Thu, 12 Jan 2012 23:22:49 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id bj3sm5089620igb.4.2012.01.12.23.22.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:22:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:22:39 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188501>

While at it, update the comment at "if (remote_head)"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   41 ++++++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 100056d..baed5ae 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -448,6 +448,29 @@ static void write_remote_refs(const struct ref *lo=
cal_refs)
 	clear_extra_refs();
 }
=20
+static void update_head(const struct ref *our, const struct ref *remot=
e,
+			const char *msg)
+{
+	if (our) {
+		/* Local default branch link */
+		create_symref("HEAD", our->name, NULL);
+		if (!option_bare) {
+			const char *head =3D skip_prefix(our->name, "refs/heads/");
+			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
+			install_branch_config(0, head, option_origin, our->name);
+		}
+	} else if (remote) {
+		/*
+		 * We know remote HEAD points to a non-branch, or
+		 * HEAD points to a branch but we don't know which one, or
+		 * we asked for a specific branch but it did not exist.
+		 * Detach HEAD in all these cases.
+		 */
+		update_ref(msg, "HEAD", remote->old_sha1,
+			   NULL, REF_NODEREF, DIE_ON_ERR);
+	}
+}
+
 static int checkout(void)
 {
 	unsigned char sha1[20];
@@ -763,23 +786,7 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			      reflog_msg.buf);
 	}
=20
-	if (our_head_points_at) {
-		/* Local default branch link */
-		create_symref("HEAD", our_head_points_at->name, NULL);
-		if (!option_bare) {
-			const char *head =3D skip_prefix(our_head_points_at->name,
-						       "refs/heads/");
-			update_ref(reflog_msg.buf, "HEAD",
-				   our_head_points_at->old_sha1,
-				   NULL, 0, DIE_ON_ERR);
-			install_branch_config(0, head, option_origin,
-					      our_head_points_at->name);
-		}
-	} else if (remote_head) {
-		/* Source had detached HEAD pointing somewhere. */
-		update_ref(reflog_msg.buf, "HEAD", remote_head->old_sha1,
-			   NULL, REF_NODEREF, DIE_ON_ERR);
-	}
+	update_head(our_head_points_at, remote_head, reflog_msg.buf);
=20
 	if (transport) {
 		transport_unlock_pack(transport);
--=20
1.7.3.1.256.g2539c.dirty
