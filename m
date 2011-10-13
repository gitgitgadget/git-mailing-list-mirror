From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/9] completion: optimize refs completion
Date: Thu, 13 Oct 2011 12:40:47 +0200
Message-ID: <20111013104047.GA15379@goldbirke>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
	<1318085683-29830-3-git-send-email-szeder@ira.uka.de>
	<7v7h497m01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 12:40:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REIid-0004gc-Az
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 12:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab1JMKku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 06:40:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:65502 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab1JMKkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 06:40:49 -0400
Received: from localhost6.localdomain6 (p5B130F07.dip0.t-ipconnect.de [91.19.15.7])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MTrXg-1RefHy189Q-00QW2T; Thu, 13 Oct 2011 12:40:46 +0200
Content-Disposition: inline
In-Reply-To: <7v7h497m01.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:2D4f/SRooj5ozILE19sPfrQGDTkIvIgi0p7ADDBB/+A
 OqhwDBozhNrPZmzfJZghvIQke2VWqW93NIzdZU8pAeZQAFhA6N
 sNHouDdQAvohXQgHn3jZ7PHSCpylhs8E3u7n1DvLuPEOhwZVDG
 PahJVlHRd/JDJjJvQo26/cXaq0wwfAn4ocBY6hsCqIp42UnIT6
 j+n67y0cZvNlJaXyyuNVA1pzPldf7IV7nMQQjJwpVUvu6SKeGo
 3ZSd+1oQTmwuUnMaGnS6QF6fdkDgiI9N4Yu5cEc1ENFcyud1yz
 lupmCZ8Z9DMOZeJQFtUzyFP/dbxfu7CC08ki/TAng2eQE2YK8+
 4S/KVTu9mp8M7X1cK8qw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183465>

On Wed, Oct 12, 2011 at 05:50:38PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > After a unique command or option is completed, in most cases it is =
a
> > good thing to add a trailing a space, but sometimes it doesn't make=
s
>=20
> s/makes/make/;
>=20
> > __gitcomp() therefore iterates over all possible completion words i=
t
> > got as argument, and checks each word whether a trailing space is
> > necessary or not.  This is ok for commands, options, etc., i.e. whe=
n
> > the number of words is relatively small, but can be noticeably slow
> > for large number of refs.  However, while options might or might no=
t
> > need that trailing space, refs are always handled uniformly and alw=
ays
> > get that trailing space (or a trailing '.' for 'git config
> > branch.<head>.').
> > ...
> > So, add a specialized variant of __gitcomp() that only deals with
> > possible completion words separated by a newline and uniformly appe=
nds
> > the trailing space to all words using 'compgen -S' (or any other
> > suffix, if specified), so no iteration over all words is done.
>=20
> s/is done./is needed./;
>=20
> I think I followed your logic (very well written ;-)

Thanks; learned it around here ;)

> but feel somewhat
> dirty, as you are conflating the "These things are separated with new=
lines"
> with "These things do not need inspection --- they all need suffix", =
which
> has one obvious drawback --- you may find other class of words that a=
lways
> want a SP after each of them but the source that generates such a cla=
ss of
> words may not separate the list elements with a newline.

Yes, there are a couple of other places where SP is uniformly needed,
for example completion of subcommands for bisect, notes, stash, etc.,
merge strategies, whitespace options, which are all separated by SP,
or help topics, which are separated by SP, TAB, and NL.  However, it
really is necessary that no SP is used to separate those words, see
below, so we can't use this optimization in these cases.  And since
the number of possible completion words in these cases is usually low,
it doesn't worth the effort to restructure those words to not use SP
separator, because it doesn't really make a performance difference
anyway.

> Because a ref cannot have $IFS whitespace in its name anyway, I think=
 you
> can rename __gitcomp_nl to a name that conveys more clearly what it d=
oes
> (i.e. "complete and always append suffix"), drop the IFS fiddling fro=
m the
> function, and get the same optimization, no?

Unfortunately, this optimization depends on the IFS fiddling, because
we want to append a SP.  The same IFS trick is done in __gitcomp(),
too.  If we use the default IFS containing an SP and append a SP to
possible completion words by 'compgen -S " "' (or by word=3D"$word ", a=
s
in __gitcomp_1()), then that SP will be promply stripped off when
compgen's output is stored in the COMPREPLY array.  Using an IFS
without SP keeps those SP suffixes.  Perhaps I should've mentioned
this explicitly in the commit message, but didn't do so because one of
the referenced commit messages (72e5e989 (bash: Add space after unique
command name is completed., 2007-02-04)) already mentioned it briefly.

But when we use an IFS without SP, that also implies that we can't
pass words separated by SP to __gitcomp_nl(), because those words
won't be split at SPs anymore.  Since refs & co. are separated by NL,
it was the obvious choice for this special-purpose IFS.  So this
optimization can't work with the class of words mentioned above. =20

So I thought that it's important to stress that this function can only
deal with NL separated words, hence I named it __gitcomp_nl().  But I
see your point about naming it after what it actually does, so I'm
fine with __gitcomp_add_suffix() or whatever else that indicates
"complete and always append suffix".

Will resend in a day or two, to leave some time for other suggestions.


Best,
G=E1bor
