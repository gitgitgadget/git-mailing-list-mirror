From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v8] refs.c: SSE2 optimizations for
 check_refname_component
Date: Mon, 16 Jun 2014 20:51:57 -0400
Organization: Twitter
Message-ID: <1402966317.5629.93.camel@stross>
References: <1402946566-14923-1-git-send-email-dturner@twitter.com>
	 <xmqqha3ko0vs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, neleai@seznam.cz,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 02:52:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwhd9-0005ev-D3
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 02:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbaFQAwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2014 20:52:01 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:56859 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaFQAwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 20:52:00 -0400
Received: by mail-qc0-f177.google.com with SMTP id r5so5347838qcx.22
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 17:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=5oi4U6pe7yKn3N1WGcmlt4RzoFrf2iokNK5uq705CD0=;
        b=Yfn44On4i28hVf5jhlx8ppKyHulWhYd89I29pNU2xtxqnXhLhudEysT3Bd1GzGCyh5
         Y1j/bSmtE2EG1ijt9HJE1g0nQTcsCqrTz5ccnCWfAf/Ox/vw9Ht+94HxaqYiioKJtpEX
         tn38Mv34glhSAwONBv+GaDOa0DSm4hr1aiQrCYmtLvaGPdTtVSw0NWJ3eKiYKN2mTRvd
         +EeQYwSq5qfBGyoj6JzHKT+kEmUYuKNmXAS44cI9RGWv0OUHKTwKxBPUWBT4G8Fwb/hk
         OVkER7ApZxGITFfNEuWWt41eEfGgd7G0kmcIcMmDZeDnj4WqkVPQSYbsmH52bAIy649d
         DcCg==
X-Gm-Message-State: ALoCoQnSwlq1L/hsxqNDtsw2sYja6vEkYP90QZ7fvZBDhV7uwINAsr5fVcnyQNc+XOTNkSy1Og52
X-Received: by 10.229.212.196 with SMTP id gt4mr31635701qcb.18.1402966320151;
        Mon, 16 Jun 2014 17:52:00 -0700 (PDT)
Received: from [172.17.3.150] ([38.104.173.198])
        by mx.google.com with ESMTPSA id y79sm7875353qgy.18.2014.06.16.17.51.58
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 17:51:59 -0700 (PDT)
In-Reply-To: <xmqqha3ko0vs.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251839>

On Mon, 2014-06-16 at 17:06 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>=20
> > Optimize check_refname_component using SSE2 on x86_64.
> >
> > git rev-parse HEAD is a good test-case for this, since it does almo=
st
> > nothing except parse refs.  For one particular repo with about 60k
> > refs, almost all packed, the timings are:
> >
> > Look up table: 29 ms
> > SSE2:          23 ms
> >
> > This cuts about 20% off of the runtime.
> >
> > The configure.ac changes include code from the GNU C Library writte=
n
> > by Joseph S. Myers <joseph at codesourcery dot com>.
> >
> > Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> suggested an SSE2 approac=
h to the
>=20
> One e-mail address is obfuscated while the other not; intended?

Yes (although I'll happily obfuscate or remove Ond=C5=99ej's if he pref=
ers);
Joseph's was obfuscated because that's how I found it in the source
material.

> > substring searches, which netted a speed boost over the SSE4.2 code=
 I
> > had initially written.
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index f6d3a46..291d46b 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -668,6 +668,16 @@ void git_qsort(void *base, size_t nmemb, size_=
t size,
> >  #endif
> >  #endif
> > =20
> > +#if defined(__GNUC__) && defined(__x86_64__)
> > +#include <emmintrin.h>
> > +/* This is the system memory page size; it's used so that we can r=
ead
>=20
> Style (there are other instances of the same kind).

Will fix.

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
>=20
> This is merely a moved code that retained the same comment, but it
> is more like "the current refname component ends with .lock", I
> suspect.  In other words, we do not allow "refs/heads/foo.lock/bar".
> Am I reading the patch correctly?

This code didn't actually need to be moved; I'll move it back.

But it now occurs to me that the SSE2 code does not actually check
for .lock at the end of each component, but only at the end of string.

I don't know why we don't allow refs/heads/foo.lock/bar.  I can
understand not allowing refs/heads/foo.lock, since it might be a lock
file.  But I have never heard of a lock directory like this.=20

I'm happy to replicate what the existing code does, but do you think it
is correct?

> Style (there are other instances of the same kind).  No SP between
> function/macro name and opening parenthesis.

Will fix.

> > +	if (refname[0] =3D=3D '.') {
> > +		if (refname[1] =3D=3D '/' || refname[1] =3D=3D '\0')
> > +			return -1;
> > +		if (!(flags & REFNAME_DOT_COMPONENT))
> > +			return -1;
> > +	}
> > +	while(1) {
> > +		__m128i tmp, tmp1, result;
> > +		uint64_t mask;
> > +
> > +		if ((uintptr_t) cp % PAGE_SIZE > PAGE_SIZE - SSE_VECTOR_BYTES  -=
 1)
>=20
> OK, so we make sure we do not overrun by reading too much near the
> end of the page, as the next page might be unmapped.

Exactly.

> I am showing my ignorance but does cp (i.e. refname) upon entry to
> this function need to be aligned in some way?

Nope -- _mm_loadu_si128 does an unaligned load.
