From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: fsck objects and timestamp ordering
Date: Mon, 25 Sep 2006 10:03:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609250951220.3952@g5.osdl.org>
References: <9e4733910609250932r146fea7alaaf858a18a8b50b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 25 19:04:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRtrz-0003KZ-PJ
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 19:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWIYRDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 13:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWIYRDk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 13:03:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751263AbWIYRDj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 13:03:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8PH3RnW000327
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Sep 2006 10:03:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8PH3OAr022491;
	Mon, 25 Sep 2006 10:03:25 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609250932r146fea7alaaf858a18a8b50b0@mail.gmail.com>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.152 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27745>



On Mon, 25 Sep 2006, Jon Smirl wrote:
>
> When running fsck objects, does it verify that timestamps are ordered
> in the same order as the dependency chains?

No. In fact, it's perfectly normal that they aren't.

Two machines with different timestamps will think time is different, and 
then one side doing a merge may have it's parents "in the future" from 
itself.

You can't even solve it sanely: you can't change the other sides 
time-stamps after the fact, and correcting the _merge_ timestamp to be 
later than both parents is a fix worse than the problem, since it would 
tend to just perpetuate a buggy timestamp further down the line.

So this is very fundamental. The first rule of distributed computing is: 
"There is no common time". Any distributed project that thinks such a 
thing exists is just fundamentally flawed, so I'd have been personally 
embarrassed by such a design decision.

So the only thing that matters is always the dependency chain. We've 
occasionally discussed having "sequence numbers" or other things to make 
it easier to decide on partial ordering between commits without having to 
actually follow the whole dependency chain, but times and dates is _never_ 
a valid thing to use for that.

> I am having trouble with a CVS repository where the timestamp ordering
> and dependency order are in conflict. It would be best if git didn't
> experience the same problem.

It's not really a problem. The timestamps don't "matter". The only thing 
git really cares about is the dependency order.

If commit timestamps aren't ordered, some of our programs may look at 
unnecessarily many commits because the heuristics use the (committer) 
timestamp as a way to guess which leg of a parenthood chain to take, but 
that's just a guess.

And the authorship timestamp is never used at all, except purely for 
output. So they show up in the log messages, but you can think of them as 
nothing more than the commit commentary. 

			Linus
