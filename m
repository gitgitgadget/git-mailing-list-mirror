From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git stash: Avoid data loss when saving a stash
Date: Sat, 6 Jul 2013 16:42:14 +0200
Message-ID: <20130706144214.GM12252@machine.or.cz>
References: <7vhaghnct4.fsf@alter.siamese.dyndns.org>
 <20130630132017.GQ12252@machine.or.cz>
 <7vppv3jtrh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 06 16:42:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvTgv-0006Gj-Rr
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 16:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab3GFOmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 10:42:20 -0400
Received: from pasky.or.cz ([84.242.80.195]:55620 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab3GFOmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 10:42:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1E1E21700067; Sat,  6 Jul 2013 16:42:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vppv3jtrh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229703>

  Hi!

  (tl;dr - I disagree but this issue is perhaps not so important
in practice)

On Sun, Jun 30, 2013 at 12:14:26PM -0700, Junio C Hamano wrote:
> I do not agree with your `git reset --hard` at all.  With the
> command, the user demands "no matter what, I want get rid of any
> funny state in my working tree so that I can start my work from that
> specified commit (default to HEAD)".

  Yeah, but this normally concerns only tracked files; `git reset
--hard` does not imply `git clean`. I'm worried when a tool normally
behaves in a way that follows an apparent rule but its behavior is
defined in such a way that in a corner case this rule is violated (but
it's ok since it's a - non-obvious - implication of the specification).

> Imagine that this is you did to arrive that "funny state":
> 
> 	$ git rm foo ;# foo used to be tracked and in HEAD
>         $ cp /somewhere/else/foo foo
> 	$ cp /somewhere/else/bar bar ;# bar is not in HEAD
> 	$ cp /somewhere/else/bar baz ;# baz is in HEAD
>         ... do various other things ...
> 
> and then "git reset --hard".  At that point, "foo" and "bar" are not
> tracked and completely unrelated to the project.  "baz" is tracked
> and have unrelated contents from that of "HEAD".
> 
> In order to satisfy your desire to go back to the state of HEAD with
> minimal collateral amage, we need to get rid of the updated "foo"
> and "baz" and replace them with those from HEAD.  We do not have to
> touch "bar" so we leave it as-is.

  Perhaps we misundertood each other here. I certainly don't care to
keep local changes as a whole - a command behaving like that wouldn't
be very useful for me; for me, the crucial distinction is between
tracked and untracked files. Therefore, from my viewpoint it's fine
to overwrite baz, but not to overwrite foo.

> And the "killed" case is just like "foo" and "baz".  If the state
> you want to go back to with "--hard" has a directory (a file) where
> your working tree's funny state has a file (a directory), the local
> cruft needs to go away to satisify your request.
> 
> I do not mind if you are proposing a different and new kind of reset
> that fails if it has to overwrite any local changes (be it tracked
> or untracked), but that is not "reset --hard".  It is something else.

  Hmm, I suppose the assumption I would prefer is that "the only command
that will destroy (currently) untracked data without warning is `git
clean`"; even though (unlike in case of git stash) the current reset
--hard behavior wouldn't surprise me, I suspect it can be a bad surprise
for many Git users when they hit this situation; but since I didn't
notice any actual complaint yet, so I don't care enough to press this
further for now anyway. :-)

-- 
				Petr "Pasky" Baudis
	For every complex problem there is an answer that is clear,
	simple, and wrong.  -- H. L. Mencken
