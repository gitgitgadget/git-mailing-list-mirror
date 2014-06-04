From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Wed, 04 Jun 2014 17:14:36 -0400
Organization: Twitter
Message-ID: <1401916476.18134.165.camel@stross>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>
	 <1401853091-15535-2-git-send-email-dturner@twitter.com>
	 <538ED2F1.9030003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 23:14:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIWD-0006Ed-B0
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbaFDVOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 17:14:41 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:37462 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaFDVOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:14:40 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so145159qgd.29
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 14:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=VtBt1vXffOAAja+majBZxovIODTFj5prliH/cut260c=;
        b=OwFO55WHqbToYON9HTOl8bxcC9onAH8dBeyOwRGbKnPH198NYAhTGMHrWw6SfX/h7Z
         0PFHF+IEc2BSCnawH58Hlh7t2JKkaNaPcKHFMIRGk/EgHtl2uAnz+neqA0I89F7DdHhs
         uFRXGDAGSJ67vEf5P3eoCqHJJBzb87lQ2sUw1EKZ2AaTl4pJf4mfF3RCDOqK4buxiGwD
         ZcRqpPeXFWF+C8nL+YC4NH9ULGxM35xoRGH+PxUJmPZbEjXwDVkbZ86FEyBa+OU7hGY1
         MBbsQTgi7L83c744N+9vaNle7ps8oGW5fAJgtysYc4SbrY5fKU/r2ql9hUkiHnBpGd/p
         tqzQ==
X-Gm-Message-State: ALoCoQknKWqhwCmD/W2xY8LRmAgvBbq0lvVAMcRg5bAtNEAkkj+vIzOKAUf9qGYY/OWq+48tZ/s3
X-Received: by 10.140.84.168 with SMTP id l37mr72866736qgd.104.1401916479291;
        Wed, 04 Jun 2014 14:14:39 -0700 (PDT)
Received: from [172.18.24.70] ([8.25.196.25])
        by mx.google.com with ESMTPSA id i9sm5953068qaq.14.2014.06.04.14.14.37
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 14:14:38 -0700 (PDT)
In-Reply-To: <538ED2F1.9030003@web.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250793>

On Wed, 2014-06-04 at 10:04 +0200, Torsten B=C3=B6gershausen wrote:
[snip discussion of compiler flags; I'll look into a cpuid approach]

> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -668,6 +668,28 @@ void git_qsort(void *base, size_t nmemb, size_=
t size,
> >  #endif
> >  #endif
> > =20
> > +#ifndef NO_SSE42
> > +#include <nmmintrin.h>
> > +/*
> > + * Clang ships with a version of nmmintrin.h that's incomplete; if
> > + * necessary, we define the constants that we're going to use.
> > + */
> > +#ifndef _SIDD_UBYTE_OPS
> > +#define _SIDD_UBYTE_OPS                 0x00
> > +#define _SIDD_CMP_EQUAL_ANY             0x00
> > +#define _SIDD_CMP_RANGES                0x04
> > +#define _SIDD_CMP_EQUAL_ORDERED         0x0c
> > +#define _SIDD_NEGATIVE_POLARITY         0x10
> > +#endif
> Why do this defines end up in git-compat-util.h when they are needed =
by one file?
> (see even below)

Because Junio told me to:
"We would prefer not to add inclusion of any system header files in
random *.c files, as there often are system dependencies (order of
inclusion, definition of feature macros, etc.) we would rather want
to encapsulate in one place, that is git-compat-util.h."

> > --- a/refs.c
> > +++ b/refs.c
> > @@ -24,6 +24,25 @@ static unsigned char refname_disposition[256] =3D=
 {
> >  	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
> >  };
> > =20
> > +static int check_refname_component_trailer(const char *cp, const c=
har *refname, int flags)
> > +{
> > +	if (cp =3D=3D refname)
> > +		return 0; /* Component has zero length. */
> > +	if (refname[0] =3D=3D '.') {
> > +		if (!(flags & REFNAME_DOT_COMPONENT))
> > +			return -1; /* Component starts with '.'. */
> > +		/*
> > +		 * Even if leading dots are allowed, don't allow "."
> > +		 * as a component (".." is prevented by a rule above).
> > +		 */
> > +		if (refname[1] =3D=3D '\0')
> > +			return -1; /* Component equals ".". */
> > +	}
> > +	if (cp - refname >=3D 5 && !memcmp(cp - 5, ".lock", 5))
> > +		return -1; /* Refname ends with ".lock". */
> > +	return cp - refname;
> > +}
> > +
> >  /*
> >   * Try to read one refname component from the front of refname.
> >   * Return the length of the component found, or -1 if the componen=
t is
> > @@ -37,7 +56,7 @@ static unsigned char refname_disposition[256] =3D=
 {
> >   * - it ends with ".lock"
> >   * - it contains a "\" (backslash)
> >   */
> > -static int check_refname_component(const char *refname, int flags)
> > +static int check_refname_component_1(const char *refname, int flag=
s)
> The name check_refname_component_1() doesn't tell too much,
> (check_refname_component_sse42()  or check_refname_component_nonsse42=
() say more)

I'll go with "_bytewise", since that's how it works.

> can I suggest to move all SSE code out to a file under compat/,
> like compat/refs_sse42.c, or something similar ?

Since this is a relatively small section of code, I think that would be
overkill.  Does anyone else have an opinion?
