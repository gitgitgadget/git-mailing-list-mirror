From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] wildmatch: correct isprint and isspace
Date: Thu, 15 Nov 2012 19:19:43 +0700
Message-ID: <1352981983-22005-1-git-send-email-pclouds@gmail.com>
References: <1352803572-14547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, schnhrr@cs.tu-berlin.de,
	rene.scharfe@lsrfire.ath.cx, Johannes Sixt <j6t@kdbg.org>,
	torvalds@linux-foundation.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 13:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYyQJ-0004GA-8T
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 13:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767604Ab2KOMTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 07:19:44 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:61523 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423250Ab2KOMTn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 07:19:43 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so647487dak.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 04:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hppt1o6n15kafxv2ia7hhHAVEfSXCJVlBX0XUuJUDpQ=;
        b=AnWcM/wbTXuDLS9zNONXfX3E4SYt4rfqDf1SzbxMqKpgviQJ7jkh2kd+PCMU7/2ptj
         4fWIBj3QuJcVf+lRdyRdt8rrb0Ib7ke0zIIlQQlFPj32wvuCUj7oCuR5jwGgQ940E02a
         RdEYwLXsA5IxfQH97DuNRY50nhAWCGQ+MjBF02nBQGmnCwS9uySQSLdey9wh4W9oXcdR
         thWTroEkAGOX1Crsik43dY/4t41X7mD7GMd8nX8rDFbnF3i+yDLpKTAMKsrJ0pOitLUX
         lbYxlPkjulwqpUbDww5ZxwOsdrjAEpRZxaSTJDzIla88ikvE+KxlEMhZ4jq+lPwhj17z
         40og==
Received: by 10.69.0.8 with SMTP id au8mr4269948pbd.58.1352981983218;
        Thu, 15 Nov 2012 04:19:43 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id os5sm9448827pbc.15.2012.11.15.04.19.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 04:19:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 15 Nov 2012 19:19:45 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1352803572-14547-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209818>

Current isprint() incorrectly includes control characters 9, 10 and
13, which is fixed by this patch.

Current isspace() lacks 11 and 12. But Git's isspace() has been
designed this way since the beginning and has over 100 call sites
relying on this. Instead of updating isspace() behavior (which could be
tricky as patches from other topics may come in parallel that assume
the old isspace()), a new isspace_posix() is introduced and used by
wildmatch.c. Other part of Git can be converted to use this new
function if it seems appropriate.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Sorry for the late response. I'll reply to everybody in one mail.

 On Wed, Nov 14, 2012 at 1:58 AM, "Jan H. Sch=C3=B6nherr" <schnhrr@cs.t=
u-berlin.de> wrote:
 > An alternative to switching from 1-byte to 4-byte values (don't we h=
ave
 > a 2-byte datatype?), would be to free up GIT_CNTRL and simply do:
 >
 > #define iscntrl(x) ((x) < 0x20)
=20
 No. 127 is also a control character.

 On Wed, Nov 14, 2012 at 2:41 AM, Johannes Sixt <j6t@kdbg.org> wrote:
 > So we have two properties that overlap:
 >
 >       SSSSSSSSSS
 >    CCCCCCCC
 >
 > You seem to generate partions:
 >
 >    XXXYYYYYZZZZZ
 >
 > then assign individual bits to each partition. Now each entry in the
 > lookup table has only one bit set. Then you define isxxx() to check =
for
 > one of the two possible bits:
 >
 >    iscntrl is X or Y
 >    isspace is Y or Z
 >
 > But shouldn't you just assign one bit for S and another one for C, h=
ave
 > entries in the lookup table with more than one bit set, and check fo=
r
 > only one bit in the isxxx macro?
 >
 > That way you don't run out of bits as easily as you do with this pat=
ch.

 I need three sets of characters actually: control, spaces and
 printable (which contains non-control spaces). Making it
 (isspace(x) && (x) >=3D 32) is simpler and because isprint() is only u=
sed in
 wildmatch, I don't need to think about performance penalty (yet).

 On Thu, Nov 15, 2012 at 2:30 AM, Ren=C3=A9 Scharfe <rene.scharfe@lsrfi=
re.ath.cx> wrote:
 > Nevertheless, it's unfortunate that we have an isspace() that *almos=
t* does
 > what the widely known thing of the same name does.  I'd shy away fro=
m
 > changing git's version directly, because it's used more than a hundr=
ed times
 > in the code, and estimating the impact of adding \v and \f to it.
 > Perhaps renaming it to isgitspace() is a good first step, followed b=
y
 > adding a "standard" version of isspace() for wildmatch?

 There are just too many call sites of isspace() and there is a risk
 of new call sites coming in independently. So I think keeping isspace(=
)
 as-is and using a different name for the standard version is probably
 a better choice.

 As the new isspace_posix() is only used by wildmatch, its performance
 as of now is not critical and a simple macro like in this patch is
 probably enough. We can optimize it later if we need to.

 git-compat-util.h | 4 +++-
 wildmatch.c       | 8 ++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 02f48f6..d4c3fda 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -486,6 +486,7 @@ extern const unsigned char sane_ctype[256];
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask))=
 !=3D 0)
 #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
+#define isspace_posix(x) (((x) >=3D 9 && (x) <=3D 13) || (x) =3D=3D 32=
)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
@@ -499,7 +500,8 @@ extern const unsigned char sane_ctype[256];
 #define isxdigit(x) (hexval_table[x] !=3D -1)
 #define isprint(x) (sane_istest(x, GIT_ALPHA | GIT_DIGIT | GIT_SPACE |=
 \
 		GIT_PUNCT | GIT_REGEX_SPECIAL | GIT_GLOB_SPECIAL | \
-		GIT_PATHSPEC_MAGIC))
+		GIT_PATHSPEC_MAGIC) && \
+		(x) >=3D 32)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 #define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
diff --git a/wildmatch.c b/wildmatch.c
index 3972e26..fd74efd 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -37,11 +37,7 @@ typedef unsigned char uchar;
 # define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D '\t')
 #endif
=20
-#ifdef isgraph
-# define ISGRAPH(c) (ISASCII(c) && isgraph(c))
-#else
-# define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace(c))
-#endif
+#define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace_posix(c))
=20
 #define ISPRINT(c) (ISASCII(c) && isprint(c))
 #define ISDIGIT(c) (ISASCII(c) && isdigit(c))
@@ -50,7 +46,7 @@ typedef unsigned char uchar;
 #define ISCNTRL(c) (ISASCII(c) && iscntrl(c))
 #define ISLOWER(c) (ISASCII(c) && islower(c))
 #define ISPUNCT(c) (ISASCII(c) && ispunct(c))
-#define ISSPACE(c) (ISASCII(c) && isspace(c))
+#define ISSPACE(c) (ISASCII(c) && isspace_posix(c))
 #define ISUPPER(c) (ISASCII(c) && isupper(c))
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
--=20
1.8.0.rc2.23.g1fb49df
