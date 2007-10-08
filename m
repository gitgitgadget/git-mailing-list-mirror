From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] Bisect: implement "bisect dunno" to mark untestable revisions.
Date: Mon, 8 Oct 2007 07:34:23 +0200
Message-ID: <200710080734.23878.chriscool@tuxfamily.org>
References: <20071008053450.a52d7c5e.chriscool@tuxfamily.org> <Pine.LNX.4.64.0710080444290.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 07:27:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iel9I-0005rp-Jf
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 07:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbXJHF1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 01:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbXJHF1O
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 01:27:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52721 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbXJHF1O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 01:27:14 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7666E1AB2BE;
	Mon,  8 Oct 2007 07:27:12 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 52C401AB2B9;
	Mon,  8 Oct 2007 07:27:12 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710080444290.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60291>

Le lundi 8 octobre 2007, Johannes Schindelin a =E9crit :
> Hi,
>
> On Mon, 8 Oct 2007, Christian Couder wrote:
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 388887a..c556318 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -143,7 +145,7 @@ bisect_write_bad() {
> >
> >  bisect_good() {
> >  	bisect_autostart
> > -        case "$#" in
> > +	case "$#" in
>
> White space breakage.

The patch tries to fix some white space breakages.

> > @@ -153,7 +155,6 @@ bisect_good() {
> >  		rev=3D$(git rev-parse --verify "$rev^{commit}") || exit
> >  		bisect_write_good "$rev"
> >  		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
> > -
>
> ?

It also removes this unneeded blank line.

> > @@ -164,6 +165,28 @@ bisect_write_good() {
> >  	echo "# good: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
> >  }
> >
> > +bisect_dunno() {
> > +	bisect_autostart
> > +	case "$#" in
> > +	0)    revs=3D$(git rev-parse --verify HEAD) || exit ;;
> > +	*)    revs=3D$(git rev-parse --revs-only --no-flags "$@") &&
> > +		test '' !=3D "$revs" || die "Bad rev input: $@" ;;
> > +	esac
> > +	for rev in $revs
> > +	do
> > +		rev=3D$(git rev-parse --verify "$rev^{commit}") || exit
> > +		bisect_write_dunno "$rev"
> > +		echo "git-bisect dunno $rev" >>"$GIT_DIR/BISECT_LOG"
>
> Should the last line not be put into bisect_write_dunno?  OTOH this i=
s
> the only call site of that function, so I strongly doubt that the
> function (consisting of 3 lines, where the first is 'rev=3D"$1"') is
> necessary at all.

Well, there are "bisect_write_bad" and "bisect_write_good" that already=
 do=20
the same thing as "bisect_write_dunno". In fact I thought that it was=20
better to just copy "bisect_dunno" from "bisect_good"=20
and "bisect_write_dunno" from "bisect_write_good".

If needed I can send another patch to factorise these functions.

> > @@ -206,17 +229,104 @@ bisect_auto_next() {
> >  	bisect_next_check && bisect_next || :
> >  }
> >
> > +search_dunno() {
> > +	_hash=3D"$1"
> > +	_dunno=3D"$2"
> > +
> > +	for _val in $_dunno ; do
> > +		case $_hash in $_val) return 1 ;; esac
> > +	done
>
> This would be faster as
>
> 	case " $1" in " $2") return 1 ;; esac
>
> I guess.

I will try your suggestion and send an updated patch. Thanks.

> But as I said in the other reply, I think this logic belongs into the=
 C
> core, instead of generating mostly useless information, passing it do=
wn
> to the script, and filtering it out again.

Yeah, it's not efficient.

Best regards,
Christian.
