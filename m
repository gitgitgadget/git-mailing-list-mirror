From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] grep: don't call regexec() for fixed strings
Date: Mon, 12 Jan 2009 20:18:24 +0100
Message-ID: <496B9780.3030000@lsrfire.ath.cx>
References: <4967D8F8.9070508@lsrfire.ath.cx> <4967DB4A.2000702@lsrfire.ath.cx> <81b0412b0901120732t1bd1978awdc4be47767e02863@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 20:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMSKL-0000Xk-Ne
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 20:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbZALTSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 14:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbZALTSc
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 14:18:32 -0500
Received: from india601.server4you.de ([85.25.151.105]:51740 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbZALTSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 14:18:31 -0500
Received: from [10.0.1.101] (p57B7DA5E.dip.t-dialin.net [87.183.218.94])
	by india601.server4you.de (Postfix) with ESMTPSA id 82DBB2F8041;
	Mon, 12 Jan 2009 20:18:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <81b0412b0901120732t1bd1978awdc4be47767e02863@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105374>

Alex Riesen schrieb:
> 2009/1/10 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
>> +static int isregexspecial(int c)
>> +{
>> +       return isspecial(c) || c =3D=3D '$' || c =3D=3D '(' || c =3D=
=3D ')' || c =3D=3D '+' ||
>> +                              c =3D=3D '.' || c =3D=3D '^' || c =3D=
=3D '{' || c =3D=3D '|';
>> +}
>> +
>> +static int is_fixed(const char *s)
>> +{
>> +       while (!isregexspecial(*s))
>> +               s++;
>> +       return !*s;
>> +}
>=20
> strchr?

Oh, yes, that would look nicer.

Another option is to extend ctype.c and implement isregexspecial() --
and while we're at it islowerxdigit() (builtin-name-rev.c::ishex()) and
iswordchar() (config.c::iskeychar(), grep.c::word_char()), too -- as
table lookups.  I.e., something like the following (untested).

Which of the mentioned functions are really worth of this promotion?
The isregexspecial() char class has more members than isspecial(), but
it's not performance critical (unless you have a lot of patterns and
only a small amount of data to grep :).

Are there more candidates for ctype-ification?

Ren=C3=A9


 ctype.c           |   14 ++++++++++----
 git-compat-util.h |    6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/ctype.c b/ctype.c
index 9208d67..1a76586 100644
--- a/ctype.c
+++ b/ctype.c
@@ -10,20 +10,26 @@
 #undef AA
 #undef DD
 #undef GS
+#undef RR
+#undef US
+#undef Ah
=20
 #define SS GIT_SPACE
 #define AA GIT_ALPHA
 #define DD GIT_DIGIT
 #define GS GIT_SPECIAL  /* \0, *, ?, [, \\ */
+#define RR GIT_REGEX_SPECIAL /* $, (, ), +, ., ^, {, | */
+#define US GIT_UNDERSCORE
+#define Ah (GIT_ALPHA | GIT_LOWER_XDIGIT)
=20
 unsigned char sane_ctype[256] =3D {
 	GS,  0,  0,  0,  0,  0,  0,  0,  0, SS, SS,  0,  0, SS,  0,  0,		/* 0=
-15 */
 	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 1=
6-15 */
-	SS,  0,  0,  0,  0,  0,  0,  0,  0,  0, GS,  0,  0,  0,  0,  0,		/* 3=
2-15 */
+	SS,  0,  0,  0, RR,  0,  0,  0, RR, RR, GS, RR,  0,  0, RR,  0,		/* 3=
2-15 */
 	DD, DD, DD, DD, DD, DD, DD, DD, DD, DD,  0,  0,  0,  0,  0, GS,		/* 4=
8-15 */
 	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 6=
4-15 */
-	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, GS, GS,  0,  0,  0,		/* 8=
0-15 */
-	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 9=
6-15 */
-	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 1=
12-15 */
+	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, GS, GS,  0, RR, US,		/* 8=
0-15 */
+	 0, Ah, Ah, Ah, Ah, Ah, Ah, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 9=
6-15 */
+	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, RR, RR,  0,  0,  0,		/* 1=
12-15 */
 	/* Nothing in the 128.. range */
 };
diff --git a/git-compat-util.h b/git-compat-util.h
index e20b1e8..5eaa662 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -328,12 +328,18 @@ extern unsigned char sane_ctype[256];
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
 #define GIT_SPECIAL 0x08
+#define GIT_REGEX_SPECIAL 0x10
+#define GIT_UNDERSCORE 0x20
+#define GIT_LOWER_XDIGIT 0x40
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask))=
 !=3D 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
 #define isspecial(x) sane_istest(x,GIT_SPECIAL)
+#define isregexspecial(x) sane_istest(x,GIT_SPECIAL | GIT_REGEX_SPECIA=
L)
+#define iswordchar(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT | GIT_UNDERS=
CORE)
+#define islowerxdigit(x) sane_istest(x,GIT_DIGIT | GIT_LOWER_XDIGIT)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
=20
