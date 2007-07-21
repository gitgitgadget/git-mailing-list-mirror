From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 21:51:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707202135450.27249@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr>    =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07071?=
	=?ISO-8859-1?Q?81004330.=0427353@?= =?ISO-8859-1?Q?woody.linux-foun?=
	=?ISO-8859-1?Q?dation.org>?=
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <851wf2bcqy.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 06:51:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC6wB-0007J8-PO
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbXGUEvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 00:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbXGUEvY
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 00:51:24 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53380 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbXGUEvX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 00:51:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L4pJeW021418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 21:51:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L4pDNh000844;
	Fri, 20 Jul 2007 21:51:13 -0700
In-Reply-To: <851wf2bcqy.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53135>



On Sat, 21 Jul 2007, David Kastrup wrote:
> 
> Ok, I have now acquired enough passing familiarity with the code that
> I find part of my way around it.  Most of your patch looks like it
> caters for the S_ISDIR type not previously in use in the index (how
> about the repository?).

The object database has always had S_ISDIR (well, "always" is since very 
early on, when I realized that flat trees didn't cut it).

> The disadvantage is that it introduces a new data type and thus one
> has to check all the code paths to see how older versions of git will
> cater with newer data.

Take a look at the "subproject" patches - those did the same (adding the 
ntion of a gitlink to the index), except those also changed how the tree 
object looked, since now a tree could contain pointers to commits too. 

> My idea of a fake zero-length file would have had predictable side
> effects:

As far as I can tell, it would have been exactly the same thing as the 
S_IFDIR, just instead of the S_IFDIR check, you'd have had to check the 
end of the filename for being '/'.

Otherwise? Exactly the same.

Except for the fact that we already supported S_IFGITLINK for subprojects 
(and there it matches the "struct tree" entry, so it really *does* make 
more sense that way), so supporting S_IFDIR was actually easier.

But hey, that's an implementation detail. I don't actually care all that 
much. In many ways, the "long-term" data structures are much more 
important than the index, the index is a purely temporary - and even more 
importantly - a purely local datastructure.

The more important thing is in many ways the object storage, and that's 
also the reason for doing the index the way I did - it more closely 
matches what the object storage does (ie the "index" ends up mirroring a 
linearized and unpacked "tree" object).

			Linus
