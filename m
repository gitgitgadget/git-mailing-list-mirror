From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: 2 questions/nits about commit and config
Date: Sun, 5 Feb 2006 01:14:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602050053280.6773@iabervon.org>
References: <20060204212337.GA8612@blinkenlights.visv.net>
 <7voe1mvkls.fsf@assigned-by-dhcp.cox.net> <7vhd7evk38.fsf@assigned-by-dhcp.cox.net>
 <1139094055.4200.6.camel@evo.keithp.com> <7vu0bemkce.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Packard <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 07:15:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5dB2-0005UE-PH
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 07:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946158AbWBEGOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 01:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946159AbWBEGOL
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 01:14:11 -0500
Received: from iabervon.org ([66.92.72.58]:30225 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1946158AbWBEGOK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 01:14:10 -0500
Received: (qmail 18649 invoked by uid 1000); 5 Feb 2006 01:14:09 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2006 01:14:09 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0bemkce.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15624>

On Sat, 4 Feb 2006, Junio C Hamano wrote:

> Here is me thinking aloud again.
> 
>  - "git commit" without _any_ parameter would keep the current
>    behaviour.  It commits the current index.
> 
>    We have two choices.  (1) we disallow this form to be run in
>    a subdirectory, or (2) we do the whole index even when this
>    form was run from a subdirectory.  I am inclined to say the
>    latter.

I'd guess this would primarily happen when the user goes into a 
subdirectory to look at related files when resolving a conflicted merge. 
If you're committing the prepared index, the working tree isn't 
particularly important, so the pwd isn't, either.

>  - "git commit paths..." acquires a new semantics.  This is an
>    incompatible change that needs user training, which I am
>    still a bit reluctant to swallow, but enough people seem to
>    have complained.  It
> 
>    1. refuses to run if $GIT_DIR/MERGE_HEAD exists (maybe
>       remind trained git users that the traditional semantics
>       now needs -i flag).
>    2. refuses to run if named paths... are different in HEAD and
>       the index (ditto about reminding).
>    3. reads HEAD commit into a temporary index file.
>    4. updates named paths... from the working tree in this
>       temporary index (similar to -i form, we never --add).

I think the following sequence should be permitted:

% git add foo
% git commit foo

I think this means we want --add in step 4, but want to check that the 
named paths exist in the index in step 3, although they're allowed to not 
exist in HEAD.

>    5. does the same updates of the paths... from the working
>       tree to the real index.
>    6. makes a commit using the temporary index that has the
>       current HEAD as the parent, and updates the HEAD with this
>       new commit.
> 
>    The first check is needed because otherwise during a merge
>    you would end up inserting an unrelated commit between the
>    original HEAD and the eventual merge result.  The second
>    check is to prevent "skewed commit" from confusing people.
>    If you updated index, modified the file further and then used
>    "git commit paths..." to make a commit, next "git commit"
>    without paths would record a partial revert otherwise.
> 
>    For this one, I think running from subdirectory is a natural
>    thing to allow.
> 
>  - "git commit --all".  Now what should we do about this?  As
>    you reminded me, it is equivalent to "git commit -i ." if run
>    from the toplevel (because of the "index must match HEAD on
>    named paths" requirements for the partial commits with named
>    paths, it is equivalent to "git commit ." only if your index
>    is clean).  I am inclined to say that this should commit all
>    changes in the whole working tree, regardless of where it is
>    run.

Agreed.

	-Daniel
*This .sig left intentionally blank*
