From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 12/12] Add git-check-ignore sub-command
Date: Mon, 17 Dec 2012 00:10:13 +0000
Message-ID: <20121217001013.GB3673@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-12-git-send-email-pclouds@gmail.com>
 <7vlif7v03r.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9g6rNiv7nnTu2i34dbn_z7r5SmhDuxief7iEQLVxtO5g@mail.gmail.com>
 <7vmwzmtmyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 01:10:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkOI1-0001AV-4o
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 01:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab2LQAKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2012 19:10:18 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41519 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab2LQAKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 19:10:17 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 36F502E5D5
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 00:10:15 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vmwzmtmyd.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211619>

On Tue, Oct 16, 2012 at 09:12:58AM -0700, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> > On Mon, Oct 15, 2012 at 3:31 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
> >> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> wri=
tes:
> >>> +For each pathname given via the command-line or from a file via
> >>> +`--stdin`, this command will list the first exclude pattern foun=
d (if
> >>> +any) which explicitly excludes or includes that pathname.  Note =
that
> >>> +within any given exclude file, later patterns take precedence ov=
er
> >>> +earlier ones, so any matching pattern which this command outputs=
 may
> >>> +not be the one you would immediately expect.
> >>
> >> "The first exclude pattern" is very misleading, isn't it?
> >
> > I don't think so, because of the second sentence.
> >
> >> For example, with these in $GIT_DIR/info/exclude, I would get:
> >>
> >>         $ cat -n .git/info/exclude
> >>           1 *~
> >>           2 Makefile~
> >>         $ git check-ignore -v Makefile~
> >>         .git/info/exclude:2:Makefile~   Makefile~
> >>
> >> which is the correct result (the last one in a single source decid=
es
> >> the fate of the path), but it hardly is "first one found" and the
> >> matching pattern in the output would not be something unexpected f=
or
> >> the users, either.
> >>
> >> The reason it is "the first one found" is because the implementati=
on
> >> arranges the loop in such a way that it can stop early when it fin=
ds
> >> a match---it simply checks matches from the end of the source.
> >>
> >> But that is not visible to end-users,
> >
> > Correct; that's precisely why I wrote the second sentence which
> > explicitly explains this.
> >
> >> and they will find the above description just wrong, no?
> >
> > It's not wrong AFAICS, but suggestions for rewording this more clea=
rly
> > are of course welcome.  Maybe s/immediately/intuitively/ ?
>=20
> I think this is sufficient:
>=20
> 	For each pathname given via the command-line or from a file
> 	via `--stdin`, show the pattern from .gitignore (or other
> 	input files to the exclude mechanism) that decides if the
> 	pathname is excluded.
>=20
> and without "Note that" at all.

I don't think this is quite sufficient.  Firstly, it does not cover
negated patterns (my original text contained "or includes").

Secondly, I think there is still potential for this rewording to
result in confused users.  If the "backwards-ness" of the internal
algorithm is kept hidden from them, then in your example above, most
users would be more likely to intuitively expect check-ignore to
return the first line of .git/info/exclude ("*~").  When they saw it
returning the second, they might draw the conclusion that the first
line failed to match (e.g. by mistakenly thinking that the file format
requires regular expressions rather than globs), rather than that git
starts at the end of the file.

This is precisely why I chose not to hide this aspect of the
implementation when initially writing this documentation.
Unfortunately my wording managed to confuse several of you, so clearly
it was not adequate.  Therefore I propose an extension of your
version:

	For each pathname given via the command-line or from a file
	via `--stdin`, show the pattern from .gitignore (or other
	input files to the exclude mechanism) that decides if the
	pathname is excluded or included.  Later patterns within a
	file take precedence over earlier ones.
