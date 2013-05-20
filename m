From: Johan Herland <johan@herland.net>
Subject: Storing refs in the odb (was: Re: [PATCH 00/17] Remove assumptions
 about refname lifetimes)
Date: Mon, 20 May 2013 15:48:15 +0200
Message-ID: <CALKQrgcBkdoJdJGam=VkE=nXHQ8WB5judY3C3nNQBJCns-_f+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 20 15:48:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeQRy-0001Qw-5W
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 15:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab3ETNsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 09:48:25 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:53849 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270Ab3ETNsY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 09:48:24 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeQRq-000B8Y-Ns
	for git@vger.kernel.org; Mon, 20 May 2013 15:48:22 +0200
Received: from mail-oa0-f42.google.com ([209.85.219.42])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeNtn-000BKN-Uo
	for git@vger.kernel.org; Mon, 20 May 2013 13:05:04 +0200
Received: by mail-oa0-f42.google.com with SMTP id i10so7777101oag.29
        for <git@vger.kernel.org>; Mon, 20 May 2013 06:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=H6uh0/uDJAsByToJxoLuasQoa7Zjq2JUlIRYuoTUIw4=;
        b=DZqxSQt6E6SweL4ItDSe75zAdF2MWQMT2tDYXqoX51Th3xHWXXRG9MdiAf7W4uouie
         ZUYVzbo/Hks75fo53bLwpI2Fc4nyrlz27m30sra0t5G76RLJn3nZSeG8pjnQ99LBDU7p
         +5SViuoFVaEWjWkSLV2jnD9Q0JvkSfVrZHl2MyoHM4YshR3lo8/dRWRNM0/mOFGJjyxO
         xnyubBQuUBeg0bcztxU2fr1rdz/GltVNG3l5Z3oyf3zHdhGNayo85xCjF3wlRe5jfy1c
         DdYr7Gq1hRWQCY0Z1cAgy36yVCilXAN2Mfq+mxKUFlXIVLCGj+wTz4sxeupjOHoMu8A8
         iXCg==
X-Received: by 10.60.80.103 with SMTP id q7mr16166192oex.135.1369057695610;
 Mon, 20 May 2013 06:48:15 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Mon, 20 May 2013 06:48:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224957>

On Mon, May 20, 2013 at 2:15 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This is a very interesting idea.  "It's turtles all the way down."

:)

> On 05/20/2013 12:28 PM, Johan Herland wrote:
>> For server-class installations we need ref storage that can be read
>> (and updated?) atomically, and the current system of loose + packed
>> files won't work since reading (and updating) more than a single file
>> is not an atomic operation. Trivially, one could resolve this by
>> dropping loose refs, and always using a single packed-refs file, but
>> that would make it prohibitively expensive to update refs (the entire
>> packed-refs file must be rewritten for every update).
>
> Correct, or the "packed-refs" file would have to be updated in place
> using some database-style approach for locking/transactions/whatever.
>
>> Now, observe that we don't have these race conditions in the object
>> database, because it is an add-only immutable data store.
>
> Except for prune, of course, which can cause race conditions WRT to writers.

Yes, but that is a different race, in need of a different solution.
E.g. that race is concerned with pruning unreachable objects that are
about to become reachable by a concurrent operation, which is AFAICS
independent from the ref update race that we're discussing here.

>> What if we stored the refs as a tree object in the object database,
>> referenced by a single (loose) ref? There would be a _single_ (albeit
>> highly contentious) file outside the object database that represent
>> the current state of the refs, but hopefully we can guarantee
>> atomicity when reading (and updating?) that one file. Transactions can
>> be done by:
>>  1. Recording the tree id holding the refs before starting manipulation.
>>  2. Creating a new tree object holding the manipulated state.
>>  3. Re-checking the tree id before replacing the loose ref. If
>> unchanged: commit, else: rollback/error out.
>
> There are two closely related possibilities and I'm not sure which one
> you mean:
>
> * Effectively treat all of the refs as loose refs, but stored not in the
> filesystem but rather in a hierarchical tree structure in the object
> database.  E.g., all of the refs directly under "refs/heads" would be in
> one tree object, those in refs/remotes/foo in a second, those for
> refs/remotes/bar in another etc. and all of them linked up together in a
> tree object representing "refs".
>
> * Effectively treat all of the refs as packed refs, but store the single
> "packed-refs" file as a single object in the object database.
>
> (The first alternative sounds more practical to me.  I also guess that's
> what you mean, since down below you say that each change would require
> producing "a few objects".)

The first alternative is what I had in mind.

Initially I thought to record it as if one were to record a new tree
using .git/refs as the root of your worktree (having exploded all
packed-refs into loose refs). I.e. you would have "heads", "tags",
"remotes" as subtrees of "reference tree", and then e.g. in the
"heads" subtree, there would be an entry named "master" pointing to a
_blob_, and the contents of that blob would be the commit id of the
current tip of the master branch.

