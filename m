From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:11:10 +0200
Message-ID: <20110428091110.GA14431@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <BANLkTim7bbFiSsj3PRr-_yM5gh1txYQR5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNG3-0001WK-AR
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1D1JLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 05:11:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41373 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388Ab1D1JL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:11:28 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFNFg-0002ev-PY
	from <mingo@elte.hu>; Thu, 28 Apr 2011 11:11:14 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id CBD063E236B; Thu, 28 Apr 2011 11:11:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTim7bbFiSsj3PRr-_yM5gh1txYQR5w@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172326>


* Dmitry Potapov <dpotapov@gmail.com> wrote:

> 2011/4/28 Ingo Molnar <mingo@elte.hu>:
> > +static inline int hashcmp(const unsigned char *sha1, const unsigne=
d char *sha2)
> > =A0{
> > - =A0 =A0 =A0 return !memcmp(sha1, null_sha1, 20);
> > + =A0 =A0 =A0 int i;
> > +
> > + =A0 =A0 =A0 for (i =3D 0; i < 20; i++, sha1++, sha2++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*sha1 !=3D *sha2) {
>=20
> At the very least, you may want to put 'likely' in this 'if'
> condition, otherwise the compiler may optimize this loop in
> the same way as with memcmp. So, it may work well now, but
> it may not work much slower with future versions or different
> level of optimization. (AFAIK, -O3 is far more aggressive in
> optimizing of loops).

the main difference is between the string assembly instructions and the=
 loop.=20
Modern CPUs will hardly notice this loop being emitted with slight vari=
ations=20
by the compiler. So i do not share this concern.

> Another thing is that so far this optimization was only with
> GCC, and we do not know whether it helps or harms to compilers.
> So, maybe placing this code under 'ifdef __GNUC__' makes more
> sense than pushing this change on other compilers too.

Well, given that 90%+ of Git development is done with GCC (and probably=
 the=20
user share is similarly high as well):

 aldebaran:~/git> git log --pretty=3Doneline -i --grep gcc | wc -l
 127
 aldebaran:~/git> git log --pretty=3Doneline -i --grep llvm | wc -l
 1

and given that these two patches speed up 'git gc' by 30%+, i doubt we'=
d want=20
to litter core Git code with #ifdef __GNUC__ uglinesses.

Thanks,

	Ingo
