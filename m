From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] pathspec: cache string length when initialize pathspec
Date: Mon, 20 Sep 2010 09:21:51 +1000
Message-ID: <1284938514-16663-4-git-send-email-pclouds@gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:22:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTDl-0007qb-HC
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab0ISXW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:22:26 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0ISXWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:22:21 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1084991pwi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=bQyFenMZpt7FkR9p79KGqT8kyDg/ur6Qf7VaUBP7G5s=;
        b=rTJ3q3MkdpNI8XXc79CqFOH5vaxj7pzc0VrUwKbftxwc2fW9oCQTvZYBTmNsx7zlAq
         auD6qWmsa+bs5CR0nvKGDmsuIHgRzNw0oyznEMq5w8HcNYykXdYu+mLBrPhMFh5kjiN5
         LPuiDHvCF3EushvxtaQG68x8nRrHxx6VuIXD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=d8hNkDOfRdb00zMyXl2c94wyinU88w6uWpSrXpJB4OeDPUht7ZyI/sQ2Q+Ulm3kO8t
         3jJpCfwU1+NNvzXCgXEeW6IP4kChKULdMuLM9yehRL/Se4FpJouODZZyMibOBQPEo27m
         ow/dqT2b7tTrhHtq9TtBLS6VRm2aj/cQ04ZkY=
Received: by 10.114.94.18 with SMTP id r18mr9051025wab.188.1284938541423;
        Sun, 19 Sep 2010 16:22:21 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id o17sm12266647wal.9.2010.09.19.16.22.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:22:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:22:15 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156522>

This field will be used when tree_entry_interesting() is converted to
use struct pathspec. Currently it uses pathlens[] in struct
diff_options to avoid calculating string over and over again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    3 +++
 dir.c   |   11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 6227ddb..045c9fc 100644
--- a/cache.h
+++ b/cache.h
@@ -495,6 +495,9 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
 struct pathspec {
 	const char **raw;
 	int nr;
+	struct pathspec_item {
+		int len;
+	} *items;
 };
=20
 extern int init_pathspec(struct pathspec *,const char **);
diff --git a/dir.c b/dir.c
index 5815b64..80b2df2 100644
--- a/dir.c
+++ b/dir.c
@@ -1074,6 +1074,7 @@ int remove_path(const char *name)
 int init_pathspec(struct pathspec *pathspec, const char **paths)
 {
 	const char **p =3D paths;
+	int i;
=20
 	memset(pathspec, 0, sizeof(*pathspec));
 	if (!p)
@@ -1082,10 +1083,18 @@ int init_pathspec(struct pathspec *pathspec, co=
nst char **paths)
 		p++;
 	pathspec->raw =3D paths;
 	pathspec->nr =3D p - paths;
+	if (!pathspec->nr)
+		return 0;
+
+	pathspec->items =3D xmalloc(sizeof(struct pathspec_item)*pathspec->nr=
);
+	for (i =3D 0; i < pathspec->nr; i++) {
+		pathspec->items[i].len =3D strlen(paths[i]);
+	}
 	return 0;
 }
=20
 void free_pathspec(struct pathspec *pathspec)
 {
-	/* do nothing */
+	free(pathspec->items);
+	pathspec->items =3D NULL;
 }
--=20
1.7.1.rc1.70.g788ca
