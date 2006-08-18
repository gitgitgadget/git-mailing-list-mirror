From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cleans up builtin-mv
Date: Fri, 18 Aug 2006 11:51:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608181137000.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com>
 <Pine.LNX.4.63.0608172301520.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 11:52:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE117-00026a-2j
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 11:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWHRJvu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 05:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWHRJvu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 05:51:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:477 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751331AbWHRJvt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 05:51:49 -0400
Received: (qmail invoked by alias); 18 Aug 2006 09:51:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 18 Aug 2006 11:51:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608172301520.25827@chino.corp.google.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25640>

Hi,

On Thu, 17 Aug 2006, David Rientjes wrote:

> On Thu, 17 Aug 2006, David Rientjes wrote:
> 
> > Cleans up builtin-mv by removing a needless check of source's length, 
> > redefinition of source's length, and misuse of strlen call that was 
> > already assigned.
> > 
> 
> I'm not sure when this command had been added to the tree

Tip of the day: "git log builtin-mv.c"

> because it definitely was not included six months ago in a git tree I 
> use everyday.  It seems to me like this would more appropriately be 
> handled by a simple shell script

Nooooooo!

First, it _was_ a perl script, which you probably could find out by 
checking your old git.

Second, it was rewritten to use Git.pm, and because _that_ did not work, 
git-mv was rewritten as a builtin.

> that would be much simpler to implement and could not possibly be slower 
> than this implementation.

Not slower? I beg to differ, admitting it is only a few percent. But your 
statement is obviously uncorrect.

As for the "simpler to implement": "harder to port" comes into mind. And 
do not try to argue that everybody and his dog could switch to Linux.

> This patch is a small fraction of what could be changed in this 
> implementation and I don't doubt it will undergo a complete rewrite in 
> the future.

Well, the patch has an improvement factor of almost none. I actually read 
the patch, and asked myself: why would anybody fix a non-problem?

> I think the problems with it have compounded on top of itself over time 
> which doesn't make a lot of sense since it appears to be a relatively 
> new addition.
> 
> For example:
> 	(length = strlen(source[i])) >= 0

Yes. Taken out of context, this sure sounds silly.

What you cleverly did not mention: It was inside a

	if (!bad &&
		(length = strlen(source[i])) >= 0 &&
		!strncmp(destination[i], source[i], length) &&
		(destination[i][length] == 0 || destination[i][length] == '/'))

construct. So, we assign the "length" variable only if we have to. And the 
">= 0" trick is a common one. I could have done

		!strncmp(destination[i], source[i], (length = strlen(source[i])))

but even I find that ugly.
		
> was _completely_ unnecessary since the previous instruction was a call to 
> lstat(source[i], ...) which would return ENOENT if source[i] was empty.  

Clarified enough?

> strlen(source[i]) was assigned to a variable later in the function, this 
> time called "len" instead.

Only if source[i] is a directory. So again, we only do it when we need to.

> This code is _utterly_ unsatisfactory.

I disagree.

What is unsatisfactory to me is that I expected some performance 
improvements from one of your earlier mails, and I see patches which 
rearrange working code. This _can_ result in performance improvements, but 
in these cases, no, it doesn't.

Having said that, I do not have anything against the patch being applied, 
but if I see more of these i-would-like-the-cupboard-here-not-there 
patches, I will just not review them any more.

Ciao,
Dscho
