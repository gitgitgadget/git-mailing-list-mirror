From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 1/1] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Sun, 15 Jun 2014 01:53:40 -0400
Organization: Twitter
Message-ID: <1402811620.5629.77.camel@stross>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>
	 <1402012575-16546-2-git-send-email-dturner@twitter.com>
	 <20140614152209.GA14125@domone.podge>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: =?UTF-8?Q?Ond=C5=99ej_B=C3=ADlka?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Jun 15 07:54:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww3Os-0007m7-EL
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 07:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbaFOFxt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jun 2014 01:53:49 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:49813 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbaFOFxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 01:53:48 -0400
Received: by mail-qc0-f180.google.com with SMTP id r5so2601491qcx.25
        for <git@vger.kernel.org>; Sat, 14 Jun 2014 22:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=ki10ioX7agmbbHzh/nvaHqVr1Uhql9ekkvY9kXH4ciY=;
        b=R/2aYDX1fHD7jnNkKqYZSjGm1NXG45GBzVbBGOrzmgXTJN9CIQzUGaIVX4fiTZwDD7
         ZaFeuHos/K0pLqyYOF2pPWuO0YFuvmEgHYz/EbYFgkte7TQzRQLRIlvStkz1lFTX68E/
         6Uri+GP475E15KvBhFU8IjpBncKRYm/LlHyw4Ckcs4hYA5mAAecFOQl/oh8rojLPl4SJ
         5g8V2fmtCIIioJ0axR5uvyxLd0PYxkmardPbIe4bP1SdIFg8rMSGWk97tFNjiBHAem20
         sL+jUdsJC+NoE1KWbDcfieJVgzOPEsFTt3klSJ4BVN8HHJdMMhV6rrjhpbN7hts78LW9
         QrVw==
X-Gm-Message-State: ALoCoQlYSdPECbMWOcLebeGvETYvv705WORxtNlqnKWhe6mCBkcNg9btfG5HKPfRo5pw16UVTrbz
X-Received: by 10.140.27.245 with SMTP id 108mr15296082qgx.18.1402811627677;
        Sat, 14 Jun 2014 22:53:47 -0700 (PDT)
Received: from [172.18.24.99] ([8.25.196.26])
        by mx.google.com with ESMTPSA id 74sm4321088qgf.32.2014.06.14.22.53.45
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 14 Jun 2014 22:53:46 -0700 (PDT)
In-Reply-To: <20140614152209.GA14125@domone.podge>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251669>

On Sat, 2014-06-14 at 17:22 +0200, Ond=C5=99ej B=C3=ADlka wrote:
> On Thu, Jun 05, 2014 at 07:56:15PM -0400, David Turner wrote:
> > Optimize check_refname_component using SSE4.2, where available.
> >=20
> > git rev-parse HEAD is a good test-case for this, since it does almo=
st
> > nothing except parse refs.  For one particular repo with about 60k
> > refs, almost all packed, the timings are:
> >=20
> > Look up table: 29 ms
> > SSE4.2:        25 ms
> >=20
> > This is about a 15% improvement.
> >=20
> > The configure.ac changes include code from the GNU C Library writte=
n
> > by Joseph S. Myers <joseph at codesourcery dot com>.
> >=20
> > Only supports GCC and Clang at present, because C interfaces to the
> > cpuid instruction are not well-standardized.
> >
> Still a SSE4.2 is not that useful, in most cases SSE2 is faster. Here=
 I
> think that difference will not be that big when correctly implemented=
=2E
> That will avoid a runtime checks.

Surprisingly to me, this is true!  At least, on my machine.  Sadly, the
only way to make it avoid a runtime check is to exclude 32-bit machines
(or to make the option non-default, which I would prefer not to do).=20

> For parallelisation you need to take extra step and paralelize whole
> check than going component-by-component.

Good idea.

> For detecting sequences a faster way is construct bitmasks with SSE2 =
so
> you could combine these. It avoids needing special casing on 16-byte
> boundaries.

That does seem to be faster.

> Below is untested implementation where you could add a bad character
> check with SSE4.2 which would speed it up. Are refs mostly
> alphanumerical? If so we could speed this up by paralelized alnum che=
ck
> and handling other characters in slower path.

Twitter's are almost entirely in [-._/a-zA-Z0-9] -- there are only a
handful of exceptions. So, a method that has some bycatch outside of
this range is just as fast as the SSE4.2 bad character check (but
somewhat more code).
