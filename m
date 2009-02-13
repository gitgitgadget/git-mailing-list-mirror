From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] stash: --keep option just saves
Date: Fri, 13 Feb 2009 08:07:24 +0100
Message-ID: <20090213070724.GD20552@atjola.homenet>
References: <20090212062514.6117@nanako3.lavabit.com> <7vljscbp60.fsf@gitster.siamese.dyndns.org> <20090212171732.6117@nanako3.lavabit.com> <7vskmjjrin.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:08:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXsAV-0007p1-2d
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 08:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbZBMHH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2009 02:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZBMHH3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 02:07:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:54532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751181AbZBMHH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 02:07:28 -0500
Received: (qmail invoked by alias); 13 Feb 2009 07:07:26 -0000
Received: from i577B878B.versanet.de (EHLO atjola.local) [87.123.135.139]
  by mail.gmx.net (mp060) with SMTP; 13 Feb 2009 08:07:26 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+YUHhKZdyY8G9Ov0s6HDdBF1zapzmYAqXFBKYMss
	zWWwCzaWcdZRLN
Content-Disposition: inline
In-Reply-To: <7vskmjjrin.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109716>

On 2009.02.12 13:04:48 -0800, Junio C Hamano wrote:
> It can be argued that it adds one huge convenience.  It is quicker to=
 say
> 'git stash save --keep' than 'git commit -a -m "WIP as of $(date)"', =
and
> in addition, you first have to do a "checkout -b wip" once, if you us=
e the
> approach with regular commits on a exprimental branch forked from the
> target branch, instead of the approach with regular commits directly =
on
> the target branch.

Another thing that came to my mind is that stash --keep would not affec=
t
"git diff". I often look at the current diff to reassure myself of what
I'm actually doing, and when you do intermediate commits, you can no
longer use a plain "git diff", but need to use, for example, "git diff
master", assuming that your current branch is exclusively for this thin=
g
you're working on. But the whole idea of taking snapshots feels more
like it is for a use case that assumes that you end up with a single
commit, that might in the end be a part of some bigger commit series. S=
o
for the "git diff <whatever>" to be convenient, you might need a
(temporary) branch for just this one commit to be, or you need to tag
your starting point.

And (in part) you also lose the ability to dynamically mark parts of
your changes as "good" by staging and unstaging them. I use that quite
often to "trim" the diff output to the currently interesting part. When
I refactor some function, that might need a lot of callers to be
trivially changed, and I don't want to be bothered with those trivial
changes when I look at the diff to review my changes. So I temporarily
stage that trivial stuff, do a review of the "interesting" part, change
something here and there and might eventually unstage all the stuff
again. Often that's more comfortable than passing a list of interesting
files to each "git diff" command, and sometime that's the only way to
get things filtered down enough to make me happy, because the trivial
and the interesting changes are in the same file.

I think it could make sense to have that "snapshot" thing committing to
another branch (or some ref in /refs/snapshots/, or whatever). Say you
have topicA checked out, and work on some change "foo" that's likely
going to be a single commit, but you want to test several versions of
that thing, while always keeping your changes uncommitted as far as HEA=
D
is concerned. Then "git snapshot foo", could do something like:

export GIT_INDEX_FILE=3D.git/snap_index

parent_ref=3D$(git rev-parse --symbolic-full-name HEAD)
parent_ref=3D${parent_ref#refs/heads/}

snap_ref=3D"refs/snapshots/$parent_ref/$1"

git read-tree HEAD
git add -u # Or maybe git add -A?

parent=3D$(git rev-parse --verify --quiet "$snap_ref" || echo HEAD)
commit=3D$(echo "Snapshot" | git commit-tree $(git write-tree) -p "$par=
ent")

git update-ref "$snap_ref" "$commit"
rm "$GIT_INDEX_FILE"


So you get the benefits of having your snapshots stored much like
intermediate commits, but don't lose the "benefits" of having
uncommitted changes, like the plain "git diff" invocation instead of
"git diff <what's_my_base_today>".

Bj=F6rn
