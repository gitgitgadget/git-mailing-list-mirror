From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 08:46:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704170833560.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <7v7isbpb0p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdpt8-0003jU-Sq
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030757AbXDQPqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030879AbXDQPqf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:46:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52517 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030757AbXDQPqe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:46:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HFkSTW006836
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 08:46:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HFkRU4000353;
	Tue, 17 Apr 2007 08:46:27 -0700
In-Reply-To: <7v7isbpb0p.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.965 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44783>



On Tue, 17 Apr 2007, Junio C Hamano wrote:
>
> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > No parsing of the keyword itself is performed, the content is simply
> > dropped.
> 
> You are sidestepping the most important problem by doing this.

I obviosly agree (and I agree with everything in your email), but:

> The only sensible keyword you could have, without destroying
> what git is, is blob id.  No commit id, no date, no author.

Yes. And I already talked about some of the very fundamental problems that 
keyword expansion has (ie switching branches is basically impossible to do 
without checking out _every_single_file_ with the "keyword" attribute 
set. There are others).

Now, unexpansion is trivial to do (it really *is* the same as the 
"CRLF->LF" translation: that's technically really just an "unexpansion" 
too). And it should work. 

The way this does unexpansion also breaks "git diff" in that it bassically 
always makes diff *ignore* the keywords. In other words, when you do

	git diff A..B

and send the diff to somebody else, they'll never see any keywords at all! 

Now, that obviously fulfills my requirement that the diff be empty if A 
and B are the same, so you should expect me to be happy. But I'm not 
happy, because if the other person also is using git, HE CANNOT EVEN APPLY 
THE DIFF! Even if he's at "A", and thus gets a diff that is supposed to 
apply *exactly*, he'll get rejects if there were other changes around the 
unexpanded keyword (which *he* will have expanded in his working tree, of 
course!)

See? Keywords simply *cannot* work. They're broken. Either you can ignore 
them (and not show them in diffs), in which case the diff is broken, or 
you can not ignore them (and show them in diffs) in which case the diff is 
*also* broken, just differently.

The only sane and workable case is to not have them at all. Any keyword 
expansion will *always* result in problems. You simply cannot do it right. 

As I mentioned originally, it results in problems in CVS too, it's just 
that CVS really has so many other issues that you seldom see the problems.

Ok, after that new rant against keywords, I will say one positive thing:

 - keyword *unexpansion* is certainly easy (exactly because it's 
   stateless)

 - if we want to support a git that only does "unexpansion", you can 
   probably hack around stupid release scripting more easily. You can add 
   your keywords *outside* of git, and git will simply ignore them. 

So I'm actually not against keyword un-expansion. It has none of the 
fundamental problems that actually expanding the keywords has. It's 
literally no different from CRLF->LF translation. It can cause confusion, 
but if it has to be explicitly enabled with an attribute and is never done 
automatically, then having some support for unexpansion and letting the 
user who wants to use keywords use his own "wrapper scripts" around git to 
do his own expansion, be my guest..

You would be unable to do fundamental operations like "git checkout B" to 
jump to another branch, but if you don't support multiple branches and 
want to just act like CVS, maybe git unexpanding the crap will help you: 
you can add your own keywords, happy in the knowledge that git simply 
won't *care* about them, and will never see them.

So I absolutely detest keyword expansion and actually have a lot of 
arguments for why I don't think it *can* work even in theory (except by 
being totally unusable), but I don't have the *un*expansion. 

		Linus
