From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/2] Soem core git optimizations
Date: Fri, 9 May 2008 09:04:03 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805090856350.3142@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 09 18:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuV6U-0005sx-M5
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 18:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbYEIQEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 12:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbYEIQEm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 12:04:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35675 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754335AbYEIQEm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2008 12:04:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m49G4538023923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 May 2008 09:04:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m49G43n6014296;
	Fri, 9 May 2008 09:04:04 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.93 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81618>


I notice that Junio merged my fnmatch-avoidance patch, but I have a few 
other optimizations that I track in my private tree that I have sent out 
but probably didn't get much attention. They do matter from a performance 
angle, even if not as much as avoiding fnmatch did.

The first patch is obvious and pretty trivial: just moving lstat() calls 
up a bit in the call-chain, so that you don't end up unnecessarily doing 
two lstat() calls after each other.

The second patch is the symlink detection rewrite, which avoids a _lot_ of 
unnecessary lstat calls under some loads by not doing the lstat on the 
directory path entries over and over for each pathname. It's just a 
single-deep cache for "last directory seen" and "last symlink seen", and 
replaces the old code that only cached the last symlink.

Diffstat for the combined thing as follows:

 builtin-apply.c  |    2 +-
 builtin-commit.c |    6 ++-
 cache.h          |    4 ++-
 diff-lib.c       |   10 +++---
 read-cache.c     |   29 +++++++++++--------
 symlinks.c       |   82 ++++++++++++++++++++++++++++++++---------------------
 unpack-trees.c   |   12 +++----
 7 files changed, 84 insertions(+), 61 deletions(-)

and while this probably doesn't matter on most loads, the reason I'm 
re-sending is that I think it's pretty solid and core code. I've been 
running with both of these patches (and some others) rebased on top of 
Junio's tree for the last few weeks.

		Linus
