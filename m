From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Documentation: warn against merging in a dirty tree
Date: Thu, 18 Sep 2008 08:15:13 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809180804100.3337@nehalem.linux-foundation.org>
References: <200809160048.31443.trast@student.ethz.ch>  <1221518994-26111-1-git-send-email-trast@student.ethz.ch>  <1221518994-26111-2-git-send-email-trast@student.ethz.ch>  <7vtzch7z7u.fsf@gitster.siamese.dyndns.org>
 <32541b130809151653w27d7876fp35e0967d597ae2a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLLA-0005rJ-DV
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116AbYIRPVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbYIRPVa
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:21:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42164 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755298AbYIRPV3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Sep 2008 11:21:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8IFFEdl025564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Sep 2008 08:15:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8IFFDVa005376;
	Thu, 18 Sep 2008 08:15:13 -0700
In-Reply-To: <32541b130809151653w27d7876fp35e0967d597ae2a9@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.437 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96200>



On Mon, 15 Sep 2008, Avery Pennarun wrote:
> 
> But how do you abort a *failed* merge in a situation like Linus's
> example?  "git reset --hard HEAD" would destroy the unstaged Makefile
> change.

As mentioned by others, sometimes you are simply willing to take the risk. 
If I have dirty data, I still want to merge, because (a) my dirty data is 
a _convenience_ and (b) the risk of me having to do a "git reset" is 
pretty low anyway.

That said, it's actually kind of sad that we don't expose a real 
capability that the git plumbing does have. Namely

	git read-tree -u -m HEAD ORIG_HEAD

should do the right thing if you want to undo a merge (except it doesn't 
actually write ORIG_HEAD to be the new head: you could use "git reset" 
with --soft to do that, or just git update-ref).

So it _may_ be that something like

	[alias]
		undo = !git read-tree -u -m HEAD ORIG_HEAD && git reset --soft ORIG_HEAD

would actually give you "git undo". 

So we have the technology, and we just don't _expose_ that capability as a 
"git reset" thing. And we probably should. In fact, that is often the 
thing people really want, and it would have made sense to have it as the 
default action, but the initial design for "git reset" was literally as a 
way to get you out of a sticky corner when you had unmerged entries and 
you just wanted to throw away crud.

NOTE NOTE NOTE! I did _not_ test that the git read-tree thing actually 
works, or that the above alias does the right thing. Caveat testor! You're 
on your own. But I agree that we should have something like that.

		Linus
