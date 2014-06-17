From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 1/3] add strnncmp() function
Date: Tue, 17 Jun 2014 12:27:27 -0700
Message-ID: <20140617192727.GB23557@hudson.localdomain>
References: <cover.1402990051.git.jmmahler@gmail.com>
 <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
 <xmqqd2e7mneh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 21:27:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwz2e-0007oX-QF
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933627AbaFQT1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:27:32 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:55789 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbaFQT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 15:27:31 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so3019143pbc.20
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 12:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ONVqnbQnBc1yyXtAbeHJuRzzIEZmzXtaZyPnLAtBqmU=;
        b=Qxo3xVDT9i49mPIAIT/opM60EnDmHtcySnbQCXv3h3Lej0ra/HgRCQaeoieIIsdu3R
         vEnF69DjuEnVoUD7bNCImcTvckHuSO64ObSF7ivgZ6KvfEcbDZcES6u3y9CMXHZwyAYH
         wm/2sIuFU4sQ+ELWuf8VLwKb9U+/DMdvAR/RbUpiGlz0CtSLpSVCSY+sVnnSYpnrnPKa
         6kEzqCvDl4rMTvyutrxXQaLsDUlGS3vyFmSpuzDviq9o5E0auGaLVG+xlpBBjC3AdVgZ
         bgkabhvQ3uf2AveyLSHNvOHoQe5HuL2+92M7/gg9Y755Eg9Ulo6zTBe65R7aSRjNd80W
         u/Zw==
X-Received: by 10.68.237.133 with SMTP id vc5mr35598977pbc.92.1403033251148;
        Tue, 17 Jun 2014 12:27:31 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id uv5sm14434957pbc.52.2014.06.17.12.27.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 12:27:29 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqd2e7mneh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251939>

Junio,

On Tue, Jun 17, 2014 at 10:55:18AM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
> > Add a strnncmp() function which behaves like strncmp() except it takes
> > the length of both strings instead of just one.  It behaves the same as
> > strncmp() up to the minimum common length between the strings.  When the
> > strings are identical up to this minimum common length, the length
> > difference is returned.
> >
> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> > ---
> >  strbuf.c | 9 +++++++++
> >  strbuf.h | 2 ++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/strbuf.c b/strbuf.c
> > index ac62982..4eb7954 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -600,3 +600,12 @@ char *xstrdup_tolower(const char *string)
> >  	result[i] = '\0';
> >  	return result;
> >  }
> > +
> > +int strnncmp(const char *a, int len_a, const char *b, int len_b)
> > +{
> > +	int min_len = (len_a < len_b) ? len_a : len_b;
> > +	int cmp = strncmp(a, b, min_len);
> > +	if (cmp)
> > +		return cmp;
> > +	return (len_a - len_b);
> > +}
> 
> I am not sure if the interface into this function conceptually makes
> much sense.  strncmp(entry, string, 14) was invented as the way to
> see if a NUL terminated "string" matches with the contents in an
> array of char "entry" that is up to 14 bytes long, and because the
> "entry" was allowed to fill full 14-byte space without terminated
> with a NUL, the maximum possible length is specified separately, but
> a NUL termination in "entry", if exists, is still honored.  Is there
> any case where such a pair of "maximum N bytes but could be shorter"
> strings are compared, especially with different N's defined per
> string, in our codebase (or in other people's project for that
> matter)?
> 
> Further, I do think that the interface into this function and its
> implementation are inappropriate for implementing the name_compare()
> function in tree-walk.c and unpack-trees.c.  These functions are
> designed to take counted strings; in a tuple <a, a_len> they take,
> "a_len" is the only thing that determines the length of string "a".
> There is no room for a NUL termination inside "a" come into play to
> make "a" shorter than "a_len".
> 
> In other words, "Two NUL-terminated strings can be compared with
> strcmp(a, b), but we use counted strings in many places in our
> codebase, and compare_counted_strings(a, a_len, b, b_len) function
> would help us, so let's add one and use it in name_compare()" may
> make good sense, but if we were to do so, I do not think strncmp()
> would be involved in its implementation.
> 
> 
The concept of a counted string clears up some of the confusion I was
having.  Thanks for that explanation.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
