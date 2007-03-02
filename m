From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Fri, 2 Mar 2007 08:36:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703020824580.3953@woody.linux-foundation.org>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
 <20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
 <20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu>
 <20070301145204.GA25304@elte.hu> <Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
 <20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
 <20070302102018.GA11549@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Mar 02 17:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNAl6-0006ST-AR
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 17:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992579AbXCBQg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 11:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992602AbXCBQg1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 11:36:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33985 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992579AbXCBQg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 11:36:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l22Ga9Ab026110
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Mar 2007 08:36:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l22Ga9eV012905;
	Fri, 2 Mar 2007 08:36:09 -0800
In-Reply-To: <20070302102018.GA11549@elte.hu>
X-Spam-Status: No, hits=-0.446 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41228>


(Ok, removed the kernel people, since this is just about the git part...)

On Fri, 2 Mar 2007, Ingo Molnar wrote:
> 
> but the conclusion is clear: if multiple bugs are present in the search 
> area then it gets quite difficult to sort it out via git-bisect - but 
> it's not impossible either. The following git-bisect enhancement could 
> have made things easier for me:
> 
>    git-bisect mark-must-have <tree>

It's not quite that easy.

In _your_ case, you always just wanted to try to apply a particular patch 
if it applied cleanly.

But in other cases, what you really want is:

 - *if* commit X is included, apply patch Y

because quite often you might have a "fix" that applies quite cleanly, but 
is totally the wrong thing to do unless the code that actually _needs_ the 
fix is already merged.

It's just that in this case, if the bug didn't exist, the fix wouldn't 
apply either, so it just didn't matter..

Also, even if we had something that git did automatically after it 
selected a commit to bisect on, it still wouldn't really be enough: we'd 
need to 

 (a) handle the failure case cleanly (again, in your case it didn't 
     matter, because it either applied cleanly or wasn't needed at all)

 (b) also handle the case where the user chooses a different point to try 
     because the automatic bisection picked a commit that was untestable. 
     Right now people do that by using "git reset --hard XYZ"

 (c) It's quite possible that the fix to be applied isn't a git commit at 
     all. Again, in your case there happened to be one well-defined commit 
     that did nothing but fix the known bug, but you could easily have had 
     a situation where - if the bug wasn't as obvious, for example - you 
     had a fix being done over _multiple_ commits, or the other way, the 
     fix you actually want to merge is just a part of a commit that does a 
     lot of other things too (that may not be appropriate at other places, 
     and you know will just cause merge errors)

The (b) case could be supplied by having a "git bisect try <XYZ>" 
subcommand instead of having people use "git reset --hard". That might be 
a good thing to do anyway, since it can also do added sanity testing (ie 
testing that the commit to try actually is *inside* the current bisection 
set, because otherwise the bisection simply won't work).

			Linus
