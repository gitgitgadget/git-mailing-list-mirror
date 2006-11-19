X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 16:29:27 -0800
Message-ID: <7vmz6o9t3s.fsf@assigned-by-dhcp.cox.net>
References: <20061118041137.6064.75827.stgit@machine.or.cz>
	<7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net>
	<20061118045323.GK7201@pasky.or.cz>
	<7vzmapdxki.fsf@assigned-by-dhcp.cox.net>
	<20061118192830.GP7201@pasky.or.cz>
	<7vejs0cz5s.fsf@assigned-by-dhcp.cox.net>
	<7vy7q8bjwn.fsf@assigned-by-dhcp.cox.net>
	<20061118231842.GS7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 00:29:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118231842.GS7201@pasky.or.cz> (Petr Baudis's message of
	"Sun, 19 Nov 2006 00:18:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31816>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlaYu-0004o4-3e for gcvg-git@gmane.org; Sun, 19 Nov
 2006 01:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755445AbWKSA33 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 19:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755447AbWKSA33
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 19:29:29 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:59560 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1755445AbWKSA32
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 19:29:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061119002927.YSL21630.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 19:29:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oQUz1V00E1kojtg0000000; Sat, 18 Nov 2006
 19:29:00 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> On Sat, Nov 18, 2006 at 09:05:12PM CET, Junio C Hamano wrote:
>> 	use heads/private/ for your own stuff.  And have
>> 	configuration that says "heads/private/" are private
>> 	branches that are not subject to default
>> 	pushing/pulling.
>> 
>> The real instruction from the project would say what the syntax
>> for telling that to git but I think you got the idea...
>
> Yes, I fully agree that being able to have this configurable is cool,
> but I'm still interested in providing a sensible out-of-the-box default
> configuration for Cogito to use. But if we can agree that heads/private/
> and tags/private/ are good BCP candidates, that's great. (The only
> possible problem is a lot of typing incurred. Perhaps the default refs
> search order should become configurable first.)

It is not clear from the discussion so far why it is necessary
(or even is a good change), and I suspect a confusion to mix up
two different things has slipped in somewhere in the discussion.

My understanding of your original plan was to use ".foo" as
a private thing for Cogito to use to implement some cleverness
when the user talks about the branch "foo" (just like StGIT
uses "refs/bases/foo" to keep track of its private stuff related
to user branch "foo").  When the user says "my 'foo' branch",
you were going to munge that name into ".foo" and use both to
implement that cleverness (just like StGIT uses "refs/bases/foo"
in addition to "refs/heads/foo" when the user is talking about
his branch "foo").

I would rather think that it would actively be a bad thing to
make the core level to consider heads/private/foo and heads/foo
ambiguous.  When the user says "my 'foo' branch" that should
mean the "foo" branch not the "private/foo" branch.

Which certainly suggests that heads/private/, as a user visible
convention to keep developer-repository private stuff for local
use, is too verbose.

StGIT's use of refs/bases (i.e. outside refs/heads) is probably
sensible because it is not something the end user should
directly muck with nor check out.  If Porcelains want some
"special branch" for their own use to do their magic, however,
the ref cannot be outside refs/heads for it to be pointed at by
HEAD to become the "current branch" ("bisect" command comes to
mind, and I suspect "cg-seek" would have similar issues).  But
that kind of use is all under controll of the Porcelain, and I
would imagine "too long to type" objection would not apply.
