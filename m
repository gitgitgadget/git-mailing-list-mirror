From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-union-merge proposal
Date: Tue, 21 Jun 2011 11:12:19 -0700
Message-ID: <7vy60v835o.fsf@alter.siamese.dyndns.org>
References: <20110621022049.GA1632@gnu.kitenet.net>
 <7v4o3j9izr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 20:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ5R6-0005sC-0D
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 20:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066Ab1FUSMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 14:12:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab1FUSMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 14:12:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACC005BDF;
	Tue, 21 Jun 2011 14:14:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rGfKjSi9S2ThJ+y4wbZhCotVlvE=; b=ubglix
	0Y5W03ph54bHfViQdK+/5V5QXFlfxTBMEiKMBmBPmMOfn6DYxZybBhEH5+/Dziry
	KmpZrsh8rz4gts7FW+OCdL87f1spVxgEVhjRC0Pq30kbGXiTfatYCoj3We1HIYjL
	YpPHZ5sCH0D3PbZjZ+lrutdUe8wYIBjIV6Wdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AmpJM1KhknthXOUttUmZ6ERIZg3jNlCo
	RyVSjs3wUSVH485ruEjngNKc+ysr+ZMskPycalVN3URPF+ilwjUxYFPDTxk37ySJ
	jH2cs6pvjsjPesKKSaI566NSXB6DJ2WM5vpz14JzayXwUsfXvk0AATzytuD8JQmX
	cNXAyvYMGbU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A65DA5BDE;
	Tue, 21 Jun 2011 14:14:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D11C25BDC; Tue, 21 Jun 2011
 14:14:32 -0400 (EDT)
In-Reply-To: <7v4o3j9izr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 21 Jun 2011 10:44:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 502EBCF0-9C32-11E0-B998-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176178>

Junio C Hamano <gitster@pobox.com> writes:

> In other words, I would prefer to see something like:
>
> 	$ git merge --index-only [-s <strategy>] <other_branch>
>
> which
>
>     (0) does work without any file checked out in the working tree;
>
>     (1) does not update a path in the working tree even if the merge
>         result for the path is different from the original index entry for
>         the path;
>
>     (2) updates the index only when everything cleanly merges (depending
>         on the definition of "cleanly merges", e.g. "union" may be a lot
>         more lenient than the usual "text" merge) and aborts without
>         touching anything if there is a conflict (because --index-only
>         does not allow us to touch working tree to ask the user to resolve
>         the conflict).
>
> "git merge" is designed to work without any file checked out in the
> working tree, by considering a _missing_ file in the working tree as if
> there is _no change_ to the path during a merge. IOW, we do not say "you
> have an uncommitted local removal of a path, which other side tried to
> modify, hence we stop the merge to protect your local change".
>
> This is so that you can do something like this:
> ...
> In other words, we are already half-way there, I think.

Addendum.

People have wished on this list who have two or more branches, e.g. "work"
and "play", based on the same upstream branch to be able to do:

	$ git fetch origin
	$ git checkout work
	$ git merge @{u}
        $ git checkout play
        $ git merge @{u}
	$ git checkout work

i.e. integrate upstream changes without having to check out "play" branch
first, if there is no conflict. The standard answer has been "You cannot,
because you may not know if there will be a conflict until you try".

But the existing "merge in a temporary working tree that is empty to start
with" support is a good way to implement it.  You would do something like
this after you are on your "work" branch and finished merging from its
upstream (package this up in a "git simplemerge" script):

	rm -fr .t && mkdir .t && cd .t &&
        GIT_DIR=$(git rev-parse --git-dir) &&
        GIT_INDEX_FILE=$GIT_DIR/temp-index &&
        GIT_WORK_TREE=$(pwd) &&
        export GIT_DIR GIT_INDEX_FILE GIT_WORK_TREE &&
	save_head &&
        git symbolic-ref refs/heads/play HEAD
        git read-tree play &&
        (
	        git merge --no-commit play@{upstream}
	)
	restore_head

If the merge goes well without conflict, you write the temporary index out
to a tree, create a commit and update the "play" branch (save_head should
save away the current branch and restore_head should restore it).

If the merge conflicts, you _could_ ask the user to resolve it in .t/
directory (with these updated GIT_DIR/GIT_INDEX_FILE/GIT_WORK_TREE), write
the result out to a tree, create a commit and update the "play"
branch. This is entirely optional, as the common request is to do this
only when the merge is trivial and there is no conflict.

And if we are allowed to punt when there is a conflict, we do not need the
temporary working tree at all if we had --index-only option.  We only need
to save and restore the HEAD pointer and the index file so that we can
continue working on the "work" branch after we are done.

This incidentally is the reason why I said "update the index" and not
"create a commit" when I specified the behaviour of "--index-only" in the
previous message.
