From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 22:36:09 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907222204310.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <7vtz146mgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:36:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqyd-0002Nd-3g
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbZGWFgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbZGWFgQ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:36:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35468 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203AbZGWFgP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 01:36:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N5a9J8013123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 22:36:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N5a9DI020247;
	Wed, 22 Jul 2009 22:36:09 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vtz146mgr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123843>



On Wed, 22 Jul 2009, Junio C Hamano wrote:
> 
> Hmm, we now have to remember what this patch did, if we ever wanted to
> introduce negative refs later (see ef06b91 do_for_each_ref: perform the
> same sanity check for leftovers., 2006-11-18).  Not exactly nice to spread
> the codepaths that need to be updated.  Is the cold cache performance of
> "git branch" to list your local branches that important?

Hmm. I do think that 7.5s is _way_ too long to wait for something as 
simple as "what branches do I have?".

And yes, it's also an operation that I'd expect to be quite possibly the 
first one you do when moving to a new repo, so cold-cache is realistic.

And the 'rawref' thing is exactly the same as the 'ref' version, except it 
doesn't do the null_sha1 check and the 'has_sha1-file()' check.

And since git branch will do something _better_ than the 'has_sha1_file()' 
check (by virtue of actually looking up the commit), I don't think that 
part is an issue. So the only issue is the is_null_sha1() thing.

And quite frankly, while the null-sha1 check may make sense, the way the 
flag is named right now (DO_FOR_EACH_INCLUDE_BROKEN), I think we might be 
better off re-thinking things later if we ever end up caring. That 
'is_null_sha1()' check should possibly be under a separate flag.

That said, while I think my patch was the simplest and most 
the problem could certainly have been fixed differently.

For example, instead of using 'for_each_ref()' and then splitting them by 
kind with that "detect kind" loop, it could instead have done two loops, 
ie

	if (kinds & REF_LOCAL_BRANCH)
		for_each_ref_in("refs/heads/", append_local, &ref_list);
	if (kinds & REF_REMOTE_BRANCH)
		for_each_ref_in("refs/remotes/", append_remote, &ref_list);

and avoided the other refs we aren't interested in _that_ way instead.

But it would be a bigger and involved patch. It gets really messy too (I 
tried), because when you use 'for_each_ref_in()' it removes the prefix as 
it goes along, but then the code in builtin-branch.c wants the prefix 
after all.

		Linus
