From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/10] clone: factor out HEAD update code
Date: Tue, 10 Jan 2012 16:57:01 +0700
Message-ID: <1326189427-20800-5-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:58:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYSv-0005GN-4n
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673Ab2AJJ54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:57:56 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49885 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751348Ab2AJJ5z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 04:57:55 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id wo16so5292866obc.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D0jcQ9jNtUUvN3ie+sJWEgA8scQrGuf4x3Lixi93FJs=;
        b=wdFssmr35XTJ1oCPEm7YG6siw9rVrezZc2JC0UZ7AGls10AV6ZLDdljHyAYVd0HLn8
         iALHnhlZXKJT2cIeBsYGG7qWoOuKJWAVa0Tt/kX7Nkhl/HyFpk2LC0UtYpQu0EBO3oqv
         1HMM5ISO9tRa7FeK0xXJ3kGFmxMO9qoQXBJxE=
Received: by 10.50.207.72 with SMTP id lu8mr1808328igc.0.1326189475076;
        Tue, 10 Jan 2012 01:57:55 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id t5sm1957735igb.4.2012.01.10.01.57.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:57:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:57:46 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188236>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   36 +++++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 100056d..26a037c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -448,6 +448,24 @@ static void write_remote_refs(const struct ref *lo=
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
+		/* Source had detached HEAD pointing somewhere. */
+		update_ref(msg, "HEAD", remote->old_sha1,
+			   NULL, REF_NODEREF, DIE_ON_ERR);
+	}
+}
+
 static int checkout(void)
 {
 	unsigned char sha1[20];
@@ -763,23 +781,7 @@ int cmd_clone(int argc, const char **argv, const c=
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
