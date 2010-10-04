From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] xdiff: cast arguments for ctype functions to unsigned char
Date: Mon, 4 Oct 2010 04:09:17 -0500
Message-ID: <20101004090917.GA14566@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Steven Drake <sdrake@xnet.co.nz>,
	der Mouse <mouse@Rodents-Montreal.ORG>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 11:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2h6g-0005Da-Nx
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab0JDJMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 05:12:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55707 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab0JDJMg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 05:12:36 -0400
Received: by iwn5 with SMTP id 5so6671573iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Z2y2aSgq6Z4/8HYM67ykK4gA7hGGdCFKalnBO8nQ3q8=;
        b=hTZh3DpgxglUmwIEgeQTsGCoHwASKBcWFoBgWCPjBmZxMO+xOTW0xdwkNThmgWb62r
         6/qVN2tiU33wC0Av/wSJr+EhBDzyADkMstA3MCHq5DKPbzLRlmNAKYImvpNY1cZSA7lX
         J8Eg0hLGZZ966bperwtmauXZnTSJUJhvx7vrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=dORXwU7YVOipNcaKydZJewX22B0MRBN6gktT0qfRVoX7yfj4Tk9KeofGx0F/UEFjlr
         o8HVMhEsUaFd7VIwAv6kt6ThgZzyJpYlRWwlev1bWp9J0l4iG5oHsKOgt2TBoBJdjAsQ
         BpmvUECqTsqgcoOoNO4IVu8WUkqf71EeAJiGs=
Received: by 10.231.79.77 with SMTP id o13mr9879256ibk.36.1286183555674;
        Mon, 04 Oct 2010 02:12:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id h8sm4744115ibk.9.2010.10.04.02.12.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 02:12:34 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158013>

The ctype functions isspace(), isalnum(), et al take an integer
argument representing an unsigned character, or -1 for EOF.  On
platforms with a signed char, it is unsafe to pass a char to them
without casting it to unsigned char first.

Most of git is already shielded against this by the ctype
implementation in git-compat-util.h, but xdiff, which uses libc
ctype.h, ought to be fixed.

Noticed-by: der Mouse <mouse@Rodents-Montreal.ORG>
Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 xdiff/xmacros.h |    1 +
 xdiff/xmerge.c  |    2 +-
 xdiff/xutils.c  |   18 +++++++++---------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 8ef232c..165a895 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -30,6 +30,7 @@
 #define XDL_MAX(a, b) ((a) > (b) ? (a): (b))
 #define XDL_ABS(v) ((v) >=3D 0 ? (v): -(v))
 #define XDL_ISDIGIT(c) ((c) >=3D '0' && (c) <=3D '9')
+#define XDL_ISSPACE(c) (isspace((unsigned char)(c)))
 #define XDL_ADDBITS(v,b)	((v) + ((v) >> (b)))
 #define XDL_MASKBITS(b)		((1UL << (b)) - 1)
 #define XDL_HASHLONG(v,b)	(XDL_ADDBITS((unsigned long)(v), b) & XDL_MA=
SKBITS(b))
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 6d6fc1b..9e13b25 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -336,7 +336,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfe=
nv_t *xe2, xdmerge_t *m,
 static int line_contains_alnum(const char *ptr, long size)
 {
 	while (size--)
-		if (isalnum(*(ptr++)))
+		if (isalnum((unsigned char)*(ptr++)))
 			return 1;
 	return 0;
 }
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 22f9bd6..ab65034 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -211,18 +211,18 @@ int xdl_recmatch(const char *l1, long s1, const c=
har *l2, long s2, long flags)
 			if (l1[i1++] !=3D l2[i2++])
 				return 0;
 		skip_ws:
-			while (i1 < s1 && isspace(l1[i1]))
+			while (i1 < s1 && XDL_ISSPACE(l1[i1]))
 				i1++;
-			while (i2 < s2 && isspace(l2[i2]))
+			while (i2 < s2 && XDL_ISSPACE(l2[i2]))
 				i2++;
 		}
 	} else if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
 		while (i1 < s1 && i2 < s2) {
-			if (isspace(l1[i1]) && isspace(l2[i2])) {
+			if (XDL_ISSPACE(l1[i1]) && XDL_ISSPACE(l2[i2])) {
 				/* Skip matching spaces and try again */
-				while (i1 < s1 && isspace(l1[i1]))
+				while (i1 < s1 && XDL_ISSPACE(l1[i1]))
 					i1++;
-				while (i2 < s2 && isspace(l2[i2]))
+				while (i2 < s2 && XDL_ISSPACE(l2[i2]))
 					i2++;
 				continue;
 			}
@@ -241,13 +241,13 @@ int xdl_recmatch(const char *l1, long s1, const c=
har *l2, long s2, long flags)
 	 * while there still are characters remaining on both lines.
 	 */
 	if (i1 < s1) {
-		while (i1 < s1 && isspace(l1[i1]))
+		while (i1 < s1 && XDL_ISSPACE(l1[i1]))
 			i1++;
 		if (s1 !=3D i1)
 			return 0;
 	}
 	if (i2 < s2) {
-		while (i2 < s2 && isspace(l2[i2]))
+		while (i2 < s2 && XDL_ISSPACE(l2[i2]))
 			i2++;
 		return (s2 =3D=3D i2);
 	}
@@ -260,10 +260,10 @@ static unsigned long xdl_hash_record_with_whitesp=
ace(char const **data,
 	char const *ptr =3D *data;
=20
 	for (; ptr < top && *ptr !=3D '\n'; ptr++) {
-		if (isspace(*ptr)) {
+		if (XDL_ISSPACE(*ptr)) {
 			const char *ptr2 =3D ptr;
 			int at_eol;
-			while (ptr + 1 < top && isspace(ptr[1])
+			while (ptr + 1 < top && XDL_ISSPACE(ptr[1])
 					&& ptr[1] !=3D '\n')
 				ptr++;
 			at_eol =3D (top <=3D ptr + 1 || ptr[1] =3D=3D '\n');
--=20
1.7.2.3
