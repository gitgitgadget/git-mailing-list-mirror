From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/13] compat/fnmatch: fix off-by-one character class's length check
Date: Sun, 11 Nov 2012 17:13:57 +0700
Message-ID: <1352628837-5784-2-git-send-email-pclouds@gmail.com>
References: <5096D76F.5090907@kdbg.org>
 <1352628837-5784-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 11:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXUaV-0005Xw-9x
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 11:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab2KKKON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 05:14:13 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43909 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2KKKOM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 05:14:12 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so3675243pad.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 02:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AbTMLDzpNlmQYih/8/BY1XdxP6TK8wfQvGLMT+A9PjA=;
        b=C5SvsnR+j4i6aQ5wv6eF7gr9/BNyukh72gGZrIkRdheoSXLJ/kFYUwLfhTvFbOSnvC
         t4k3kh5ArmAj839KYWeBXbPGEK3PbMCbkykgta0puuxU1sdrdSt6dpClAI2/bCv957pP
         HrCV39ibT5qmrVNbbdbz+KePXR9cxW4M4T7CAwiT9XLmxlL9CtqA/MPtsC6+O8HzFflg
         /VuPFWFLLHuX1m7nyK3tUkM/9aLD/Lw84Jv2Vjn1yzyS0o0ZAi7reLR/FqFgoKhYQe65
         KqIqSdsElbhDIv863WD+8Qn7hPsPuolLrQmYs6feYVeVcfRHC+cofLJ1JQ/WHc7Uxq21
         EJFQ==
Received: by 10.68.227.230 with SMTP id sd6mr14789997pbc.41.1352628851654;
        Sun, 11 Nov 2012 02:14:11 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id ot5sm2327030pbb.29.2012.11.11.02.14.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 02:14:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 11 Nov 2012 17:14:10 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1352628837-5784-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209330>

Character class "xdigit" is the only one that hits 6 character limit
defined by CHAR_CLASS_MAX_LENGTH. All other character classes are 5
character long and therefore never caught by this.

This should make xdigit tests in t3070 pass on Windows.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I tested with Linux (removing the ifdef __LIBC in fnmatch.c) but I
 think this should get an ACK from someone who actually uses it on
 Windows.

 We may want to tell upstream (who?) about this if they haven't fixed
 it already.

 compat/fnmatch/fnmatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 9473aed..0ff1d27 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -345,7 +345,7 @@ internal_fnmatch (pattern, string, no_leading_perio=
d, flags)
=20
 		    for (;;)
 		      {
-			if (c1 =3D=3D CHAR_CLASS_MAX_LENGTH)
+			if (c1 > CHAR_CLASS_MAX_LENGTH)
 			  /* The name is too long and therefore the pattern
 			     is ill-formed.  */
 			  return FNM_NOMATCH;
--=20
1.8.0.rc2.23.g1fb49df
