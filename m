From: Jake Goulding <goulding@vivisimo.com>
Subject: Re: [RFC PATCH 1/1] git-tag: Add --regex option
Date: Wed, 04 Feb 2009 14:36:00 -0500
Message-ID: <4989EE20.1010307@vivisimo.com>
References: <1233677512-1846-1-git-send-email-goulding@vivisimo.com> <7vljsm3aow.fsf@gitster.siamese.dyndns.org> <4989A34C.4080104@vivisimo.com> <7v4ozaum08.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 20:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUnYw-0002ve-Sf
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 20:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZBDTgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 14:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZBDTgF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 14:36:05 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:59508 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZBDTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 14:36:04 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id 25640853EB0;
	Wed,  4 Feb 2009 14:36:02 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id EDD352E68D0;
	Wed,  4 Feb 2009 14:36:01 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a1-NHKx-GwPI; Wed,  4 Feb 2009 14:36:01 -0500 (EST)
Received: from [192.168.0.20] (jpg-melchior.vivisimo.com [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id F11D42E68CF;
	Wed,  4 Feb 2009 14:36:00 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7v4ozaum08.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108415>

Junio C Hamano wrote:
> Jake Goulding <goulding@vivisimo.com> writes:
> 
>> Is that a complete enough description for a rational use-case?
> 
> It certainly describes what you are trying to use it for much better than
> a patch that does not say anything other than "because we can".  A patch
> marked as RFC could have been written with such an explanation from the
> beginning to save everybody's time.

My apologies - my previous patch, as you pointed out, was more
self-evident, and I felt this one was too.

> Imagine we are not discussing git nor tags, but doing something similar on
> the filesystem (e.g. you have files that store release-notes for key
> versions) and would want to have a way to limit the filename arguments you
> give to the commands, e.g. "wc -l 1.0.0*".  You most likely would not
> patch your shell to accept "set regexpglob; wc -l 1\.0\.0.*".  Instead you
> would arrange your naming convention to make it easy to limit to what you
> are interested in by globbing.

This is true. In this case, I would instead post-process the globbed
list with my regex, then pass the munged list to wc. I thought about
doing something similar here, where I would do the list, munge it, then
perform the contains test. Since I had just messed with git tag,
however, I felt like messing some more. :-) I

> I liked the "git-tag --contains" patch, because the ref filters git-branch
> has are really ref filters, not branch filters, and should not belong only
> to git-branch.  But now that you revealed that you are using the Porcelain
> for scripting, it made me realize that these features should be accessible
> from the plumbing, perhaps for-each-ref, and your little web application
> should be using that, not "git-branch" nor "git-tag".

This is a good point. I originally started by using for-each-ref, then
realized that it did not have contains. Someone on IRC suggested I look
at the functionality in git branch, and copy over to git tag. That is
how I arrived at the previous patch series.

> Currently it cannot, because these useful ref filters are implemented
> first at the Porcelain level.  Because the plumbing _is_ meant for people
> writing scripts, that is the issue we should be fixing first.

This is something that I constantly forget, and it happened again in
this case. I get so used to using the porcelain in day-to-day use, it is
the most prevalent thing in my head when I go to write simple scripts.

> I would have liked the patch if it were a series to refactor the code to
> filter refs based on their relationships from "git branch" (one of which
> you did with the --contains patch, but --merged, --no-merged should be
> addressed, too, I think), and make them available to for-each-ref, branch
> and tag.  If done right, adding regexp support or other fancier filtering
> can be done by enhancing the shared ref filtering logic once and both
> Porcelain and plumbing will benefit.

> Adding --regexp only to "git-tag" is going backwards, as you would have to
> then sideport that to "git-branch", and the new feature is still not
> available to the plumbing.  Seeing such a patch from somebody who improved
> the world by freeing --contains from the grip of "git-branch" makes me
> moderately unhappy.  It shows that you did not understand why your earlier
> patch was a good thing to begin with.

Well, in my defense, it still is a good thing, just not as good as it
could have been. I will admit that I do not have a total grasp of the
git code, but I figured (correctly) that someone would be kind enough to
point it out when I show my ignorance ;-).

I agree that it feels dumb to add this type of functionality to git tag
and not git branch (and not to the plumbing).

I'm sure that adding the regex support to for-each-ref would be nearly
as trivial as it was for git tag, and I will happily do that instead of
this patch.

What I am not as clear about is how I can then use that functionality in
git tag/branch. The main code I messed with in git tag calls
for_each_tag_ref (and for_each_ref in branch). Would it be appropriate
to add a struct reference_filter to these functions?

Really, that is what I am trying to accomplish - to have finer-grained
filtering on the references that are being enumerated.

If that seems fine, then I will work on refactoring that code. If not,
let me know. :-)

-Jake
