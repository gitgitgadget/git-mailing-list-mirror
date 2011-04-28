From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 08:36:25 +0200
Message-ID: <20110428063625.GB952@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <20110427231748.GA26632@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 08:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFKqH-00042f-RR
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 08:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab1D1Ggm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 02:36:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:35399 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876Ab1D1Ggl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 02:36:41 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFKpu-0005Sg-Ta
	from <mingo@elte.hu>; Thu, 28 Apr 2011 08:36:30 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 5752C3E250F; Thu, 28 Apr 2011 08:36:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110427231748.GA26632@elie>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172319>


* Jonathan Nieder <jrnieder@gmail.com> wrote:

> Ingo Molnar wrote:
> 
> > Most overhead is in hashcmp(), which uses memcmp(), which falls back to 
> > assembly string operations.
> >
> > But we know that hashcmp() compares hashes, which if they do not match, the first byte
> > will differ in 99% of the cases.
> >
> > So i tried the patch below: instead of relying on GCC putting in the string 
> > ops, i used an open-coded loop for this relatively short comparison, which does 
> > not go beyond the first byte in 99% of the cases.
> [...]
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -675,14 +675,33 @@ extern char *sha1_pack_name(const unsigned char *sha1);
> [...]
> > +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> >  {
> > -	return memcmp(sha1, sha2, 20);
> > +	int i;
> > +
> > +	for (i = 0; i < 20; i++, sha1++, sha2++) {
> 
> Hm.  This would be very sensitive to the compiler, since a too-smart 
> optimizer could take this loop and rewrite it back to memcmp! So I wonder if 
> it's possible to convey this to the compiler more precisely:
> 
> 	return memcmp_probably_differs_early(sha1, sha2, 20);
> 
> E.g., how would something like
> 
> 	const unsigned int *start1 = (const unsigned int *) sha1;
> 	const unsigned int *start2 = (const unsigned int *) sha2;
> 
> 	if (likely(*start1 != *start2)) {
> 		if (*start1 < *start2)
> 			return -1;
> 		return +1;
> 	}
> 	return memcmp(sha1 + 4, sha2 + 4, 16);
>
> perform?

Note that this function wont work on like 99% of the systems out there due to 
endianness assumptions in Git.

Also, your hypothetical smart compiler would recognize the above as equivalent 
to memcmp(sha1, sha2, 20) and could rewrite it again - so we'd be back to 
square 1.

As i argued in my other mail in this thread, it's hard to keep a compiler from 
messing up its assembly output if it really wants to mess up - we'll deal with 
it when that happens. I used a very fresh compiler and a modern CPU for my 
testing - so even if very, very new compilers improve this problem somehow it 
will stay with us for a long, long time.

Having said that, it would be nice if someone could test these two patches on a 
modern AMD box, using the perf stat from here:

  http://people.redhat.com/mingo/tip.git/README

  cd tools/perf/
  make -j install

and do something like this to test git gc's performance:

  $ perf stat --sync --repeat 10 ./git gc

... to see whether these speedups are generic, or somehow Intel CPU specific.

> I suspect we don't have to worry about endianness as long as hashcmp
> yields a consistent ordering, but I haven't checked.

Well i messed up endianness in an early version of this patch and 'git gc' was 
eminently unhappy about it! I have not figured out which part of Git relies on 
the comparison result though - most places seem to use the result as a boolean.

Thanks,

	Ingo
