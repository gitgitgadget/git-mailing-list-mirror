From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add 'sane' mode to 'git reset'
Date: Wed, 03 Dec 2008 14:22:46 -0800
Message-ID: <7vr64oc30p.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:24:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L808i-0001he-7M
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 23:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYLCWW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 17:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYLCWWz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:22:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbYLCWWz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 17:22:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D6D78357D;
	Wed,  3 Dec 2008 17:22:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6079A8357A; Wed,
  3 Dec 2008 17:22:48 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Mon, 1 Dec 2008 09:30:31 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC40AAAE-C188-11DD-B480-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102294>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We have always had a nice way to reset a working tree to another state 
> while carrying our changes around: "git read-tree -u -m". Yes, it fails if 
> the target tree is different in the paths that are dirty in the working 
> tree, but this is how we used to switch branches in "git checkout", and it 
> worked fine.
>
> However, perhaps exactly _because_ we've supported this from very early 
> on, another low-level command, namely "git reset", never did. 
>
> But as time went on, 'git reset' remains as a very common command, while 
> 'git read-tree' is now a very odd and low-level plumbing thing that nobody 
> sane should ever use, because it only makes sense together with other 
> operations like either switching branches or just rewriting HEAD.
>
> Which means that we have effectively lost the ability to do something very 
> common: jump to another point in time without always dropping all our 
> dirty state.
> ...
> I've wanted this for a long time, since I very commonly carry a dirty 
> tree while working on things. My main 'Makefile' file quite often has the 
> next version already modified, and sometimes I have local modifications 
> that I don't want to commit, but I still do pulls and patch applications, 
> and occasionally want to do "git reset" to undo them - while still keeping 
> my local modifications.

I think a bit more explicit description with an example command sequence
in the documentation is in order.  Here is what I managed to reconstruct
from your description.

    Let's say you have a small change in the Makefile and some other local
    changes that you would want to keep uncommitted.  Then you receive a
    pull request that you would want to respond to.  So you do this:

	$ git pull $URL $branch

    knowing that your own local changes will be safe because pull will
    refuse to clobber them if the changes in the other person did overlaps
    with it.  Let's further say that the changes did not overlap, the
    merge succeeded and you still have your own local changes.

    But after inspecting the result, you realize that you do not want this
    change after all.  That means rewinding the HEAD back to the previous
    point (i.e. ORIG_HEAD), match the index to that commit, *and* rewind
    the work tree back to the state before the merge (i.e. mostly matching
    the index except for the local changes to Makefile and a handful other
    files).  "git reset" is the command to move the HEAD.  What mode
    should you use?

    Unfortunately, the only two modes that touch the index and/or the work
    tree are --mixed and --hard.

    You do not want to use --hard, because it will discard your local
    changes.  You do not want to use --mixed either, because it will keep
    not just your local changes but also the changes the merge brought
    into your work tree.  That's when you would want to use --merge mode.

	$ git reset --merge ORIG_HEAD

    This command (1) resets the HEAD to the given commit (ORIG_HEAD in
    this example), and runs "read-tree -m -u HEAD ORIG_HEAD" which means
    (2) resets the index to match the tree recorded by that commit, and
    (3) updates the files in the work tree for difference between HEAD and
    ORIG_HEAD, i.e. undoing the changes made between ORIG_HEAD and HEAD.
    Because you know the work undone in (3) does not overlap with your
    local changes, this is exactly what you want in such a situation.

    This procedure works just as well when you are accepting patches by
    replacing "git pull" with "git am" and "ORIG_HEAD" with "HEAD~$n"
    (where $n is the number of patches contained in the e-mailed series)
    in the above description.

Does the above describe what you meant?

Although I admit that I have used "read-tree -m -u" for probably more than
a couple of times in the past 6 months, I really do not recall the exact
sequence that led me into the situation where it was the most appropriate
command to use.  I do not think any of these occassions were about me
having a wrong commit at HEAD (meaning, I really wanted to read the index
and update the work tree, without changing where the next commit would
go), so obviously my workflow is quite different from yours.

The recovery procedure I would use in such a case (and I rarely pull while
managing git.git even though I do so in my day job) would be:

	$ git checkout -b this-needs-more-work
        $ git checkout master

to stash away the "topic" that needs more work in a new branch, and have
"checkout" take me back to where I was with my local modifications, and
that is probably why I never felt the need for this new mode (nor did not
understand why you thought very strongly that --merge should be the
default mode and not --mixed).
