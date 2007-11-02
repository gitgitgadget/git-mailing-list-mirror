From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New features in gitk
Date: Fri, 2 Nov 2007 08:03:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711020751290.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:04:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iny4A-0002wW-Uf
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbXKBPD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbXKBPD4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:03:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56035 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753879AbXKBPDz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 11:03:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2F3JnJ026742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 08:03:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2F3I8K027384;
	Fri, 2 Nov 2007 08:03:18 -0700
In-Reply-To: <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-2.731 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63123>



On Fri, 2 Nov 2007, Paul Mackerras wrote:
> 
> How would that help?  That doesn't list about 2/3 of the commits at
> all.

Yeah, you'd have to do all the parent processing on your own, I guess that 
would be too slow.

> In any case, no that's not the only reason.  The main reason is that
> it (i.e. --topo-order) spits out the commits in exactly the order that
> gitk wants to display them (of which the bit about parents coming
> after all their children is a part), and thus reduces the amount of
> processing I need to do in Tcl.

The thing is, you shouldn't *care* how long it takes to get 50,000+ 
commits.

You're only visualizing ~20 commits at a time. Ignore the rest.

THAT is the number that is timing-critical. You're optimizing for the 
wrong case - the "whole history" thing doesn't matter as much as the 
"recent history" does.

So I bet from a usability standpoint, you'd be *much* better off with 
something that might take ten times as long for the whole thing, if the 
first thirty lines show up in a third of the time.

In fact, if you want to really optimize parsing and that is a big issue, 
use

	git log --left-right --parents --pretty=format:"%m %H %P %an <%ae> %aD"

which will give you a single line per commit. I bet tk is good at reading 
single lines. Don't even read anythign else - until somebody actually 
*selects* the commit, at which point you do the diff *and* the full thing.

Yes, it will make things slower over-all. And no, the above won't work for 
the "search everywhere", which means that once people start searching for 
everything, you'll be screwed, but with somethign like the above, you'll 
get the first commits immediately and can start showing them.

And yes, if they come in the wrong order, you'll have to recalculate the 
display, but I thought you had something incremental already - ie you can 
always do it for just the current window of 100 commits or whatever.

			Linus
