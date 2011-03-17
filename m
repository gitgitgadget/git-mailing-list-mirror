From: Jeff King <peff@peff.net>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 02:38:16 -0400
Message-ID: <20110317063816.GD11931@sigill.intra.peff.net>
References: <4D8119BE.2090208@workspacewhiz.com>
 <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 07:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q06qn-0007AC-8Y
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 07:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab1CQGiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 02:38:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56440
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab1CQGiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 02:38:19 -0400
Received: (qmail 20635 invoked by uid 107); 17 Mar 2011 06:38:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 02:38:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 02:38:16 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169212>

On Thu, Mar 17, 2011 at 01:21:19AM -0400, Jay Soffian wrote:

> > Git doesn't support distribution of a merge (although that would be
> > extraordinarily cool), so the next best thing seemed to be force ad=
ding all
> > files with conflict markers and then committing the merge. =C2=A0We=
 then publish
> > the conflicting branch and have each person fix their files. =C2=A0=
Given that the
> > conflict markers are already in place, they can't use their favorit=
e
> > graphical merge tool.
>=20
> Well, this is awful, but you could do something like:
>=20
> for x in conflicted_files:
>    git show :1:$x > $x.base
>    git show :3:$x > $x.theirs
>    git checkout --ours $x
>    git add $x.base $x.theirs $x
>=20
> Commit that, then folks can use their favorite merge tools, commit th=
e
> result, and remove the .base and .theirs.

I don't think you need to do anything so drastic. You can just have
everybody do the partial merge, commit, and then push their result.  An=
d
then as you suggest below, one person does the real merge, uses checkou=
t
to install the desired result state from each person's partial tree, an=
d
then everybody throws away their partial merges.

The trick is that each person will resolve some conflicts and commit,
but you need to know which ones they resolved. They can't leave things
unmerged in the final commit. So they would have to provide such a list
to you; one way is in the commit message[1].

So let's say you have three devs, Alice, Bob, and Charlie, and one
integrator, Matt, who will do the merge. Each of the developers does:

  git checkout -b partial-merge
  git merge old-topic
  git mergetool ;# or manually resolve and git add

Eventually they get tired of the conflicts and give up. So they record
the list of resolved paths, either manually or with something like[2]:

  {
    echo 'partial merge result'
    echo

    git status --porcelain | perl -ne '
      next if /^U|\?/;
      s/^\S+\s+//;
      print;
    '

  } >msg

And then they stage the rest of it (knowing it will be ignored by Matt)
and commit:

  git add -u
  git commit -F msg
  git push wherever partial-merge

Then Matt does the actual merge:

  git merge old-topic

which of course results in lots of conflicts. So he pulls resolved
versions from each person's tree:

  for i in alice bob charlie; do
    git fetch $i
    git checkout $i/partial-merge -- \
      `git log -1 --format:%b $i/partial-merge`
  done

And then fixes up whatever's left manually or with git-mergetool, and
commits the end result.

Take all of my scripting there as illustrative of the concept, but not
necessarily a good idea. In particular, it doesn't handle quoting of
filenames at all, and it probably doesn't handle files whose resolution
was to be deleted (since the checkout will fail).

-Peff

[1] I also considered that instead of noting the resolved files in the
commit message, the developers could just remove anything they didn't
resolve. After all, their tree is going to be thrown away eventually.
Then Matt could just script around "git ls-tree" to pull their files
out. The downside is that there is no way for the developers to say "th=
e
resolution is to delete this file", since it just looks like something
they didn't resolve.

[2] It really seems like the right command to get the list of resolved
files would be "git diff-index" with either a diff-filter, or grepping
the output of --name-status. But I couldn't convince it to show me
unmerged files; the unmerged entries always just appeared as
modifications (actually, deletions in --raw), which made them
indistinguishable from modified resolutions.
