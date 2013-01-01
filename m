From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/10] wildmatch: advance faster in <asterisk> + <literal> patterns
Date: Tue,  1 Jan 2013 09:44:10 +0700
Message-ID: <1357008251-10014-10-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TprrA-0000Zi-L5
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864Ab3AACpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:45:14 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:64223 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab3AACpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:45:12 -0500
Received: by mail-pb0-f54.google.com with SMTP id wz12so7229683pbc.13
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=trOoL1z9oKUU2nfknnr8xO32W7+sgsHdNwxPUtNdYs4=;
        b=QzFOLrpnERlf5zqodllUY82FPun2qe3Oj737VKx68j8TlQ1PQqzzLsds599pJCQB0N
         xSKE72dzPrrBoNNRIOy+lkZBDa0ju+Ro+N4kloW0RXtmL+H6FPUUHu2qZg9wK6yLPfaB
         fh46ZvPTy1K+sLirHXx7rkd0n/K/2s8mTOIfJiom4CmN2nMuamGKUTTaJj6QURAdaTkL
         wzgcT3SuUDQFM0OMqTiBLtv72JOKTBdUeeq2+SxqC5GpXNVbWV+3jZe3X+HStoZUbc95
         +cIilFDBZOyo7XTeUmSTISUBsHBTPaefpP9Opk8K6mwprJtFj7LQ81SZ1jR13EI8zBoK
         qN3Q==
X-Received: by 10.66.79.195 with SMTP id l3mr124682242pax.82.1357008311656;
        Mon, 31 Dec 2012 18:45:11 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id qn3sm23656256pbb.56.2012.12.31.18.45.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:45:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:45:15 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212392>

Normally when we match "*X" on "abcX", we call dowild("X", "abcX"),
dowild("X", "bcX"), dowild("X", "cX") and dowild("X", "X"). Only the
last call may have a chance of matching. By skipping the text before
"X", we can eliminate the first three useless calls.

compat, '*/*/*' on linux-2.6.git file list 2000 times, before:
wildmatch 7s 985049us
fnmatch   2s 735541us or 34.26% faster

and after:
wildmatch 4s 492549us
fnmatch   0s 888263us or 19.77% slower

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh |  8 ++++++++
 wildmatch.c          | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 97f1daf..4c37057 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -207,6 +207,11 @@ match 0 x foo '*/*/*'
 match 0 x foo/bar '*/*/*'
 match 1 x foo/bba/arr '*/*/*'
 match 0 x foo/bb/aa/rr '*/*/*'
+match 1 x foo/bb/aa/rr '**/**/**'
+match 1 x abcXdefXghi '*X*i'
+match 0 x ab/cXd/efXg/hi '*X*i'
+match 1 x ab/cXd/efXg/hi '*/*X*/*/*i'
+match 1 x ab/cXd/efXg/hi '**/*X*/**/*i'
=20
 pathmatch 1 foo foo
 pathmatch 0 foo fo
@@ -226,5 +231,8 @@ pathmatch 0 foo '*/*/*'
 pathmatch 0 foo/bar '*/*/*'
 pathmatch 1 foo/bba/arr '*/*/*'
 pathmatch 1 foo/bb/aa/rr '*/*/*'
+pathmatch 1 abcXdefXghi '*X*i'
+pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
+pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
=20
 test_done
diff --git a/wildmatch.c b/wildmatch.c
index bb42522..7192bdc 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -133,6 +133,29 @@ static int dowild(const uchar *p, const uchar *tex=
t, unsigned int flags)
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
+				/*
+				 * Try to advance faster when an asterisk is
+				 * followed by a literal. We know in this case
+				 * that the the string before the literal
+				 * must belong to "*".
+				 * If match_slash is false, do not look past
+				 * the first slash as it cannot belong to '*'.
+				 */
+				if (!is_glob_special(*p)) {
+					p_ch =3D *p;
+					if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
+						p_ch =3D tolower(p_ch);
+					while ((t_ch =3D *text) !=3D '\0' &&
+					       (match_slash || t_ch !=3D '/')) {
+						if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
+							t_ch =3D tolower(t_ch);
+						if (t_ch =3D=3D p_ch)
+							break;
+						text++;
+					}
+					if (t_ch !=3D p_ch)
+						return WM_NOMATCH;
+				}
 				if ((matched =3D dowild(p, text, flags)) !=3D WM_NOMATCH) {
 					if (!match_slash || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
--=20
1.8.0.rc2.23.g1fb49df
