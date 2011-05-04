From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [RFC PATCH 3/3] git-grep: Learn PCRE
Date: Wed, 4 May 2011 08:16:28 +0200
Message-ID: <20110504081628.6a80f4a0@mkiedrowicz>
References: <1304458557-25629-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1304458557-25629-3-git-send-email-michal.kiedrowicz@gmail.com>
	<7vliyngz1x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHVO2-0007lo-Qo
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 08:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab1EDGQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 02:16:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62102 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab1EDGQd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 02:16:33 -0400
Received: by ewy4 with SMTP id 4so252220ewy.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=qaDbcBuJhKRo+QmLy4YS73H46CUaa31iw3cyqA/G+4E=;
        b=WvGNhRsMz8ioyxSC8nORUz/Jp9ttaC8p3+Rro5oYUpngjXGfKZgSGlk9oQRTPMUpc1
         QWPqS9m3UsUbA9+0SJYZARon7v81IEV34BMGEpUVLCrzUuOFDzOh6zuaa6VlR0j8Qggb
         7dFqevS3nmIJA0h0FuTV298m2+cCqIjD588iA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=wADbwf4Q5VcP/DLD8xXqbCIXhuV9NNr+pzN7V+aVzqCMjFua0W7MpAi/xKfd0oGamc
         VolwOKz+GrzrvLlg47lmoPUMy0Ub1WZu/fElJXqZqvZoHiK5vjKGkB93NDWJf641/qqk
         JkbYCBt/+qNA2aG1DMoLzvhQQxndBQ7bhl6R0=
Received: by 10.213.31.142 with SMTP id y14mr1823147ebc.112.1304489791616;
        Tue, 03 May 2011 23:16:31 -0700 (PDT)
Received: from mkiedrowicz (pc10.ivo.park.gdynia.pl [153.19.128.10])
        by mx.google.com with ESMTPS id s49sm583866eei.26.2011.05.03.23.16.31
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 23:16:31 -0700 (PDT)
In-Reply-To: <7vliyngz1x.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172718>

On 03.05.2011 16:11:06 -0700 Junio C Hamano <gitster@pobox.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > This patch lacks tests.
> >
> > AFAIK grep.c is a part of libgit.a, so libpcre is linked with the
> > git itself, which bloats it. I don't like it, especially because it
> > makes 'make test' take:
> >
> > 	real    6m27.558s
> > 	user    1m34.392s
> > 	sys     2m11.029s
> >
> > instead of
> >
> > 	real    3m41.322s
> > 	user    1m44.005s
> > 	sys     2m32.403s
> >
> > on my PC.
>=20
> I am not against pcre, but the performance numbers look rather yucky.
>=20
> > diff --git a/grep.c b/grep.c
> > index d67baf9..4f5fcbb 100644
> > --- a/grep.c
> > +++ b/grep.c
> > @@ -70,6 +70,30 @@ static void compile_regexp(struct grep_pat *p,
> > struct grep_opt *opt) if (p->fixed)
> >  		return;
> > =20
> > +	if (opt->pcre) {
> > +#ifdef NO_LIBPCRE
> > +		die("cannot use Perl-compatible regexes when
> > libpcre is not compiled in"); +#else
> > +		const char *error;
> > +	...
> > +		return;
> > +#endif
> > +	}
> > +
>=20
> Please avoid these #ifdefs in the middle of otherwise generic
> function.

Yeah, I don't like them too.

>=20
> Make the above into something like:
>=20
> 	if (opt->pcre) {
>         	compile_pcre(p, opt);
>                 return;
> 	}
>=20
> and then have an extra section entirely devoted to pcre integration
> that has bunch of ...
>=20
>         #ifdef NO_LIBPCRE
>         static void compile_pcre_part(struct grep_pat *p, struct
> grep_opt *opt) {
>                 die("...");
> 	}
>         #else
>         static void compile_pcre_part(struct grep_pat *p, struct
> grep_opt *opt) {
>                 ...
> 	}
>         #endif
>=20
> ... that is totally separate from the generic part of the codebase.
> They could even be in a separate file, if you need numerous helpers.
>=20
> > @@ -320,7 +344,16 @@ void free_grep_patterns(struct grep_opt *opt)
> >  		case GREP_PATTERN: /* atom */
> >  		case GREP_PATTERN_HEAD:
> >  		case GREP_PATTERN_BODY:
> > +#ifndef NO_LIBPCRE
> > +			if (p->re) {
> > +				pcre_free(p->re);
> > +				pcre_free(p->extra);
> > +			} else {
> > +				regfree(&p->regexp);
> > +			}
> > +#else
> >  			regfree(&p->regexp);
> > +#endif
> >  			break;
> >  		default:
> >  			break;
>=20
> > diff --git a/grep.h b/grep.h
> > index 06621fe..cd202a9 100644
> > --- a/grep.h
> > +++ b/grep.h
> > @@ -1,6 +1,9 @@
> >  #ifndef GREP_H
> >  #define GREP_H
> >  #include "color.h"
> > +#ifndef NO_LIBPCRE
> > +#include <pcre.h>
> > +#endif /* NO_LIBPCRE */
>=20
> This part might want to do something like
>=20
> 	#ifndef NO_LIBPCRE
>         #include <pcre.h>
>         #else
>         typedef int pcre; /* dummy */
>         typedef int pcre_extra; /* dummy */
>         #endif
>=20
> if it makes it easier to keep the generic part of the code and
> structure definition clean.
>=20
> For example, the "free" part of your patch above then would become
>=20
> 	if (p->pcre_regexp)
>         	free_pcre_part(p);
> 	else
>         	regfree(&p->regexp);
>=20
> with the conditional enclosed entirely within the implementation of
> the free_pcre_part() helper function.
>=20
> Also by doing so, the struct definition below can lose #ifndef, and
> can become:
>=20
> 	 struct grep_pat {
>          ...
>         +	pcre *pcre_regexp;
>         +	pcre_extra *pcre_extra_info;
> 	 ...
> 	 };

That makes sense. Will re-roll (and add Signed-off-by).

>=20
> > @@ -33,6 +36,10 @@ struct grep_pat {
> >  	size_t patternlen;
> >  	enum grep_header_field field;
> >  	regex_t regexp;
> > +#ifndef NO_LIBPCRE
> > +	pcre *re;
> > +	pcre_extra *extra;
> > +#endif /* NO_LIBPCRE */
> >  	unsigned fixed:1;
> >  	unsigned ignore_case:1;
> >  	unsigned word_regexp:1;
> > @@ -83,6 +90,7 @@ struct grep_opt {
> >  #define GREP_BINARY_TEXT	2
> >  	int binary;
> >  	int extended;
> > +	int pcre;
> >  	int relative;
> >  	int pathname;
> >  	int null_following_name;
