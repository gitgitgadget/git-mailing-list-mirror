From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 22/28] remote-curl: pass ref SHA-1 to fetch-pack as well
Date: Mon, 25 Nov 2013 10:55:48 +0700
Message-ID: <1385351754-9954-23-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEz-0002D8-5E
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677Ab3KYDxj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:39 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:55839 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab3KYDxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:38 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so4755793pbb.23
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=paDeV4ioycTN9j2diQiybbdaXtw0ZFXnMSB3+j+eFGo=;
        b=PbuQmIH+HzoD+n1GiELEdbSTnq0U1yvCEdjvxcbsXf4jhGNnMZvOngde4Lb/5JvXNm
         OysUpKCnA6VOpdCW9nYv+H4ViTY/7OnY59rguSGDti6SJ8yAVFYlzXByKIbPiy20gcEA
         WbolmPJ0kC134OOr7GmZk1Xh9P9FGhwiojYUfPnByhRH6MOYsnmFC5aubADY91onxPRJ
         9UzEsWgyRVNBwDKfTRAWO2mPEL43pcsSII+0DaRJyV4BYgFzy3pnpZYPkbD4mXPD8ZBP
         nOTnMA4CHE8KeFrlcKKW2qKcYzBQnR5rEJhOOEVP6ouFb0082KfJ32X+idA3WEknTuv5
         JAJA==
X-Received: by 10.68.194.9 with SMTP id hs9mr16025587pbc.95.1385351618020;
        Sun, 24 Nov 2013 19:53:38 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id m2sm69720694pbn.19.2013.11.24.19.53.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:58:10 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238294>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c | 7 +++++++
 remote-curl.c        | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 927424b..aa6e596 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -13,6 +13,13 @@ static void add_sought_entry_mem(struct ref ***sough=
t, int *nr, int *alloc,
 				 const char *name, int namelen)
 {
 	struct ref *ref =3D xcalloc(1, sizeof(*ref) + namelen + 1);
+	unsigned char sha1[20];
+
+	if (namelen > 41 && name[40] =3D=3D ' ' && !get_sha1_hex(name, sha1))=
 {
+		hashcpy(ref->old_sha1, sha1);
+		name +=3D 41;
+		namelen -=3D 41;
+	}
=20
 	memcpy(ref->name, name, namelen);
 	ref->name[namelen] =3D '\0';
diff --git a/remote-curl.c b/remote-curl.c
index 222210f..25d6730 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -719,7 +719,8 @@ static int fetch_git(struct discovery *heads,
 		struct ref *ref =3D to_fetch[i];
 		if (!ref->name || !*ref->name)
 			die("cannot fetch by sha1 over smart http");
-		packet_buf_write(&preamble, "%s\n", ref->name);
+		packet_buf_write(&preamble, "%s %s\n",
+				 sha1_to_hex(ref->old_sha1), ref->name);
 	}
 	packet_buf_flush(&preamble);
=20
--=20
1.8.2.83.gc99314b
