From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/10] wildmatch: make a special case for "*/" with FNM_PATHNAME
Date: Tue,  1 Jan 2013 09:44:09 +0700
Message-ID: <1357008251-10014-9-git-send-email-pclouds@gmail.com>
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
	id 1Tprr4-0000YR-0X
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab3AACpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:45:07 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38585 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab3AACpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:45:05 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so7399715pad.9
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=RsYR08o0qZ5KPyEmXNNzEbOrzvIohbe8KEEQeQ32nqY=;
        b=OMdvJLd1g9EwivtUnfTtSuBFf6VJGGR6S+jP6NwTS4OEH7mA7EsG2gWg+n63SQM1KM
         0L62isANem4Pu8dJMoXgG7PByM7J9oJf4g3AzJC7UeiSGFkC1gf35Vsp5XxyZdcuE2zn
         Fjg9m8aWoWzfG5LFzVIr3nUO43cc52RKj45XTR+NtObEe/Il0qdzbpfBP7A4pxXQJEFO
         Yyym0iDBRVbr3xcAriULD03/hWi8o819+6h1uLxKtmmeK/ssDgrHno/NyIb0URT3QUya
         38hpVklS5O7XriPUtOcSKAldyGx5lb2kO5LEQNq2z/bo3wDjooOUPPyFc2D87FskYLtV
         a00w==
X-Received: by 10.66.78.100 with SMTP id a4mr125704080pax.4.1357008305209;
        Mon, 31 Dec 2012 18:45:05 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id i5sm26657598pax.13.2012.12.31.18.44.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:45:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:45:04 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212391>

Normally we need recursion for "*". In this case we know that it
matches everything until "/" so we can skip the recursion.

glibc, '*/*/*' on linux-2.6.git file list 2000 times
before:
wildmatch 8s 74513us
fnmatch   1s 97042us or 13.59% faster
after:
wildmatch 3s 521862us
fnmatch   3s 488616us or 99.06% slower

Same test with compat/fnmatch:
wildmatch 8s 110763us
fnmatch   2s 980845us or 36.75% faster
wildmatch 3s 522156us
fnmatch   1s 544487us or 43.85% slower

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh |  8 ++++++++
 wildmatch.c          | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 5c9601a..97f1daf 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -203,6 +203,10 @@ match 1 1 'XXX/adobe/courier/bold/o/normal//12/120=
/75/75/m/70/iso8859/1' 'XXX/*/
 match 0 0 'XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/=
1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
 match 1 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n=
*t'
 match 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*=
n*t'
+match 0 x foo '*/*/*'
+match 0 x foo/bar '*/*/*'
+match 1 x foo/bba/arr '*/*/*'
+match 0 x foo/bb/aa/rr '*/*/*'
=20
 pathmatch 1 foo foo
 pathmatch 0 foo fo
@@ -218,5 +222,9 @@ pathmatch 0 foo/bba/arr 'foo/*z'
 pathmatch 0 foo/bba/arr 'foo/**z'
 pathmatch 1 foo/bar 'foo?bar'
 pathmatch 1 foo/bar 'foo[/]bar'
+pathmatch 0 foo '*/*/*'
+pathmatch 0 foo/bar '*/*/*'
+pathmatch 1 foo/bba/arr '*/*/*'
+pathmatch 1 foo/bb/aa/rr '*/*/*'
=20
 test_done
diff --git a/wildmatch.c b/wildmatch.c
index 536470b..bb42522 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -117,6 +117,18 @@ static int dowild(const uchar *p, const uchar *tex=
t, unsigned int flags)
 						return WM_NOMATCH;
 				}
 				return WM_MATCH;
+			} else if (!match_slash && *p =3D=3D '/') {
+				/*
+				 * _one_ asterisk followed by a slash
+				 * with WM_PATHNAME matches the next
+				 * directory
+				 */
+				const char *slash =3D strchr((char*)text, '/');
+				if (!slash)
+					return WM_NOMATCH;
+				text =3D (const uchar*)slash;
+				/* the slash is consumed by the top-level for loop */
+				break;
 			}
 			while (1) {
 				if (t_ch =3D=3D '\0')
--=20
1.8.0.rc2.23.g1fb49df
