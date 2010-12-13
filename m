From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/19] tree_entry_interesting(): support wildcard matching
Date: Mon, 13 Dec 2010 16:46:49 +0700
Message-ID: <1292233616-27692-13-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:49:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS52N-0005A4-TB
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab0LMJt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:49:26 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43383 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0LMJtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:49:25 -0500
Received: by pzk6 with SMTP id 6so479649pzk.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=riv3uDOoGO41tRuyoTnhUs4cEfZ5HbLMKWjy/l1/0rM=;
        b=rtMtAAPyMIHlD7SpWWpXdAzNNzffVIhZpMBrpTc686/7Fd4e+s/hlfMh0o9FCr7YnV
         AYA4o5M+XUad7g/IhdBzorGOzz7YICxOQqVBgTr1WMwx8LB9DwA5LsMnHuUYFqhVXPZL
         XIDFJI6LftjoG51tB+2TQp/5p+9rYb5dzNeBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MvWpVe/DQF6rkRmX6symRMPEFNbTaN5xUdXCieBimOKPfomnvQWABeTClVkhyoZQMy
         D05+3lbHNjUd2GVkG76iH0JkqyUlhAKZ6mydWDXZ1luI/IL0CbBCT0b8iYXJOFLXTXES
         VWLaLnao+u4YwQP+nMA7rOaIT+v9p9pqaNe2s=
Received: by 10.142.162.3 with SMTP id k3mr2058396wfe.170.1292233764649;
        Mon, 13 Dec 2010 01:49:24 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id p8sm8678272wff.4.2010.12.13.01.49.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:48:32 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163540>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-walk.c |   33 ++++++++++++++++++++++++++++++---
 tree-walk.h |    2 +-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index d28de30..b5ad42b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -552,7 +552,7 @@ static int match_dir_prefix(const char *base, int b=
aselen,
  *  - negative for "no, and no subsequent entries will be either"
  */
 int tree_entry_interesting(const struct name_entry *entry,
-			   const char *base, int baselen,
+			   char *base, int baselen,
 			   const struct pathspec *ps)
 {
 	int i;
@@ -573,13 +573,15 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
 	for (i =3D 0; i < ps->nr; i++) {
+		const struct pathspec_item *item =3D ps->items+i;
+
 		const char *match =3D ps->raw[i];
-		int matchlen =3D ps->items[i].len;
+		int matchlen =3D item->len;
=20
 		if (baselen >=3D matchlen) {
 			if (!match_dir_prefix(base, baselen, match, matchlen))
 				/* Just a random prefix match */
-				continue;
+				goto match_wildcards;
=20
 			if (!ps->recursive || ps->max_depth =3D=3D -1)
 				return 2;
@@ -596,6 +598,31 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 					&never_interesting))
 				return 1;
 		}
+
+match_wildcards:
+		/*
+		 * Concatenate base and entry->path into one and do
+		 * fnmatch() on it.
+		 */
+
+		if (!item->has_wildcard)
+			continue;
+
+		never_interesting =3D 0;
+		memcpy(base + baselen, entry->path, pathlen+1);
+
+		if (!fnmatch(match, base, 0)) {
+			base[baselen] =3D 0;
+			return 1;
+		}
+		base[baselen] =3D 0;
+
+		/*
+		 * Match all directories. We'll try to match files
+		 * later on.
+		 */
+		if (ps->recursive && S_ISDIR(entry->mode))
+			return 1;
 	}
 	return never_interesting; /* No matches */
 }
diff --git a/tree-walk.h b/tree-walk.h
index c12f0a2..94e0ef4 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -60,6 +60,6 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
-extern int tree_entry_interesting(const struct name_entry *, const cha=
r *, int, const struct pathspec *ps);
+extern int tree_entry_interesting(const struct name_entry *, char *, i=
nt, const struct pathspec *ps);
=20
 #endif
--=20
1.7.3.3.476.g10a82
