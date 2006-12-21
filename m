From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 10:23:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612211013500.3394@woody.osdl.org>
References: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Cliburn <jacliburn@bellsouth.net>, git@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 19:23:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxSa0-000421-GH
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 19:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423004AbWLUSXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 13:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423011AbWLUSXn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 13:23:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56967 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423004AbWLUSXm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 13:23:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBLINV2J002405
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Dec 2006 10:23:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBLINUMV001049;
	Thu, 21 Dec 2006 10:23:30 -0800
To: Francis Moreau <francis.moro@gmail.com>
In-Reply-To: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
X-Spam-Status: No, hits=-0.652 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35079>



On Thu, 21 Dec 2006, Francis Moreau wrote:
> 
> I must really miss something but is a diff between origin and driver heads
> achieved by:
> 
> 	$ git diff driver origin
> 
> instead of:
> 
> 	$ git diff origin..driver

No. 

	git diff origin driver

and

	git diff origin..driver

is exactly the same thing.

> From the git-rev-list documentation I can read that:
> 
> 	git-rev-list origin..driver == git-rev-list driver ^origin

Correct. However, "git diff" is very aware of things like "^origin", and 
understands that

	git diff driver ^origin

is the same thing as saying "I want what is in driver, but not in origin", 
so it needs to switch the arguments.

In short, for git diff (and ONLY) git diff, all of these are the same:

	git diff a..b
	git diff a b
	git diff b ^a

[ ADDITIONALLY git diff _also_ has a magic special case of

	git diff a b ^c

  which actually means the same as "git diff c..a" (and "b" is 
  totally ignored). That may sound strange, but it's because the 
  expression "a...b" means "b a --not $(git-merge-base a b)", and so what 
  you actually WANT is that if you do

	git diff a...b

  you should get "diff from merge-base to b", so when "a...b" expands to 
  "b a ^merge-base", then git understands that if it gets that stange 
  command line with THREE commits, and one of them is negated, you really 
  wanted the diff from the negated one to the first one ]

It basically all boils down to:

	"git diff" is special

exactly because unlike almost ALL other git commands, "git diff" does not 
work on a _list_ of commits, it only works on two end-points. That means 
that the "list operations" actually end up meaning something else for git 
diff than they do for "git log" and friends.

		Linus
