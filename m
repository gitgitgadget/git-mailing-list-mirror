From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 11/45] parse_pathspec: support stripping submodule trailing slashes
Date: Fri, 15 Mar 2013 13:06:26 +0700
Message-ID: <1363327620-29017-12-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5O-0004lK-T5
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab3COGZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:21 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:59317 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3COGZS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:18 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so2947406iaa.29
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=8WOMp+VRjcPkoES9jhiMs9yFa7PfxoJ7ObtXZ04Xa0E=;
        b=IERsbGD9V0b+eDw5WWERVYaSfDg8BPJf+z2oKOIc5sVyhiVr1CIxzBgbT/nQwmVAR0
         YijSsqcmNeHhpaMIA/W9O5jlCfMJUIRyerXXcPn8xZppS8t/SalQGRFwoTsc7TUCkIMp
         ihvFwvtMJAXKZDfUF96gPU9C8GhALTmUJLogTnYs6Zx3/DqHVJQ/F6lGcd2BLCfMRYLn
         vzrD3TiRM2oFFSP0VeDIzfQPr7JR0HFz5nL6z1n62pK3NInL+h2DJ2Drl4FqZm0+s9xf
         StZZ/h8hVioFW9DvkwWFFQbMgk6nAR8L2M+T+DZlQt7Z+nqvKjMmhbehnm68/T0Ohx9a
         cFNw==
X-Received: by 10.50.33.203 with SMTP id t11mr4305889igi.97.1363328717461;
        Thu, 14 Mar 2013 23:25:17 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id xd4sm752032igb.3.2013.03.14.23.25.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:16 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:20 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218198>

This flag is equivalent to builtin/ls-files.c:strip_trailing_slashes()
and is intended to replace that function when ls-files is converted to
use parse_pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 9 +++++++++
 pathspec.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index b2446c3..2da8bc9 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -204,6 +204,15 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	*raw =3D item->match =3D match;
 	item->original =3D elt;
 	item->len =3D strlen(item->match);
+
+	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
+	    (item->len >=3D 1 && item->match[item->len - 1] =3D=3D '/') &&
+	    (i =3D cache_name_pos(item->match, item->len - 1)) >=3D 0 &&
+	    S_ISGITLINK(active_cache[i]->ce_mode)) {
+		item->len--;
+		match[item->len] =3D '\0';
+	}
+
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
 	else
diff --git a/pathspec.h b/pathspec.h
index aa98597..f24b07b 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -31,6 +31,7 @@ struct pathspec {
 #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything =
*/
 #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
+#define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
--=20
1.8.0.rc0.19.g7bbb31d
