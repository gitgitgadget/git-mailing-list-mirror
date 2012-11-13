From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH nd/wildmatch] Correct Git's version of isprint and isspace
Date: Tue, 13 Nov 2012 20:41:08 +0100
Message-ID: <50A2A254.9030908@kdbg.org>
References: <507E9FDE.7080706@cs.tu-berlin.de> <1352803572-14547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	schnhrr@cs.tu-berlin.de, rene.scharfe@lsrfire.ath.cx
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYMMR-0002T4-20
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 20:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab2KMTlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 14:41:13 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:16878 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab2KMTlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 14:41:12 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9447B10016;
	Tue, 13 Nov 2012 20:41:09 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1482019F30E;
	Tue, 13 Nov 2012 20:41:09 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <1352803572-14547-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209661>

Am 13.11.2012 11:46, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> @@ -14,11 +14,11 @@ enum {
>  	P =3D GIT_PATHSPEC_MAGIC, /* other non-alnum, except for ] and } */
>  	X =3D GIT_CNTRL,
>  	U =3D GIT_PUNCT,
> -	Z =3D GIT_CNTRL | GIT_SPACE
> +	Z =3D GIT_CNTRL_SPACE
>  };
> =20
> -const unsigned char sane_ctype[256] =3D {
> -	X, X, X, X, X, X, X, X, X, Z, Z, X, X, Z, X, X,		/*   0.. 15 */
> +const unsigned int sane_ctype[256] =3D {
> +	X, X, X, X, X, X, X, X, X, Z, Z, Z, Z, Z, X, X,		/*   0.. 15 */
>  	X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,		/*  16.. 31 */
>  	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
>  	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 02f48f6..4ed3f94 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -474,8 +474,8 @@ extern const char tolower_trans_tbl[256];
>  #undef ispunct
>  #undef isxdigit
>  #undef isprint
> -extern const unsigned char sane_ctype[256];
> -#define GIT_SPACE 0x01
> +extern const unsigned int sane_ctype[256];
> +#define GIT_CNTRL_SPACE 0x01
>  #define GIT_DIGIT 0x02
>  #define GIT_ALPHA 0x04
>  #define GIT_GLOB_SPECIAL 0x08
> @@ -483,9 +483,10 @@ extern const unsigned char sane_ctype[256];
>  #define GIT_PATHSPEC_MAGIC 0x20
>  #define GIT_CNTRL 0x40
>  #define GIT_PUNCT 0x80
> -#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask=
)) !=3D 0)
> +#define GIT_SPACE 0x100
> +#define sane_istest(x,mask) ((sane_ctype[(unsigned int)(x)] & (mask)=
) !=3D 0)
>  #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
> -#define isspace(x) sane_istest(x,GIT_SPACE)
> +#define isspace(x) sane_istest(x,GIT_SPACE | GIT_CNTRL_SPACE)
>  #define isdigit(x) sane_istest(x,GIT_DIGIT)
>  #define isalpha(x) sane_istest(x,GIT_ALPHA)
>  #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
> @@ -493,7 +494,7 @@ extern const unsigned char sane_ctype[256];
>  #define isupper(x) sane_iscase(x, 0)
>  #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
>  #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REG=
EX_SPECIAL)
> -#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
> +#define iscntrl(x) (sane_istest(x,GIT_CNTRL | GIT_CNTRL_SPACE))
>  #define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
>  		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
>  #define isxdigit(x) (hexval_table[x] !=3D -1)

So we have two properties that overlap:

      SSSSSSSSSS
   CCCCCCCC

You seem to generate partions:

   XXXYYYYYZZZZZ

then assign individual bits to each partition. Now each entry in the
lookup table has only one bit set. Then you define isxxx() to check for
one of the two possible bits:

   iscntrl is X or Y
   isspace is Y or Z

But shouldn't you just assign one bit for S and another one for C, have
entries in the lookup table with more than one bit set, and check for
only one bit in the isxxx macro?

That way you don't run out of bits as easily as you do with this patch.

-- Hannes
