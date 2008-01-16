From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Make 'git fsck' complain about non-commit branches
Date: Tue, 15 Jan 2008 17:01:57 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151654050.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801151618300.2806@woody.linux-foundation.org> <7v8x2qd2hu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwgg-0003P9-JX
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbYAPBCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756036AbYAPBCJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:02:09 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50659 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968AbYAPBCI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 20:02:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G11w6u001598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 17:01:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G11vG0012497;
	Tue, 15 Jan 2008 17:01:58 -0800
In-Reply-To: <7v8x2qd2hu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70589>



On Tue, 15 Jan 2008, Junio C Hamano wrote:
> 
> So far, the plumbing level did not care much about the Porcelain
> convention, such as refs/heads and refs/remotes (you seem to
> have forgot) are about "branches" and must point at commit
> objects.

Yeah. I'm not sure this is all a great idea, but I think they are correct 
(and no, "refs/remotes/" would *not* have been correct). 

The "be more careful about parents" patch (builtin-commit.c) is 
unquestionably a good idea - those things really *have* to be commits from 
a plumbing standpoint.

The other ones follow the same rules: "HEAD" really does need to be a 
commit, since that will otherwise cause breakage (not just for "git 
commit", but for "git clone" too). The same is true of "git checkout" and 
"refs/heads/" - if a "refs/heads/" ref isn't a commit, switching branches 
will get confused!

So now git-fsck verifies things that would confuse git itself. But that's 
also why refs/remotes/* aren't checked for being commits, and really a 
remote branch is very *different* from a local branch - because those 
things would never be used for a commit chain by the native git commands, 
so git itself shouldn't care.

We've clearly moved a lot of the porcelain layer into git internals, and 
maybe this went too far, but I suspect not. You can still do whatever the 
heck you want from a porcelain angle, it just has to follow the (fairly 
lax) rules that core git itself does expect.

		Linus
