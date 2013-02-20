From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge with staged and unstaged changes
Date: Wed, 20 Feb 2013 12:21:06 -0800
Message-ID: <7vobfeybwt.fsf@alter.siamese.dyndns.org>
References: <A54CE3E330039942B33B670D971F85740396B267@TK5EX14MBXC254.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Edward Thomson <ethomson@microsoft.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 21:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8GAb-0001Ks-2c
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935376Ab3BTUVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:21:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935009Ab3BTUVL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:21:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A424F6058;
	Wed, 20 Feb 2013 15:21:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zG+yr6xFOzLHPXVFbVLlLdyXYbM=; b=T2waQ5
	pNRO5Df0S5J1Ga+QETjVEeGBhPpe31EUNxtVCIRbgW/7YmbLdFHJ0TWHDWMsMoim
	3Z0q8FkeVIhmneouoxAUKK3kbH0uEBtT/fn4ef5DZ4TZxttf8/3aeNyDNiDm9K6p
	DFgZZky1oA6xzUFwqOlszKyg1A4af2whbDbi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I9Rdthf4fPRHOvx1jRG3/FDUtDETpeeL
	Zrx1v9yYlDr13Nnc1shNWoqQGGS3QCLnUjKm2+PzDgfCURxKraMYtLU1KDEIiwUh
	eq+2I7yTQddWH5Q72gn6Fn12MXXP3Z8phv4HsLvXugZkzb4B3oBzTzcwoVLotr7h
	WXgt7Px6Kjk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98E836057;
	Wed, 20 Feb 2013 15:21:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9F646056; Wed, 20 Feb 2013
 15:21:07 -0500 (EST)
In-Reply-To: <A54CE3E330039942B33B670D971F85740396B267@TK5EX14MBXC254.redmond.corp.microsoft.com> (Edward Thomson's message of "Wed, 20 Feb 2013 19:17:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F1E9830-7B9B-11E2-82EB-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216735>

Edward Thomson <ethomson@microsoft.com> writes:

> What was surprising to me was that my merge can proceed if I stage a change
> that is identical to the merge result.  That is, if my merge result would
> be to take the contents from "theirs", then my merge can proceed if I've
> already staged the same contents:
>
>    input                                 result
>    anc ours theirs idx wd  merge result  idx wd
> 4  A   A    B      B   B   take B        B   B
> 5  A   A    B      B   C   take B        B   C
>
> This seems unexpected - is there a use-case that this enables or is
> this accidental?

Both are very much on purpose. The integrator may have seen the
patch on the list, ran "git apply [--index]" on it to contemplate on
it, and before commiting the result, saw a pull request for a branch
that contains the change.  The above two allow the pull from such a
state to succeed without losing any information.

I think we have a similar table in Documentation/technical area that
explains these things, by the way.

> Another surprising result was that if I have deleted a file (and staged
> the deletion or not) then the merge will proceed and the file in question
> will be recreated.  Consider "X" to be a missing file:
>
>    input                                 result
>    anc ours theirs idx wd  merge result  idx wd
> 6  A   A    B      A   X   take B        B   B
> 7  A   A    B      X   X   take B        B   B

I am not sure about #7, but #6 is done very much on purpose.  The
lower level merge machinery deliberately equates "in index but not
checked out to the working tree" state and "in index and not
modified in the working tree" state; this is to support a merge done
in a temporary working area that starts out empty.

This was designed really long time ago (read: during the first two
weeks of Git development, back when there were no "stash" nor
"remote tracking branches"), with a vision to make this scenario
work nicely:

    You have checked out 'master' branch and you are working on it.
    You see a more urgent pull request on 'maint' branch.  But your
    working tree for 'master' is no shape to commit, yet.

Without disturbing the working area you are using to advance the
'master' branch, you could do the merge "only in the index" by doing:

 * Fetch the requested commit:
 
	$ git fetch $over_there refs/heads/master

 * Populate a temporary index with the contents of your 'maint':

	$ GIT_INDEX_FILE=,,temp-index GIT_DIR=$(pwd)/.git
        $ export GIT_INDEX_FILE GIT_DIR
        $ git read-tree refs/heads/maint

 * Create an empty temporary working area and go there:

	$ mkdir ,,temp-merge
	$ cd ,,temp-merge

 * Run the three-way merge between your 'maint' and the requested
   commit:

	$ MB=$(git merge-base FETCH_HEAD maint)
	$ git read-tree -m -u $MB maint FETCH_HEAD

Notice that we start without _any_ file in that temporary working
area (,,temp-merge directory).  In the last step, because the merge
machinery (read-tree -m -u) treats missing files as "they are
unmodified by us; we didn't even bother checking them out of the
index", we will see _only_ the files that are different from our
'maint' and files that needs our help to get conflicts resolved
in the temporary working area after the command finishes.  You
inspect them, resolve conflicts and run "git update-index" on them
(remember, there weren't "git add" or "git commit -a"), write the
resulting index as a tree with "git write-tree" and record the tree
with "git commit-tree -p maint -p FETCH_HEAD" (actually, back then
"commit-tree -p" insisted on getting raw tree object names, so you
had to do the equivalent of "git rev-parse maint^{tree}" there) and
then update your 'maint' branch with the resulting commit.

If there is no conflict to be resolved, then you essentially can run
a script that does all of the above (and cleans up the temporary
directory ,,temp-merge and the temporary index) to implement "Can
perform a merge into a branch that is not currently checked out,
without disturbing my current work" feature.  And this "missing
files are unmodified---I didn't even bother to check them out of the
index" was done as an integral part of it.

Back when we (IIRC, mostly between Linus and I) were discussing this
design, it did come up that in the normal case of "I am merging in
my working tree", this behaviour would lose information, but "I'm
planning to remove this" is only a single bit and lossage of that
was judged to be trivially small and easily recoverable compared to
the benefit of being able to do a merge in an empty working tree,
and that is where this behaviour comes from.

We could certainly revisit this design and make the behaviour
optional.  When somebody wants to do the "Can perform a merge into a
branch that is not currently checked out, without disturbing my
current work" feature, its implementation needs to be able to turn
it back on, but for doing everything else we do not have to treat a
missing file as unmodified.
