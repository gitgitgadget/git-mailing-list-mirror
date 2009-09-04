From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: tracking branch for a rebase
Date: Fri, 4 Sep 2009 20:59:49 +0200
Message-ID: <20090904185949.GA21583@atjola.homenet>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 21:00:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mje0x-0004wn-M1
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 21:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180AbZIDS7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 14:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757166AbZIDS7x
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 14:59:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:40972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757165AbZIDS7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 14:59:53 -0400
Received: (qmail invoked by alias); 04 Sep 2009 18:59:54 -0000
Received: from i59F54DAD.versanet.de (EHLO atjola.homenet) [89.245.77.173]
  by mail.gmx.net (mp038) with SMTP; 04 Sep 2009 20:59:54 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19SWh4pEXdSmrDASQKaf9AZqvMuQM2daQBLa3oJ66
	fT4JMW8MUxckVx
Content-Disposition: inline
In-Reply-To: <20090904181846.GC19093@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127760>

On 2009.09.04 14:18:46 -0400, Jeff King wrote:
> On Fri, Sep 04, 2009 at 04:31:57PM +0200, Michael J Gruber wrote:
>=20
> > Making [rebase against upstream] the default for rebase without
> > arguments may meet some objections (oh no, I didn't mean to rebase)=
,
> > but I guess it's worth trying.
>=20
> FWIW, that has been a patch I have been meaning to do for a while. I
> don't see it as any more error-prone than "git pull" without argument=
s.
> In either case, you can always recover with a reset from the reflog.

Note that with:
	branch.foo.remote =3D origin
	branch.foo.merge =3D refs/heads/foo

"git pull --rebase" is not the same as:
"git fetch origin && git rebase origin/foo", but:

git fetch origin && git rebase --onto origin/foo $reflog_merge_base

Where $reflog_merge_base is the first merge base is found between the
current branch head, and the reflog entries for origin/foo.


Same deal for "git pull --rebase origin bla", which is not:
"git fetch origin bla && git rebase FETCH_HEAD", but:

git fetch origin && git rebase --onto FETCH_HEAD $reflog_merge_base

Where again $reflog_merge_base is found by looking at the reflog for
origin/foo.

It does that to try to automatically handle cases where upstream has
been rebased. I'm not completely sure whether I like or hate that.
Especially the "git pull --rebase <remote> <refspec>" case seems very
weird to me. And if "rebase" is to pickup the same default as "pull", I
guess it should also show the same behaviour, but just skips the "fetch=
"
part?

> The biggest question is whether it should respect branch.*.merge, or
> just branch.*.rebase (I never use the latter simply because I never u=
se
> "git pull", but I think it is probably reasonable to restrict it to
> cases where you said you are interested in rebasing in general).

Hm, you'll probably want "git merge" to pickup the default as well then=
,
right? And that should only do so if branch.*.rebase is not set. So
effectively, you still have to use the right command, but can skip the
argument. Having to deal a lot with git-svn, I also regulary use its
"git svn rebase --local", which means "just rebase, don't fetch".

Now, basically "git svn rebase" is pretty much git-svn's "pull". Maybe
its idea could be taken, so we get "git pull --local" to just skip the
fetch part, but keep "git rebase" and "git merge" 'dumb', requiring
explicit arguments.

(In the past, I once argued for deprecating "pull", and having
merge/rebase doing the fetch as well, with a --local argument that stop=
s
them from doing so. That was probably mostly due to the fact that I ran
into too many people that simply didn't understood that "git pull" is
not "svn up". I still kind of like the idea, but seeing just how often =
I
use rebase/merge with already fetched stuff, I can see how having to us=
e
a --local flag with them all the time would be quite a PITA, but now,
having the --local flag for "pull" seems to make sense to me.)

Bj=F6rn
