From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 09:23:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809110910430.3384@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
 <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl>
 <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org> <48C940C8.6040407@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 18:25:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdoz0-0004jM-Cr
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 18:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbYIKQYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 12:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbYIKQYR
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 12:24:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54350 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751986AbYIKQYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 12:24:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BGNUO3009615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Sep 2008 09:23:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BGNTSg005312;
	Thu, 11 Sep 2008 09:23:29 -0700
In-Reply-To: <48C940C8.6040407@gnu.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.938 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95618>



On Thu, 11 Sep 2008, Paolo Bonzini wrote:
> 
> Yes, but you should not have used Stephen's proposed new option to git
> cherry-pick, just like you shouldn't have used the existing -x option.
> "-x" would not have created a dangling reference, but it would have
> created a puzzling commit message.

But my point is, _none_ of what Stephen proposes has _any_ advantage over 
the already existing functionality.

IOW, absolutely *everything* is actually done better with existing data 
structures, and then just adding tools to perhaps follow those SHA1's in 
the commit message.

The whole "origin" field doesn't have any semantics that make sense for 
core git. It's basically ignored by all normal git operations, and the 
_only_ things that people seem to point out as being features are things 
that can - and obviously in my opinion should - be done by much higher 
levels.

For example, the claim was that it's hard to follow the chain of 
cherry-picks. That's not _true_. Use gitweb and gitk, and you can already 
see them. Sure, you need to use "-x", BUT YOU'D HAVE TO USE THAT WITH 
Steven's MODEL TOO!

Exactly because it would be a frigging _disaster_ if that "origin" field 
was done by default.

And the only thing that "origin" does is:

 - hide the information

 - make it easier to make mistakes (either enable the feature by default, 
   or not notice that you didn't enable it when you wanted to)

 - add a requirement for a backwards-incompatible field that is just 
   guaranteed to confuse any old git binaries.

 - make it _harder_ to do things like send revert/cherry-pick information 
   by email.

See? There are only downsides.

Look at the kernel -stable trees. They explicitly add that cherry-pick 
information, and can add *more*. For example, they go look at

	http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.26.y.git;a=commit;h=cb09de4542ad75cc3b66d0cf1a86217bf5633416

and then go to its parent commit (just click on the parent SHA). And 
notice how the stable kernel tree commits talk about where they were 
back-ported from, or _why_ they aren't back-ports at all!

IOW, there are really two main cases:

 - the common case for cherry-picking: you do not want any origin 
   information, because it's irrelevant, pointless, and *wrong*.

 - you _do_ want origin information, but you actually want to _explain_ 
   explicitly why it's not irrelevant, pointless, or wrong.

And yes, the latter case is about a lot more than "this was 
cherry-picked". It's about "this fixes that other commit we did", or it's 
about "this was anti-cherry-picked - ie reverted". They are all "origins" 
for the commit in the sense that they are relevant to the commit, but they 
all need some explanation of what _kind_ of origins they are.

			Linus
