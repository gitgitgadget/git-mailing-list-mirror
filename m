From: =?ISO-8859-1?Q?=22Jan_H=2E_Sch=F6nherr=22?= 
	<schnhrr@cs.tu-berlin.de>
Subject: Re: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and
 isprint
Date: Wed, 17 Oct 2012 14:09:02 +0200
Message-ID: <507E9FDE.7080706@cs.tu-berlin.de>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com> <1350182110-25936-3-git-send-email-pclouds@gmail.com> <507AB73D.8010406@lsrfire.ath.cx> <CACsJy8B+6OPkP6ijMDzm+n0eHnDZ4Pj8UO_KasdfEP4wF+_hww@mail.gmail.com> <507AC543.2020402@lsrfire.ath.cx> <20121014142624.GA992@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 14:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOSRJ-0004Gw-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 14:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab2JQMJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 08:09:22 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:60530 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953Ab2JQMJV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 08:09:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 49B7E67E6
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 14:09:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id nSJ6bKD1hrjl 15485-14;
	Wed, 17 Oct 2012 14:09:01 +0200 (CEST) 13711
Received: from [130.149.91.59] (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Wed, 17 Oct 2012 14:09:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120919 Thunderbird/10.0.7
In-Reply-To: <20121014142624.GA992@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207911>

Hi Nguyen.

I just had a need for isprint() myself, and then I found
your code here.

I had a look at the POSIX locale as describe here:

http://sourceware.org/git/?p=glibc.git;a=blob;f=localedata/locales/POSIX

Some remarks below.

Am 14.10.2012 16:26, schrieb Nguyen Thai Ngoc Duy:
> -- 8< --
> diff --git a/ctype.c b/ctype.c
> index faeaf34..0bfebb4 100644
> --- a/ctype.c
> +++ b/ctype.c
> @@ -11,18 +11,21 @@ enum {
>  	D = GIT_DIGIT,
>  	G = GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
>  	R = GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | */
> -	P = GIT_PATHSPEC_MAGIC  /* other non-alnum, except for ] and } */
> +	P = GIT_PATHSPEC_MAGIC, /* other non-alnum, except for ] and } */
> +	X = GIT_CNTRL,
> +	U = GIT_PUNCT,
> +	Z = GIT_CNTRL | GIT_SPACE
>  };
>  
>  const unsigned char sane_ctype[256] = {
> -	0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
> -	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
> +	X, X, X, X, X, X, X, X, X, Z, Z, X, X, Z, X, X,		/*   0.. 15 */
> +	X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,		/*  16.. 31 */

"Normal" isspace() also includes vertical tab (11) and form-feed (12) as
white-space characters. Is there a reason, why they are not included here?

>  	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
>  	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
>  	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
> -	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, R, P,		/*  80.. 95 */
> +	A, A, A, A, A, A, A, A, A, A, A, G, G, U, R, P,		/*  80.. 95 */
>  	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
> -	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, P, 0,		/* 112..127 */
> +	A, A, A, A, A, A, A, A, A, A, A, R, R, U, P, X,		/* 112..127 */
>  	/* Nothing in the 128.. range */
>  };
>  
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f8b859c..db77f3e 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
[...]
> @@ -527,6 +533,13 @@ extern const unsigned char sane_ctype[256];
>  #define isupper(x) sane_iscase(x, 0)
>  #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
>  #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX_SPECIAL)
> +#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
> +#define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
> +		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
> +#define isxdigit(x) (hexval_table[x] != -1)
> +#define isprint(x) (sane_istest(x, GIT_ALPHA | GIT_DIGIT | GIT_SPACE | \
> +		GIT_PUNCT | GIT_REGEX_SPECIAL | GIT_GLOB_SPECIAL | \
> +		GIT_PATHSPEC_MAGIC))

"Normal" isprint() only includes space (32) from the white-space characters.
The other white-space characters are not considered printable.

Do we want to stay close to the "original", or not?

Regards
Jan
