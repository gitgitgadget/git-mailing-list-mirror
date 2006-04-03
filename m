From: Sam Vilain <sam@vilain.net>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 11:55:58 +1200
Message-ID: <4431B60E.3030008@vilain.net>
References: <4430D352.4010707@vilain.net> <7vsloucuxk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 01:56:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQYuF-0003hU-Rq
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 01:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWDCX4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 19:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWDCX4U
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 19:56:20 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:1682 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S964886AbWDCX4T (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 19:56:19 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 2F5A26241; Tue,  4 Apr 2006 11:56:16 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 88EA1622B;
	Tue,  4 Apr 2006 11:56:01 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsloucuxk.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18362>

Junio C Hamano wrote:

>I suspect people have hard time grasping _why_ you are jumping
>through hoops.  At least I do.  What problem are you trying to
>solve?  You perhaps described your mechanism well enough, but it
>is not quite clear to me what kind of operations are made easier
>with this exercise, against which possible downside of it, if
>any, would be judged.
>[...]
>So can you step back a bit and start from describing what
>problem you are trying to solve, before describing the
>mechanisms you think would help?
>  
>

As a research exercise the principle purpose was first to see if there
is a natural fit with git's data model, and secondly to investigate what
benefits were possible from it. In a sense it was "bottom-up" investigation.

>>  - the current tools make this style of development difficult.
>>    
>>
>Git was born from necessity, and we have been aiming to have
>tools to do what are commonly needed.  It is not surprising to
>see existing tools do not support modes of operations that are
>"unusual" (meaning, things we have not done with git so far).
>Also we do not tend to do things only because we can.
>  
>

And a good principle that is, too.

>For example, the point jdl raised during the discussion is far
>easier to understand.  When working on multiple topics, he often
>needs to test them as a whole, so he pulls them into a test
>branch (can be a throwaway branch).  When he needs to do fixups,
>it is most efficient to do compile/run test while still in the
>test branch, but after things test out, in order to keep
>logically different things separate, he needs to go back to
>relevant topic branches and make a commit.  This is painful --
>are there ways to make this easier [*2*]?
>
>Would patch commutation calculus help with his problem?
>  
>

I'd provisionally say "yes, that's the fit". It's just like having
multiple topic branches all checked out at once, with commits going to
the appropriate branch as necessary.

In my experiment, when a commit touched files on more than one head,
then the heads would be collapsed to a single one, like a merge. As the
nature of the setup was such that you didn't explicitly name heads, this
was a natural thing to do. But if you're naming them, you probably would
want some way to choose between applying the commit to just one head,
both heads, or collapsing the two heads into one.

That approach actually offers the most flexibility - a porcelain could
do full darcs-like patch calculus if it wanted, or saner explicit topic
branching.

>One thing I can think of that could potentially come out of your
>approach would be an alternative implementation of what StGIT
>does.  Inside a local developer repository, being able to
>reorder patches and rewrite them flexibly is very useful.
>  
>

Oh, I didn't think of that. Were you thinking of an extra head for each
"uncommitted" chain of related patches? That's an interesting idea.

I think it might really help use cases like the -mm Linux tree, where
bunches of related commits are typically applied in a series, but you
especially want to track inter-set dependencies. Currently stgit takes a
very long time to import the split -mm series :-)

>Another obvious strategy would be to make commits on top of
>"test" and then cherry-pick them back on top of the relevant
>topics later.
>    
>        topicA                  You have three topics
>         o---o                  you need to test together...
>        /
>  [...]
>        \         /
>         o---o---2'
>        topicC
>  
>

That's a nice illustration of it, yes.

Sam.
