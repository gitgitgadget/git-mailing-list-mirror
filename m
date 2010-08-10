From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: 'git stash list' vs. non-default 'log.date' setting
Date: Tue, 10 Aug 2010 17:40:56 +0200
Message-ID: <20100810154056.GA4252@neumann>
References: <20100809104056.GJ4612@neumann>
	<7vbp9b96cm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 17:41:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiqws-0005XB-8y
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 17:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206Ab0HJPlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 11:41:00 -0400
Received: from francis.fzi.de ([141.21.7.5]:2674 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932157Ab0HJPk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 11:40:59 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 10 Aug 2010 17:40:56 +0200
Content-Disposition: inline
In-Reply-To: <7vbp9b96cm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 10 Aug 2010 15:40:56.0979 (UTC) FILETIME=[6CB41630:01CB38A2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153121>

Hi,


On Mon, Aug 09, 2010 at 08:02:49AM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > Fortunately, fixing 2) is a no-brainer:
>=20
> I don't think it is a "no-brainer" to "fix" it, even though it may be=
 so
> to hack it around.  Having to give "--date=3Ddefault" to "git log -g"=
 to
> cause it to show reflog entries in non-date format sounds like a terr=
ible
> UI bug to me.  I'd expect
>=20
>     $ git log -g --date=3Ddefault
>=20
> to give you the logs in the default date format, overriding log.date

Indeed.  I was just trying to get back the old behavior quickly and
with minimal effort, and didn't think about what the default date
format should actually mean.

> and perhaps either of these
>=20
>     $ git log -g --no-date
>     $ git log -g --date=3Dno
>     $ git log -g --numbered
>=20
> to countermand log.date and force it to show numbered entries.

It never occured to me before that that number in @{<num>} in reflogs
is actually kind of a date format.  But since it seems to be the case,
a dedicated --date=3D<whatever> option for this format might be good to
have, although I don't think that this date format would be applicable
to regular logs.

> I _think_ "git log -g" uses a hacky heuristics to choose between date=
/number
> based on how you give the stating ref.  I personally do not like this=
 dwim
> very much, but it seems to be stable and established by now, so it ma=
y be
> a good thing to use here instead:
>=20
>     $ git log -g refs/stash@{0}
>     $ git log -g refs/stash@{now}

I see the DWIMery in this case, but 'git stash list' uses
reflog-specific format specifiers to generate the list of stashes:

    git log --format=3D"%gd: %gs" -g "$@" $ref_stash --

and unfortunately the %gd (and %gD) format specifier performs this
DWIMery only when log.date is not set, otherwise log.date takes over:

    $ git config --get log.date
    $ git log --format=3D"%gd: %gs" -g refs/stash@{0}
    stash@{0}: On master: foo
    $ git log --format=3D"%gd: %gs" -g refs/stash@{now}
    stash@{2010-08-09 17:41:37 +0200}: On master: foo
    $ git config log.date iso8601
    $ git log --format=3D"%gd: %gs" -g refs/stash@{0}
    stash@{2010-08-09 17:41:37 +0200}: On master: foo
    $ git log --format=3D"%gd: %gs" -g refs/stash@{now}
    stash@{2010-08-09 17:41:37 +0200}: On master: foo


Best,
G=E1bor
