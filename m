From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Wed, 7 Dec 2011 15:11:05 -0500
Message-ID: <20111207201105.GA22995@fieldses.org>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <4ED8F9AE.8030605@lsrfire.ath.cx>
 <4EDE9BBA.2010409@lsrfire.ath.cx>
 <4EDE9ED1.8010502@lsrfire.ath.cx>
 <20111207044242.GB10765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 21:11:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNpk-0001X9-V1
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 21:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805Ab1LGULL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 15:11:11 -0500
Received: from fieldses.org ([174.143.236.118]:33380 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757685Ab1LGULK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 15:11:10 -0500
Received: from bfields by fieldses.org with local (Exim 4.72)
	(envelope-from <bfields@fieldses.org>)
	id 1RYNpZ-00067C-NY; Wed, 07 Dec 2011 15:11:05 -0500
Content-Disposition: inline
In-Reply-To: <20111207044242.GB10765@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186498>

On Tue, Dec 06, 2011 at 11:42:42PM -0500, Jeff King wrote:
> On Wed, Dec 07, 2011 at 12:01:37AM +0100, Ren=C3=A9 Scharfe wrote:
>=20
> > Reading of git objects needs to be protected by an exclusive lock
> > and cannot be parallelized.  Searching the read buffers can be done
> > in parallel, but for simple expressions threading is a net loss due
> > to its overhead, as measured by Thomas.  Turn it off unless we're
> > searching in the worktree.
>=20
> Based on my earlier numbers, I was going to complain that we should
> also be checking the "simple expressions" assumption here, as time sp=
ent
> in the actual regex might be important.
>=20
> However, after trying to repeat my experiment, I think the numbers I
> posted earlier were misleading. For example, using my "more complex"
> regex of 'a.*b':
>=20
>   $ time git grep --threads=3D8 'a.*b' HEAD >/dev/null
>   real    0m8.655s
>   user    0m23.817s
>   sys     0m0.480s

Dumb question (I missed the beginning of the conversation): what kind o=
f
storage are you using, and is the data already cached?

I seem to recall part of the motivation for the multithreading being
NFS, where the goal isn't so much to keep CPU's busy as it is to keep
the network busy.

Probably a bigger problem for something like "git status" which I think
ends up doing a series of stat's (which can each require a round trip t=
o
the server in the NFS case), as it is a problem for something like
git-grep that's also doing reads.

Just a plea for considering the IO cost as well when making these kinds
of decisions....

(Which maybe you already do, apologies again for just naively dropping
into the middle of a thread.)

--b.

>=20
> Look at that sweet, sweet parallelism. It's a quad-core with
> hyperthreading, so we're not getting the 8x speedup we might hope for
> (presumably due to lock contention on extracting blobs), but hey, 3x
> isn't bad. Except, wait:
>=20
>   $ time git grep --threads=3D0 'a.*b' HEAD >/dev/null
>   real    0m7.651s
>   user    0m7.600s
>   sys     0m0.048s
>=20
> We can get 1x on a single core, but the total time is lower! This
> processor is an i7 with "turbo boost", which means it clocks higher i=
n
> single-core mode than when multiple cores are active. So the numbers =
I
> posted earlier were misleading. Yes, we got parallelism, but at the c=
ost
> of knocking the clock speed down for a net loss.
>=20
> The sweet spot for me seems to be:
>=20
>   $ time git grep --threads=3D2 'a.*b' HEAD >/dev/null
>   real    0m6.303s
>   user    0m11.129s
>   sys     0m0.220s
>=20
> I'd be curious to see results from somebody with a quad-core (or more=
)
> without turbo boost; I suspect that threading may have more benefit
> there, even though we have some lock contention for blobs.
>=20
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -1048,7 +1048,7 @@ int cmd_grep(int argc, const char **argv, con=
st char *prefix)
> >  	nr_threads =3D 0;
> >  #else
> >  	if (nr_threads =3D=3D -1)
> > -		nr_threads =3D (online_cpus() > 1) ? THREADS : 0;
> > +		nr_threads =3D (online_cpus() > 1 && !list.nr) ? THREADS : 0;
> > =20
> >  	if (nr_threads > 0) {
> >  		opt.use_threads =3D 1;
>=20
> This doesn't kick in for "--cached", which has the same performance
> characteristics as grepping a tree. I think you want to add "&& !cach=
ed" to
> the conditional.
>=20
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
