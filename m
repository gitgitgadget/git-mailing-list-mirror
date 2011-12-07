From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Tue, 6 Dec 2011 23:42:42 -0500
Message-ID: <20111207044242.GB10765@sigill.intra.peff.net>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <4ED8F9AE.8030605@lsrfire.ath.cx>
 <4EDE9BBA.2010409@lsrfire.ath.cx>
 <4EDE9ED1.8010502@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 07 05:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY9Lg-0002FM-Ve
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 05:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab1LGEnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 23:43:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41627
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686Ab1LGEmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 23:42:44 -0500
Received: (qmail 11828 invoked by uid 107); 7 Dec 2011 04:49:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 23:49:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 23:42:42 -0500
Content-Disposition: inline
In-Reply-To: <4EDE9ED1.8010502@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186421>

On Wed, Dec 07, 2011 at 12:01:37AM +0100, Ren=C3=A9 Scharfe wrote:

> Reading of git objects needs to be protected by an exclusive lock
> and cannot be parallelized.  Searching the read buffers can be done
> in parallel, but for simple expressions threading is a net loss due
> to its overhead, as measured by Thomas.  Turn it off unless we're
> searching in the worktree.

Based on my earlier numbers, I was going to complain that we should
also be checking the "simple expressions" assumption here, as time spen=
t
in the actual regex might be important.

However, after trying to repeat my experiment, I think the numbers I
posted earlier were misleading. For example, using my "more complex"
regex of 'a.*b':

  $ time git grep --threads=3D8 'a.*b' HEAD >/dev/null
  real    0m8.655s
  user    0m23.817s
  sys     0m0.480s

Look at that sweet, sweet parallelism. It's a quad-core with
hyperthreading, so we're not getting the 8x speedup we might hope for
(presumably due to lock contention on extracting blobs), but hey, 3x
isn't bad. Except, wait:

  $ time git grep --threads=3D0 'a.*b' HEAD >/dev/null
  real    0m7.651s
  user    0m7.600s
  sys     0m0.048s

We can get 1x on a single core, but the total time is lower! This
processor is an i7 with "turbo boost", which means it clocks higher in
single-core mode than when multiple cores are active. So the numbers I
posted earlier were misleading. Yes, we got parallelism, but at the cos=
t
of knocking the clock speed down for a net loss.

The sweet spot for me seems to be:

  $ time git grep --threads=3D2 'a.*b' HEAD >/dev/null
  real    0m6.303s
  user    0m11.129s
  sys     0m0.220s

I'd be curious to see results from somebody with a quad-core (or more)
without turbo boost; I suspect that threading may have more benefit
there, even though we have some lock contention for blobs.

> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1048,7 +1048,7 @@ int cmd_grep(int argc, const char **argv, const=
 char *prefix)
>  	nr_threads =3D 0;
>  #else
>  	if (nr_threads =3D=3D -1)
> -		nr_threads =3D (online_cpus() > 1) ? THREADS : 0;
> +		nr_threads =3D (online_cpus() > 1 && !list.nr) ? THREADS : 0;
> =20
>  	if (nr_threads > 0) {
>  		opt.use_threads =3D 1;

This doesn't kick in for "--cached", which has the same performance
characteristics as grepping a tree. I think you want to add "&& !cached=
" to
the conditional.

-Peff
