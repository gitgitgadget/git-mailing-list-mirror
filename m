From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] upload-pack: example code to use get_shallow_commits_by_rev_list
Date: Thu,  5 Mar 2015 17:28:15 +0700
Message-ID: <1425551295-28653-7-git-send-email-pclouds@gmail.com>
References: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
 <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:29:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTT1w-0003ox-WF
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 11:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbbCEK3R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 05:29:17 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:41443 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbbCEK3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 05:29:13 -0500
Received: by pdno5 with SMTP id o5so65317796pdn.8
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 02:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PiqBhUmvCJs8pGMhtM+Ou+r0B9F+CpeejOtcAZF4CB8=;
        b=WHmlLKBjKtwFIfFzxZtxlW2+VBbHCKePs8NavwC+a5CX0Vy6LKhOm0rx36Lz/Jv9h8
         ZeGCHDsG2+TxRVrCnDvec4DHnY82MCnuQz8HqZ4vsyk4A04MK1+lzV1r4yG0kbnTWvJ8
         gRLZ3KtIH0NOK1ku98t9HPJGZPDSBkvgDxJP8Sy9thB21jWvclAs/dzHj2kh/SNxwPi5
         +iBGx1bnP7Urdf7PnR3LdryRBS1GYm5KZa0Fs6lYSJP2iYJMo7pT6p6bssE23ZPLXvX4
         RTg1JaD/Ci2en9QhS0dE//UCsPCC6uMYtn9KnR+PKyAdzmFMam+zKaMi//uhLLWh7XOJ
         CTWw==
X-Received: by 10.68.125.197 with SMTP id ms5mr15044305pbb.12.1425551352718;
        Thu, 05 Mar 2015 02:29:12 -0800 (PST)
Received: from lanh ([115.73.230.115])
        by mx.google.com with ESMTPSA id gf9sm6445762pbd.95.2015.03.05.02.29.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 02:29:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Mar 2015 17:29:44 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264826>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 69a3828..e616e19 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -592,6 +592,18 @@ static void deepen(int depth, const struct object_=
array *shallows)
 	packet_flush(1);
 }
=20
+static void deepen_by_rev_list(int ac, const char **av,
+			       struct object_array *shallows)
+{
+	struct commit_list *result;
+
+	result =3D get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALL=
OW);
+	send_shallow(result);
+	free_commit_list(result);
+	send_unshallow(shallows);
+	packet_flush(1);
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
@@ -686,6 +698,12 @@ static void receive_needs(void)
 		return;
 	if (depth > 0)
 		deepen(depth, &shallows);
+#if 0
+	else if (since_is_specified) {
+		/* prepare ac, av */
+		deepen_by_rev_list(ac, av, &shallows);
+	}
+#endif
 	else
 		if (shallows.nr > 0) {
 			int i;
--=20
2.3.0.rc1.137.g477eb31
