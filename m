From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An interaction with ce_match_stat_basic() and autocrlf
Date: Wed, 09 Jan 2008 18:11:31 -0800
Message-ID: <7vzlvea0q4.fsf@gitster.siamese.dyndns.org>
References: <7vfxx8tt1z.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801080748080.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 03:12:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCmuK-0007aj-UH
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 03:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbYAJCMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 21:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbYAJCMF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 21:12:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYAJCMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 21:12:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E4D35117B;
	Wed,  9 Jan 2008 21:11:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CA7D117A;
	Wed,  9 Jan 2008 21:11:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70033>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This patch should fix it, but I suspect we should think hard about that 
> change to ie_modified(), and see what the performance issues are (ie that 
> code has tried to avoid doing the more expensive ce_modified_check_fs() 
> for a reason).
>
> The change to diff.c is similarly interesting. It is logically wrong to 
> use the worktree_file there (since we have to read the object anyway), but 
> since "reuse_worktree_file" is also tied into the whole refresh logic, I 
> think the diff.c change is correct.
>
> I dunno. This is not meant to be applied, it is meant to be thought about.

There are a few cases around the changing value of autocrlf (and
filter attributes --- anything that affects convert_to_git() and
convert_to_working_tree()).

 * The cached stat information matches the work tree, but user
   changed convert_to_working_tree().  "git diff" reports
   nothing.  The user needs to remove the work tree file and
   check it out again.

 * The cached stat information matches the work tree, but user
   changed convert_to_git().  Again, diff reports nothing.  The
   user needs to "git add" to cause rehashing.

 * The cached stat information does not match.  What the working
   tree file stores hasn't changed, but convert_to_git() was
   changed.

   The fact that the working tree "file" contents did not change
   does not have much significance in this case.  What defines
   the "contents" as far as git is concerned is the combination
   of the working tree file contents _and_ what convert_to_git()
   does to it.

   Depending on the nature of the change to convert_to_git(),
   "git diff-files" may or may not report real changes in this
   case.

 * The working tree file has changed, and convert_to_git() also
   has changed.

   Depending on the nature of the change to convert_to_git(),
   "git diff" may or may not report change in this case.  The
   most extreme case is when unix2dos is run on the working tree
   file and convert_to_git() is made to strip CR.  The object
   registered in the index won't change in this case.

   But in practice, the most problematic case also falls into
   this category.  The user has _real_ changes to the work tree
   file, but at the same time flipped convert_to_git() to
   operate differently from before.  Users should not be making
   such a change, not because of git, but because a commit like
   that will be impossible to review (and understand three
   months later while archaeologying).

The ie_modified() change you suggested will not be hurt by the
first two cases (which I see are one-shot events and re-checkout
and re-add are good enough solution to them, and I do not want
them to hurt the performance for normal use cases).

I originally thought it was a _bug_, but I suspect the false
positive changes reported by "git diff" is even a good thing.
