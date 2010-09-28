From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] pathspec: cache string length when initializing pathspec
Date: Tue, 28 Sep 2010 22:00:26 +1000
Message-ID: <1285675229-28019-4-git-send-email-pclouds@gmail.com>
References: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:33:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ijZ-00036b-6H
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157Ab0I1WdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 18:33:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61631 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab0I1WdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:33:08 -0400
Received: by pzk34 with SMTP id 34so35451pzk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yU2MXgc6kflo5G7DA3KaFjMFXhhVFa2fwL4ZvOfyYBM=;
        b=C1UpJ/0EIN5xRb14RjtXIIbGlW4W/1gUcifR9fqJMQM2t4+nPY62UTAjp8qV30ga0X
         bGdL4ya0mRO/wh8Lt+kc1PvFwiEbU5uap0OazGiRogrZWs/aaGyOrXQ8a325dMpVaEdu
         M7uTAL2fYSctwfi3RBcMJqo2SeBBg4l2PO1T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hoqPpKm85mfjZm79PbncFfzMYNNPiyhQIvpeA1NkMPSUJ/iWuV83tJH+awlyrmT9YE
         D2jTVeO3V9kE4x/NKeuWbljp6IDEt++VcuK8FOuvhNhExbWZDDBHiil/PA01eJHiKsSM
         f0GGfOr1aG5xYoaxnN39nV+0mTU3FXQKqL60Y=
Received: by 10.142.51.21 with SMTP id y21mr607480wfy.173.1285713186746;
        Tue, 28 Sep 2010 15:33:06 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id l42sm9369466wfa.21.2010.09.28.15.33.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 15:33:05 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 28 Sep 2010 22:00:49 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157489>

This field will be used when tree_entry_interesting() is converted to
use struct pathspec. Currently it uses pathlens[] in struct
diff_options to avoid calculating string over and over again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    3 +++
 dir.c   |   13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index a3029fd..d4d9bc5 100644
--- a/cache.h
+++ b/cache.h
@@ -495,6 +495,9 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
+	struct pathspec_item {
+		int len;
+	} *items;
 };
=20
 extern int init_pathspec(struct pathspec *, const char **);
diff --git a/dir.c b/dir.c
index 205adc4..646c79f 100644
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
@@ -1082,10 +1083,20 @@ int init_pathspec(struct pathspec *pathspec, co=
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
+		struct pathspec_item *item =3D pathspec->items+i;
+
+		item->len =3D strlen(paths[i]);
+	}
 	return 0;
 }
=20
 void free_pathspec(struct pathspec *pathspec)
 {
-	; /* do nothing */
+	free(pathspec->items);
+	pathspec->items =3D NULL;
 }
--=20
1.7.1.rc1.70.g788ca
