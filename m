From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: being nice to patch(1)
Date: Fri, 6 Jul 2007 11:08:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707061102280.9434@woody.linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
 <20070702142557.eba61ccd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
 <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
 <Pine.LNX.4.64.0707031303130.4071@racer.site>
 <86644xd7wr.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 20:08:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6sED-0007m4-Db
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 20:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760396AbXGFSIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 14:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758818AbXGFSIX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 14:08:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40706 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759966AbXGFSIW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2007 14:08:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l66I8GqT001872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2007 11:08:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l66I8A0b011718;
	Fri, 6 Jul 2007 11:08:11 -0700
In-Reply-To: <86644xd7wr.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-2.645 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51779>



On Fri, 6 Jul 2007, David Kastrup wrote:
> 
> Well, hmph!  I just rewrote my git-diff-using script to not check
> stuff into a throw-away git repository, and guess what: with real-life
> use cases (diffing trees of about 500MB size), git-diff runs out of
> memory (the machine probably has something like 1.5GB of virtual memory
> size) when operating outside of a git repository.

Ok, that's probably some huge memory leak that just doesn't show up with 
any normal git operations, likely simply because all the normal git 
operations will have thrown out the case of "identical files" without ever 
even looking at the file.

I'd guess that when using the diff logic on outside files, we'll read them 
all in, compare them, and keep them all in memory even though they are 
identical.

Generally, though, "git diff" has a much higher memory footprint than any 
normal file-by-file recursive diff, exactly because of the rename logic. 
An external "diff" won't ever have any reason to keep more than two files 
in memory at a time, but because git diff does rename and copy detection, 
it wants to keep the file data in memory over much longer times.

But I bet there is some stupid bug where we just make it much much worse 
for the "no git tree/index" case, and keep the whole tree in memory or 
something.

(The same is true of "git apply", btw, for a different reason: because 
git-apply will refuse to write out partial results in case some later 
patch fails, git-apply will keep the whole result in memory until the very 
end, and then do the write-out in one go. Again, that obviously means 
that it will potentially use a lot more memory than the "one patch at a 
time" approach that regular "patch" does)

			Linus
