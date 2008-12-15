From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Mon, 15 Dec 2008 14:13:13 -0800
Message-ID: <7vej09w0hy.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <20081215004651.GA16205@localhost>
 <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
 <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org> <20081215095949.GA7403@localhost>
 <7vskopwxej.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Dec 15 23:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCLi5-0007HJ-5y
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 23:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbYLOWNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 17:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbYLOWNW
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 17:13:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYLOWNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 17:13:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7275C877EA;
	Mon, 15 Dec 2008 17:13:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 36044877E8; Mon,
 15 Dec 2008 17:13:15 -0500 (EST)
In-Reply-To: <7vskopwxej.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 15 Dec 2008 02:22:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94E1182C-CAF5-11DD-BF4C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103211>

Junio C Hamano <gitster@pobox.com> writes:

> Clemens Buchacher <drizzd@aon.at> writes:
>
>> On Sun, Dec 14, 2008 at 07:34:46PM -0800, Junio C Hamano wrote:
>>> merge-recursive: do not clobber untracked working tree garbage
>>> 
>>> When merge-recursive wanted to create a new file in the work tree (either
>>> as the final result, or a hint for reference purposes while delete/modify
>>> conflicts), it unconditionally overwrote an untracked file in the working
>>> tree.  Be careful not to lose whatever the user has that is not tracked.
>>
>> This leaves the index in an unmerged state, however, so that a subsequent
>> git reset --hard still kills the file. And I just realized that the same
>> goes for merge-resolve. So I'd prefer to abort the merge, leave everything
>> unchanged and tell the user to clean up first.
>
> That is unfortunately asking for a moon, I am afraid.
>
> It needs a major restructuring of the code so that the recursive works
> more like the way resolve works, namely, changing the final "writeout"
> into two phase thing (the first phase making sure nothing is clobbered in
> the work tree, and then the second phase actually touching the work tree).

Actually, the more I think about it, I do not think this is not something
we would even want to do.

By this, I do not mean the restructuring to bring some sanity to
merge-recursive.  That is necessary.  What I do not think is unnecessary
is the issue you raise about "git reset --hard".

You can do a merge inside a dirty work tree, and the merge will fail
without clobbering your work tree files that are dirty when it needs to be
able to overwrite to do its job.  The set of "dirty files" in this
sentence of course includes paths that are modified since HEAD, but it
also includes also paths that do not exist in HEAD (i.e. "new files").

But we already caution users that you need to know what you are doing when
working in such a dirty work tree.  Namely, after a failed merge, your
next "git reset --hard" will blow away your local modifications.  And
local modifications in this context includes the files you could have
added to the index but you haven't.

By the way, I think the patch I sent earlier is too complex and
suboptimal for an entirely different reason.

The only reason the codepath for delete/modify in process_entry() wants to
leave the modified side in the result is because the internal merge done
when the algorithm is coming up with a merged merge bases _must_ be fully
resolved.  There is no such requirement for the final round of the merge
whose result is written out to the work tree.  Whether the path that was
involved in delete/modify conflict was originally in the index or not, we
should just leave it alone in the work tree.  The logic I implemented as
the would_lose_untracked() function is just overkill.
