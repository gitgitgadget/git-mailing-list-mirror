X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: Missing features in git
Date: 14 Nov 2006 16:38:00 -0500
Message-ID: <20061114213800.28716.qmail@science.horizon.com>
References: <20061114195559.40967ee4.froese@gmx.de>
NNTP-Posting-Date: Tue, 14 Nov 2006 21:38:16 +0000 (UTC)
Cc: linux@horizon.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061114195559.40967ee4.froese@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31381>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk5yp-0004hj-Va for gcvg-git@gmane.org; Tue, 14 Nov
 2006 22:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966380AbWKNViE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 16:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966381AbWKNViE
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 16:38:04 -0500
Received: from science.horizon.com ([192.35.100.1]:16444 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S966380AbWKNViC (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 16:38:02 -0500
Received: (qmail 28717 invoked by uid 1000); 14 Nov 2006 16:38:00 -0500
To: git@vger.kernel.org, torvalds@osdl.org
Sender: git-owner@vger.kernel.org

>>> Another solution would be to be able to put non-head ref in HEAD,
>>> but allow to commit only if the prefix is refs/heads/
>> 
>> That's not a bad idea.  Then you can checkout a tag and have
>> 'ref: refs/tags/v1.11' in HEAD, which means anyone who puts
>> $(git-symbolic-ref) calls into their PS1 will see "refs/tags/v1.11"
>> as their current branch, reminding them they are looking at the past.

> I agree. This would probably be a good way to do "read-only branches".
> 
> Allowing people to do a "git checkout" on anything committish, but then 
> not allowing them to commit to that, is probably the right thing to do.
> 
> Together with a nice readable error message from "git commit" (and merge, 
> and pull - although you might well allow "fetch" to update the thing that 
> current HEAD points to, though), this would be a lot easier to use for 
> people who just follow somebody elses branch.

This certainly seems like a popular idea.  I think the vote is to symlink
(symref) to a non-refs/heads/ object if possible, but allow an arbitrary
object ID as well.  In either case, commits would be forbidden.

The only reason I had avoided symlinking before was in case the tag was
deleted, but that can be fixed easily enough.  (Either make git-tag -d/-f
fail, or have it replace the HEAD symref with a raw hex object.
Actually, you could do the same with git branch -d.  Any opinions?)

I can try to write the patch if there are no better volunteers, although
it'll take me a lot longer that someone more comfortable with the code.

Um.. for example, I'm not sure what the git fetch problem could
possibly be.  It only updates heads, no?  Or are you thinking
of the new refs/remotes thing that I'm not familiar with?

I'll have to examine the callers of git-symbolic-ref to see what
it should do.  Return the hex object ID and fail are the obvious
possibilities.


Note that NOT having any sort of bisect label (and just using HEAD
itself as a raw pointer) solves the "git reset --hard" problem; I can
"git checkout HEAD^" and have debug hacks preserved.

It also removes a paragraph of excuses from some "using git" docs
I'm writing.  It's a lot easier to explain why you can't commit
if you're not on a branch than to explain why you can't not be
on a branch.

Oh, and as I mentioned, not that "git checkout -b <newbranch>" is
exactly painful, but I think a "-b <newbranch>" option to git-commit
would be a convenience.  (An interesting question is whether it should
create the new branch even if there is nothing to.  I'm thinking "yes"
