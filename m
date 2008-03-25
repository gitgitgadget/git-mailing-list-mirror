From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] Case-insensitive filesystem support, take 1
Date: Tue, 25 Mar 2008 14:04:58 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803251347400.2775@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <20080325081409.GI25381@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 22:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeGLe-0008Gx-W0
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 22:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbYCYVFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 17:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbYCYVFk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 17:05:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55988 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281AbYCYVFj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 17:05:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2PL50mk032660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2008 14:05:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2PL4wIe013220;
	Tue, 25 Mar 2008 14:04:59 -0700
In-Reply-To: <20080325081409.GI25381@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.751 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78221>



On Tue, 25 Mar 2008, Dmitry Potapov wrote:
> 
> - merge different branches were two file names are only differ by case
>   will cause that the result branch has two file names that differ only
>   by case and one of them will be overwritten by the other and shown as
>   modified in the worktree by git status.

Ok. So there's two issues here:

 - the git trees themselves had two different names

   This is not something I'm *ever* planning on changing. All my "case 
   insensitive" patches were about the *working*tree*, not about core git 
   data structures themselves.

   In other words: git itself is internally very much a case-sensitive 
   program, and the index and the trees are case-sensitive and will remain 
   so forever as far as I'm concerned. So when you do a tree-level merge 
   of two trees that have two different names that are equivalent in case, 
   git will create a result that has those two names. Because git itself 
   is not case-insensitive.

 - HOWEVER - when checking things out, we should probably notice that 
   we're now writing the two different files out and over-writing one of 
   them, and fail at that stage. I don't know what a good failure 
   behaviour would be, though. I'll have to think about it.

IOW, all my case-insensitivity checking was very much designed to be about 
the working tree, not about git internal representations. Put another way, 
they should really only affect code that does "lstat()" to check whether 
a file exists or code that does "open()" to open/create a file.

> - git status cares only about case-insensitivity only for files and not
>   for directories. Thus, if case of letters in a directory name is changed
>   then this directory will be shown as untracked.

Ahh, yes. This is sad. It comes about because while we can look up whole 
names in the index case-insensitively, we have no equivalent way to look 
up individual path components, so that still uses the "index_name_pos()" 
model and then looking aroung the failure point to see if we hit a 
subdirectory. Remember: the index doesn't actually contain directories at 
all, just lists of files.

This will not be trivial to fix. 

> - pattern specified in .gitignore are match as case-sensitive despite
>   core.ignorecase set to true.

This should probably be fairly straightforward. All the logic here is in 
the function "excluded_1()" in dir.c - and largely it would be about 
changing that "strcmp()" into a "strcasecmp()" and using the FNM_CASEFOLD 
flag to fnmatch().

The only half-way subtle issues here are

 - do we really want to use strcasecmp() (which may match differently than 
   our hashing matches!) or do we want to expand on our icase_cmp() or 
   similar in hash-name.c (I think the latter is the right thing, but it 
   requires a bit more work)

 - FNM_CASEFOLD has the same issue, but also adds the wrinkle of being a 
   GNU-only extension. Which is sad, since most systems that have glibc 
   would never need it in the first place. So then we get back to the 
   whole issue of maybe having to reimplement 'fnmatch()', or at least a 
   subset of it that git uses.

So that last issue is conceptually simple and straightforward to fix, but 
fixing it right would almost certainly be a few hundred lines of code 
(fnmatch() in particular is nasty if you want to do all the cases, but 
perhaps just '*' is ok?).

The first two issues are nontrivial.

			Linus
