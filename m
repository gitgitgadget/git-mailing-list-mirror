From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/10] checkout: do not try xstrdup() on NULL
Date: Tue, 15 Nov 2011 13:07:51 +0700
Message-ID: <1321337276-17803-5-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC9w-0005p2-Hu
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab1KOGFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:05:41 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64839 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab1KOGFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:05:40 -0500
Received: by mail-gx0-f174.google.com with SMTP id b2so7055058ggn.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9vLELYz9GkVrOL6NrpUi/5RmqYzRk4wn5quwEmm2Mbk=;
        b=LI9k7TIcHxGQIhlmEreXk1APe88JVKLnMmFcAm6ybmJA9zh1f0/p1zgUr+MQVOnmgJ
         0dQGLl4VBdNsBOeVOImef2x55Nyex6wXUaz+p3200/YofuV6bCOUy7zNq1tYasODMzFB
         3f6orSDOLKlai+JyJLat7ibn24gIqkl84t13s=
Received: by 10.68.15.232 with SMTP id a8mr56666684pbd.129.1321337139415;
        Mon, 14 Nov 2011 22:05:39 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id f1sm54178195pba.7.2011.11.14.22.05.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:05:38 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:24 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185427>

Also free memory in the other exit point

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f92c737..d80e2c4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -696,15 +696,14 @@ static int switch_branches(struct checkout_opts *=
opts, struct branch_info *new)
 {
 	int ret =3D 0;
 	struct branch_info old;
+	char *path;
 	unsigned char rev[20];
 	int flag;
 	memset(&old, 0, sizeof(old));
-	old.path =3D xstrdup(resolve_ref("HEAD", rev, 0, &flag, 0));
+	old.path =3D path =3D resolve_ref("HEAD", rev, 0, &flag, 1);
 	old.commit =3D lookup_commit_reference_gently(rev, 1);
-	if (!(flag & REF_ISSYMREF)) {
-		free((char *)old.path);
+	if (!(flag & REF_ISSYMREF))
 		old.path =3D NULL;
-	}
=20
 	if (old.path && !prefixcmp(old.path, "refs/heads/"))
 		old.name =3D old.path + strlen("refs/heads/");
@@ -718,8 +717,10 @@ static int switch_branches(struct checkout_opts *o=
pts, struct branch_info *new)
 	}
=20
 	ret =3D merge_working_tree(opts, &old, new);
-	if (ret)
+	if (ret) {
+		free(path);
 		return ret;
+	}
=20
 	if (!opts->quiet && !old.path && old.commit && new->commit !=3D old.c=
ommit)
 		orphaned_commit_warning(old.commit);
@@ -727,7 +728,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	update_refs_for_switch(opts, &old, new);
=20
 	ret =3D post_checkout_hook(old.commit, new->commit, 1);
-	free((char *)old.path);
+	free(path);
 	return ret || opts->writeout_error;
 }
=20
--=20
1.7.4.74.g639db
