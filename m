From: Jeff King <peff@peff.net>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 17:50:03 -0500
Message-ID: <20150212225003.GA20763@peff.net>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
 <20150212092824.GA19626@peff.net>
 <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
 <CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
 <xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
 <CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
 <xmqq4mqqrc70.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:50:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM2aT-0008Uw-7K
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 23:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbbBLWuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 17:50:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:48430 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751246AbbBLWuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 17:50:06 -0500
Received: (qmail 7089 invoked by uid 102); 12 Feb 2015 22:50:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 16:50:06 -0600
Received: (qmail 28829 invoked by uid 107); 12 Feb 2015 22:50:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 17:50:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2015 17:50:03 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mqqrc70.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263778>

On Thu, Feb 12, 2015 at 02:34:43PM -0800, Junio C Hamano wrote:

> I actually was hoping that this would extend to cases other than
> "git merge --squash".
> 
> When running "git commit" and:
> 
>  - You didn't use a more explicit method of specifying the
>    authorship identity (--author, --date, -C, -c --amend,
>    --reset-author options, or environment variables GIT_AUTHOR_*);
> 
>  - You have commit.useAuthorFromEditorComment variable;
> 
>  - You have "# Author: " line that are identical in the result of
>    the editor,
> 
> then use that author.  That would allow "git commit --amend" to
> update a misspelled author name, for example.
> 
> Is that a bit too liberal?  Would it invite mistakes?

I like this direction in general.

What happens if there is no "Author:" line in the output? Do we do the
equivalent "--reset-author"? That seems slightly error-prone to me. It
is not uncommon for me to delete to the end file in my editor to drop
cruft (e.g., in an interactive rebase with a "squash" command, I very
often drop the final commit message, and it is simpler to just delete to
the end of file than to delete to the top of the comment block).

I wonder if we should have some markers in the commented-out section
that indicate it even exists, like:

  # --- Lines in this section affect the commit authorship ---
  # Author: ...
  # ---

Of course that is nice when you are editing an existing Author line, but
not so much when you have to remember to type that line yourself
(because you are adding an author attribution when there was not one
before).

So probably a saner thing is that a missing "Author:" line does nothing,
and using "Author: " (with no text) does a reset.

Also, on the topic of "merge --squash". I never use it myself, but
having experimented with it due to this thread, I found the template it
sticks into COMMIT_EDITMSG to be horribly unfriendly for munging. For
example, with two simple commits, I get:

    Squashed commit of the following:
    
    commit 6821a8ac920ed00675e4aec10dcef705211105cd
    Author: Jeff King <peff@peff.net>
    Date:   Thu Feb 12 17:39:28 2015 -0500
    
        commit subject 2
    
        commit body 2
    
    commit b0840bb4bbfe00b6ed8c7c4d483f11d126fa2d69
    Author: Jeff King <peff@peff.net>
    Date:   Thu Feb 12 17:39:28 2015 -0500
    
        commit subject 1
    
        commit body 1

I guess that is helpful if you want to keep a complete log of what got
squashed, but I doubt that is the common case (if you did, then doing a
real merge would probably be in order). But to munge that into a usable
single commit message, I have to:

  1. Drop the header fields. We could mark these with "#" instead (which
     would also make the "# Author: " proposal here work.

  2. Reindent all of the actual message lines!

  3. Probably reorder the commit messages, since they are
     reverse-chronological here.

I would find something like:

    # commit b0840bb4bbfe00b6ed8c7c4d483f11d126fa2d69
    # Author: Jeff King <peff@peff.net>
    # Date:   Thu Feb 12 17:39:28 2015 -0500
    
    commit subject 1
    
    commit body 1

    # ... and then the second commit ...

much more friendly, and closer to what interactive rebase's squash does.
It also raises a question for the proposal in this thread: if there are
multiple "Author:" lines, which one do we take? The first, or the last?
I think in the proposed chronological-order format I just showed, it
would make sense to take the first.

-Peff
