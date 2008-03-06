From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/5] Add 'df_name_compare()' helper function
Date: Thu, 6 Mar 2008 07:58:48 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803060743180.12253@woody.linux-foundation.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org> <b1cd18fa986c63bea6d0a20ac580b993e5fffaa2.1204777699.git.torvalds@linux-foundation.org> <8563w03sxv.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 17:00:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXIVq-0006qZ-Rc
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 17:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761823AbYCFP66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 10:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761645AbYCFP65
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 10:58:57 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48038 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758472AbYCFP64 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 10:58:56 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m26FxAE8001176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Mar 2008 07:59:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m26Fwmfv005248;
	Thu, 6 Mar 2008 07:58:49 -0800
In-Reply-To: <8563w03sxv.fsf@lola.goethe.zz>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.931 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76395>



On Thu, 6 Mar 2008, David Kastrup wrote:
> 
> Uh, that screams just bloody murder at me with regard to working on
> sorted material.  You'll never even get into the situation where the
> conflicting "equal" entries will be compared if you presorted them with
> something in between.

And you really can't.

> Consider the case of a merge of
> 
> A:
> blubb
> blubb.hi
> 
> B:
> blubb.hi
> blubb/
> 
> Any traversal that is done reasonably efficiently will never compare
> blubb to blubb/ and I don't see how to get around this.

Correct. There _is_ no sort order that will find the conflict in a single 
pass, yet get the sorting right for this case, because there is no sort 
that can satisfy both the "get DF conflicts together" _and_ the "keep 
things in the right order" requirements.

Btw, the old code was no better (and was probably worse) - it used 
"strcmp()" to order the things, so it effectively did the same thing, it 
just wasn't as obvious about it (and got the case of "foo/" vs "foo." 
entirely wrong). The new code makes this hack very explicit.

> Basically, I think you need a special traversal routine.

Yes, we need to handle it in two passes. Which is actually hopefully not 
all that hard, but it is totally impossible (at least for me) with the old 
code that was so hard to follow.

So what I did was to rewrite the code so that it can be followed and 
maintained, and now my plan is to simply put the result in a separate 
index. 

We've always really wanted to do that *anyway* (right now we have this 
"discard and re-read index" cruft in the callers and in the error cases to 
get back the index we overwrote when merging!), and I bet we could have 
done that with the old code too, but _I_ couldn't have done it.

The problem with having a single index as both source and destination is 
that you cannot do a two-phase thing, because you are basically destroying 
one of your sources in your first phase (or put another way: in the second 
phase, you don't really know whether the index entry you now find was 
there to begin with, of whether you just generated it yourself earlier).

So what that series of five patches do is to not fix a single bug, but to 
make the thing a bit easier for me to look at (and I think it's good for 
other reasons too - one less arbitrary tree traversal function!)

I'm hoping that people can look at the patches and test them, and say 
"yeah, that looks like it does the same thing we used to", and then when I 
get the energy (hopefully later today) I'll just make it take a separate 
source and destination index.

		Linus
