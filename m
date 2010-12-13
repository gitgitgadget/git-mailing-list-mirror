From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/19] pathspec: cache string length when initializing pathspec
Date: Mon, 13 Dec 2010 16:46:40 +0700
Message-ID: <1292233616-27692-4-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS516-0004Xi-W6
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786Ab0LMJsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:48:14 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41933 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab0LMJsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:48:12 -0500
Received: by pwj3 with SMTP id 3so1096117pwj.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9S1A/KYFhD1DPQMhpxC6QJ5S1UmxUBviNUolAO/3plc=;
        b=hrmVKw5Oopb4pxMD37dE1EVvYP7SQw0h+0MaCp6uMfWWROS3wZ3MGiYybOUsDC7FYg
         G+8idM0ks2P/Xa6gE6OPZ07jOOCLXQ5/IHRfwpzNbbLaCEe9e33Uw1acoj/qi9JUGBdd
         Kx8l/RtKppnnUKEuIelcoUIlFI+11TpRULgmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AtMQ2f0QRKlDB0HDEqCOUFTBINAHC/ljTViN1j01tYKupefA4powIff9O4P8H9Tyqq
         CX1MGlKFyNNbgwRaETxGhXpDoXErtUjtjcb9ctqHNkc0p+MS3z2qCRJt9LyQN05GWf7E
         IMb3Ygq6pfPRr1EacdWc5M2BkN69WomfBg3VM=
Received: by 10.142.139.17 with SMTP id m17mr3049460wfd.41.1292233692551;
        Mon, 13 Dec 2010 01:48:12 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id w22sm8674487wfd.19.2010.12.13.01.48.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:48:11 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:47:19 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163533>

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
index 3330769..36819b6 100644
--- a/cache.h
+++ b/cache.h
@@ -496,6 +496,9 @@ extern int ie_modified(const struct index_state *, =
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
1.7.3.3.476.g10a82
