From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Wed, 17 Jun 2015 17:16:49 +0700
Message-ID: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 12:16:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5AOb-0006cm-1B
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 12:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbbFQKQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 06:16:33 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36697 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbFQKQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 06:16:30 -0400
Received: by pdjm12 with SMTP id m12so36222549pdj.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=E3F1XBgxPiPvSrm2MyD/YBgzym3F1/gdFuxYMnRZFrI=;
        b=rOUtQTdWhFaaQIbLjH9pmBSkLKxamIIA4T3yaF6BIa8O1bRdvOmyi/2fDV+5RzO0Z8
         liRTUxEAf/AsQBfmue7fTL4qladnnF5OqXHm4sskZnj0MRbxoDlmvpLGWfTSTpzsTsuk
         /Fn1UVnxt0IeEV/3M+Bhuue6uiA3fYiYm8qCPWQLNsQed0ZFxG2c9AcfyubpF6Qth5rL
         rSAZTSynSHazPcZVQp9d+zacoODSfNlp4xVkQQpedM9MpZ+g8IQXx96yQ6NmczO4nxM2
         ktThl5Bu1XsSEtbcqojOrFcFWWeztFGyn7dhGkx3herd/WrAf3aYSsuhMVIDqI6QjAEq
         XNpw==
X-Received: by 10.68.101.65 with SMTP id fe1mr9506816pbb.40.1434536189756;
        Wed, 17 Jun 2015 03:16:29 -0700 (PDT)
Received: from lanh ([115.73.44.207])
        by mx.google.com with ESMTPSA id ki3sm4173135pdb.74.2015.06.17.03.16.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2015 03:16:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Jun 2015 17:16:51 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271826>

It usually goes like this

    strbuf sb =3D STRBUF_INIT;
    if (!strncmp(sb.buf, "foo", 3))
       printf("%s", sb.buf + 3);

Coverity thinks that printf() can be executed, and because initial
sb.buf only has one character (from strbuf_slopbuf), sb.buf + 3 is out
of bound. What it does not recognize is strbuf_slopbuf[0] is always (*)
zero. We always do some string comparison before jumping ahead to
"sb.buf + 3" and those operations will stop out of bound accesses.

Just make strbuf_slopbuf[] large enough to keep Coverity happy. If it's
happy, we'll have cleaner defect list and better chances of spotting
true defects.

(*) It's not entirely wrong though. Somebody may do sb.buf[0] =3D 'f'
    right after variable declaration and ruin all unused strbuf.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 There are lots of false warnings like this from Coverity. I just
 wanted to kill them off so we can spot more serious problems easier.
 I can't really verify that this patch shuts off those warnings
 because scan.coverity.com policy does not allow forks.

 I had another patch that avoids corrupting strbuf_slopbuf, by putting
 it to .rodata section. The patch is more invasive though, because
 this statement buf.buf[buf.len] =3D '\0' now has to make sure buf.buf
 is not strbuf_slopbuf. It feels safer, but probably not enough to
 justify the change.

 strbuf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 0d4f4e5..0d7c3cf 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -16,7 +16,12 @@ int starts_with(const char *str, const char *prefix)
  * buf is non NULL and ->buf is NUL terminated even for a freshly
  * initialized strbuf.
  */
+#ifndef __COVERITY__
 char strbuf_slopbuf[1];
+#else
+/* Stop so many incorrect out-of-boundary warnings from Coverity */
+char strbuf_slopbuf[64];
+#endif
=20
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
--=20
2.3.0.rc1.137.g477eb31
