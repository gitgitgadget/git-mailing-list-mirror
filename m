From: Jeff King <peff@peff.net>
Subject: Re: Simulating an empty git repository without having said
 repository on disk
Date: Mon, 16 Jan 2012 15:41:31 -0500
Message-ID: <20120116204131.GC18699@sigill.intra.peff.net>
References: <CAD77+gR=txp8sKrA57ztQX0a1-QZM7wwR6ThBq77c=c+AbsS0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 21:41:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmtN5-000195-Sx
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 21:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab2APUlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 15:41:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39449
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755684Ab2APUle (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 15:41:34 -0500
Received: (qmail 17887 invoked by uid 107); 16 Jan 2012 20:48:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jan 2012 15:48:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2012 15:41:31 -0500
Content-Disposition: inline
In-Reply-To: <CAD77+gR=txp8sKrA57ztQX0a1-QZM7wwR6ThBq77c=c+AbsS0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188651>

On Mon, Jan 16, 2012 at 07:34:04PM +0100, Richard Hartmann wrote:

> for vcsh[1], I need a rather hackish feature: List all files untracked
> by vcsh. The plan to achieve this is:
> 
> Get lists of all files by all repos which' GIT_WORK_TREE is in one
> directory ($HOME, by default), merge all lists into one and use that
> as a .gitignore or exclude. Then run `git status` with $GIT_WORK_TREE
> pointing to $HOME while using said ignore/exclude. That will give me a
> list of all files & directories which are not tracked by any of the
> git repos managed by vcsh.

I don't use vcsh, but I seem to recall that it works by overlaying the
working trees of different repositories on each other, right? So you
can't just say "oh, files in foo/ belong to repository 'bar'". You must
take the union of the set of tracked files from all repos, then find the
difference of that from the set of all files.

Can individual repos mark things as excluded, too? Or do you have a
master exclusion list? I.e., if I decide that I don't want "foo" tracked
at all, how do I tell vcsh?

> I could create an empty git repo to run this operation in, but that
> seems wasteful. Thus, I would prefer to run this command against a
> non-existing, empty git repo. Problem is, I could not find a way to do
> this.
> 
> I know the empty tree's SHA is hard-coded into git so I was hoping
> there would be a way to trick git using this, but I couldn't find a
> way.

I'm not sure why you care about the empty tree if you are only looking
at untracked files. Or perhaps the problem is that you are using "git
status", which fundamentally cares about looking at differences between
HEAD and the index, even though you don't care in this case. In that case,
maybe "git ls-files -o" would be more appropriate?

The most straightforward way in git would be to generate a temporary
index that mentions all of the tracked files, like this:

  tmp=/some/tmp/index
  rm -f $tmp
  for i in repo; do
    git --git-dir=$repo ls-files -z |
      GIT_INDEX_FILE=$tmp xargs -0 git update-index --add
  done
  GIT_INDEX_FILE=$tmp git ls-files -o

but that is very close to your "create an empty git repo" (in fact, you
might even need to in order for update-index to be happy). But it would
give you a place to put a master exclusion list (you would use it as
--exclude=... in the final ls-files).

If you have per-repo exclusion lists, then you could take a different
approach, and simply run "git ls-files -o" for each repository. Any
files which appeared in _every_ output would be untracked (since tracked
files or individually-excluded files would be omitted from at least one
repo). Like:

  # get the list of untracked files from each repo's perspective
  count=0
  for i in repo; do
    count=$(($count + 1))
    git --git-dir=$repo ls-files -o
  done >output

  # now count how many times each entry appears. Truly untracked things
  # appear $count times.
  sort <output |
  uniq -c |
  perl -lne "/^\s*$count (.*)/ and print \$1"

The downside is that you are doing $count traversals of the untracked
directories. On an OS with a reasonable lstat and a directory structure
that fits into cache, that is probably not too big a deal, though.

> Any and all help appreciated, even if it's just a "no, this is not possible"

I took a lot of guesses at exactly what you want. It might be more clear
if you gave us an example situation along with the output you expect.

-Peff
