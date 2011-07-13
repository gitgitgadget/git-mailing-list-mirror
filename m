From: Jeff King <peff@peff.net>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Wed, 13 Jul 2011 15:07:24 -0400
Message-ID: <20110713190724.GA31965@sigill.intra.peff.net>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie>
 <7vpqlgbjmd.fsf@alter.siamese.dyndns.org>
 <20110711221419.GE30155@sigill.intra.peff.net>
 <CALkWK0n41LZ8-ZU2M1oD_ddJ2g2A47MxuO8w+5Ew6Php8gvF+g@mail.gmail.com>
 <20110712064706.GA13375@sigill.intra.peff.net>
 <CALkWK0=EDZ9E1qYg=bEt2h3jmUUvERoiR1TpkUupRO2XrYyt9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Miles Bader <miles@gnu.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 21:07:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh4mS-0006Bk-7D
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 21:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806Ab1GMTH1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 15:07:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44774
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab1GMTH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 15:07:26 -0400
Received: (qmail 27660 invoked by uid 107); 13 Jul 2011 19:07:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 15:07:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 15:07:24 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=EDZ9E1qYg=bEt2h3jmUUvERoiR1TpkUupRO2XrYyt9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177069>

On Wed, Jul 13, 2011 at 03:11:54PM +0530, Ramkumar Ramachandra wrote:

> Ha, true.  After all .git/objects/ is "polluted" with lots of files :=
p
> A couple of questions arise:
> 1. Would opening, writing, closing many files not put too much strain
> on I/O, and hence affect performance significantly?

In a tight loop, perhaps. At the begining of invoking a program,
probably not. We're talking about what, a dozen or so files?

If you have doubts, then measure.

> 2. Will two options from different instructions (when we extend the
> instruction sheet to accommodate them) have the same name, but
> different effects?  Having a gitconfig-like configuration file doesn'=
t
> solve this problem either, so it's not a "configfile versus key-value
> store" question.

If you have per-instruction options, then I think you would want your
storage of options to be per-instruction. Whether it's a config file or
files in a directory, you'd want to be accessing ".../opts/$hash" as a
config file (or ".../opts/$hash/*" for a directory).

But I have only been paying a little attention to the deeper parts of
this topic, so I may be misunderstanding what you're asking.

> > Using git-config is maybe a little more self-documenting than somet=
hing
> > like "sq_quote_argv". And probably not much more code (maybe even l=
ess,
> > since it can handle the file update for you).
>=20
> Yeah :)

One other advantage of "git config" over sq_quote_argv is that it is
fairly transparent to outside programs. You can just say "git config
--file=3D.git/sequencer/opts --get-all strategy" or whatever.

That transparency is one of the things I liked about the "files in a
directory" approach taken by rebase currently. But given that the "git
config" command exists, they are probably equivalent in that respect.

> > I recently used the config code to write out a non-standard config =
file.
> > My two complaints were:
> >
> > =C2=A01. You can't queue up a bunch of changes and then write the f=
ile once.
> > =C2=A0 =C2=A0 Every time you call git_config_set, it rewrites the w=
hole file.
> >
> > =C2=A02. There's no way to write to a nonstandard file short of the=
 horribly
> > =C2=A0 =C2=A0 hack-ish:
> >
> > =C2=A0 =C2=A0 =C2=A0 const char *saved =3D config_exclusive_filenam=
e;
> > =C2=A0 =C2=A0 =C2=A0 config_exclusive_filename =3D "foo.conf";
> > =C2=A0 =C2=A0 =C2=A0 git_config_set(...);
> > =C2=A0 =C2=A0 =C2=A0 config_exclusive_filename =3D saved;
> >
> > Point (2) is pretty easy to fix. But point (1) might be a bit more
> > involved. I haven't really looked yet.
>=20
> Thanks for pointing these out.  Yes, I'm aware of these issues, and
> it's part of the reason I implemented my own parser.  It'll take some
> time to refactor config.c so that it's usable by others in a sane
> manner, no?  What do you suggest I do until then?  Can I try to get m=
y
> custom parser merged (and replaced by a more generic configparser whe=
n
> it's ready), or should I throw away my parser and go with the
> key-value store?

I think a reasonable strategy is:

  1. Refactor git_config_set into git_config_set_in_file with a file
     argument (and make git_config_set a wrapper that uses the current
     file-selection). This should be easy to do.

  2. Ignore the fact that you are writing the file multiple times. It's
     not a correctness issue, but rather an optimization. If and when
     the config code shows itself to be too slow, then we can do that
     optimization (which will benefit not just your code, but all confi=
g
     writers).

And then throw away your parser and just use git_config_from_file and
git_config_set_in_file.

Between config and a key/value store of files, I think it is largely a
matter of taste.

> Just to clarify, here's an example to illustrate what I understand
> when you say key-value store (please correct me if I got the idea
> wrong):
> .git/sequencer/opts/ will have files like:
> $ cat ff
> true
> $ cat record-origin
> true
> $ cat mainline
> 1
> $ cat strategy
> ours
> $ cat strategy-option
> patience + renormalize

Yeah, exactly. Though I would probably use "\n" to split list items in
strategy-options, which is a little more traditional. I.e.,:

  $ cat strategy-option
  patience
  renormalize

-Peff
