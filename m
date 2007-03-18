From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 18:44:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171833420.21612@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com> 
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org> 
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home> 
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 02:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSkRr-0008N3-VB
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 02:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbXCRBo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 21:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbXCRBo0
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 21:44:26 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52199 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbXCRBoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 21:44:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2I1i7cD017903
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 18:44:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2I1i5UL013635;
	Sat, 17 Mar 2007 17:44:06 -0800
In-Reply-To: <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.977 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42466>



On Sat, 17 Mar 2007, Linus Torvalds wrote:
> > 
> > That's a lot of strings, or perhaps very long strings.  Or a profiling bug.

Btw, the reason I'm pretty sure that it's not a profiling bug is that
 (a) the rest of the profile looks fine
 (b) it actually matches the rest of the profile.

In particular, while you reacted to

	samples  %        app name                 symbol name
	41527    15.6550  git                      strlen

you didn't bat an eye on

	9240      3.4833  git                      get_mode
	8863      3.3412  git                      tree_entry_extract

ie over 3% of time spent in tree entry extract and get_mode. But take 
another look at that tree_entry_extract() function in particular and look 
what it does, and ask yourself: if *that* function takes up 3% of time, 
what does it tell you about strlen()?

(Side note: we could probably improve "strlen()" in particular. We 
sometimes call it twice: look at "entry_extract()", which calls strlen() 
on the tree entry extract, but then *also* calls strlen on the resulting 
path.

I suspect the

	a->pathlen = strlen(a->path);

could be written as

	a->pathlen = (char *)a->sha1 - (char *)a->path - 1;

but somebody should check that I didn't off-by-one or something. Also, it 
migt be better to make that part of "tree_entry_extract()" itself, because 
other callers do the same thing (see "find_tree_entry()": doing a 
"strlen()" on the path return of tree_entry_extract() seems to be a common 
pattern).

HOWEVER!

Once we get to *that* level of optimizations, we're doing pretty damn 
well. I'm sure we could probably cut down that strlen() from 16% to 8% by 
being smart about it, but still - this is a "good kind of problem" to 
have, if these things are your lowest-hanging fruit!

Maybe it all boils down to the same thing: I just can't seem to be really 
upset about "git log drivers/usb/ > /dev/null" taking all of a second. It 
just doesn't strike me as a performance problem ;)

			Linus
