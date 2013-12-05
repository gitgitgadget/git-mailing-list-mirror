From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 22/28] remote-curl: pass ref SHA-1 to fetch-pack as well
Date: Thu,  5 Dec 2013 20:02:49 +0700
Message-ID: <1386248575-10206-23-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:00:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYXs-0002mV-19
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab3LENAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:00:40 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33985 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab3LENAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:00:39 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so24552921pdj.17
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FEGy0H1aAudeWDWzEvriHq9w93SFVTXUr+s35nDc7ZI=;
        b=rhobd6Miv8LVMUcd2lG4XQop6CfP2pdFWmvYKWtujgVwbCE1yeGpb2YasMDfWV1K1n
         3IotmrFaYUpobT9C/HOKSD1RlV/nA9D7S3OOMrqdfPfiOcHQADdq98nosNTJ2DQZaL3U
         00+NA4tapLTqd66hioqX3te5UOpUbxV632pyuc5JjG+FPv/x3fW3rvC0RPH2eZUztcfp
         AH8X5niJ07HSVRA4N2YwmSFvuPVSoX7fflWBwwmEJsuGczq8V07pETicBcuA7skaZDdg
         KyBsdMWiDZam8TSCEfLg8kd7Lp98mZjybdf/Tt5L5Cbj/ZgRKgPfT7Yd26X+mSJWdSCQ
         g3oA==
X-Received: by 10.66.179.143 with SMTP id dg15mr88841695pac.52.1386248439180;
        Thu, 05 Dec 2013 05:00:39 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id qw8sm144608285pbb.27.2013.12.05.05.00.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:00:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:22 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238878>

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
1.8.5.1.25.g8667982
