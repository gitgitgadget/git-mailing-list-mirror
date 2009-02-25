From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 11:12:47 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902251106070.3111@localhost.localdomain>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com> <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain> <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcPD6-0003dd-Lm
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 20:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbZBYTM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 14:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756147AbZBYTM6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 14:12:58 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42647 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756104AbZBYTM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 14:12:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1PJClRr011067
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2009 11:12:48 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1PJClOm000733;
	Wed, 25 Feb 2009 11:12:47 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.451 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111480>



On Wed, 25 Feb 2009, Junio C Hamano wrote:
>
> I've been repeating the above to new people to save you time, but recently
> I noticed one thing.
> 
> The handling of a case where a pull decides to go ahead (because it does
> not have to touch the Makefile you have your codename updates in) but does
> not complete with real conflicts, is not as graceful as the other two
> cases (merge refusing to run at all without touching anything, or merge
> completes cleanly and makes a commit).

I agree (although your phrasing was confusing - by "does not complete with 
real conflicts" you made it sound like there were no real conflicts, but 
you must have meant "does not actually finish the merge commit _due_ to 
real conflicts").

That case is one large part of why I wanted to have that "git reset 
--merge" behavior - because it's a good way to get back to the "pre-merge 
with dirty state" situation. Although I have to admit that I don't think 
I've had that happen since the feature got merged ;)

> You will be left with:
> 
>  - Paths that have local changes (index matches HEAD but work tree does
>    not match the index --- like your Makefile);
> 
>  - Paths cleanly merged (index and HEAD are different but work tree
>    already matches the index);
> 
>  - Unmerged paths (index has higher stage entries with <<</===/>>> files
>    in the work tree);

Yes. The good news is that for people who know what they are doing, this 
is all unambiguous. Clean merges will be up-to-date in the index, unmgered 
paths will be marked as such in the index, and your own _real_ dirty state 
will be unambioguously dirty in the working tree.

But I do agree that if you don't know what's up, you now are an in a 
really good position for screwing up, and (for example) resolving the 
merge conflict and then incorrectly committing your own unrelated changes 
with the merge.

> You, I and experienced users know what to do.  Deal *only* with the last
> kind, mark them with "git add" after you are done with each of them, and
> make sure you do not say "-a" when committing the result, to exclude the
> first kind from the merge result.
> 
> I've been wondering if we can make this safer for others.

You're right. We could decide to have a mode (maybe default to it, so that 
people like me can just use a config option to enable "expert" mode) that
simply refuses to do the merge if it doesn't succeed cleanly if there were 
dirty files in the tree.

			Linus
