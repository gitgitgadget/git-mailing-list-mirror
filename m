From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/1] git-tag: Add --regex option
Date: Wed, 04 Feb 2009 09:53:27 -0800
Message-ID: <7v4ozaum08.fsf@gitster.siamese.dyndns.org>
References: <1233677512-1846-1-git-send-email-goulding@vivisimo.com>
 <7vljsm3aow.fsf@gitster.siamese.dyndns.org> <4989A34C.4080104@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 18:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUlxl-0004Bp-V6
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 18:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbZBDRxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 12:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbZBDRxf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 12:53:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZBDRxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 12:53:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BC332A6F9;
	Wed,  4 Feb 2009 12:53:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A30E92A6F0; Wed, 
 4 Feb 2009 12:53:29 -0500 (EST)
In-Reply-To: <4989A34C.4080104@vivisimo.com> (Jake Goulding's message of
 "Wed, 04 Feb 2009 09:16:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCDFA69C-F2E4-11DD-8AB3-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108401>

Jake Goulding <goulding@vivisimo.com> writes:

> Junio C Hamano wrote:
>> Jake Goulding <goulding@vivisimo.com> writes:
>> 
>>> Allows the tag pattern to be expressed as a regular expression.
>> 
>> We use shell globs for refname throughout the system (not just tags).  Why
>> is this a good thing, other than "because we can"?
>
> I'll give the particular use-case that we are using it for:
>
> In preparation for a release, we have a nightly tagging/building
> process. We start by tagging something as 1.0.0-build1. We then do that
> series for a while, then decide it is time to shift to a more thorough
> QA cycle. We branch a QA branch, then start tagging at 1.0-0-rc1.
> Eventually, a rc passes all QA tests and we tag that rc again as 1.0-0.
>
> Thus, our tags look like something of the form:
>
> 1.0.0-build1
> 1.0.0-rc1
> 1.0.0
>
> As we fix bugs, a hook automatically adds the commit hash is as a
> comment to the appropriate bugzilla bug.
>
> We whipped up a dinky little web application that takes a hash and a
> branch, and shows which tags contain that particular hash (which is the
> reason for my previous commit for --contains support in git tag). We
> hacked bugzilla to match on git hashes, and provide a link to this webapp.
>
> I wanted to be able to limit the search space to (builds, rcs,
> releases), but globs don't allow that amount of flexibility.
>
> Is that a complete enough description for a rational use-case?

It certainly describes what you are trying to use it for much better than
a patch that does not say anything other than "because we can".  A patch
marked as RFC could have been written with such an explanation from the
beginning to save everybody's time.

I still do not like the patch, and it is not entirely your fault.

Imagine we are not discussing git nor tags, but doing something similar on
the filesystem (e.g. you have files that store release-notes for key
versions) and would want to have a way to limit the filename arguments you
give to the commands, e.g. "wc -l 1.0.0*".  You most likely would not
patch your shell to accept "set regexpglob; wc -l 1\.0\.0.*".  Instead you
would arrange your naming convention to make it easy to limit to what you
are interested in by globbing.

In that sense, the above explanation does not change the fact at all that
your patch is "because we can".

But that is minor.

I liked the "git-tag --contains" patch, because the ref filters git-branch
has are really ref filters, not branch filters, and should not belong only
to git-branch.  But now that you revealed that you are using the Porcelain
for scripting, it made me realize that these features should be accessible
from the plumbing, perhaps for-each-ref, and your little web application
should be using that, not "git-branch" nor "git-tag".

Currently it cannot, because these useful ref filters are implemented
first at the Porcelain level.  Because the plumbing _is_ meant for people
writing scripts, that is the issue we should be fixing first.

I would have liked the patch if it were a series to refactor the code to
filter refs based on their relationships from "git branch" (one of which
you did with the --contains patch, but --merged, --no-merged should be
addressed, too, I think), and make them available to for-each-ref, branch
and tag.  If done right, adding regexp support or other fancier filtering
can be done by enhancing the shared ref filtering logic once and both
Porcelain and plumbing will benefit.

Adding --regexp only to "git-tag" is going backwards, as you would have to
then sideport that to "git-branch", and the new feature is still not
available to the plumbing.  Seeing such a patch from somebody who improved
the world by freeing --contains from the grip of "git-branch" makes me
moderately unhappy.  It shows that you did not understand why your earlier
patch was a good thing to begin with.
