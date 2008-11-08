From: Francis Galiegue <fg@one2team.net>
Subject: Re: [RFC] Configuring (future) committags support in gitweb
Date: Sat, 8 Nov 2008 21:02:44 +0100
Organization: One2team
Message-ID: <200811082102.44919.fg@one2team.net>
References: <200811082007.55045.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 21:06:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyu4p-0000I5-C9
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYKHUFU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 15:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYKHUFU
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:05:20 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:47412 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbYKHUFT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 15:05:19 -0500
Received: from erwin.kitchen.eel (unknown [90.63.17.94])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 532AE92C011;
	Sat,  8 Nov 2008 21:05:07 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811082007.55045.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100418>

Le Saturday 08 November 2008 20:07:53 Jakub Narebski, vous avez =E9crit=
=A0:
> Francis Galiegue <fg@one2team.net> writes
> in "Need help for migration from CVS to git in one go..."
>
> > * third: also Bonsai-related; Bonsai can link to Bugzilla by
> > matching (wild guess) /\b(?:#?)(\d+)\b/ and transforming this into
> > http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1. Does gitweb ha=
ve
> > this built-in? (haven't looked yet) Is this planned, or has it been
> > discussed and been considered not worth the hassle?
>
> Here below there is proposal how the committags support could look li=
ke
> for gitweb _user_, which means how to configure gitweb to use (or do =
not
> use) committags, how to configure committags, and how to define new
> committags.
>

Your proposal goes much further than my initial question, but I thought=
 I'd=20
jump in anyway :p

> Committags are "tags" in commit messages, expanded when rendering com=
mit
> message, like gitweb now does for (shortened) SHA-1, converting them =
to
> 'object' view link.  It should be done in a way to make it easy
> configurable, preferably having to configure only variable part, and =
not
> having to write whole replacement rule.
>
> Possible committags include: _BUG(n)_, bug _#n_, _FEATURE(n),
> Message-Id, plain text URL e.g. _http://repo.or.cz_, spam protecting
> of email addresses, "rich text formatting" like *bold* and _underline=
_,
> syntax highlighting of signoff lines.
>

What do you mean with "not having to write whole replacement rule"?

> I think it would be good idea to use repository config file for
> setting-up repository-specific committags, and use whatever Perl
> structure for global configuration. The config language can be
> borrowed from "drivers" in gitattributes (`diff' and `merge' drivers)=
=2E
>
> So the example configuration could look like this:
>
>   [gitweb]
>   	committags =3D sha1 signoff bugzilla
>
>   [committag "bugzilla"]
>   	match =3D "\\b(?:#?)(\\d+)\\b"
>   	link  =3D "http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1"
>
> where 'sha1' and 'signoff' are built-in committags, committags are
> applied in the order they are put in gitweb.committags;

I don't understand what the "signoff" builtin is : is that a link to se=
e only=20
commits "Signed-off-by:" a particular person?

If so, might I suggest that an "alt" tells "Only show commits signed of=
f by=20
this person"?

And also, what about the sha1 builtin? AFAIK, a SHA1 can point to a com=
mit, a=20
tree, and others... In fact, it points to any of these right now, but h=
ow=20
would you tell apart these different SHA1s in a commit message? The onl=
y=20
obvious use I see for it is the builtin "Revert ..." commit message, th=
at the=20
commiter _can_ override...

Or would that be:

my $sha1_re =3D qr/[a-z[0-9]{40}/;

/(?:(?i:commit\s+))?\b($sha1_re)\b/ =3D> [link to commit $1]
/(?:(?i:tree\s+))\b($sha1_re)\b)/ =3D> [link to tree $1]
/(?:(?:tag\s+))\b($sha1_re)\b)/ =3D> [link to tag $1]

=46inally, is there any reason to think that a sha1 or signoff committa=
g will=20
ever need to be overriden in some way?

> possible actions=20
> for committag driver include:
>  * link: replace $match by '_<a href=3D"$link">_$match_</a>_'
>  * html: replace $match by '_$html_'
>  * text: replace $match by '$text'
> where '_a_' means that 'a' is treated as HTML, and is not expanded
> further, and 'b' means that it can be further expanded by later
> committags, and finally is HTML-escaped (esc_html).
>

What use do you see for the html match? Just asking...

And I don't see what you '_a_' and '_b_' are about...

--=20
fge
