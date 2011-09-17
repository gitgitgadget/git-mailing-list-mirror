From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 2/4] merge: use return value of resolve_ref() to determine if HEAD is invalid
Date: Sat, 17 Sep 2011 21:57:43 +1000
Message-ID: <1316260665-1728-2-git-send-email-pclouds@gmail.com>
References: <1316260665-1728-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 13:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4tXK-0005Dj-BV
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 13:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab1IQL6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Sep 2011 07:58:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35780 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab1IQL6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 07:58:01 -0400
Received: by mail-iy0-f174.google.com with SMTP id q3so3214468iaq.19
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bIy842nyVr6PcZ5DatfuJ3DrXLczh7JBMb+7hr8n330=;
        b=pDOtxsjyFglzpqbP+7URYRf3moUkGl339MAG02KdqA2+K0f8n6O6DzGX/llO4fnfT5
         bVClgYGzm6Rt++2fdoE9SEsNbJ/Fgb4JttFN3jPyptpKJf+B9AuLjMlNJibzP+eXq1r+
         FNkiEMVJGCQyevCvfzBEYvlwSCJS+YM1LJAHA=
Received: by 10.231.69.18 with SMTP id x18mr771031ibi.37.1316260681480;
        Sat, 17 Sep 2011 04:58:01 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id j2sm14265122ibx.11.2011.09.17.04.57.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 04:58:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 17 Sep 2011 21:57:54 +1000
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1316260665-1728-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181577>

resolve_ref() only updates "head" when it returns non NULL value (it
may update "head" even when returning NULL, but not in all cases).

Because "head" is not initialized before the call, is_null_sha1() is
not enough. Check also resolve_ref() return value.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
 >> -     if (is_null_sha1(head))
 >> -             head_invalid =3D 1;
 >> +     if (!is_null_sha1(head)) {
 >> +             head_commit =3D lookup_commit(head);
 >> +             if (!head_commit)
 >> +                     die(_("could not parse HEAD"));
 >> +     }
 >
 > Is this is_null_sha1() valid without first clearing head[]?

 No it's not.

 builtin/merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a068660..c371484 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1030,7 +1030,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	branch =3D resolve_ref("HEAD", head, 0, &flag);
 	if (branch && !prefixcmp(branch, "refs/heads/"))
 		branch +=3D 11;
-	if (is_null_sha1(head))
+	if (!branch || is_null_sha1(head))
 		head_invalid =3D 1;
=20
 	git_config(git_merge_config, NULL);
--=20
1.7.3.1.256.g2539c.dirty
