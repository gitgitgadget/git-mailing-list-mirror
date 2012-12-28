From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 7/9] wildmatch: make a special case for "*/" with FNM_PATHNAME
Date: Fri, 28 Dec 2012 11:10:52 +0700
Message-ID: <1356667854-8686-8-git-send-email-pclouds@gmail.com>
References: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 05:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToRIv-00015V-4X
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 05:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2L1EL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Dec 2012 23:11:58 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43093 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab2L1EL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 23:11:57 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so5794849pad.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 20:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=9c6gryEh+gLA6ou4/ZDvqY4X9jGfjsfzo6pIjDT0U0k=;
        b=lg43UQ2tQ9So7/kIFLLSEbNox6fPomN9+9BPFnokYrcr8I/fKGWFxrhHWtk1E6JvL2
         InelCYQE7N4G3AwMyNwAfHBx048tv/dVfMv45J6m5ODKITACtVNYFwe7GC70JMmMYYi6
         734R92lbceRGxyyfJVLVbTtZ1+mgKN3O1r/BQ62Krqlm62EZlFl7f4RktOMUnZONCmAH
         5aa5CZi/Hsa3WX+ZILx4jdbKI6dhn+YrBje5hhV3OP29RSObWBDVaE0Qv4vEhldtpfvz
         FMqz2nNdqlLibKPM/1kNyuAx1g6IWpIOOkjAPbwy0d3s566ZIDyUUgUPWpsCLCPLWZ07
         yLLg==
X-Received: by 10.68.223.230 with SMTP id qx6mr102285502pbc.159.1356667916413;
        Thu, 27 Dec 2012 20:11:56 -0800 (PST)
Received: from lanh ([115.74.54.149])
        by mx.google.com with ESMTPS id rk6sm18928795pbc.20.2012.12.27.20.11.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 20:11:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 28 Dec 2012 11:11:56 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212230>

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
index dbfa903..4cdb13b 100755
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
index 0c8edb8..f6d45d5 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -116,6 +116,18 @@ static int dowild(const uchar *p, const uchar *tex=
t, unsigned int flags)
 						return WM_NOMATCH;
 				}
 				return WM_MATCH;
+			} else if (*p =3D=3D '/' && (flags & WM_PATHNAME) && !match_slash) =
{
+				/*
+				 * an asterisk followed by a slash
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
