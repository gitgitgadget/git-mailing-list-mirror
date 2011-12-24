From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Sat, 24 Dec 2011 08:38:47 -0500
Message-ID: <20111224133847.GA6669@sigill.intra.peff.net>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <CACBZZX6hboo4wu3fOs+CHnxsdmedxw72GFMVttQzmHzpcZbqoQ@mail.gmail.com>
 <87mxaihpiq.fsf@thomas.inf.ethz.ch>
 <CACBZZX67WhcdhXdqOm8gZHW7C3YMbV2KzeytwjHwsnF=8-M_+w@mail.gmail.com>
 <20111224070715.GA32267@sigill.intra.peff.net>
 <CACsJy8DbfE8r3KsxCnb30-sb3LUAAWapAKJUSJ1zBZme1FoMwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 24 14:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReRoi-0003cC-TZ
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 14:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab1LXNiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Dec 2011 08:38:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52106
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898Ab1LXNiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 08:38:52 -0500
Received: (qmail 8342 invoked by uid 107); 24 Dec 2011 13:45:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Dec 2011 08:45:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Dec 2011 08:38:47 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DbfE8r3KsxCnb30-sb3LUAAWapAKJUSJ1zBZme1FoMwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187659>

On Sat, Dec 24, 2011 at 05:55:14PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Sat, Dec 24, 2011 at 2:07 PM, Jeff King <peff@peff.net> wrote:
> > The case where we would most expect the setup cost to be drowned ou=
t is
> > using a more complex regex, grepping tree objects. There we have a
> > baseline of:
> >
> > =C2=A0$ time git grep 'a.*c' HEAD >/dev/null
> > =C2=A0real =C2=A0 =C2=A00m5.684s
> > =C2=A0user =C2=A0 =C2=A00m5.472s
> > =C2=A0sys =C2=A0 =C2=A0 0m0.196s
> >
> > =C2=A0$ time git ls-tree --name-only -r HEAD |
> > =C2=A0 =C2=A0 =C2=A0xargs git grep 'a.*c' HEAD -- >/dev/null
> > =C2=A0real =C2=A0 =C2=A00m10.906s
> > =C2=A0user =C2=A0 =C2=A00m10.725s
> > =C2=A0sys =C2=A0 =C2=A0 0m0.240s
> >
> > Here, we still almost double our time. It looks like we don't use t=
he
> > same pathspec matching code in this case. But we do waste a lot of =
extra
> > time zlib-inflating the trees in "ls-tree", only to do it separatel=
y in
> > "grep".
>=20
> I assume this is gree_tree(), we have another form of pathspec
> matching here: tree_entry_interesting() and it's still a bunch of
> strcmp inside. Does strcmp show up in perf report?

Yes, but not nearly as high. The top of the report is:

  +  32.16%    git  libc-2.13.so        [.] re_search_internal
  +  17.82%    git  libz.so.1.2.3.4     [.] 0xe986
  +   7.81%    git  git                 [.] look_ahead
  +   6.24%    git  libc-2.13.so        [.] __strncmp_sse42
  +   4.08%    git  git                 [.] tree_entry_interesting
  +   3.27%    git  git                 [.] end_of_line
  +   2.63%    git  libz.so.1.2.3.4     [.] adler32
  +   1.93%    git  libz.so.1.2.3.4     [.] inflate

where the strncmps are from[1]:

  -   6.24%    git  libc-2.13.so        [.] __strncmp_sse42
     - __strncmp_sse42
        + 80.92% grep_tree
        + 19.08% tree_entry_interesting

So we're spending maybe 10% of our time on pathspecs, but most of it is
going to zlib and the actual regex search.

-Peff

[1] Note that this is with -O2, so some of that is from inlined calls.
