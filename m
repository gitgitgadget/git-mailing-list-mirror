From: Jeff King <peff@peff.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Wed, 9 Feb 2011 16:03:12 -0500
Message-ID: <20110209210312.GB2083@sigill.intra.peff.net>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net>
 <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <20110207195035.GA13461@sigill.intra.peff.net>
 <20110208100518.GA9505@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Feb 09 22:03:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnHC7-0007I3-RQ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 22:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab1BIVDT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 16:03:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43263 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab1BIVDS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 16:03:18 -0500
Received: (qmail 12657 invoked by uid 111); 9 Feb 2011 21:03:16 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 09 Feb 2011 21:03:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Feb 2011 16:03:12 -0500
Content-Disposition: inline
In-Reply-To: <20110208100518.GA9505@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166442>

On Tue, Feb 08, 2011 at 11:05:18AM +0100, SZEDER G=C3=A1bor wrote:

> > I think even the same people may different preferences from project=
 to
> > project. For most of my projects, the scope of the repo is well-def=
ined,
> > and I want full-tree semantics (e.g., I hack on a bug, go into t/ t=
o
> > tweak and run the tests, and then want to "git add -u" the whole th=
ing
> > when everything looks good). But I also recently worked on a gigant=
ic
> > project that was split into several sub-components. I would cd 3 or=
 4
> > levels deep into the sub-component that I was working on, and I wou=
ld
> > prefer my "git add -u" to stay in that sub-component, and my "git g=
rep"
> > to look only in that sub-component.
>=20
> It sounds like your work focused solely on the sub-component you cd-d
> into.  Did you have any other changes outside of that sub-component?
> Because when not, then both the current and the whole-tree "git add -=
u"
> would have the same effect.

Yes, I often did have other changes. They were usually one of two types=
=2E
The build infrastructure was in a separate directory, so one type would
be local tweaks to the build that should not end up getting committed.
The other type was required changes to another component that would get
committed separately (e.g., while working on component "foo" you realiz=
e
that it depends on a new feature in component "bar"; you leave "foo"
modified in the working tree, work on "bar", commit it, then come back
to "foo").

> The current and the whole-tree "git grep" would behave differently, o=
f
> course.  But even then a whole-tree "git grep" would be harmless and
> easy to limit in scope, though might be a bit annoying in the "cd dee=
p
> down" case.  In that case you would immediately see the matches
> outside of cwd, know that you forgot to limit the operation to cwd, s=
o
> you hit the up key, simply append the "." to the last command, and yo=
u
> get what you wanted.

Yeah, grep is not as annoying because it does not have the "oops, I jus=
t
pushed this commit and it turns out that I screwed up "git add" five
minutes ago and it only had half of the files I intended" problem.

> As mentioned in this or other related threads, this is not at all tha=
t
> simple the other way around, i.e. with current "git grep" when you ar=
e
> in the sub-component and you happen to need a grep on the whole tree,
> because you have to pay attention to use the right number of "../"s.

Yes, it is annoying, but that is merely a syntactic issue. If we aliase=
d
"/" to "the root of the project", then most arguments for full-tree
could be reversed for the relative case (e.g., "sure, but it's easy
enough to type 'git add /'").

=46or the record, I would much prefer full-tree behavior as the default=
,
and I think the '/' syntax is ugly and confusing. If you were asking at
the beginning of "git add -u" what the behavior should be, I would
absolutely say full-tree. But we're not there; we're talking about
changing existing behavior. And I'm not sure there is a clear-cut,
obvious-to-anybody-who-will-annoyed-with-the-change argument that
full-tree behavior is definitively better.

The most compelling I have seen is "you tend to notice accidental
full-tree sooner than accidental relative behavior". Which you mentione=
d
in your email. I just don't know if that passes the "will satisfy
annoyed users" test.

I dunno. I would not be sad at all if we moved to full-tree defaults
everywhere. I just don't want to have to be the one that annoyed users
yell at. :)

-Peff
