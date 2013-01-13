From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 07/10] parse_pathspec: accept :(icase)path syntax
Date: Sun, 13 Jan 2013 19:49:36 +0700
Message-ID: <1358081379-17752-8-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:50:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN1O-0001Jf-8x
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab3AMMuT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:50:19 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57123 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab3AMMuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:50:18 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so1778679pad.7
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Dt29oMA0pcHNs19VA9O9fdC0ctg16yiDVLSCCteGesk=;
        b=ZDjmZh7w5rudoJXO+VQjF4bguVFY1xOK5QsG+oOsE6p6NSRFzQvPLFaHSP6TtmXr2A
         JDXe4FY3zxu/YjYVC7xNhLhoNhqshYqfUxzkoL5wS+5eLDkWJ86xQsirnHq+UoNDcTl8
         GZuPniHXqzOx/ryJwVkGIctXTb+4xIG9LbfEqVPyMm6/d4hA1uCbmlDd8jUVTxvSJuxU
         89f3i9U1X+OLuJbADnYbnahbDojA77LmSiKyW+k5PEVokj+u6RuZnDs6mZss8PRTayI5
         T0cSqqGAVVhR5xcduzx0GgIt1xes4/bvbRnhQBprRViagPIMFRV6pYGM55pttXI4NZr+
         PuLw==
X-Received: by 10.68.223.135 with SMTP id qu7mr167962732pbc.134.1358081417925;
        Sun, 13 Jan 2013 04:50:17 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id p9sm3176720pao.29.2013.01.13.04.50.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:50:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:50:32 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213379>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h | 1 +
 setup.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 9c27f18..c3b5585 100644
--- a/cache.h
+++ b/cache.h
@@ -480,6 +480,7 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
 #define PATHSPEC_FROMTOP    (1<<0)
 #define PATHSPEC_LITERAL    (1<<1)
 #define PATHSPEC_GLOB       (1<<2)
+#define PATHSPEC_ICASE      (1<<3)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
diff --git a/setup.c b/setup.c
index b3e146d..e22abf1 100644
--- a/setup.c
+++ b/setup.c
@@ -157,7 +157,6 @@ void verify_non_filename(const char *prefix, const =
char *arg)
  *
  * Possible future magic semantics include stuff like:
  *
- *	{ PATHSPEC_ICASE, '\0', "icase" },
  *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
  *	{ PATHSPEC_REGEXP, '\0', "regexp" },
  *
@@ -171,6 +170,7 @@ static struct pathspec_magic {
 	{ PATHSPEC_FROMTOP, '/', "top" },
 	{ PATHSPEC_LITERAL,   0, "literal" },
 	{ PATHSPEC_GLOB,   '\0', "glob" },
+	{ PATHSPEC_ICASE,  '\0', "icase" },
 };
=20
 /*
--=20
1.8.0.rc2.23.g1fb49df
