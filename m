From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/31] parse_pathspec: support stripping/checking submodule paths
Date: Sun, 13 Jan 2013 19:35:25 +0700
Message-ID: <1358080539-17436-18-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:38:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMp7-0007N0-Fz
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131Ab3AMMhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:37:41 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:48087 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3AMMhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:37:41 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so1706530pbb.1
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=52aYuEfqpkIXfQU6BORn02lwFAtRc6ibR1jAVzMaFsY=;
        b=q2nlqk0qGASQi8+UUHr9Ah/26/yg+s/1OhMWRAUJLyE4lRQ50c7LjNt7EgZX2cs8IO
         YGwp8bcOut2GjEONjXeFGT9okvDgM4hMJ7oqUZTWihFG+1x+QJQceNsG/jA1rN8scLyo
         OU5dwWOdNqhi3Q5u+q7lRuZxRguw/l6u9tgWhcjUrzlAIE4vHxA4Ovx0zChVI4OcjqOY
         fldKW79I9DuMpcqMxyCPguKX3qk5KSBPNQhuj7EAADasqDTNJ3hAfBK7nS2X2QKGiQgE
         yQTeLHFn9brO4obBM9cbqQRd4G3c9mZpc1keZYLVweQAnKHLTbwz6mKnCzX6MLdixP/e
         pZ0Q==
X-Received: by 10.69.1.9 with SMTP id bc9mr244643554pbd.61.1358080660529;
        Sun, 13 Jan 2013 04:37:40 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id wr4sm6284050pbc.72.2013.01.13.04.37.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:37:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:37:56 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213357>

PATHSPEC_SYMLINK_LEADING_PATH and _STRIP_SUBMODULE_SLASH_EXPENSIVE are
respectively the alternate implementation of
builtin/add.c:validate_pathspec() and
builtin/add.c:treat_gitlinks(). They are intended to replace those
functions when builtin/add.c is converted to use parse_pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  2 ++
 setup.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/cache.h b/cache.h
index 611a410..a49496e 100644
--- a/cache.h
+++ b/cache.h
@@ -506,6 +506,8 @@ struct pathspec {
 /* parse_pathspec flags */
 #define PATHSPEC_EMPTY_MATCH_ALL (1<<0) /* No args means match everyth=
ing */
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<1)
+#define PATHSPEC_SYMLINK_LEADING_PATH (1<<2) /* has_symlink_leading_pa=
th */
+#define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<3)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec, unsigned magic_m=
ask,
diff --git a/setup.c b/setup.c
index a1aabc2..b6f419d 100644
--- a/setup.c
+++ b/setup.c
@@ -259,6 +259,26 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 		match[item->len] =3D '\0';
 	}
=20
+	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
+		for (i =3D 0; i < active_nr; i++) {
+			struct cache_entry *ce =3D active_cache[i];
+			int ce_len =3D ce_namelen(ce);
+
+			if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+
+			if (item->len <=3D ce_len || match[ce_len] !=3D '/' ||
+			    memcmp(ce->name, match, ce_len))
+				continue;
+			if (item->len =3D=3D ce_len + 1) {
+				/* strip trailing slash */
+				item->len--;
+				match[item->len] =3D '\0';
+			} else
+				die (_("Pathspec '%s' is in submodule '%.*s'"),
+				     elt, ce_len, ce->name);
+		}
+
 	item->flags =3D 0;
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
@@ -333,6 +353,12 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (item[i].magic & ~magic_mask)
 			die(_("pathspec magic in '%s' is not supported"
 			      " by this command"), arg);
+
+		if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
+		    has_symlink_leading_path(item[i].match, item[i].len)) {
+			die(_("pathspec '%s' is beyond a symbolic link"), arg);
+		}
+
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard =3D 1;
 		pathspec->magic |=3D item[i].magic;
--=20
1.8.0.rc2.23.g1fb49df
