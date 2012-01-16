From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 05/10] clone: factor out remote ref writing
Date: Mon, 16 Jan 2012 16:46:11 +0700
Message-ID: <1326707176-8045-6-git-send-email-pclouds@gmail.com>
References: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:47:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmj9m-0002vO-EC
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 10:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab2APJrJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 04:47:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55465 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2APJrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 04:47:07 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so2315494iag.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mUytywnnORm6K/g26F1TjwYe5TzDfUvlp4XaD9XwQ5w=;
        b=VLGUvQFgdyHLWhMMS/yjOEbBtjIixAG3r1rjrW05lFZzJqQ0djTQD5vbPUPRBTablT
         QOyzGz1NuXLd5vvrCB072ENvuMm9B+8EBVQsSuzxyJXqPecbc/HjnjLMenbTIqOXbwJ2
         nnsSHC5SZlnuoCdMI1qoYyt27FTp2ZPRLli3s=
Received: by 10.42.162.197 with SMTP id z5mr9648419icx.48.1326707227646;
        Mon, 16 Jan 2012 01:47:07 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pb6sm32285064igc.5.2012.01.16.01.47.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 01:47:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:46:58 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188620>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 3b68014..2733fa4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -486,6 +486,29 @@ static void write_followtags(const struct ref *ref=
s, const char *msg)
 	}
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
+		if (option_single_branch)
+			write_followtags(refs, msg);
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
+}
+
 static void update_head(const struct ref *our, const struct ref *remot=
e,
 			const char *msg)
 {
@@ -782,12 +805,6 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	if (refs) {
-		clear_extra_refs();
-
-		write_remote_refs(mapped_refs);
-		if (option_single_branch)
-			write_followtags(refs, reflog_msg.buf);
-
 		remote_head =3D find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =3D
 			guess_remote_head(remote_head, mapped_refs, 0);
@@ -821,14 +838,8 @@ int cmd_clone(int argc, const char **argv, const c=
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
