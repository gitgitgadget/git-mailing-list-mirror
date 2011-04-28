From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:44:59 +0200
Message-ID: <20110428094459.GA15952@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <BANLkTim7bbFiSsj3PRr-_yM5gh1txYQR5w@mail.gmail.com>
 <20110428091110.GA14431@elte.hu>
 <BANLkTikWd8=1RbY78tPFMVhuV05eKVzjkg@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Apr 28 11:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNmr-0002rc-Nh
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544Ab1D1JpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 05:45:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46878 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884Ab1D1JpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:45:12 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFNmP-00017m-6I
	from <mingo@elte.hu>; Thu, 28 Apr 2011 11:45:06 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 29A393E236B; Thu, 28 Apr 2011 11:44:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikWd8=1RbY78tPFMVhuV05eKVzjkg@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172339>


* Dmitry Potapov <dpotapov@gmail.com> wrote:

> 2011/4/28 Ingo Molnar <mingo@elte.hu>:
> >
> > * Dmitry Potapov <dpotapov@gmail.com> wrote:
> >
> >> 2011/4/28 Ingo Molnar <mingo@elte.hu>:
> >> > +static inline int hashcmp(const unsigned char *sha1, const unsi=
gned char *sha2)
> >> > =A0{
> >> > - =A0 =A0 =A0 return !memcmp(sha1, null_sha1, 20);
> >> > + =A0 =A0 =A0 int i;
> >> > +
> >> > + =A0 =A0 =A0 for (i =3D 0; i < 20; i++, sha1++, sha2++) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*sha1 !=3D *sha2) {
> >>
> >> At the very least, you may want to put 'likely' in this 'if'
> >> condition, otherwise the compiler may optimize this loop in
> >> the same way as with memcmp. So, it may work well now, but
> >> it may not work much slower with future versions or different
> >> level of optimization. (AFAIK, -O3 is far more aggressive in
> >> optimizing of loops).
> >
> > the main difference is between the string assembly instructions and=
 the loop.
> > Modern CPUs will hardly notice this loop being emitted with slight =
variations
> > by the compiler. So i do not share this concern.
>=20
> Here you make an assumption what kind of optimization the compiler
> can do. [...]

I make no assumption there because rule #1 is that the compiler can pre=
tty well=20
do what it wants and we have little control over that.

> [...] As Jonathan noticed above, theoretically a smart compiler can t=
urn this=20
> loop into memcmp (or code very similar to memcmp).

Yes, and in practice it does not, and in practice we can speed up git g=
c=20
measurably.

> The reason why memcmp does not work well is that it is optimized
> for the worst case scenario (where beginning of two strings is
> the same), while _we_ know that with a hash it very unlikely,
> and we want to conduct this knowledge to the compiler in some
> way. Just re-writing memcmp as explicit loop does not conduct
> this knowledge.
>=20
> Therefore, I believe it makes sense to add 'likely'. I have not
> tested this code, but in the past, I had a very similar code
> which was compiled with -O3, and just putting likely turned out
> to 40% speed-up for that comparison function.

You guys can certainly add the 'likely()' if you want to (it likely won=
t hurt)=20
- but note that the compiler can *still* turn it into a memcpy() - see =
rule #1=20
above.

Note that Git does not have a likely() facility at the moment and=20
__builtin_expect() is a GNU extension. Should be a separate patch.

Thanks,

	Ingo
