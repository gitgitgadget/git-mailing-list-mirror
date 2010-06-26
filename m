From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Sat, 26 Jun 2010 02:13:05 -0400
Message-ID: <20100626061305.GB10290@coredump.intra.peff.net>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
 <1277418881-11286-1-git-send-email-avarab@gmail.com>
 <7v1vbvkorf.fsf@alter.siamese.dyndns.org>
 <AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
 <7v1vbukcu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:13:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOdl-00055k-Ht
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab0FZGNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 02:13:12 -0400
Received: from peff.net ([208.65.91.99]:55815 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab0FZGNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:13:12 -0400
Received: (qmail 8579 invoked by uid 107); 26 Jun 2010 06:14:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 26 Jun 2010 02:14:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jun 2010 02:13:05 -0400
Content-Disposition: inline
In-Reply-To: <7v1vbukcu8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149727>

On Fri, Jun 25, 2010 at 02:43:27PM -0700, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > On Fri, Jun 25, 2010 at 17:25, Junio C Hamano <gitster@pobox.com> w=
rote:
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >>
> >>> Before the change error messages were drowned out by git-fetch's
> >>> non-error update notices, which didn't need my attention.
> >>
> >> I don't understand this part; care to elaborate?
> >
> > I have a cron job (github-backup) that calls git fetch. Without thi=
s
> > patch I have to run it as '> /dev/null 2>&1' and just rely on the e=
xit
> > code,
>=20
> Signaling failure with exit code is _the_ standard practice, no?
>=20
> Some people seem to think unclean standard error means some error (mo=
st
> notably tcl ;-), but I think they are mistaken.

Agreed. I thought it was intentional for any human-readable progress
messages go to stderr. It is true in the case of git-fetch that stdout
is not being used for anything, but:

  1. Git should be consistent about where output goes. And other
     programs may actually produce useful output on stdout, which shoul=
d
     not be mixed with human-readable verbose messages. For the sake of
     those programs, we should be consistent about sending the output t=
o
     stderr.

  2. Fetch may be combined with other operations in script. Consider
     this toy script to print the latest origin/master to stdout:

       #!/bin/sh
       git fetch && git rev-parse origin/master

     The user sees verbose cruft on stderr, but the interesting part is
     on stdout. With your patch, the script is now broken. Yes, it's
     obviously a toy, but I don't think it inconceivable that somebody
     would not want fetch unexpectedly polluting their stdout. Even if
     it would have been a better behavior in the first place (which I
     don't agree with), changing it now means breaking scripts.

The real problem is that git is very chatty compared to other unix
programs. Most produce no output at all unless there is an error, or
human-readable non-error output on stderr only if it is a tty. We do
this already with progress meters, and this output is just another form
of progress update. So I think a patch to quell the status table when
stderr is not a tty would be better (that still can break some scripts,
too, but I am less sympathetic to people trying to save and parse
human-readable stderr messages).

Or even easier: is there a reason that "git fetch -q" would not do what
you (=C3=86var) want?

-Peff
