From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] wildmatch: advance faster in <asterisk> + <literal> patterns
Date: Sat, 22 Dec 2012 14:57:08 +0700
Message-ID: <1356163028-29967-9-git-send-email-pclouds@gmail.com>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 08:58:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmJyV-0000LX-BM
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 08:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab2LVH6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 02:58:08 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:47899 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2LVH6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 02:58:07 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2430694dak.5
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 23:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=rbLwRtAutaitDcPH9urk0njdmbpUEPxQLyWizXXIybA=;
        b=IE2/HXMuJcfiCWSODoo1mztq8f4AUIp2WTH0MVXJj19cAc5EcGhFbo/hpX6Xp8ArB2
         A7H38dtQsUEDVgHeT3gElZInGm3TBfYWNVbyyXjkwvbDQtrcokzZFORkfteVga1JbT+4
         jPgTbZNFpwIa0Ije0/K97gmFwxNrodyzdyt2fSnPS+DZYkzEvamZacybqdVW/IoXvqnZ
         82F6BkcI+bx2IvGuDDpY/ukUvq745tBmOOvoglUGgkBTi/zVv2ywvtiP14xpelYUoaId
         Zee752C29pZo8SHHJFtuLayt6eoMCdC/Cp+AOOd+LQ+RVKS4Q8ZybpalsDeIARuVlpKA
         oBaw==
X-Received: by 10.66.82.73 with SMTP id g9mr44188981pay.5.1356163086402;
        Fri, 21 Dec 2012 23:58:06 -0800 (PST)
Received: from lanh ([115.74.46.73])
        by mx.google.com with ESMTPS id uk9sm8419542pbc.63.2012.12.21.23.58.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 23:58:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Dec 2012 14:58:02 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212035>

compat, '*/*/*' on linux-2.6.git file list 2000 times, before:
wildmatch 7s 985049us
fnmatch   2s 735541us or 34.26% faster

and after:
wildmatch 4s 492549us
fnmatch   0s 888263us or 19.77% slower

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/wildmatch.c b/wildmatch.c
index 3794c4d..68b02e4 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -132,6 +132,27 @@ static int dowild(const uchar *p, const uchar *tex=
t, unsigned int flags)
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
+				/*
+				 * Try to advance faster when an asterisk is
+				 * followed by a literal. We know in this case
+				 * that the the string before the literal
+				 * must belong to "*".
+				 */
+				if (!is_glob_special(*p)) {
+					p_ch =3D *p;
+					if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
+						p_ch =3D tolower(p_ch);
+					while ((t_ch =3D *text) !=3D '\0' &&
+					       (!(flags & WM_PATHNAME) || t_ch !=3D '/')) {
+						if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
+							t_ch =3D tolower(t_ch);
+						if (t_ch =3D=3D p_ch)
+							break;
+						text++;
+					}
+					if (t_ch !=3D p_ch)
+						return WM_NOMATCH;
+				}
 				if ((matched =3D dowild(p, text,  flags)) !=3D WM_NOMATCH) {
 					if (!special || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
--=20
1.8.0.rc2.23.g1fb49df
