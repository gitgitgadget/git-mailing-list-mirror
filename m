From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: possible bug in git apply?
Date: Sun, 5 Aug 2007 09:59:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
 <alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
 <7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: david@lang.hm, git@vger.kernel.org, rob@landley.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 19:00:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHjSi-0002e4-R9
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 19:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbXHERAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 13:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbXHERAL
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 13:00:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47441 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753307AbXHERAJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 13:00:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75Gx9ap031831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Aug 2007 09:59:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75Gx30d017379;
	Sun, 5 Aug 2007 09:59:04 -0700
In-Reply-To: <7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55042>



On Sat, 4 Aug 2007, Junio C Hamano wrote:
> >
> > Does this fix it? Totally untested, but it _looks_ obvious enough..
> 
> That would regress the fix made in aea19457, I am afraid.

The fix in aea19457 is broken anyway.

Why? 

That whole "do it in two phases" thing breaks it.

What can happen is that you have a directory with 100 files, and:
 - a patch modifies 99 of them
 - and removes one

What happens is that during phase 0, we'll remove all the files (and *not* 
write new ones), and then beause the last patch entry is a removal, we'll 
also remove the directory (which succeeds, because all the files that got 
modified are all long gone).

Then, in phase 1, we'll re-create the files that we modified, and create a 
whole new directory.

IOW, as far as I can see we _already_ delete and then recreate the 
directory structure under some circumstances.

I just extended it to also do it for "rename" and not just delete, since a 
rename may be renaming it to another directory.

So I'd say that my patch is a clear improvement on the current situation. 

That said, if we really wanted to get it right, we should do this as a 
three-phase thing: (1) remove old files (2) create new files (3) for all 
removals and renames, try to remove source directories that might have 
become empty.

That would fix it properly and for all cases.

		Linus
