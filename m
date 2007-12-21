From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-commit: add --verbatim to allow unstripped commit
	messages
Date: Fri, 21 Dec 2007 01:14:49 +0100
Message-ID: <20071221001449.GA10607@atjola.homenet>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <20071220233324.GB3052@steel.home> <alpine.LFD.0.9999.0712201545450.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 01:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5VXs-0001Eq-MI
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 01:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbXLUAOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 19:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbXLUAOy
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 19:14:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:48621 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751142AbXLUAOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 19:14:54 -0500
Received: (qmail invoked by alias); 21 Dec 2007 00:14:50 -0000
Received: from i577B9A5D.versanet.de (EHLO localhost) [87.123.154.93]
  by mail.gmx.net (mp006) with SMTP; 21 Dec 2007 01:14:50 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19GAo0pIZ9GauNWkeWABUrgFOhhbR2c0PGtaYpduk
	2fdpX/h/IkIZm2
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712201545450.21557@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69032>

On 2007.12.20 15:55:18 -0800, Linus Torvalds wrote:
>=20
>=20
> On Fri, 21 Dec 2007, Alex Riesen wrote:
> >=20
> > Yes, I afraid I need both. I use "git commit -t" almost (submission=
 in
> > perforce takes careful planning) every day. I also would like to ke=
ep
> > the empty leading and trailing lines (perforce default GUI P4Win do=
es
> > not show them, but our scripts which check the descriptions will te=
st
> > the description text according to template which does have trailing
> > empty lines).
>=20
> Hmm. I think your updated patch was pretty good, although I still thi=
nk it=20
> could be improved a bit. In particular, thinking more about it, I thi=
nk we=20
> have more than an "on/off" switch - we really have three cases:
>=20
>  a) strip whitespace _and_ comments
>  b) strip unnecessary whitespace only
>  c) leave things _totally_ alone
>=20
> and on top of that we also have the issue of an editor.
>=20
> So my patch basically said that in the absense of an editor, we'll st=
ill=20
> clean up whitespace, but not comments (ie "no_edit" implies doing (b)=
=20
> rather than (b)), while your patch basically results in (c) regardles=
s of=20
> whether we run an editor or not.
>=20
> But that still leaves one case: do we ever want to do (b) even *if* w=
e use=20
> an editor? There's another possible choice: our old behaviour of (a) =
in=20
> the presense of an editor is now gone.
>=20
> Now, that last choice (ie "case (a) without an editor") is not only=20
> unlikely to be anything people want to do anyway, it's also easy enou=
gh to=20
> do by just using "git stripspace -s" on whatever non-editor thing you=
 feed=20
> to "git commit", so I don't think we need to worry about that one.
>=20
> But the "maybe you want to run an editor, and you _do_ want case (b)"=
=20
> sounds like a case that is not at all unlikely. I could easily see th=
e=20
> case where you want to have a template that uses '#', and *despite* t=
hat=20
> you want to (a) allow the user to edit things _and_ (b) clean up=20
> whitespace too.
>=20
> So I'd almost suggest you make the "--verbatim" flag a three-way swit=
ch,=20
> to allow "totally verbatim" (leave everything in place) and a "don't =
touch=20
> comments" (just fix up whitespace) mode.
>=20
> Hmm? Does that make sense to you?

Hm, this is a bit more intrusive, but should catch most cases.

At the top of the comments in the commit message template add:
#GIT CUT HERE
(And adjust the descriptive text)

That line hopefully being uncommon enough to not affect any existing
stuff.

If that line is present, comment lines above it are kept, otherwise
they're removed. Whitespace is always fixed(?).

Results:
 - git commit -m "# Foo and bar"
   * keeps the comment, looks like the expected thing

 - git commit with editor
   * Comments that are manually added are kept
   * For the (probably seldom) case, that you want manually added
     comments to be stripped, you can still remove the "#GIT CUR HERE"
     line

 - git commit with template
   * The existing templates probably won't have a "#GIT CUT HERE" line,
     so we're backwards compatible
   * Templates that want to keep the comments can simple get a "#GIT CU=
T
     HERE" line at the end and Just Work, regardless of whether or not
     you forget to pass --verbatim.


Hmm?

thanks,
Bj=F6rn
