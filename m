From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 17:52:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603021747430.22647@g5.osdl.org>
References: <20060302164405.GB7292@trixie.casa.cgf.cx> <20060302165510.GB18929@spearce.org>
 <20060302220930.GE6183@steel.home> <Pine.LNX.4.64.0603021521250.22647@g5.osdl.org>
 <7v1wxk5ptf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603021643560.22647@g5.osdl.org>
 <7vveuw48uw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 02:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEzU4-0004PZ-Vv
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 02:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbWCCBxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 20:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWCCBxA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 20:53:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752121AbWCCBwb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 20:52:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k231qQDZ016079
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Mar 2006 17:52:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k231qMfU019596;
	Thu, 2 Mar 2006 17:52:25 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveuw48uw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17134>



On Thu, 2 Mar 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Yeah, I actually looked at a few examples, so I knew what it was basically 
> > trying to do, and then I ignored it as not interesting to the exercise, 
> > which was to abuse the new revision listing library in interesting ways by 
> > calling it multiple times.
> 
> Abuse is exactly the word.  The reason it is an abuse is exactly
> why you said "... but to fix it you'd have to actualyl walk the
> parent list yourself, rather than letting get_revision do it all
> for you."  Which relates to the fact that object.c layer is not
> designed to be used multiple times...
> 
> Maybe we want to make object.c layer reusable first?

No, the "abuse" is actually very much done that way on purpose. It's a bit 
strange to do "incremental" prepare_revision_walk() calls, but it all 
comes from the fact that the object structures are "persistent" across the 
calls, even if we remove them from the list when we walk them. 

So it's strange, but that was kind of part of the reason for doing it. 
It's a _good_ strangeness.

The thing about handling commits that were already in another branch but 
weren't shown is different: the way to handle that is to generate the 
_whole_ revision list in one go - instead of incrementally - and then for 
each branch you merge you show the top 10 "not yet shown" commits.

IOW, that thing would never use "get_revision()" at all, but would instead 
depend on "prepare_revision_walk()" generating the whole tree, and then 
you just walk the parent pointers from the branch heads by hand, marking 
then "seen" as you print them.

So the object layer and the revision parsing actually does exactly the 
right thing, you just have to decide on how to use them..

			Linus
