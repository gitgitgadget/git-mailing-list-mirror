From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 14:19:45 +0100
Message-ID: <20091209131945.GB30218@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <20091208160822.GA1299@atjola.homenet>
 <20091208161406.GB32045@redhat.com>
 <20091208163737.GA2005@atjola.homenet>
 <20091208164449.GA32204@redhat.com>
 <20091208191107.GA4103@atjola.homenet>
 <20091208200017.GA827@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 14:19:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIMSR-0002NI-Ds
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 14:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbZLINTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 08:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755539AbZLINTn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 08:19:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:46101 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755489AbZLINTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 08:19:42 -0500
Received: (qmail invoked by alias); 09 Dec 2009 13:19:47 -0000
Received: from i59F5468C.versanet.de (EHLO atjola.homenet) [89.245.70.140]
  by mail.gmx.net (mp034) with SMTP; 09 Dec 2009 14:19:47 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19w8vgVroZwjuvQmGMNhcwE9GKDjinOJn86mBoDQg
	JoP6huM/Sx3cwl
Content-Disposition: inline
In-Reply-To: <20091208200017.GA827@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134965>

On 2009.12.08 22:00:17 +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 08, 2009 at 08:11:07PM +0100, Bj=F6rn Steinbrink wrote:
> > So you can already do what you want to do, but wrapping it in a sin=
gle
> > porcelain might still be useful because it's obviously a  lot easie=
r and
> > safer that way. That said, I wonder what kind of workflow you're us=
ing
> > though, and why you require that feature. I've never needed somethi=
ng
> > like that.
>=20
> I need this often for many reasons:
> -	Imagine developing a patchset with a complex bugfix on master branc=
h.
> 	Then I decide to also apply (backport) this patchset to stable branc=
h.

Hm, I'd also imagine that you want a separate branch then, and not
directly mess up the stable branch, so I'd do:
git branch foo-stable foo # Create a branch for the backport
git rebase --onto stable master foo-stable # Backport

Now you got your backported version and can merge it to "stable".

Common wisdom is do things the other way around though. Create the
bugfix for the oldest branch that it applies to, then merge it forward,
either doing:

"bugfix -> stable" and "stable -> master" merges, or
"bugfix -> stable" and "bugfix -> master" merges.

That approach has the advantage that you don't get multiple commits
doing the same thing, which you get with rebasing/cherry-picking.

IIRC the gitworkflows manpage describe that in some more detail.

> -	Imagine developing a bugfix/feature patchset on master branch.
> 	Then I decide the patchset is too large/unsafe and want to
> 	switch it to staging branch.

Hm, so you have a topic branch "foo" based upon master, but it's too
experimental so you don't want to merge it to master, but "staging". I
don't see why you even have to rebase it then. "staging" is likely ahea=
d
of master, so the merge base of "foo" and "master" is also reachable
through "staging", and simply merging "foo" to "staging" should work
without any ill-effects.

> -	I have a large queue of patches on staging branch, I decide that
> 	a range of patches is mature enough for master.

Basically, same deal as with the first two cases. If the series is
directly on "staging" (i.e. you didn't create a topic branch), you can
create one now:
git branch foo $last_commit_for_foo
git rebase --onto master $first_commit_for_foo^ foo

And you got your backported topic branch for "foo".

Or you already have a topic branch "foo-staging", but it's based upon
some commit only in "staging" but not in "master", so a plain merge
would mess things up. Same deal as with backporting from "master" to
"stable"

And in this case it's also true that basing the topic branches on
"master" instead of "staging" makes things easier. That way, you can
merge to either "staging" or "master" without any ill-effects.

Bj=F6rn
