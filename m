From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Sat, 27 Sep 2008 13:16:03 +1000
Message-ID: <18653.42355.668715.736749@cargo.ozlabs.ibm.com>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 05:19:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjQL6-0000cA-Ko
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 05:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbYI0DSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 23:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYI0DSN
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 23:18:13 -0400
Received: from ozlabs.org ([203.10.76.45]:39351 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbYI0DSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 23:18:12 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6B47FDDDED; Sat, 27 Sep 2008 13:18:11 +1000 (EST)
In-Reply-To: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96897>

Linus Torvalds writes:

> And the thing I wanted to work was to have the abbreviated SHA1's that 
> have started to get more common in the kernel commit logs work as links in 
> gitk too, just the way a full 40-character SHA1 link works.

Fair enough...

> This patch does seem to work, but it's also buggy in exactly the same ways 
> the regular 40-character links are buggy, and while I find those bugs 
> very irritating _too_, I can't cut-and-paste myself to a solution for 
> that.
> 
> The pre-existing bugs that this shares with the long links are:
> 
>  - since gitk started doing incremental showing of the graph, the whole 
>    "check if it exists" doesn't work right if the target hasn't been 
>    loaded yet. And when it _does_ end up being loaded one second later, 
>    nothing re-does the scanning.

Actually there *is* logic in gitk to remember that certain SHA1 ids
are "interesting" and do something when we come across them later.  So
when we see a string of 40 hex digits in a commit message and we don't
recognize that as an ID that we know about, we remember it as an
interesting ID, with the action being to turn the string into a link.
So when the ID turns up later, the string in the commit message
becomes a link.

However, that currently only works for the full 40-character IDs, not
for abbreviations, because the way we remember that the ID is
interesting is with an associative array (i.e. a hash).  What we need
to do is use only the first 6 characters and then have each array
element be a list of (ID, action) pairs, where the ID can now be a
partial ID.

I'd hack it up now except that I just got home from the US and I need
to sleep...

>  - slightly related to the above: when we _do_ find a link, we create it 
>    to be a link to line so-and-so, but since we now don't just 
>    incrementally parse the commits that come in, but gitk _also_ actually 
>    reflows the commits to be in topological order, the link we just 
>    created may actually no longer point to the right line by the time the 
>    link is then clicked on, so clicking on a link can actually take you to 
>    the wrong commit!

Yep, guilty as charged.  We need to defer the ID -> line number
translation until the user actually clicks on the link.

> I suspect that the correct fix is to always do the link, whether we 
> actually see it or not, and not make it point to a line number, but simply 
> keep it as a SHA1, and then do the equivalent of "gotocommit" when 
> clicking it. But I don't know how links workin tcl/tk, so I'm not going to 
> be able to do that.

We need this change in setlink (caution, completely untested):

-	$ctext tag bind $lk <1> [list selectline [rowofcommit $id] 1]
+	$ctext tag bind $lk <1> [list selbyid $id]

> In the meantime, this patch introduces no new bugs, and the workarounds 
> are the same for abbreviated SHA1's as they are for the full ones.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> I'm sure it could have been done better. In particular, I think the 
> "short->long" translation could/should probably be a function of its own. 
> But I'm so uncomfortable with wish programming that I'm not starting to 
> write any new functions..
> 
> Comments? Paul?

The main thing is to change how we handle the commitinterest array so
that we can use it to match on short IDs as well as full 40-char ones.
And yes, we should pull out the short->long translation into its own
function.

Paul.
