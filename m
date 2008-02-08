From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH 3/4] git.el: Check for existing buffers on revert.
Date: Fri, 08 Feb 2008 20:10:53 +0300
Message-ID: <87prv7z84i.fsf@osv.gnss.ru>
References: <87r6fporp3.fsf@wine.dyndns.org> <87ve4zzfkl.fsf@osv.gnss.ru>
	<8763wzwlat.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNWlx-0000Yn-6D
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 18:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbYBHRLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 12:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbYBHRLM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 12:11:12 -0500
Received: from javad.com ([216.122.176.236]:1982 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965230AbYBHRLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 12:11:09 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m18HAxd17900;
	Fri, 8 Feb 2008 17:10:59 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JNWkX-0001FE-Lt; Fri, 08 Feb 2008 20:10:53 +0300
In-Reply-To: <8763wzwlat.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Fri\, 08 Feb 2008 15\:54\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73114>

Alexandre Julliard <julliard@winehq.org> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> What's the point? What if I do want to have modified buffer and still
>> revert the on-disk file? Why git-revert cares to the level of
>> prohibiting this?
>>
>> Besides, it's inconsistent with the rest of Emacs, I think, as in
>> similar situations Emacs usually allows to either save the buffer(s), do
>> not save the buffer(s) and continue, or abort operation (I suppose using
>> (save-some-buffers) call, though I didn't check). See, for example, how
>> (compile) behaves when some of buffers are not saved.
>
> It's modeled on the vc-revert behavior, but yes, it could also prompt
> whether to discard changes; prompting to save doesn't make sense if you
> are about to throw away the changes.

Yes, and I think that prompting makes more sense at the time we try to
actually revert buffer from disk. Besides this allows to eliminate the
first check for modified buffers altogether.

And I'd put this (revert some buffers with prompt) into a separate
function as I foresee a need for such a function when, say,
git-checkout, or any other command that changes working files will be
implemented.

> I think reverting the file on disk without changing the buffer is
> confusing: either you want to discard the changes, and you want to
> discard the buffer changes too, or you want to keep your changes, and
> reverting the file on disk doesn't make sense since the revert will be
> undone as soon as you save the buffer.

I think that prompting is the best solution. It won't be a frequent
situation, so prompting won't be annoying. Though this will differ both
from VC and PCVS behavior.

BTW, there is another related issue: what to do with buffers for which their
files disappear (are removed). AFAIK PCVS doesn't close such buffers,
that according to the above logic is confusing as well.

>> In fact I believe the way PCL-CVS handles this, and that was implemented
>> in my earlier patch, is superior compared to this patch. An addition of
>> save-some-buffers call won't hurt either, but IMHO is not very useful in
>> the specific case of git-revert.
>>
>> BTW, what definitely lacks (save-some-buffers) call is git-commit, as it
>> silently commits on-disk state of a file when corresponding buffer is
>> modified.
>
> This could certainly be done, though it would have to be smarter than
> a simple (save-some-buffers), I find it very annoying when compile
> prompts to save a bunch of unrelated files.

[And so do I, but unlike git-commit, compile has no clue of what files
are relevant (though it does lack a method to ignore buffers by, say,
regexp of buffer name).]

I agree git-commit could be made smarter. Fortunately, save-some-buffers
has /pred/ argument that allows for arbitrary filtering of buffers to be
considered.

-- Sergei.
