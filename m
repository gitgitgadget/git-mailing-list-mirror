X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some advanced index playing
Date: Sun, 03 Dec 2006 11:36:47 -0800
Message-ID: <7vy7powz3k.fsf@assigned-by-dhcp.cox.net>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
	<Pine.LNX.4.64.0612031008360.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 19:36:57 +0000 (UTC)
Cc: git@vger.kernel.org, Alan Chandler <alan@chandlerfamily.org.uk>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612031008360.3476@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 3 Dec 2006 10:24:11 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33132>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqx8u-0007OL-CK for gcvg-git@gmane.org; Sun, 03 Dec
 2006 20:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760035AbWLCTgt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 14:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760036AbWLCTgt
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 14:36:49 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37532 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1760035AbWLCTgt
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 14:36:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061203193648.CRWV296.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Sun, 3
 Dec 2006 14:36:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uKcD1V00u1kojtg0000000; Sun, 03 Dec 2006
 14:36:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I think that is actually a misfeature. 
>
> This _should_ just work. It's the easy and logical way to do it, and it's 
> the one that matches all the other behaviours of "git commit" these days.
>
> The reason for the safety valve is actually not really "safety" any more, 
> it's purely "historical behaviour". Ie the sanity check is not there 
> because you would be doing anything unsafe, but simply because the 
> behaviour in this area _changed_, so the semantics are different from what 
> they were originally.
> ...
> Or at _least_ there should be a flag to force it.
>
> Junio?

I agree that if this sequence:

	$ edit foo
        $ git update-index foo
        $ edit foo
        $ git commit foo
        
is what the user actually gives from the command line, after
this commit is made, the user would want to _lose_ the state of
foo at the update-index after this commit is made, 100% of the
time (not "most likely", nor "usually", but "always").  So I am
very in favor of removing that check.

I am a bit worried if the reason behind this safety valve might
have been something else, and we describe the reason as "we
would lose data with this sequence otherwise" only to illustrate
what's happening behind the scene in technical terms.

In other words, while I think no user would ever want to keep
the state of foo at update-index after the above exact sequence
as the end-user action, I am worried if a usage sequence that
involve a group of operations encapsulated in a larger command
(a synthetic command that touches index and working files
without making the user painfully aware of the index -- likes of
git-mv, git-rm, ...) might have been the true motivation of the
safety valve.

I need to be reminded by somebody who went back to the list
discussion around the time we introduced --only, and made sure
that the "you would lose the snapshot you staged in the index if
we allowed it" literally meant only that and nothing else; not
some other common sequence that had the above command sequence
inside, and keeping the state of 'foo' at update-index time made
sense for that usage pattern, although I do not think of
anything offhand...

