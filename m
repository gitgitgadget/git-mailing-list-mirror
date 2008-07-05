From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git, merging, and News/Relnotes files
Date: Sat, 5 Jul 2008 11:38:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807051119170.2815@woody.linux-foundation.org>
References: <g4n7j6$359$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 20:40:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFCg6-0002AM-PR
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 20:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbYGESjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 14:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754973AbYGESi7
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 14:38:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47144 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754850AbYGESi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jul 2008 14:38:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m65IcQaN012111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 Jul 2008 11:38:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m65IcPFe001054;
	Sat, 5 Jul 2008 11:38:25 -0700
In-Reply-To: <g4n7j6$359$1@ger.gmane.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.362 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87458>



On Sat, 5 Jul 2008, Edward Z. Yang wrote:
> 
> Something that I've noticed recently, as we've started migrating away
> from the ghetto SVN development model to the Git branchy model, is that
> this NEWS file ends up being the source of a lot of conflicts. Granted,
> they're easy conflicts to resolve, but still, they make a pull a little
> more complicated than it should be.

I don't think anybody really _uses_ the functionality, but git does have 
the capability to specify special merge drivers based on filenames.

So you can

 (a) create a merge strategy that automaticaly does what you want. There's 
     a built-in driver called "union" that may or may not work for your 
     use case.

     See "Defining a custom merge driver" in "man gitattributes" for more 
     details about this.

 (b) Say which files you want to merge with this driver, by having 
     something like

	NEWS merge=news-merge

     in your .gitattributes file (or in ".git/info/attributes", if you 
     want to keep this all private to your own setup rather than in a 
     committed file that gets distributed to everybody else too).

and now your NEWS file will be merged using your special "news-merge" 
custom merge function.

Of course, the custom merge driver is only done for non-trivial merges. 
Git will do all the trivial fast-forward merges on its own, and only call 
the custom merge driver for things that have actual possible data 
conflicts (ie changes in both branches).

NOTE! Keeping an ordered list (like a ChangeLog or a NEWS file) is 
fundamentally not an easy thing to do in a distributed environment. The 
"union" merge strategy may well work for you (and if it does, this is all 
going to be very easy), but it's also entirely possible that you will find 
that the ordering in a distributed environment is so unspecified, you'll 
prefer to do the merges by hand _anyway_ in the end.

So the first thing you should do is probably to just *try* adding that

	NEWS merge=union

line to your .gitattributes file, and see if it works for you. My personal 
guess is that you'll realize that you really prefer doing the trivial 
merges manually after all, but hey, maybe not. And as mentioned, you *can* 
create your very own merge strategy that knows about the particular rules 
of the files in question, but that gets more complex.

For example, the default 'union' merge will literally _duplicate_ 
identical that were added in both branches. So if you cherry-pick a commit 
so that it exists both in the branch you are merging _and_ the branch you 
are merging into, then any additions to the NEWS file will basically show 
up twice, and yet auto-merge "cleanly".

Which is very understandable, but is almost certainly not what you want.

			Linus
