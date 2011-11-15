From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/10] fmt-merge-msg: request resolve_ref() to allocate new buffer
Date: Tue, 15 Nov 2011 13:07:55 +0700
Message-ID: <1321337276-17803-9-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC9z-0005p2-PG
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab1KOGGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:06:07 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51083 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab1KOGGF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:06:05 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so14545629pzk.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KkaMjxq5qqLPhZrnhAeufZI9vFYzVkJoH32eay7XcAs=;
        b=PvCNAY2MVXAYYdktDQcTRFFgWMzrIJD8t0u8Caukwvr8zNBu0xoaj6ZorTsF0OqNfo
         Mkx3q6S+GgTHTiVCH/ZHxS3xGi+VEMx6l9ihbYWkoYWBFihJJhfwQdHI3MiSPAedZBJe
         N0vpvHLD4YjZ6t6hGuKDOpufAlkagH3Ot5fvw=
Received: by 10.68.36.72 with SMTP id o8mr55757085pbj.115.1321337165430;
        Mon, 14 Nov 2011 22:06:05 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id b8sm62396771pba.16.2011.11.14.22.06.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:06:04 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:50 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185430>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fmt-merge-msg.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index c80f4b7..3d001d4 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -261,9 +261,10 @@ static int do_fmt_merge_msg(int merge_title, struc=
t strbuf *in,
 	int i =3D 0, pos =3D 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
+	char *ref;
=20
 	/* get current branch */
-	current_branch =3D resolve_ref("HEAD", head_sha1, 1, NULL, 0);
+	current_branch =3D ref =3D resolve_ref("HEAD", head_sha1, 1, NULL, 1)=
;
 	if (!current_branch)
 		die("No current branch");
 	if (!prefixcmp(current_branch, "refs/heads/"))
@@ -283,8 +284,10 @@ static int do_fmt_merge_msg(int merge_title, struc=
t strbuf *in,
 			die ("Error in line %d: %.*s", i, len, p);
 	}
=20
-	if (!srcs.nr)
+	if (!srcs.nr) {
+		free(ref);
 		return 0;
+	}
=20
 	if (merge_title)
 		do_fmt_merge_msg_title(out, current_branch);
@@ -306,6 +309,7 @@ static int do_fmt_merge_msg(int merge_title, struct=
 strbuf *in,
 			shortlog(origins.items[i].string, origins.items[i].util,
 					head, &rev, shortlog_len, out);
 	}
+	free(ref);
 	return 0;
 }
=20
--=20
1.7.4.74.g639db
