From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] xemit.c: fix a [-Wchar-subscripts] compiler warning
Date: Thu, 26 May 2016 00:06:27 +0100
Message-ID: <57462FF3.4010705@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu May 26 01:14:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5i0E-0007yR-Rf
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 01:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbcEYXOK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 19:14:10 -0400
Received: from avasout01.plus.net ([84.93.230.227]:39565 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbcEYXOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 19:14:09 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id yn6T1s0045VX2mk01n6Ut8; Thu, 26 May 2016 00:06:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=OxXAzCjDktHfwcK1LcoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295616>


While compiling on cygwin (x86_64), gcc complains thus:

      CC xdiff/xemit.o
  xdiff/xemit.c: In function =E2=80=98is_empty_rec=E2=80=99:
  xdiff/xemit.c:163:2: warning: array subscript has type =E2=80=98char=E2=
=80=99 [-Wchar-subscripts]
    while (len > 0 && isspace(*rec)) {
    ^

A comment in the <ctype.h> header reads, in part, like so:

   These macros are intentionally written in a manner that will trigger
   a gcc -Wall warning if the user mistakenly passes a 'char' instead
   of an int containing an 'unsigned char'.

In order to suppress the warning, cast the 'char *' pointer 'rec' to an
'unsigned char *' pointer, prior to passing the dereferenced pointer to
the isspace() macro.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Ren=C3=A9,

If you need to re-roll your 'rs/xdiff-hunk-with-func-line' branch, coul=
d
you please squash this (or something like it) into the relevant patch.

[A comment in the linux <ctype.h> header, says that the ctype-info tabl=
es ...
   point into arrays of 384, so they can be indexed by any `unsigned
   char' value [0,255]; by EOF (-1); or by any `signed char' value
   [-128,-1).
So, this is not a problem on linux.]

Thanks!

ATB,
Ramsay Jones

 xdiff/xemit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d0c0738..ae9adac 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -160,7 +160,7 @@ static int is_empty_rec(xdfile_t *xdf, xdemitconf_t=
 const *xecfg, long ri)
 	const char *rec;
 	long len =3D xdl_get_rec(xdf, ri, &rec);
=20
-	while (len > 0 && isspace(*rec)) {
+	while (len > 0 && isspace(*((unsigned char *)rec))) {
 		rec++;
 		len--;
 	}
--=20
2.8.0
