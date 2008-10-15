From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 12:56:26 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810151247560.3288@nehalem.linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org> <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm> <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm> <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <alpine.DEB.1.10.0810151240220.7808@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Oct 15 21:58:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCVd-0003hz-LH
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYJOT5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYJOT5D
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:57:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43075 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751575AbYJOT5B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 15:57:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FJuRVw006790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Oct 2008 12:56:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FJuQTO029374;
	Wed, 15 Oct 2008 12:56:26 -0700
In-Reply-To: <alpine.DEB.1.10.0810151240220.7808@asgard.lang.hm>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.434 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98312>



On Wed, 15 Oct 2008, david@lang.hm wrote:
> 
> I see it fairly frequently when switching between different branches of a
> project.

So, at least for any normal switch, assuming file 'a' doesn't exist in the 
other branch, you really should have a few different cases:

 - you have a dirty file, and git should say something like

	error: You have local changes to 'file'; cannot switch branches.

   because it refuses to modify the file to match the other branch (which 
   includes removing it) if it doesn't match the index.

   So this case shouldn't leave anything behind.

 - You have that extra file, but it's not in the index.

   If it's in your current HEAD, we should still notice it with something 
   like:

	error: Untracked working tree file 'tree' would be removed by merge.

   because now it's untracked (not in the index), but the switching 
   between branches tries to essentially "apply" the difference between 
   your current HEAD and the new branch, and finds that the difference 
   involves removing a file that git isn't tracking.

See?

HOWEVER.

If you're used to doing "git checkout -f" or "git reset --hard", both of 
those checks are just ignored. After all, you asked for a forced switch. 

And at least in the second case, what I think happens is that git won't 
remove the file it doesn't know about, so you'll have a "turd" left 
around.

So yes, you can certainly get these kinds of left-overs, but they really 
should be only happening if you "force" something. Do you do that often?

			Linus
