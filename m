From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Tue, 31 Mar 2009 09:11:00 +0200
Message-ID: <20090331071100.GA3307@atjola.homenet>
References: <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com> <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com> <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net> <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org> <20090329215651.GA4355@dcvr.yhbt.net> <7v3acvldc7.fsf@gitster.siamese.dyndns.org> <20090330174151.GA32728@dcvr.yhbt.net> <7vy6umdgxq.fsf@gitster.siamese.dyndns.org> <20090330225834.GA24254@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Anton Gyllenberg <anton@iki.fi>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 09:12:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoY9J-000247-Kn
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 09:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZCaHLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 03:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZCaHLI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 03:11:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:52087 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751345AbZCaHLG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 03:11:06 -0400
Received: (qmail invoked by alias); 31 Mar 2009 07:11:03 -0000
Received: from i59F54235.versanet.de (EHLO atjola.local) [89.245.66.53]
  by mail.gmx.net (mp019) with SMTP; 31 Mar 2009 09:11:03 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX186KHB90no6IAOxyD0zGV7lpWMopu1/RuNHqYyuhl
	YP1qfXywH/lHbX
Content-Disposition: inline
In-Reply-To: <20090330225834.GA24254@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115229>

On 2009.03.30 15:58:34 -0700, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> > > From the ls-tree documentation, I was under the impression that "=
--"
> > > matching "--dashed" was intended:
> > >
> > >   When paths are given, show them (note that this isn't really ra=
w
> > >   pathnames, but rather a list of patterns to match).
> > >
> > > It doesn't make sense to me match like this, either; but I do thi=
nk it
> > > was intended and it will break things if people depend on the
> > > existing behavior.

I guess that paragraph was meant to explain why "git ls-tree HEAD
Documentation" and "git ls-tree HEAD Documentation/" give different
results.  The first one shows the entry for the tree object, while the
second one shows the contents of the tree object. In contrast to "ls"
which would descend into the directory in both cases.

> > Ok, but then the decision to descend into --dashed should be consis=
tent
> > with that policy, no?  Right now, it appears that giving "--" alone=
 says
> > "Anything under --dashed can never match that pattern, so I wouldn'=
t
> > bother recursing into it".
>=20
> Right.  Except in the case when there are multiple files inside --das=
hed/
> as Bj=F6rn's email illustrated.  So there seems to be a bug in the wa=
y
> the number of files inside --dashed/ affects what "--" does when used
> with "--dashed/1" (if --dashed/2 also exists).  Very confusing :x

It's not the number of files that matters. With just one file, you just
don't notice the buggy behaviour, because showing all files is the same
as showing the specified file.

And interestingly, the problem doesn't seem to be in
show_tree/show_recursive, but in match_tree_entry.

With "git ls-tree HEAD gitweb/git-favicon.png g" we descend into gitweb=
/
and at some point we get:

match =3D "g"
base =3D "gitweb/"

And we have:
if (baselen >=3D matchlen) {
	if (strncmp(base, match, matchlen))
		continue;
	/* The base is a subdirectory of a path which was specified */
	return 1;
}

So we return 1 there. The code doesn't do what the comment says, so I
guess we can be pretty sure that the behaviour is not intended.

Bj=F6rn
