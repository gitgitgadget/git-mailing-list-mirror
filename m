From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-save script
Date: Tue, 26 Jun 2007 18:05:42 -0700
Message-ID: <7vsl8euryx.fsf@assigned-by-dhcp.pobox.com>
References: <20070623220215.6117@nanako3.bluebottle.com>
	<7vmyyq2zrz.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 03:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Lyc-0008Ou-RP
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 03:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbXF0BFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbXF0BFo
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:05:44 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62903 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbXF0BFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:05:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627010544.IPPU17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 21:05:44 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GR5j1X0031kojtg0000000; Tue, 26 Jun 2007 21:05:43 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50994>

Junio C Hamano <gitster@pobox.com> writes:

> Nanako Shiraishi <nanako3@bluebottle.com> writes:
> ...
>> +	save=$( (
>> +		i_tree=$(git-write-tree)
>> +
>> +		TMP=$GIT_DIR/.git-save-tmp
>> +		GIT_INDEX_FILE=$TMP
>> +		export GIT_INDEX_FILE
>> +
>> +		git-read-tree $i_tree
>> +		git-add -u
>> +		w_tree=$(git-write-tree)
>> +		rm $TMP
>> +		git-read-tree --prefix=base/ HEAD^{tree}
>> +		git-read-tree --prefix=indx/ $i_tree
>> +		git-read-tree --prefix=work/ $w_tree
>> +		git-write-tree
>> +		rm $TMP
>> +	) )
> ...
>  - Although you keep a separate tree for the index (before the
>    "git add -u" to grab the working tree changes) in the saved
>    data, it does not seem to be used.  It _might_ make sense to
>    replace "git add -u" with "git add ." so that work/ tree
>    contains even untracked (but not ignored) files, and on the
>    restore side unstage the paths that appear in work/ but not
>    in indx/.  I dunno.

I would like to take the last part of the sentence back.

I do not think "git add ." makes much sense.  The only case that
"add ." vs "add -u" may make a difference is the files that are
so new to your working tree that you haven't even added them to
the index.  But they would not be in your current HEAD, and they
would not have been added in the commit you are pulling, and if
that is not the case, git-merge would complain and bail out as
usual anyway.  I replied to your other message with something
about ".gitignore", but not everybody uses "ignore" mechanism
effectively, and "git add ." indeed would end up sucking all the
irrelevent cruft to w_tree for them, only to be extracted back
(because HEAD, i_tree and whichever commit you will later be
applying the stash to are not likely to have them).  Maybe we
could argue that those people with nonoptimal "ignore" list
deserve it, but I do not think it is worth the potential added
aggravation.

By the way, I initially liked the clever use of a single commit
that records the three trees in it, but now I am beginning to
really hate it.  I am suspecting that the primary reason you did
it that way was to reduce the number of commit objects used for
this purpose.  I personally do not think it is something we
would want to optimize for.

I think it would make much more sense to represent a stash like
this:

              .------o commit to represent index state
             /        \
     ---o---o----------o
            HEAD       commit to represent worktree state

That is, "index" and "worktree" state are represented as one
commit each, both are direct child of the HEAD, with an added
twist of the latter being also a child of the former.

This has an interesting side effect that I can do this:

	$ git show stash

to view what was in HEAD, index and working tree at the same
time (you can use "git stash show" to view the changes between
HEAD and worktree as before).

Being able to view this "evil merge" (this is a deliberately
evil merge, as you typically have huge differences between the
index and worktree when you need to stash) may not be that
interesting in the real life, but I think this is a good
demonstration of the reason why it is better to use more
straightforward ancestry structure to represent the stash.  By
not using a custom tree structure that is only understood by
"git stash", the user can use existing tools that operate on
normal ancestry chains.

>> ...
>> +	save_work
>> +	git reset --hard
>
> I am not absolutely sure if "git reset --hard" belongs here.
> You can certainly type one less command in your example sequence
> ("stash; pull; restore").  But I suspect there may be a case
> that would be more useful if "git save" did not do the reset
> itself.  I dunno....

I now think "git reset --hard" here is fine.
