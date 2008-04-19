From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 16:26:19 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain> <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org> <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Apr 20 01:27:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnMSs-0008FO-I3
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 01:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbYDSX02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 19:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755835AbYDSX01
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 19:26:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38057 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755173AbYDSX00 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 19:26:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JNQK6A001103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 16:26:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JNQJG0004928;
	Sat, 19 Apr 2008 16:26:20 -0700
In-Reply-To: <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79935>



On Sun, 20 Apr 2008, Pieter de Bie wrote:
> 
> The number of lstats are cut down by your patch: 428761 vs. 338091. Funnily
> enough, there is no significant difference in run-time:

It may be that the problem with OS X is a sucky pathname cache mechanism.

The trivial patch cut down the number of stat() calls by a fair amount, 
but the calls that got removed were all of the "do two 'lstat()' calls on 
the exact same pathname consecutively" type.

Maybe OS X has some very limited pathname caching that catches that, or 
even if not, it just ends up being very nice in the D$, so it's not a big 
deal. And then the real suckiness happens only with bigger workloads.

It may also be that the bulk of the OS X cost isn't in lstat() at all, but 
in the VM. That was true for some other OS X load.

> Command                                            Mean     Std
> git status .                                       13.970  1.298
> /Users/pieter/projects/External/git/git-status .   13.759  0.321

This is the WebKit archive, right?

For me, doing a "time git status ." on the WebKit thing I just cloned from 
git://git.webkit.org/WebKit.git is much faster: 1.264s (and it goes down 
by maybe 5-10% with my lstat-avoidance patch).

Is there any system-level profiler for OS X to get a clue where that cost 
is, in case it's not the lstat() at all?

			Linus
