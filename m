From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 22:08:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr>    =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07071?=
	=?ISO-8859-1?Q?81004330.=0427353@?= =?ISO-8859-1?Q?woody.linux-foun?=
	=?ISO-8859-1?Q?dation.org>?=
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <851wf2bcqy.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707202135450.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 07:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC7Dd-0001vC-PN
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 07:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbXGUFJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 01:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbXGUFJO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 01:09:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40188 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631AbXGUFJN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 01:09:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L58VsW022037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 22:08:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L58QLj001415;
	Fri, 20 Jul 2007 22:08:26 -0700
In-Reply-To: <alpine.LFD.0.999.0707202135450.27249@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53136>



On Fri, 20 Jul 2007, Linus Torvalds wrote:
> 
> As far as I can tell, it would have been exactly the same thing as the 
> S_IFDIR, just instead of the S_IFDIR check, you'd have had to check the 
> end of the filename for being '/'.

BTW, there is actually one big difference, and the '/' at the end actually 
has one huge advantage.

Why? Because my preliminary patches sort the index entries wrong. A 
directory should always sort *as*if* it had the '/' at the end.

See base_name_compare() for details.

And we've never done that for the index, because the index has never had 
this issue (since it never contained directories). So sit down and compare 
base_name_compare (for tree entries) with cache_name_compare() (for index 
entries), and see how the latter doesn't care about the type of names.

This was actually something that I hit already with subproject support, 
and one of my very first patches even had some (aborted) code to start 
sorting subprojects in the index the way we sort directories.

And I *should* have done it that way, but I never did. It now makes the 
S_ISDIR handling harder, because directories really do have to be sorted 
as if they had the '/' at the end, or "git-fsck" will complain about bad 
sorting.

Sad, sad, sad. It effectively means that S_IFGITLINK is *not* quite the 
same as S_IFDIR, because they sort differently. Duh.

Of course, it seldom matters, but basically, you should test a directory 
structure that has the files

	dir.c
	dir/test

in it, and the "dir" directory should always sort _after_ "dir.c".

And yes, having the index entry with a '/' at the end would handle that 
automatically.

As it is, with the "mode" difference, it instead needs to fix up 
"cache_name_compare()". Admittedly, that would actually be a cleanup 
(since it would now match base_name_compare() in logic, and could actually 
use that to do the name comparison!), but it's a damn painful cleanup 
because we don't even pass in the mode to "cache_name_compare()", since we 
never needed it.

Gaah.

cache_name_compare itself isn't used in that many places, but it's used 
by "index_name_pos()/cache_name_pos()", which *is* used in many places. 
And again, that one doesn't even have the mode, so it cannot pass it down.

So it probably *is* easier to add the '/' at the end of the name instead, 
to make directories sort the right way in the index. I'd still suggest you 
*also* make the mode be S_IFDIR, though (and preferably make git-fsck 
actually verify that the mode and the last character of the name 
matches!).

		Linus
