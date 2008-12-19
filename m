From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 16:46:51 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812181637140.14014@localhost.localdomain>
References: <1229642734.5770.25.camel@rotwang.fnordora.org>  <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>  <1229645511.5770.29.camel@rotwang.fnordora.org>  <alpine.LFD.2.00.0812181614070.14014@localhost.localdomain>
 <1229646948.5770.33.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDTXt-0007kZ-If
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbYLSArW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbYLSArV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:47:21 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38463 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752883AbYLSArU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 19:47:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ0kqAe004240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 16:46:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ0kpeE006716;
	Thu, 18 Dec 2008 16:46:51 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1229646948.5770.33.camel@rotwang.fnordora.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.423 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103523>



On Thu, 18 Dec 2008, Alan wrote:
> 
> So what is the recommended way to undo mistaken merges caught after the
> fact that will not fubar later merges?

Oh, I suspect reverting is the right thing, it's just that then you need 
to remember to revert the revert if you intend to merge that branch again 
later.

So reverting a merge isn't _wrong_ per se. It's just that you need to be 
aware of the consequences, and if it becomes a common situation, you have 
a problem in your usage patterns.

Btw, even with non-merge commits, "revert" can have interesting effects 
exactly because it doesn't change history. For example, let's say that you 
had a history like this, with two branches:

	--> a --> b --> c --> d
	      |
	      +-> e --> !a

where the second branch reverts 'a', but the first one does not. What 
happens when you merge the two branches? Is the revert sticky? In this 
case, yes, a merge will cause the revert to stick. But what happens if you 
had

	--> a --> b --> c --> d
	      |
	      +-> e --> f --> !e

and 'b' and 'e' were the same patch (just applied in two different 
branches), and '!e' reverts that patch in the second branch. What happens 
to 'b' when you merge? Would you expect for 'b' to go away, since the 
revert undid the same data in the second branch?

In that second case, the revert of 'e' will basically make git act as if 
'e' didn't happen at all in the second branch, and so when you merge them, 
'b' _will_ exist in the end result, so now the revert didn't "take".

All of this is very self-consistent (it's a very direct result of how 
merges work and how revert works), but I'm just bringing these things up 
as examples of how 'revert' is not a totally trivial matter. You'll always 
find cases where you might have wished that it had acted differently when 
you merge things.



			Linus
