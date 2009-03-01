From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: avoid 'git reset' when possible
Date: Sun, 1 Mar 2009 22:57:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903012242180.10279@pacific.mpi-cbg.de>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com> <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302> <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com> <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
 <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302> <7vvdqt8wob.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 23:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdthQ-0005sV-6L
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbZCAVzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 16:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbZCAVzx
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:55:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:53873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753488AbZCAVzw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:55:52 -0500
Received: (qmail invoked by alias); 01 Mar 2009 21:55:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 01 Mar 2009 22:55:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7tPsnk7L7eLoBSENzb0iHGmwqtrOFOgM5SA3u1j
	yzZPAYBaFNN5yp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdqt8wob.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111884>

Hi,

On Sun, 1 Mar 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 3dc659d..a9617a2 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -442,6 +442,27 @@ do_rest () {
> >  	done
> >  }
> >  
> > +# skip picking commits whose parents are unchanged
> > +skip_unnecessary_picks () {
> > +	current=$ONTO
> > +	i=0
> > +	while read command sha1 rest
> > +	do
> > +		test pick = "$command" &&
> > +		test $current = "$(git rev-parse $sha1^)" ||
> > +		break
> > +		current=$(git rev-parse $sha1)
> > +		i=$(($i+1))
> > +	done < "$TODO"
> > +	test $i = 0 || {
> > +		sed -e "${i}q" < "$TODO" >> "$DONE" &&
> > +		sed -e "1,${i}d" < "$TODO" >> "$TODO".new &&
> > +		mv -f "$TODO".new "$TODO" &&
> > +		ONTO=$current ||
> > +		die "Could not skip $i pick commands"
> > +	}
> > +}
> 
> I do not think you have to count and then run two sed.
> 
> 	this=$ONTO
> 	skip_pick=t
> 	while read command sha1 rest
> 	do
> 		sha1=$(git rev-parse "$sha1")
>         	case "$skip_pick,$command" in
>                 t,pick | t,p)
> 			if test "$this" = "$sha1"
>                         then
> 				echo >&3 "$command $sha1 $rest"
>                         	this="$sha1"
> 				continue
> 			fi
> 		esac                        
> 		skip_pick=f
>                 echo "$command $sha1 $rest"
> 	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
> 	...

Or even

	current=$ONTO
	fd=3
	while read command sha1 rest
	do
		case "$fd,$command,$current" in
		3,pick,"$sha1"*|t,p,"$sha1"*)
			current=$sha1
			;;
		*)
			fd=1
			;;
		esac
		echo "$command $sha1 $rest" >&$fd
	done < "$TODO" > "$TODO.new" 3>> "$DONE" &&
	mv "$TODO.new" "$TODO"

Hmm?

Ciao,
Dscho
