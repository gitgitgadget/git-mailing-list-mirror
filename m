From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 13:23:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org> <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm> <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm> <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <20081015124949.b657a8db.akpm@linux-foundation.org> <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: david@lang.hm, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCwn-0006TM-Ex
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbYJOUZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755620AbYJOUZG
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:25:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43968 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755459AbYJOUZF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 16:25:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FKNof1008764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Oct 2008 13:23:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FKNolw032475;
	Wed, 15 Oct 2008 13:23:50 -0700
In-Reply-To: <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.433 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98320>



On Wed, 15 Oct 2008, Linus Torvalds wrote:
> 
>  - a merge goes south with a data conflict, and since it's all automated, 
>    you just want to throw it away.

Actually, with your filename, I suspect the conflict would be not a real 
file content, but more of a "delete" conflicting with a modification to 
that file. IOW, I'm guessing that the thing you hit with 
arch/x86/kernel/apic.c was that some branch you pulled:

 - created that file

 - deleted arch/x86/kernel/apic_[32|64].c

 - the old file got marked as a rename source for the new apic.c and 
   there was a data conflict when trying to apply the changes.

as a result, your working tree would have that "apic.c" file in it, but 
with conflict markers, and marked as unmerged.

When you then do "git reset --hard", it will just ignore unmerged entries, 
and since the original tree (and the destination tree) match, and neither 
of them contain apic.c either, git will totally ignore that file and not 
even try to remove it (since it wasn't there originally).

> So you do "git reset --force" to do that.

It's "--hard", not "--force". Yeah, the git reset flags are insane. As is 
the default action, for that matter. It's one of the earliest interfaces, 
and it's stupid and reflects git internal implementations rather than what 
we ended up learning about using git later. Oh, well.

But 'git checkout -f' (which is nicer from a user interface standpoint) 
has the exact same logic and I think shares all the implementation. I 
think they both end up just calling "git read-tree --reset -u".

It's quite possible that we should remove unmerged entries. Except that's 
not how our internal 'read_cache_unmerged()' function works. It really 
just ignores them, and throws them on the floor. We _could_ try to just 
turn them into a (since) stage-0 entry.

Junio?

			Linus
