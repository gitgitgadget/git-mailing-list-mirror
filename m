From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Sat, 24 Dec 2011 02:07:15 -0500
Message-ID: <20111224070715.GA32267@sigill.intra.peff.net>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <CACBZZX6hboo4wu3fOs+CHnxsdmedxw72GFMVttQzmHzpcZbqoQ@mail.gmail.com>
 <87mxaihpiq.fsf@thomas.inf.ethz.ch>
 <CACBZZX67WhcdhXdqOm8gZHW7C3YMbV2KzeytwjHwsnF=8-M_+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 24 08:07:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReLhU-0005UU-69
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 08:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab1LXHHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Dec 2011 02:07:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52010
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab1LXHHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 02:07:18 -0500
Received: (qmail 6291 invoked by uid 107); 24 Dec 2011 07:14:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Dec 2011 02:14:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Dec 2011 02:07:15 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX67WhcdhXdqOm8gZHW7C3YMbV2KzeytwjHwsnF=8-M_+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187656>

On Sat, Dec 24, 2011 at 02:39:11AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Is the expensive part of git-grep all the setup work, or the actual
> traversal and searching? I'm guessing it's the latter.
>=20
> In that case an easy way to do git-grep in parallel would be to simpl=
y
> spawn multiple sub-processes, e.g. if we had 1000 files and 4 cores:
>=20
>  1. Split the 1000 into 4 parts 250 each.
>  2. Spawn 4 processes as: git grep <pattern> -- <250 files>
>  3. Aggregate all of the results in the parent process

That's an interesting idea. The expense of the traversal and searching
depends on two things:

  - how complex is your regex?

  - are you reading from objects (which need zlib inflated) or disk?

But you should be able to approximate it by compiling with NO_PTHREADS
and doing (assuming you have GNU xargs):

  # grep in working tree
  git ls-files | xargs -P 8 git grep "$re" --

  # grep tree-ish
  git ls-tree -r --name-only $tree | xargs -P 8 git grep "$re" $tree --

I tried to get some timings for this, but ran across some quite
surprising results. Here's a simple grep of the linux-2.6 working tree,
using a single-threaded grep:

  $ time git grep SIMPLE >/dev/null
  real    0m0.439s
  user    0m0.272s
  sys     0m0.160s

and then the same thing, via xargs, without even turning on
parallelization. This should give us a measurement of the overhead for
going through xargs at all. We'd expect it to be slower, but not too
much so:

  $ time git ls-files | xargs git grep SIMPLE -- >/dev/null
  real    0m11.989s
  user    0m11.769s
  sys     0m0.268s

Twenty-five times slower! Running 'perf' reports the culprit as pathspe=
c
matching:

  +  63.23%    git  git                 [.] match_pathspec_depth
  +  28.60%    git  libc-2.13.so        [.] __strncmp_sse42
  +   2.22%    git  git                 [.] strncmp@plt
  +   1.67%    git  git                 [.] kwsexec

where the strncmps are called as part of match_pathspec_depth. So over
90% of the CPU time is spent on matching the pathspecs, compared to les=
s
than 2% actually grepping.

Which really makes me wonder if our pathspec matching could stand to be
faster. True, giving a bunch of single files is the least efficient way
to use pathspecs, but that's pretty amazingly slow.

The case where we would most expect the setup cost to be drowned out is
using a more complex regex, grepping tree objects. There we have a
baseline of:

  $ time git grep 'a.*c' HEAD >/dev/null
  real    0m5.684s
  user    0m5.472s
  sys     0m0.196s

  $ time git ls-tree --name-only -r HEAD |
      xargs git grep 'a.*c' HEAD -- >/dev/null
  real    0m10.906s
  user    0m10.725s
  sys     0m0.240s

Here, we still almost double our time. It looks like we don't use the
same pathspec matching code in this case. But we do waste a lot of extr=
a
time zlib-inflating the trees in "ls-tree", only to do it separately in
"grep".

Doing it in parallel yields:

  $ time git ls-tree --name-only -r HEAD |
      xargs -n 4000 -P 8 git grep 'a.*c' HEAD -- >/dev/null
  real    0m3.573s
  user    0m21.885s
  sys     0m0.400s

So that does at least yield a real speedup, albeit only by about half,
despite using over six times as much CPU (though my numbers are skewed
somewhat, as this is a quad i7 with hyperthreading and turbo boost).

-Peff