Obviously the next optimization would be to drop the "master" -> blob
-> commit indirection, and use "master" -> commit instead, i.e. the
"master" tree entry corresponds directly to the commit to which it
points (symrefs would naturally be recorded as symlinks). This would
automatically provide reachability for all refs, but as you correctly
observe:

> Of course in either case we couldn't use a tree object directly, because
> these new "reference tree" objects would refer not only to blobs and
> other trees but also to commits and tags.

Indeed. I don't know if the best solution would be to actually _allow_
that (which would complicate the object parsing code somewhat; a tree
entry pointing to a commit is usually interpreted as a submodule, but
that is not what we'd want for the ref tree, and a tree entry pointing
at a tag has AFAIK not yet been done), or whether it means we need to
come up with a different kind of structure.

> [I know this is not what you are suggesting, but I am reminded of
> Subversion, which stores trunk, branches, and tags in the same "tree"
> space as the contents of the working trees.  A Subversion commit
> references a gigantic tree encompassing all branches of development and
> all files on all of those branches (with cheap copies to reduce the
> redundancy):
>
>     /
>     /trunk/
>     /trunk/Makefile
>     /trunk/src/
>     /trunk/src/foo.c
>     /branches/
>     /branches/next/
>     /branches/next/Makefile
>     /branches/next/src/
>     /branches/next/src/foo.c
>     /branches/pu/
>     /branches/pu/Makefile
>     /branches/pu/src/
>     /branches/pu/src/foo.c
>     /tags/
>     /tags/v1.8.2/
>     /tags/v1.8.2/Makefile
>     /tags/v1.8.2/src/
>     /tags/v1.8.2/src/foo.c
>     etc...
>
> A Subversion commit thus describes the state of *every* branch and tag
> at that moment in time.  The model is conceptually very simple (in fact,
> too simple, and I believe the Subversion developers regret not having
> distinguished between the branch namespace and the file namespace).]

True. Thanks for the added perspective. The crucial difference between
Subversion and Git in this regard is obviously that Git puts the
commit "between" the branch namespace and the file namespace, firmly
separating the two. My suggestion does not change this in any way, but
it reuses the same object model to look at the branch namespace as
"meta-trees".

> The main difficulty with this idea will be the extreme contention on
> that "last loose reference file" pointing at the root of the reference
> tree.  Essentially *every* change to the repository will have to create
> a new reference tree and point this file at the new version.

Yes. This is indeed the ultimate problem with this idea. But AFAICS it
is the same ultimate problem for all filesystem-based solutions: since
atomicity can only be guaranteed for single-file updates, any
file-based solution _must_ have the equivalent of a single lock on all
ref updates.

Hence, if it can be demonstrated that the contention on a single
(41-byte) file is sufficiently extreme to make it infeasible in
practice, then we can conclude that there is _no_ filesystem-based
solution that will solve our problem, and we _must_ go for more
advanced database solution.

> I doubt
> that would be a problem for short-lived operations, but I fear that a
> long-lived operation would *never* get done.  By the time it had
> finished constructing its new reference tree, some other short-lived
> operation will have changed it, and the long-lived process will have to
> choose between
>
> * Restart from the beginning.
>
> * Die with a kind of "concurrent modification error".
>
> * Resolve the difference between the reference tree at the start of its
> operation and the reference tree as it exists when it is done with the
> changes that they want to make.  In some cases this might be able to be
> done automatically as a kind of "reference tree merge" but the logic
> might have to vary from case to case.

Alternatively, it could (when sufficiently miffed) grab a lock that
would temporarily refuse/delay anybody else access to update refs.

>> PS: Keeping reflogs is just a matter of wrapping the ref tree in a
>> commit object using the previous state of the ref tree as its parent.
>
> Yes, there are a lot of nice aspects to this idea in that it reuses
> concepts with which we are already familiar.  For example, fetching from
> a remote would approximately hook the remote's entire reference tree
> into a subtree of the local "refs/remotes" reference subtree.

True. Hadn't thought of that...

> But with
> things like reflogs we would have to be careful not to keep obsolete
> objects around *forever*--there would have to be some mechanism to prune
> the old reference history.

Yes, pruning reflogs could be done by finding the oldest reflog-commit
we want to keep, rewriting it to have zero parents with "git replace",
and then rewriting the reflog-commit history accordingly to make the
older reflog-commits unreachable.

(But then, the "git replace" mechanism writes its own refs/replace/*
ref, which would cause a new reflog-commit. Fortunately the replace
ref does not make the replaced history reachable, so this should in
fact work, albeit more than a little complicated...)

...Johan


> Altogether a very interesting idea.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/



-- 
Johan Herland, <johan@herland.net>
www.herland.net
