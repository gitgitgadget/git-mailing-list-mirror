From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/46] parse_pathspec: support prefixing original patterns
Date: Sun, 14 Jul 2013 15:35:35 +0700
Message-ID: <1373790969-13000-13-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHoI-0001md-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974Ab3GNIhc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:37:32 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37847 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIha (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:30 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so10307080pad.37
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Tdvd7nyUdS0TM6KbBPBCb8UF+74+8B40wNJVz1MxmPE=;
        b=pHwpHVig/4m+xi41GQHEClkIhlAkmWEjGiPZvmJnA1hBaTFO0QrS3n0+6rPqXKpap+
         8f5CXcxVk1hhc6e4ftcM6rFQsSO3akT/2IXM0lhYCTRKgTAieAb4W/3v8cvb9ERzYmkA
         x57Zx+O1pL/rV9zG/eHQxvoUI4MuFNXVVV07HO1ea88+eUTQI6SKLwnVSnFDlFjW+dIc
         RZNQ0hsv8vq6FSs9gSxRdYOepfqha5UKB07Ec1qFoFdlOcQ+g07SL8MidDbCVccHfEyX
         dqAADk0shv2NM/NApFsgfhgmlJDWqtqaaXTr84baCNo8PISeCUL87KXZY9x0xGqI582n
         o+zQ==
X-Received: by 10.66.219.38 with SMTP id pl6mr51198698pac.59.1373791049885;
        Sun, 14 Jul 2013 01:37:29 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id dg3sm54550550pbc.24.2013.07.14.01.37.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:37:41 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230324>

This makes 'original' suitable for passing to an external command
because all pathspec magic is left in place, provided that the
external command understands pathspec. The prefixing is needed because
we usually launch a subcommand at worktree's top directory and the
subcommand can no longer calculate the prefix itself.

This slightly affects the original purpose of 'original'
(i.e. reporting). We should report without prefixing. So only turn
this flag on when you know you are about to pass the result straight
away to an external command.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 12 +++++++++++-
 pathspec.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index e2a4f91..ba6408a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -203,7 +203,17 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	else
 		match =3D prefix_path(prefix, prefixlen, copyfrom);
 	*raw =3D item->match =3D match;
-	item->original =3D elt;
+	/*
+	 * Prefix the pathspec (keep all magic) and assign to
+	 * original. Useful for passing to another command.
+	 */
+	if (flags & PATHSPEC_PREFIX_ORIGIN) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_add(&sb, elt, copyfrom - elt);
+		strbuf_addstr(&sb, match);
+		item->original =3D strbuf_detach(&sb, NULL);
+	} else
+		item->original =3D elt;
 	item->len =3D strlen(item->match);
=20
 	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
diff --git a/pathspec.h b/pathspec.h
index 450fc03..2e427d7 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -43,6 +43,7 @@ struct pathspec {
  * safer than _SLASH_CHEAP and also more expensive.
  */
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
+#define PATHSPEC_PREFIX_ORIGIN (1<<6)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
--=20
1.8.2.83.gc99314b
