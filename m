From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/31] parse_pathspec: support stripping submodule trailing slashes
Date: Sun, 13 Jan 2013 19:35:22 +0700
Message-ID: <1358080539-17436-15-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:37:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMom-000729-Ra
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130Ab3AMMhR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:37:17 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:47590 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab3AMMhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:37:16 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so1413480dac.26
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ea6SE5Wd/pQFmdpfkYAyvoIF7IQCvn426urd/sfOCR8=;
        b=q6nOckW5Wou1Ys7bMEHYGCigvvHPfNXci9CJXYLLzKJG5fR3li4IoZZGYfwwG2jVQs
         gkIHG+OyL59tQMmaubt2Sbc/m2/TjiXbqXq4s8jcBZ2CceUTUfmHjR28Zzm8Zt15H3Wq
         6l+HXFyN5/4FijmVsKiZOWvE4/VcgU/IPsdMgXho/5dKpNxsQls3Yl88nfzMiv/F/h5d
         KfNmG/v7pI5tGY9lwLr87KwFFOsfYWRvvWzs7f8/+xAGGFwSKvm5qwV5an84j0wFS41C
         ITWmLXIbVfRfK4ZGUqpx5r3UmRRq/WooaFFAh5ChPvIXOkkJvjZ+Il8kC0FKMJTSalo0
         v57g==
X-Received: by 10.68.235.71 with SMTP id uk7mr246638798pbc.10.1358080636033;
        Sun, 13 Jan 2013 04:37:16 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id us7sm6289465pbc.40.2013.01.13.04.37.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:37:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:37:30 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213354>

This flag is equivalent to builtin/ls-files.c:strip_trailing_slashes()
and is intended to replace that function when ls-files is converted to
use parse_pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h | 1 +
 setup.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/cache.h b/cache.h
index 32231d8..611a410 100644
--- a/cache.h
+++ b/cache.h
@@ -505,6 +505,7 @@ struct pathspec {
=20
 /* parse_pathspec flags */
 #define PATHSPEC_EMPTY_MATCH_ALL (1<<0) /* No args means match everyth=
ing */
+#define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<1)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec, unsigned magic_m=
ask,
diff --git a/setup.c b/setup.c
index d0b1d1f..a1aabc2 100644
--- a/setup.c
+++ b/setup.c
@@ -250,6 +250,15 @@ static unsigned prefix_pathspec(struct pathspec_it=
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
 	item->flags =3D 0;
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
--=20
1.8.0.rc2.23.g1fb49df
