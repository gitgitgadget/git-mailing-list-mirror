From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 14/24] Added the class IgnoreRuleListFactory.
Date: Tue, 13 May 2008 21:06:00 -0400
Message-ID: <20080514010600.GK29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-15-git-send-email-florianskarten@web.de> <20080513010844.GE29038@spearce.org> <48296B41.9020105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian =?utf-8?Q?K=C3=B6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Wed May 14 03:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw5SM-00033T-Ks
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765AbYENBGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 21:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758017AbYENBGG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:06:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43545 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758116AbYENBGF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 21:06:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jw5RG-00010W-Rp; Tue, 13 May 2008 21:05:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9C91620FBAE; Tue, 13 May 2008 21:06:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48296B41.9020105@web.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82058>

Florian Kberle <FloriansKarten@web.de> wrote:
> Shawn O. Pearce wrote:
> >
> >Why go through all this work to buffer the lines we don't care about
> >(starting with # or are blank) when we could just discard them in the
> >inside of createIgnoreRuleList and then create the rule right away?
>
> I did this to reduce complexity and to increase modularity.
> The method createIgnoreRuleList(Iterable<String> lineIterable) can now 
> be tested without the need to create files. Also it is so possible to 
> read the patterns from different sources.
> 
> If you worry about memory usuage I could create some kind of 
> RulesBuilder class:

OK.  I guess I can see that.  I wasn't worried about memory, it just
seemed odd to me that the "parser" (splitting the file into lines)
was also not skipping the lines that were not interesting.

Given your explanation I don't see a reason to change it, it just
struck me as odd.
 
> >I suspect this code would be easier to follow if you just accepted
> >changing the method parameter, such as:
> >
> >	private Rule createRule(String pattern) {
> >		boolean exclude = true;
> >		if (pattern.startsWith("!)) {
> >			pattern = pattern.substring(1);
> >			exclude = false;
> >		}
>
> If I remember correctly Intellij IDEA marks per default cases where you 
> change a parameter. So it looks like that there are style guides which 
> are against the practice of changing the values of parameters.

Yes, there are style guides floating around that say "do not
modify parameters".  There is also a Java keyword that means
"do not modify this variable in scope", its called "final".

Personally I think whether or not something should be final in
a scope depends on the size of the scope and what is clearer to
read to modify the existing variable, or to introduce a copy with a
different name and a potentially different value.  Forcing everything
to not modify parameters by compiler edict is nuts.

In the code I was talking about you had two different variables
for the pattern, just to avoid not modifying the parameter.
Yet within the scope of the method once the "!" is cut off the
original pattern string is worthless.  In my very humble opinion
it is more risky to have two different variables (one whose scope
has expired the moment the method starts and one that is useful)
then to have a mutable parameter.

But as I said, its only my humble opinion.  Since I'm American my
$0.02 is worth what, 0.00000002 rupees these days?  ;-)
 
> I implemented it that way, becasue git behave the same way:
> * create the follwing file: a/a/b/test.txt
> * add the line "a/b" to .gitignore
> * add a and notice that it adds the test.txt file.

OK.  You are correct.  If the ignore rule contains "/" it appears
to only apply from the top level of the repository.  That wasn't
my understanding of how it worked, but I stand corrected.  Thank you.

-- 
Shawn.
