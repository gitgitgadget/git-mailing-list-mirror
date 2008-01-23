From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Wed, 23 Jan 2008 12:01:03 -0800
Message-ID: <7vzluwgvls.fsf@gitster.siamese.dyndns.org>
References: <7vfxwpqvfg.fsf@gitster.siamese.dyndns.org>
	<47977792.5080001@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:01:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHlnC-0001Gj-I9
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 21:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYAWUBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 15:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbYAWUBU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 15:01:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbYAWUBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 15:01:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8482F3C51;
	Wed, 23 Jan 2008 15:01:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6925D3C4F;
	Wed, 23 Jan 2008 15:01:11 -0500 (EST)
In-Reply-To: <47977792.5080001@nrlssc.navy.mil> (Brandon Casey's message of
	"Wed, 23 Jan 2008 11:21:22 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71566>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> In certain rare cases, the creation of the commit object
> and update of HEAD can succeed, but then installing the
> updated index will fail. This is most likely caused by a
> full disk or exceeded disk quota. When this happens the
> new index file will be removed, and the repository will
> be left with the original now-out-of-sync index. The
> user can recover with a "git reset HEAD" once the disk
> space issue is resolved.
>
> We should detect this failure and offer the user some
> helpful guidance.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---

Thanks, looks much better, especially with S-o-b: line.

>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>> If you're interested, here's a patch.
>> 
>> Looks Ok from a quick glance.  I am mired at day job this week
>> so it may take a while for me to come up with a commit log
>> message though.
>
> Oh, I had /ASS/u/ME/d this was simple enough that the one-liner
> was sufficient.

I do not get the funny punctuation, sorry.

Anyway, here is a bit more detailed reason behind my request.

 (1) The subject is primarily to help people who look at
     shortlog (or "gitk") to get the overview of recent changes,
     or in general "changes within a given range".

     Readers are most interested in what areas are affected
     (e.g. the command from the end-user's point of view, or the
     internal implementation) and what the nature of the change
     was (e.g. bugfix vs enhancement).  To help them, the
     Subject: line summarizes "what the change is about".

     Your Subject: line is _perfect_.  It identifies the area as
     "git-commit" instead of "builtin-commit.c", because it is
     not about fixing internal implementation of that file, but
     about the end-user experience interacting with the command.
     It also makes it clear that it is a fix by saying that we
     failed to exit with non-zero status code upon some failure.

 (2) The body of the commit log message is primarily to help
     people who look at this particular commit 6 months down the
     road to see why things got there that way.  

     Reason behind the logic in the code _after_ the change can
     be left in in-code comments.  The reason behind the change
     itself (why the logic behind the code _before_ the change
     was faulty or insufficient, and the logic behind the new
     code is better) is not captured well in such a comment (and
     we do not want to clutter the code comments with a long "in
     ancient versions we used to do this but then we updated it
     to do that but now we do it this way instead." --- I made
     that mistake earlier and I suspect some of the older source
     files still have them).

     The commit log message should describe why the change was
     needed (e.g. "The earlier code assumed X because it knew Y
     won't happen, but that is not the case anymore since commit
     Z, so this code stops relying on that assumption and
     implements the logic this way instead"), why the proposed
     implementation was thought to be the best one to choose
     (e.g. "We alternatively could do W and it may have some
     performance edge, but this way the code is simpler and in
     my benchmark with real life data I did not see significant
     gain from the added complexity").

     How the code was changed in this commit does not need to be
     described; that can be seen in "git show $this_commit"
     output easily.

In this particular case, I think it is probably sufficient to
briefly describe what "failure to commit the index", mentioned
in the summary line, means.  For more complex fixes and
enhancements, it would make a good log message to also describe
what the plausible cases the updated codepath is triggered, from
the point of view of the committer/author when making the commit
(IOW, what scenarios the updated behaviour intends to handle),
like you did in this version.

Such a description will help the person who finds the change was
faulty or insufficient 6 months down the road by allowing him to
say "Aha, the change considered these cases but forgot to
consider this case, and missed the fact that this part of the
code needs to work differently in that particular case" while
making further fixes.  Otherwise the person will be left
wondering if the omission of handing that case he encountered
was deliberate or a simple oversight.  With the comment, he can
make his fix with more confidence.

In addition, at the end of the body, there is expected to be
your S-o-b: line, so it will never be "1-liner".

In any case, thanks for a fix.  Will apply.
