From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/21] tree_entry_interesting(): fix depth limit with overlapping pathspecs
Date: Wed, 15 Dec 2010 22:02:45 +0700
Message-ID: <1292425376-14550-11-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSt0k-0004PK-QQ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab0LOPLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:11:18 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40720 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab0LOPLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:11:17 -0500
Received: by ywl5 with SMTP id 5so1088696ywl.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Nz6OGyKkODMzjSHQ9jheQGX10lsxquccQUaVFW2rzgQ=;
        b=VaDSRPY1XqueSChbXryxGR8JV4T0Ru9N/uaNqlyWKPx6+V/rGIisgpi/7IRGREpM47
         KPZlzqKGkSkEsMEPyYIstVlheQPti7hpg/WJVY2QCg1fI7xC3jU+VaycfBsi9KXmpSGy
         rkZSLKhAGQalPI4rXNyh2vm4xsEWxvdr2GbvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xGGqRtn4XeOQaSZTZDCT3AMZjWrBddbK76VNEMsUXalBiIACOV12w6PWUG0xLI+4xY
         z6w4LrnoUAWFg1FJ4of9UdEr3wQhJU60iw/kDFyc2gK/wCknhLdQowgPLvQ0ZPGlI7Ux
         aU4JaJ2XXjhX3i3An0w+6Z5n/4blng5wpgopc=
Received: by 10.42.178.1 with SMTP id bk1mr6029673icb.234.1292425510932;
        Wed, 15 Dec 2010 07:05:10 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id y3sm853730icw.0.2010.12.15.07.05.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:05:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:04:18 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163778>

Suppose we have two pathspecs 'a' and 'a/b' (both are dirs) and depth
limit 1. In current code, pathspecs are checked in input order. When
'a/b' is checked against pathspec 'a', it fails depth limit and
therefore is excluded, although it should match 'a/b' pathspec.

This patch reorders all pathspecs alphabetically, then teaches
tree_entry_interesting() to check against the deepest pathspec first,
so depth limit of a shallower pathspec won't affect a deeper one.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c       |   13 +++++++++++++
 tree-walk.c |    2 +-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 79e88f6..aa0522d 100644
--- a/dir.c
+++ b/dir.c
@@ -1086,6 +1086,15 @@ int remove_path(const char *name)
 	return 0;
 }
=20
+static int pathspec_item_cmp(const void *a_, const void *b_)
+{
+	struct pathspec_item *a, *b;
+
+	a =3D (struct pathspec_item *)a_;
+	b =3D (struct pathspec_item *)b_;
+	return strcmp(a->match, b->match);
+}
+
 int init_pathspec(struct pathspec *pathspec, const char **paths)
 {
 	const char **p =3D paths;
@@ -1109,6 +1118,10 @@ int init_pathspec(struct pathspec *pathspec, con=
st char **paths)
 		item->match =3D path;
 		item->len =3D strlen(path);
 	}
+
+	qsort(pathspec->items, pathspec->nr,
+	      sizeof(struct pathspec_item), pathspec_item_cmp);
+
 	return 0;
 }
=20
diff --git a/tree-walk.c b/tree-walk.c
index 91d7b36..93b05a7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -568,7 +568,7 @@ int tree_entry_interesting(const struct name_entry =
*entry,
=20
 	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
-	for (i =3D 0; i < ps->nr; i++) {
+	for (i =3D ps->nr-1; i >=3D 0; i--) {
 		const struct pathspec_item *item =3D ps->items+i;
 		const char *match =3D item->match;
 		int matchlen =3D item->len;
--=20
1.7.3.3.476.g10a82
