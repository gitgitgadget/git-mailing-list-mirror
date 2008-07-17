From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-merge.txt: Expand the How Merge Works
 section
Date: Thu, 17 Jul 2008 11:17:22 -0700
Message-ID: <7v3am8gytp.fsf@gitster.siamese.dyndns.org>
References: <20080717162922.12081.96582.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:18:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJY3i-0004Tq-EF
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758061AbYGQSRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbYGQSRb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:17:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757589AbYGQSRa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:17:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FCE030AB1;
	Thu, 17 Jul 2008 14:17:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E0A7130AB0; Thu, 17 Jul 2008 14:17:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9D3FD944-542C-11DD-BC52-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88896>

Petr Baudis <pasky@suse.cz> writes:

> The git-merge documentation's "HOW MERGE WORKS" section is confusingly
> composed and actually omits the most interesting part, the merging of
> the arguments into HEAD itself, surprisingly not actually mentioning
> the fast-forward merge anywhere.

Thanks.

> +Three kinds of merge can happen:
>  
> +* The merged commit is already contained in `HEAD`. This is the
> +  simplest case and only "Already up-to-date" is printed.

Let's introduce and define terms here, because I think the readers will be
harmed by being given a weak "this _might_ be called" in later paragraph.

I.e.:

	... This is the simplest case and called "Already up-to-date".

> +* `HEAD` is already contained in the merged commit. This is the
> +  most common case especially when involved through 'git pull':
> +  you are tracking an upstream repository, committed no local
> +  changes and now you want to update to a newer upstream revision.
> +  So-called "fast-forward merge" is performed, simply repointing
> +  your `HEAD` (and index) to the merged commit; no extra merge
> +  commit is created.

I'd suggest rewording the last three lines:

	Your `HEAD` (and the index) is updated to point the merged
        commit, without creating an extra merge commit.  This is
        called "Fast-forward".

> +* Both merged commit and `HEAD` are independent and must be
> +  "tied together" by a merge commit, having them both as its parents;
> +  this might be called a "true merge" and is described in the rest
> +  of this section.

And this becomes:

	... both as its parents.  The rest of this section describes this
	"True merge" case.

> +Pre-flight requirements note
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +In certain special cases, your index is
> +allowed to be different from the tree of the `HEAD` commit.

Now this paragraph is moved far away from the original context that said
"your index must be clean before you start your merge", you would need to
re-introduce that in this sentenece:

	... tree of the `HEAD` before you run 'git-merge'.

> +...  The most
> +notable case is when your `HEAD` commit is already ahead of what
> +is being merged, in which case your index can have arbitrary
> +differences from your `HEAD` commit.

Thanks to your re-organization, we now have established terminology when
the reader reads this part, so we can just say:

	When the merge will be "Already-up-to-date", your index can have
	...

> +... Also, your index entries
> +may have differences from your `HEAD` commit that match
> +the result of a trivial merge (e.g. you received the same patch
> +from an external source to produce the same result as what you are
> +merging).  For example, if a path did not exist in the common
> +ancestor and your head commit but exists in the tree you are
> +merging into your repository, and if you already happen to have
> +that path exactly in your index, the merge does not have to
> +fail.

I originally wrote the above paragraph purely for completeness, but I
wonder if this happens a lot in practice.  This is not something the user
can easily anticipate anyway, so we might want to drop this.

> +Other than that, merge will refuse to do any harm to your repository

My initial reaction to this "Other than that" was "Huh?  so the special
case we just saw allows merge to do harm to my repository?".  The original
"Otherwise" wasn't any better, either.

	In all other cases, your index must match the `HEAD` commit, even
	though you can have local changes in your working tree, as
	described below.  Merge will avoid doing any harm to your working
	tree state and your repository by refusing to work if such local
	changes conflict with the merged result, though.



> +So in the above two "failed merge" case, you do not have to
> +worry about loss of data --- you simply were not ready to do
> +a merge, so no merge happened at all.  You may want to finish
> +whatever you were in the middle of doing, and retry the same
> +pull after you are done and ready.

I am not sure what two cases we were describing.  It could be that this
paragraph was taken from a mailing list message responding to a question
(e.g. "I got this merge failure message and my tree is screwed up.  Please
help me get back to a good state, I am lost...") without copying the
original sample failure scenario.
