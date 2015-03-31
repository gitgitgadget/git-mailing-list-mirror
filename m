From: Mike Hommey <mh@glandium.org>
Subject: Allowing weak references to blobs and strong references to commits
Date: Tue, 31 Mar 2015 19:07:56 +0900
Message-ID: <20150331100756.GA13377@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 12:08:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yct5e-0006eS-6V
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 12:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbbCaKIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 06:08:05 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:36053 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbbCaKID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 06:08:03 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Yct5Q-0003er-R7
	for git@vger.kernel.org; Tue, 31 Mar 2015 19:07:56 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266519>

Hi,

Currently, in git-cinnabar[1], I'm using a private namespace
(refs/cinnabar) for various different things:
- references to all the imported heads (which may or may not
  match remote refs),
- the last refs used for a fetch (part of the refspec protocol for
  remote-helpers)
- a branch containing mappings from mercurial sha1s to git objects.
- a branch used to store all mercurial manifests.
- a cache of some sort (used for tags only atm)

So essentially there are a bit more than twice as many refs as actually
necessary (and up to more than three when there is only one remote).

Ideally, the mercurial manifests data would use as many refs as
branches, so that their parent information wouldn't have to be guessed
from the corresponding git commits, but I didn't do that initially to
avoid making the number of necessary refs even bigger (that would make
the number three or four times as many as necessary).

I won't bother you with all the whys and hows, but that ends up being
a lot of unwanted noise for users, because many commands don't limit
themselves to refs/heads, refs/tags and refs/remotes.

One way to reduce this noise would be for me to create fake octopus
merges and reduce the number of heads to one, or at least one per
category. But this is cumbersome and would create a lot of useless
commits that would end up loose, except if they are kept forever which
seems even worse.

So I thought, since commits are already allowed in tree objects, for
submodules, why not add a bit to the mode that would tell git that
those commit object references are meant to always be there aka strong
reference, as opposed to the current weak references for submodules.
I was thinking something like 0200000, which is above S_IFMT, but I
haven't checked if mode is expected to be a short anywhere, maybe one of
the file permission flags could be abused instead (sticky bit?).

I could see this used in the future to e.g. implement a fetchable reflog
(which could be a ref to a tree with strong references to commits).

Then that got me thinking that the opposite would be useful to me as
well: I'm currently storing mercurial manifests as git trees with
(weak) commit references using the mercurial sha1s for files.
Unfortunately, that doesn't allow to store the corresponding file
permissions, so I'm going through hoops to get that. It would be simpler
for me if I could just declare files or symlinks with the right
permissions and say 'the corresponding blob doesn't need to exist'.
I'm sure other tools using git as storage would have a use for such
weak references.

What do you think about this? Does that seem reasonable to have in git
core, and if yes, how would you go about implementing it (same bit with
different meaning for blobs and commits (or would you rather that were
only done for commits and not for blobs)? what should I be careful
about, besides making sure gc and fsck don't mess up?)

Cheers,

Mike

1. a git-remote-hg tool, https://github.com/glandium/git-cinnabar/
