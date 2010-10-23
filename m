From: Jeff King <peff@peff.net>
Subject: Re: git as an sfc member project
Date: Sat, 23 Oct 2010 09:39:48 -0400
Message-ID: <20101023133948.GA2002@sigill.intra.peff.net>
References: <20101022183027.GA12124@sigill.intra.peff.net>
 <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
 <7vocalkf53.fsf@alter.siamese.dyndns.org>
 <20101022231820.GB25520@sigill.intra.peff.net>
 <AANLkTikxMtdvppLur4kuXffRn0G29NFv6ameTpaeY46G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 15:52:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9eW4-0005X7-A4
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 15:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756942Ab0JWNjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 09:39:03 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34378 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422Ab0JWNjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 09:39:01 -0400
Received: (qmail 2662 invoked by uid 111); 23 Oct 2010 13:39:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (65.14.229.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 23 Oct 2010 13:39:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Oct 2010 09:39:48 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikxMtdvppLur4kuXffRn0G29NFv6ameTpaeY46G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159784>

On Sat, Oct 23, 2010 at 11:52:26AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Either way it doesn't matter, since I'm not interested in being a SFC
> liasion. I just want to hack, not deal with issues like these (but
> more power to people who want to).

I didn't mean to pick on you, btw. It's just that I was surprised to se=
e
you, whose first commit was only 6 months ago, in the list of top
contributors by lines of code. You're productive, but not _that_
productive. :)

As it turns out, even though Junio's numbers are doubled, you are in
fact high by line count. It's because of compat/regex:

  $ git log --pretty=3Dformat: --numstat --author=3DBjarmason compat/re=
gex/* |
    perl -ne '/^\d+/ and $total +=3D $&; END { print "$total\n"; }'
  11186

which accounts for 85% of your contribution. :)

> But I think picking people for anything based on the number of lines
> that git-blame thinks people "own" is a bad criteria. My contribution=
s
> to Git are relatively small, but I've happened to pick projects (the
> test suit, gettext) that have touched a lot of lines of code.
>=20
> But other people who've done 10x more work than I have (both in time =
&
> importance) probably have 10x less lines of code assigned to them.

I think counting surviving lines via git-blame is not that bad a metric
for importance. It's certainly better than counting added lines (as I
did above), as it measures lines that people are actually still using.
The problem here is that we have quite large chunks of "uninteresting".
Junio made some attempt to account for this by counting various parts o=
f
the codebase separately. Probably compat/ should have been removed from
the core count (ditto for Marius Storm-Olsen, whose line count is
inflated by importing nedmalloc; which isn't to say that any of these
contributions aren't important. They just aren't the same as sitting
down and writing 10,000 lines of custom git code).

In general, any line count of code (surviving or otherwise) will favor
people who are adding features rather than fixing bugs. I prefer commit
count, where I personally fare much better. :)

One interesting metric to me is the ratio of commit log lines to code
lines. A high ratio implies (to some degree) working on bugfixes, where
the actual changed lines of code are less important than the time you
spend figuring out _which_ lines to change.

You can measure it with something like:

  $ git log  --format=3D'Author: %an%n%w(0,4,4)%B' --numstat --no-merge=
s |
    perl -ne '
      if (/^Author: (.*)/) { $author =3D $1 }
      elsif (/^\s{4}.+/) { $commit{$author}++ }
      elsif (/^\d+/) { $code{$author} +=3D $& }
      END {
        print($commit{$_} / $code{$_}, " $_\n")
          for grep { $code{$_} } keys(%code)
      }
    ' | sort -rn

Of course it has its own set of flaws. One giant feature contribution
can outweight a lot of bugfixes in the average.

-Peff
