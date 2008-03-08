From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] bug in unpack_trees
Date: Sat, 8 Mar 2008 14:25:03 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803081417040.5896@woody.linux-foundation.org>
References: <20080304115940.GA5260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Goerzen <jgoerzen@complete.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 08 23:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7UU-0005DK-2k
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYCHWZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYCHWZ2
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:25:28 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41311 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751491AbYCHWZ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 17:25:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m28MPaLn022500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Mar 2008 14:25:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m28MP4DJ004337;
	Sat, 8 Mar 2008 14:25:04 -0800
In-Reply-To: <20080304115940.GA5260@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.925 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76596>



On Tue, 4 Mar 2008, Jeff King wrote:
>
> I am tracking down a bug in unpack_trees, but I can't seem to find the
> exact problem; I'm hoping to get help from people who have touched this
> code a bit more than I have.

Ok, so I decided that I should now finally go back and look at the 
original bug-report that triggered my unpack-trees rewrite, now that it's 
in a form where I feel like I can actually look at the code and fix the 
problem..

But when I just tested the bug-report case that Jeff described, it seems 
that I fixed the bug just with my cleanup. The current git "master" branch 
gives the following (incorrect) output for Jeff's script:

	[torvalds@woody repo]$   diff -u index1 index2
	--- index1      2008-03-08 14:16:51.000000000 -0800
	+++ index2      2008-03-08 14:16:51.000000000 -0800
	@@ -1 +1,2 @@
	 df/file
	+new

and with all my patches it just magically works correctly and the "git 
reset" correctly reset the index.

So while I actually tried to be as careful as possible and do a minimal 
"convert to cleaner code" rather than actually fix the bug, it seems that 
just the cleanup actually did end up fixing it and there is nothing more 
to chase down.

I'd love to say that I know what the original bug was, but since I 
couldn't fix it in the first place because I couldn't read the original 
code, I can't really say what fixed it.

Jeff's test-script appended just for people who can't find the original 
message that started this all.

		Linus

---
  # make a repo
  mkdir repo && cd repo && git init

  # make a directory which will become a df conflict
  mkdir df
  echo content >df/file
  git add df/file
  git commit -m one

  # and save a copy of the index
  git ls-files >index1

  # now make a new commit that has the df conflict and
  # a newly added file
  rm -rf df
  echo content >df
  git add df
  echo content >new
  git add new
  git commit -m two

  # now this should put our index exactly back to 'one'
  git reset --hard HEAD^

  # but it doesn't
  git ls-files >index2
  diff -u index1 index2

