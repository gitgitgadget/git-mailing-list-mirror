From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and
 isprint
Date: Sun, 14 Oct 2012 21:26:24 +0700
Message-ID: <20121014142624.GA992@do>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-3-git-send-email-pclouds@gmail.com>
 <507AB73D.8010406@lsrfire.ath.cx>
 <CACsJy8B+6OPkP6ijMDzm+n0eHnDZ4Pj8UO_KasdfEP4wF+_hww@mail.gmail.com>
 <507AC543.2020402@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Oct 14 16:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNP9c-0001FC-Ee
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 16:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab2JNO0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 10:26:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59629 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab2JNO0k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 10:26:40 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4106212pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1NdrYFtJG+HT/Ct+7J776h+C8wjyYXzIV5a/LvLzqyM=;
        b=UFX55jjRJs2p3yHPwmrWz7lq6fUPuO/L/oDjOi1y1xpgzNiPz3v25boMYJxV4fftBr
         1buQNU5jQ0/QWvtq/82+J76pnHxUI+M2DiQFGQkUSOdsnfRtKO3QNUbdxeWrZlPAAW4/
         TH/bIQbpUEm0kamr7viZTZo5Ess7wEAS8TuWofM3r+t0LWvOhx8HOk3Z4sTXhIxzOuSr
         7+qI/dsZ+QGYec1Epg4+7aTePOmE+hdP9vuQNAyh4EhXNy32yiqJlwtfbvyPQ4moMvnI
         iCaSPbo/SfbSgDeWLVCChnt+l9cdIsBe0IjE+e3GeI8tPuj+AUKaWX8YmtTxvXrLEfjx
         P1sQ==
Received: by 10.68.136.229 with SMTP id qd5mr29318006pbb.154.1350224800286;
        Sun, 14 Oct 2012 07:26:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id ka4sm7532712pbc.61.2012.10.14.07.26.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 07:26:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 21:26:24 +0700
Content-Disposition: inline
In-Reply-To: <507AC543.2020402@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207666>

On Sun, Oct 14, 2012 at 03:59:31PM +0200, Ren=E9 Scharfe wrote:
> Am 14.10.2012 15:25, schrieb Nguyen Thai Ngoc Duy:
> > On Sun, Oct 14, 2012 at 7:59 PM, Ren=E9 Scharfe
> > <rene.scharfe@lsrfire.ath.cx> wrote:
> >> With that, couldn't you squeeze the other two classes into the exi=
sting
> >> sane_type?
> >
> > No there are still conflicts: 9, 10 and 13 as spaces (vs controls) =
and
> > 123, 124 and 126 as regex/pathspec special (vs punctuation).
>=20
> That's not a problem, an entry in the table can have more than one bi=
t=20
> set -- just OR them together in ctype.c.  It may not look as nice, bu=
t=20
> that's OK.  You could also define a character for GIT_SPACE | GIT_CNT=
RL=20
> etc. for cosmetic reasons.

Only space chars is not a subset of control chars, which needs a new
combination. So the result does not look as bad as I thought:

-- 8< --
diff --git a/ctype.c b/ctype.c
index faeaf34..0bfebb4 100644
--- a/ctype.c
+++ b/ctype.c
@@ -11,18 +11,21 @@ enum {
 	D =3D GIT_DIGIT,
 	G =3D GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
 	R =3D GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | */
-	P =3D GIT_PATHSPEC_MAGIC  /* other non-alnum, except for ] and } */
+	P =3D GIT_PATHSPEC_MAGIC, /* other non-alnum, except for ] and } */
+	X =3D GIT_CNTRL,
+	U =3D GIT_PUNCT,
+	Z =3D GIT_CNTRL | GIT_SPACE
 };
=20
 const unsigned char sane_ctype[256] =3D {
-	0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
+	X, X, X, X, X, X, X, X, X, Z, Z, X, X, Z, X, X,		/*   0.. 15 */
+	X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,		/*  16.. 31 */
 	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
 	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
 	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
-	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, R, P,		/*  80.. 95 */
+	A, A, A, A, A, A, A, A, A, A, A, G, G, U, R, P,		/*  80.. 95 */
 	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
-	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, P, 0,		/* 112..127 */
+	A, A, A, A, A, A, A, A, A, A, A, R, R, U, P, X,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index f8b859c..db77f3e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -510,6 +510,10 @@ extern const char tolower_trans_tbl[256];
 #undef isupper
 #undef tolower
 #undef toupper
+#undef iscntrl
+#undef ispunct
+#undef isxdigit
+#undef isprint
 extern const unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
@@ -517,6 +521,8 @@ extern const unsigned char sane_ctype[256];
 #define GIT_GLOB_SPECIAL 0x08
 #define GIT_REGEX_SPECIAL 0x10
 #define GIT_PATHSPEC_MAGIC 0x20
+#define GIT_CNTRL 0x40
+#define GIT_PUNCT 0x80
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask))=
 !=3D 0)
 #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
@@ -527,6 +533,13 @@ extern const unsigned char sane_ctype[256];
 #define isupper(x) sane_iscase(x, 0)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
 #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX=
_SPECIAL)
+#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
+#define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
+		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
+#define isxdigit(x) (hexval_table[x] !=3D -1)
+#define isprint(x) (sane_istest(x, GIT_ALPHA | GIT_DIGIT | GIT_SPACE |=
 \
+		GIT_PUNCT | GIT_REGEX_SPECIAL | GIT_GLOB_SPECIAL | \
+		GIT_PATHSPEC_MAGIC))
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 #define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
-- 8< --

--=20
Duy
