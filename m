From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Wed, 8 Jun 2011 20:43:47 -0400
Message-ID: <20110609004347.GC19715@sigill.intra.peff.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
 <4DEDC124.3060302@drmicha.warpmail.net>
 <201106081312.46377.jnareb@gmail.com>
 <BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
 <20110608150537.GC7805@sigill.intra.peff.net>
 <BANLkTinibF0xmibeuJ6f9FUjaMmxavMJig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Thu Jun 09 02:43:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUTLn-00058N-QD
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 02:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab1FIAnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 20:43:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54227
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab1FIAnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 20:43:51 -0400
Received: (qmail 6169 invoked by uid 107); 9 Jun 2011 00:43:58 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 20:43:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 20:43:47 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinibF0xmibeuJ6f9FUjaMmxavMJig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175480>

On Wed, Jun 08, 2011 at 02:57:09PM -0400, Michael Nahas wrote:

> > Isn't this going to be behavior change, since your NEXT is not quite the
> > same as the index? How do I now get an n-way combined diff of the
> > unmerged files in the index?
> 
> The index is a file in .git/ that serves many purposes.  NEXT is an
> image of the whole project.  NEXT can be computed from the index and
> HEAD.
> 
> During a conflicted merge, stage 0 of the index holds the resolved
> files.  WTREE holds all merge files: the resolved and the unresolved
> (which have <<<< ==== >>>> blocks in them).  I propose that during a
> conflicted merge, that NEXT be computed as HEAD plus the resolved
> files, that is, the files in stage 0 of the index.

OK. So NEXT actually has less information than the whole index, because
it doesn't contain information on what was on either side of the merge
originally (or in the merge base).

> "git diff HEAD NEXT" would print the resolved changes.
> "git diff NEXT WTREE" would print the unresolved changes
> "git diff HEAD WTREE" would print all changes.
> 
> I believe that is the same behaviour as "git diff", "git diff
> --cached" and "git diff HEAD" during a conflicted merge.

I assume you don't mean respectively here, but rather:

  git diff          => git diff NEXT WTREE
  git diff --cached => git diff HEAD NEXT
  git diff HEAD     => git diff HEAD WTREE

But even still, I don't think "git diff" is the same. Try this:

  git init repo && cd repo
  echo one >file && git add file && git commit -m one &&
  echo two >file && git add file && git commit -m two &&
  git checkout -b other HEAD^ &&
  echo three >file && git add file && git commit -m three &&
  ! git merge master &&
  git diff

I get:

  diff --cc file
  index 2bdf67a,f719efd..0000000
  --- a/file
  +++ b/file
  @@@ -1,1 -1,1 +1,5 @@@
  ++<<<<<<< HEAD
   +three
  ++=======
  + two
  ++>>>>>>> master

Note that this is _not_ a diff between NEXT and the working tree.  It is a
3-way "combined" diff of what's in the working tree compared to each side of
the merge.

If NEXT is a tree that contains HEAD plus stage 0 files, then we would
see a 2-way diff of the HEAD version of "file" and the working tree
version. I.e., the same as "git diff HEAD -- file":

  diff --git a/file b/file
  index 2bdf67a..087e97e 100644
  --- a/file
  +++ b/file
  @@ -1 +1,5 @@
  +<<<<<<< HEAD
   three
  +=======
  +two
  +>>>>>>> master

which looks similar, because we haven't started resolving anything yet.
But try resolving it like this:

  cat >file <<'EOF'
  three
  and
  two
  EOF

Now try "git diff" again. You should get:

  diff --cc file
  index 2bdf67a,f719efd..0000000
  --- a/file
  +++ b/file
  @@@ -1,1 -1,1 +1,3 @@@
   +three
  ++and
  + two

This shows us that "three" came from one side of the merge, "two" from
the other, and that "and" was found in neither side.

Compare to the 2-way that shows:

  diff --git a/file b/file
  index 2bdf67a..1ecff7e 100644
  --- a/file
  +++ b/file
  @@ -1 +1,3 @@
   three
  +and
  +two

There's nothing to distinguish added code pulled from the other side of
the merge versus changes that were made as part of the resolution.

I think this is what Junio was talking about when he said that the index
is more than a tree. There may be times when you want to treat the items
in stage 0 as a tree, but diffing against the index is more than just
diffing against that tree.

> I do not know how "n-way" merge works.  I saw somewhere that indicated
> that it was a series of N-1 two-way merges.

Git history can represent a merge of any number of branches (an "octopus
merge"), because the commits store only the final state and a list of
parent commits. The combined diff format is capable of handling an
arbitrary number of parents.

I should have just said "3-way", though, because it's not relevant here.
The index only has 2 stage bits, so we can only represent four stages
("resolved", "base", "ours", and "theirs"). So you can't represent an
n-way merge in the index.

So "git merge" just punts on an octopus merge if there are actual merge
conflicts that would need to go in the index. So in practice, people
just tend to do N-1 pair-wise merges.

You can see some example octopus merges (and their combined diff) if you
have a recent git (that supports --min-parents) with:

  git log --min-parents=3 -p --cc

in both git.git and linux-2.6.git.

-Peff
