From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-format-patch for binary files / merges [Re: Expose subprojects
 as special files to "git diff" machinery]
Date: Wed, 18 Apr 2007 08:47:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704180831330.2828@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
 <200704152116.26773.andyparkins@gmail.com> <Pine.LNX.4.64.0704151402130.5473@woody.linux-foundation.org>
 <4625DAEE.3090702@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 17:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCNr-0003iN-4q
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 17:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbXDRPrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 11:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbXDRPrr
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 11:47:47 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36449 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033AbXDRPrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 11:47:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IFleYC018517
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 08:47:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IFldOH028263;
	Wed, 18 Apr 2007 08:47:40 -0700
In-Reply-To: <4625DAEE.3090702@vilain.net>
X-Spam-Status: No, hits=-0.464 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44901>



On Wed, 18 Apr 2007, Sam Vilain wrote:
> 
> Speaking of 'custom' patch file formats, anyone put any thought to a
> format for the commits which can't be represented with patch, like
> binary files and merges?

We do already support binary patches, so those can be represented well in 
a patch (but you need "git-apply" to apply them, so they are disabled by 
default.. And while we have tests for them, I suspect not a lot of people 
really use them widely, so who knows how complete the coverage is. For 
example, will "git rebase" really work? Probably. Do I know for sure? No).

As to merges, they are certainly something that *can* be represented as a 
patch (just tell what all the parents were, and desribe the end result as 
a patch against _one_ of them: that already really encodes all the 
information). So we *could* support it with some trivial extension (and I 
don't think the extension is necessarily even an expansion of the diff 
format itself - I think the parents information is a "higher-level" 
information, and independent of the actual patch).

However, representing merges as a patch doesn't really make much sense. 
You really have two separate cases, and neither of them really makes sense 
to have a patch with:

 - you want to "rebase" the history, including merges. Quite frankly, I 
   don't think a patch makes sense: you'd really need to re-do the merge 
   with the old parents "remapped" to the new rebased parents, and what 
   you might want to have is the "rerere" information from the previous 
   merge. Maybe that's a patch, maybe it's not, but regardless, I don't
   think it really makes sense to describe it as a "patch" even if the 
   implementation would do that: you don't do "remote rebases", so 
   whatever it is would really be totally an internal thing to git-rebase.

   We currently simply don't support rebasing history with merges. Rebase 
   is a linear history operation. If somebody wants to try to rebase 
   complex history, I'd applaud the effort, but I think the problems are 
   elsewhere than the actual "patch" part. 

 - you want to send raw git commits to somebody else. Use the native git 
   protocol. We already support that over email, it's called "bundles".

   I used "bundles" once or twice under BK (it was called "bk send" and 
   "bk receive + bk resolve" or something like that), and I hated them. It 
   wasn't BK's fault: I just found the workflow annoying. So I haven't 
   even tested the git bundles, but if what you were looking for was to do 
   a "git push/pull" by email, they are what you'd be using.

(The reason I don't like bundles is that if I use email, I want to see the 
individual patches _in_ the email. And once I see them, I think it's 
better to take advantage of the flexibility that individual patches gives 
me, ie I can re-order them, decide to skip one, edit the messages or 
whatever before applying them. If I were to use bundles, I might as well 
just not blow up my mailbox, and just ask people to tell me where to 
pull from).

			Linus
