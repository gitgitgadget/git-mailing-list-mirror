From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/27] upload-pack: move rev-list code out of check_non_tip()
Date: Fri, 10 Jun 2016 19:26:57 +0700
Message-ID: <20160610122714.3341-11-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:30:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLYL-0000um-Vp
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbcFJM2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:42 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34150 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbcFJM2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id 66so3245049pfy.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eejmqCLK1M1/lW5srIb4LU5HCo3/WBVy3SJskBfRGWY=;
        b=rF/7RNfy3mrvyxb/hC5vyPsrYxRvE3MDVd08BSbJmyhjR4Jm4IFZze48VNLuxV7tIZ
         K5btUzUu2/gJjl4hG/9MBllQlzaE3zHnamTgYcO5cNV2rqTp4Bqba+V6wNnwESn0Bj8h
         sUXruICuZ4pT8yGgyF872CHJE22BZVipzU1N5hPM1CrwT7sBuBJ/yjpWr7w7opIG+9Kg
         qt5qo5Lw7Wm/bdgPhuhCtSmxQaVR/JViMVrBczylHLQr474nmzSL7EGmtuUBWldqhXSi
         OyFh4txoAOvzx1oMFrFJ4AAwbiwio388zs9e4YB/q9FU+knTbOB3Ex9Mq2ctieg2CBh7
         LIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eejmqCLK1M1/lW5srIb4LU5HCo3/WBVy3SJskBfRGWY=;
        b=BUEPheZxJ2kWBhrUUlgs5t/8SaahRxM/XJNLsVDK74dJf/90MsIOlLUP5lbDcEqIhh
         MLp3NaTL3NqPMfbnV1qL80VvbBvSN3TcrRWbUw/jPwkSF8L9p6nvP1MnuV/ypvlAcSVj
         oOgRk+bkyz3lpIhHeExnuTJqwzrTzwNowQg3mFBZl8jZsfI3ksbsmqYf+XnxbOtxT5PT
         JRRf2JDuTIDZTHp5kVvaly86jLZTr/G4UL+/muOrtwGgrSVCVcHtUmbHW7qn5dsxBezz
         S7ZRvIoC5EX+ZW8rffK2eYXIj4RhEXkHQUCE/5qwaQ86yWWZRA2l2NAfs9/RP3eiLOPt
         6KqQ==
X-Gm-Message-State: ALyK8tJ8mFOvAoPpv2sK3db96kEESKVfi9rcYxa/SEEkKBhkvN2N3RoOBR9Yx1EidHxQAg==
X-Received: by 10.98.157.135 with SMTP id a7mr2087434pfk.117.1465561719191;
        Fri, 10 Jun 2016 05:28:39 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id xt1sm17562893pac.7.2016.06.10.05.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:38 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:34 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296986>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 1e8b025..b6f3756 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -451,7 +451,7 @@ static int is_our_ref(struct object *o)
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
=20
-static void check_non_tip(void)
+static int check_unreachable(struct object_array *src)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
@@ -461,14 +461,6 @@ static void check_non_tip(void)
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
=20
-	/*
-	 * In the normal in-process case without
-	 * uploadpack.allowReachableSHA1InWant,
-	 * non-tip requests can never happen.
-	 */
-	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REA=
CHABLE_SHA1))
-		goto error;
-
 	cmd.argv =3D argv;
 	cmd.git_cmd =3D 1;
 	cmd.no_stderr =3D 1;
@@ -500,8 +492,8 @@ static void check_non_tip(void)
 		}
 	}
 	namebuf[40] =3D '\n';
-	for (i =3D 0; i < want_obj.nr; i++) {
-		o =3D want_obj.objects[i].item;
+	for (i =3D 0; i < src->nr; i++) {
+		o =3D src->objects[i].item;
 		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
@@ -534,17 +526,35 @@ static void check_non_tip(void)
 		goto error;
=20
 	/* All the non-tip ones are ancestors of what we advertised */
-	return;
+	return 1;
=20
 error:
 	if (cmd.in >=3D 0)
 		close(cmd.in);
 	if (cmd.out >=3D 0)
 		close(cmd.out);
+	return 0;
+}
=20
+static void check_non_tip(void)
+{
+	int i;
+
+	/*
+	 * In the normal in-process case without
+	 * uploadpack.allowReachableSHA1InWant,
+	 * non-tip requests can never happen.
+	 */
+	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REA=
CHABLE_SHA1))
+		goto error;
+	if (check_unreachable(&want_obj))
+		/* All the non-tip ones are ancestors of what we advertised */
+		return;
+
+error:
 	/* Pick one of them (we know there at least is one) */
 	for (i =3D 0; i < want_obj.nr; i++) {
-		o =3D want_obj.objects[i].item;
+		struct object *o =3D want_obj.objects[i].item;
 		if (!is_our_ref(o))
 			die("git upload-pack: not our ref %s",
 			    oid_to_hex(&o->oid));
--=20
2.8.2.524.g6ff3d78
