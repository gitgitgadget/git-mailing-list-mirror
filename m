From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 18:54:23 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311840240.3277@nehalem.linux-foundation.org>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>  <20080731105727.GF7008@dpotapov.dyndns.org>  <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>  <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com> 
 <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>  <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com> <ac9f0f090807311817n551f53a5mb1270e6f4b2a058e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Dmitry Potapov <dpotapov@gmail.com>,
	git@vger.kernel.org
To: cte <cestreich@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 03:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOjvR-000604-0v
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 03:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYHAB5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 21:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbYHAB53
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 21:57:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35685 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbYHAB53 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 21:57:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m711vNZQ017492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 18:57:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m711vMvi023446;
	Thu, 31 Jul 2008 18:57:22 -0700
In-Reply-To: <ac9f0f090807311817n551f53a5mb1270e6f4b2a058e@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.405 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91017>



On Thu, 31 Jul 2008, cte wrote:
>
> Instead, git-log had to be altered to address gitk's needs, and an 
> option was added that users don't typically use.

Actually, no. 

I ended up doing a hack to add "git log --early-output", and some quick 
hacks to make git use it. But I'm happy to say that gitk doesn't use it 
any more. Gitk just parses the normal git log output, although obviously 
it ends up needing enough data to be able to fill in the gaps (ie it uses 
the "--parents" flag to get the rewritten parenthood info and the merges 
to keep it together).

So yeah, we have some options that enable output that simply doesn't make 
_sense_ to humans, but does when you are post-processing it (git has 
always had those, since it very much was about scripting from day one), 
but no, at least gitk doesn't use any really odd ones.

It literally does

	git log --no-color -z --pretty=raw --parents --boundary

(plus the args the user gave it). The --no-color turns off color if it's 
enabled by default.

The -z makes it the git log output a bit easier to parse by using a NUL 
character between commits.

The --pretty=raw is just to give the full/raw commit info - like giving 
the timestamps in the native raw format that is much easier to parse than 
any human-readable format.

The --parents I already mentioned - it is what makes you able to stitch 
the commits together (and it's useful for other things too: any scripts 
that look for merges will tend to use it, for example)

And the --boundary is to show the commits that aren't part of the actual 
selected set in gray.

It's all pretty generic, in other words. The -z option is purely for 
machine parsing, the others _can_ actually be useful even for humans (eg, 
--boundary together with --left-right and --pretty=oneline actually is 
very readable if you are used to that format).

So it's very true that git in general is geared towards scripting (and 
we've often added things to make it even more so), but no, your particular 
complaint isn't true. gitk doesn't do anything really strange.

		Linus
