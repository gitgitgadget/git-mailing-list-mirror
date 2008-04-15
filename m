From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] bisect: warn if given dubious tag or branch as rev
Date: Tue, 15 Apr 2008 09:05:14 +0200
Message-ID: <200804150905.15053.chriscool@tuxfamily.org>
References: <20080414054151.52e55e7f.chriscool@tuxfamily.org> <7vabjw810v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 09:00:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlf9w-0008Ax-D5
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 09:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYDOHAD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 03:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbYDOHAD
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 03:00:03 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:59435 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbYDOHAA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 03:00:00 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4D19F1AB2F2;
	Tue, 15 Apr 2008 08:59:59 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 097731AB2CE;
	Tue, 15 Apr 2008 08:59:58 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vabjw810v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79572>

Le mardi 15 avril 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This patch refactors rev parsing code in a new "bisect_parse_rev"
> > function, and adds warnings in case a rev with a name that is the
> > same as one of the bisect subcommands is given where a revision
> > is expected.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  git-bisect.sh               |   47
> > ++++++++++++++++++++++++++++++------------ t/t6030-bisect-porcelain=
=2Esh
> > |   21 +++++++++++++++++++
> >  2 files changed, 54 insertions(+), 14 deletions(-)
> >
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 6b43461..a090b97 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -61,6 +61,31 @@ bisect_autostart() {
> >  	}
> >  }
> >
> > +bisect_parse_rev() {
> > +	rev=3D"$1"
> > +	dont_die_on_wrong_rev=3D"$2"
> > +	name=3D"$rev^{commit}"
> > +	dubious_rev_name=3D''
> > +
> > +	case "$rev" in
> > +	HEAD)
> > +		name=3D'HEAD' ;;
> > +	help|start|bad|good|skip|next|reset|visualize|replay|log|run)
> > +		dubious_rev_name=3D'yes' ;;
> > +	esac
>
> I see you listed all the subcommand names here but I somehow doubt th=
is
> is sensible.
>
> The "bisect good $foo bad $bar" example from Ingo's transcript may
> suggest that good/bad may incorrectly appear by copying and pasting f=
rom
> an incorrect how-to guide,

Yes, and there are also some "git bisect start good $foo bad $bar" in h=
is=20
transcript. So perhaps we should warn only on "bad" good" and maybe "sk=
ip".

> but on the other hand "bisect bad log" to mark=20
> the tip of the "log" branch (or "replay or any other common words) to=
 see
> where in the development trail on that branch things got broken is a
> perfectly valid and plausible thing to do.  Also when you happen to h=
ave
> found something broken while you are working on a more important issu=
e,
> you may tentatively do "git tag bad $it", and keep working on that
> important issue, only to come back later and use that lightweight tag=
 to
> feed "git bisect" with.  In either use case, "you named your ref the =
same
> as bisect subcommand name, bad boy" is an unnecessary noise.

I think Ingo uses git and git bisect very often, and still he made mist=
akes=20
that could have resulted in unwanted behavior with nothing to help=20
understand what happened, if he had tags or branches named "good" or "b=
ad".

So it's not for "bad boys" or forcing good naming, but really preventin=
g=20
mistakes.

In bisect_autostart we also have:

		echo >&2 'You need to start by "git bisect start"'
		if test -t 0
		then
			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
			read yesno
			case "$yesno" in
			[Nn]*)
				exit ;;
			esac
			bisect_start
		else
			exit 1
		fi

to make sure that the users know what happens, and help them do what th=
ey=20
want. If you prefer I can add something like the above to make sure tha=
t=20
the user knows what he is doing.

Thanks,
Christian.
