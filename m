From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 20/21] refs.c: refactor do_head_ref(... to do_one_head_ref("HEAD", ...
Date: Sat, 14 Dec 2013 17:55:06 +0700
Message-ID: <1387018507-21999-21-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:53:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrmqW-0001Qh-OC
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab3LNKxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:53:16 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:43034 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab3LNKxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:53:14 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so3625249pbc.13
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=adYd/feZLk4I7joFyUE2X00D/peqU/p/uPlDcmLMrqU=;
        b=Xqgu4o2HbZfnk+RvtJN7LW7xf/QHLGFvbEz+35z8uUMs7UTQFXdhp4ByDWTv8Sq6ea
         H7J+1wYqAznGWLk5S/A2Djn0s7fS0l7NDDKwzjj/QosE2f27Xs0PMzqPwwyGeRWZEdTJ
         dVZW1ufaW021gfv29DX8zKpFdVEcq4ey7lx9JRquGXufS1l+MYghBk+s+Ho+IFW7Oax9
         cBxNy/fGDWPRp7ir7kFD9ZIHwaFIDVEhyBX5U0kT8n2DI41/GiYG0cVKvw9FKXVt/V1c
         h1ZGqk1Pq7QJ29Ximc47Tvfvs5ILC9tHRDoCbgh7TSQ96/V6QMWec1sVhLCpNHdEMKHF
         8HKA==
X-Received: by 10.68.162.131 with SMTP id ya3mr8786382pbb.102.1387018394326;
        Sat, 14 Dec 2013 02:53:14 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id g6sm15367953pat.2.2013.12.14.02.53.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:53:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:58:07 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239302>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index d856b1a..8ef1cb0 100644
--- a/refs.c
+++ b/refs.c
@@ -1721,32 +1721,33 @@ static int do_for_each_ref(struct ref_cache *re=
fs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
=20
-static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb=
_data)
+static int do_one_head_ref(const char *ref, const char *submodule,
+		      each_ref_fn fn, void *cb_data)
 {
 	unsigned char sha1[20];
 	int flag;
=20
 	if (submodule) {
-		if (resolve_gitlink_ref(submodule, "HEAD", sha1) =3D=3D 0)
-			return fn("HEAD", sha1, 0, cb_data);
+		if (resolve_gitlink_ref(submodule, ref, sha1) =3D=3D 0)
+			return fn(ref, sha1, 0, cb_data);
=20
 		return 0;
 	}
=20
-	if (!read_ref_full("HEAD", sha1, 1, &flag))
-		return fn("HEAD", sha1, flag, cb_data);
+	if (!read_ref_full(ref, sha1, 1, &flag))
+		return fn(ref, sha1, flag, cb_data);
=20
 	return 0;
 }
=20
 int head_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_head_ref(NULL, fn, cb_data);
+	return do_one_head_ref("HEAD", NULL, fn, cb_data);
 }
=20
 int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb=
_data)
 {
-	return do_head_ref(submodule, fn, cb_data);
+	return do_one_head_ref("HEAD", submodule, fn, cb_data);
 }
=20
 int for_each_ref(each_ref_fn fn, void *cb_data)
--=20
1.8.5.1.77.g42c48fa
