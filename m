From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-update script to update wc - suggestions welcome
Date: Wed, 20 Jun 2007 14:02:38 -0700
Message-ID: <7vtzt2s5jl.fsf@assigned-by-dhcp.pobox.com>
References: <E1I0tZY-0001Uz-00@www.watts.utsl.gen.nz>
	<7vr6o7uhwz.fsf@assigned-by-dhcp.pobox.com>
	<46798AB6.6060403@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:02:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I17K6-0005pR-MF
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 23:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbXFTVCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 17:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbXFTVCk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 17:02:40 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43542 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbXFTVCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 17:02:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620210239.HGJW2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 17:02:39 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Dx2e1X00G1kojtg0000000; Wed, 20 Jun 2007 17:02:38 -0400
In-Reply-To: <46798AB6.6060403@vilain.net> (Sam Vilain's message of "Thu, 21
	Jun 2007 08:14:46 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50572>

Sam Vilain <sam@vilain.net> writes:

>>>   cd ..
>>>   success=
>>>   if git-diff-files
>>>   then
>>>     
>> ...
>>
>>>     git-reset --hard HEAD && success=1
>>>   fi
>>>     
>>
>> Wouldn't "reset --hard HEAD" pretty much unconditionally nuke
>> your local changes, including added files to the index?  For
>> example, if I do this:
>>
>> 	$ >foo && git add foo && git reset --hard HEAD
>>
>> it would remove the newly added 'foo' from both the index and
>> the working tree.  So I am not quite sure what you are trying to
>> achieve with "diff-index | perl" magic.
>
> Right, but we've already checked using diff-files that there weren't any
> local changes. So all we're saying is "remove all files which won't be
> written by git reset --hard, then checkout new versions of files".

I am afraid I am not following your logic.

I missed that "if git-diff-files"; it is not checking (you would
have to ask for --exit-code or something --- traditionally we
never used git-diff-xxxx exit code to indicate if there is any
changes).

Suppose we update that "if" to see if diff-files says "no change
in the working tree wrt the index".  But then, I think what you
have at the end, "git reset --hard HEAD", where the HEAD is an
arbitrary commit that does not necessarily have to do anything
with what the index is based on, would remove what is known to
the index but not in HEAD.  Which was my point about the
"diff-index piped to perl".  I do not think that one is
necessary.

Actually, more importantly, why is it justified to remove a file
that is unchanged since the index, if the updated HEAD does not
have it?  That is losing information, isn't it?

Or are you assuming that this is used only for a worktree where
there is NO actual development happens, but just kept up to date
to whatever commit comes at HEAD?
