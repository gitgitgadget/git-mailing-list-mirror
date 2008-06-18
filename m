From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Wed, 18 Jun 2008 19:32:46 +0200
Message-ID: <20080618173246.GA1155@diana.vm.bytemark.co.uk>
References: <20080612052913.23549.69687.stgit@yoghurt> <20080612053424.23549.64457.stgit@yoghurt> <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com> <20080617123138.GA6932@diana.vm.bytemark.co.uk> <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com> <20080617153247.GA12520@diana.vm.bytemark.co.uk> <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com> <20080618143633.GB30540@diana.vm.bytemark.co.uk> <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 19:34:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K91Xr-0000Iq-SC
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 19:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbYFRRdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYFRRdL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 13:33:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2380 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbYFRRdK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 13:33:10 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K91WZ-0000TD-00; Wed, 18 Jun 2008 18:32:47 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85393>

On 2008-06-18 17:16:10 +0100, Catalin Marinas wrote:

> 2008/6/18 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Do you mean remove hidden patches from StGit altogether, or just
> > not store them in the log?
>
> Remove them altogether. Is there anyone using them apart from me? I
> could create a "rotten" branch and pick those patches with
> --unapplied.

I've never heard about anyone else using them. So fine by me!

> It gets too complicated, really. A single commit with the proper
> parents could do the job.

Yes. The problem is that you need quite a lot of parents. Every system
I could come up with that got all the corner cases right was even more
complex (in my eyes) than the one I ended up implementing.

> We could also easily use the commit message directly for metadata
> instead of .git/patches/<branch>/.

Yes. This is true for any log scheme, though. (But I agree -- longer
term, it would be very nice to have _only_ the log.)

> The time to create that tree and blobs worries me a bit, plus the
> (in my view) complicated structure.

You're right to worry. My log format makes things feel slightly slower
when logging a 20-30 deep stack. If I can't make it faster, it's not
viable. But I'm pretty sure I can -- it should be simple to reuse all
the trees and blobs for the patches that weren't touched. (And
operations that touch lots of patches, like rebase, have to write a
lot of git objects anyway as part of their operation, so the relative
slowdown should not be large.)

Anyway, benchmarking is the way to go here. Talk will only get us that
far.

> Making the first log entry special gets difficult with log pruning
> (unless you prune the whole log rather than entries older than a
> chosen time or number) since you might have to re-create all the
> chained log entries as the first log's sha1 will probably change.

You have to re-create all the commits anyway, since they all are
immutable, and all have a back pointer.

> The applied patches are chained automatically via HEAD. For
> unapplied patches, we could add the correponding commits as parents
> of the logging commit (starting with the third parent as the first
> two are used for log chaining and applied patches). Do we hit any OS
> limit with the number of arguments?

Not until long after we hit git limits to the number of parents of a
commit. I believe the octopus merge refuses to create merges with more
than about 25 parents, and we probably shouldn't do more than that
either. We'll have to do a tree of octopuses.

This is why my log format looks the way it does. :-)

> Since we only need the unapplied commits tracking for gc and pull
> reasons, we could only create that commit that references them when
> we prune the stack log and link it from the top one (but it won't be
> used by stgit).

Yes, we need to create an "unapplied octopus" if and only if we have
unapplied patches that we can't prove are reachable from the stack top
or the branch head (we have to save both, in case the user has done
something such as git-committing on topp of the stack and caused head
!=3D top). Which is for the first log entry, and in situations such as
"stg pick --unapplied", but not for "stg pop" and the like.

I do agree that we shouldn't try to use the octopuses to get hold of
the commits, though -- just to keep them reachable. We save the sha1
along with the patch name elsewhere in a more convenient form. (My
proposed format does precisely this.)

So. If I got it right, your proposal is:

  * Tree: just take the HEAD tree.

  * Commit message: list the applied and unapplied patches with their
    commit sha1s.

  * Parents: the previous log entry; branch head; something that
    (recusively) points to all unapplied commits, if necessary.

I'd add to that:

  * The stack top must be a parent too if head !=3D top.

  * The commit message must include a version number, and the branch
    head sha1.

  * I'm pretty sure we want the kind of "simplified" log I have in my
    proposal. The full log in your proposal is going to look every bit
    as ugly as the one in mine.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
