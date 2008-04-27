From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: my git problem
Date: Sun, 27 Apr 2008 12:44:54 -0700
Message-ID: <20080427124454.6a606305.akpm@linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 21:46:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqCpE-0001nJ-VF
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 21:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763068AbYD0Tp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 15:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763007AbYD0Tp2
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 15:45:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40268 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762903AbYD0Tp1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2008 15:45:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3RJitbn011877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 12:44:56 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3RJisbR021788;
	Sun, 27 Apr 2008 12:44:54 -0700
In-Reply-To: <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.801 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80479>

On Sun, 27 Apr 2008 12:15:27 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sun, 27 Apr 2008, Andrew Morton wrote:
> > 
> > Now, I want to generate a plain patch against mainline which will add the
> > patches which are in git-ia64 and which aren't in mainline.  ie: when that
> > patch is applied to mainline, we get git-ia64.  Sounds simple.
> > 
> > A naive
> > 
> > 	git-diff origin git-ia64
> 
> Don't do that.
> 
> That will diff between the two branches, and if they both contain stuff 
> (which they obviously do), you'll get all the things that are in origin 
> (but not git-ia64) as a reversed diff.
> 
> What you _want_ is the diff from the last common point, aka the "merge 
> base".
> 
> With git, you could do that as
> 
> 	merge_base=$(git merge-base origin git-ia64)
> 	git diff $merge_base git-ia64
> 
> but there is a convenient shorthand for that, which is to use "a...b" 
> (three dots!), so
> 
> 	git diff -p --stat origin...git-ia64
> 
> should generally get you what you want.

That generates no diff for several trees which I tried it on.  And
afaict from manual inspection, that's correct - they are empty.

git-sched is non-empty:

y:/usr/src/git26> cat .git/branches/git-sched 
git+ssh://master.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-sched-devel.git#for-akpm

and seems to dtrt too.

But I'm pretty sure that the simple solutions were found wanting, but I
don't recall why.  I think it was because of a problem when
git-netdev-all is based on git-net which is based on origin.  I want to
extract the git-net -> git-netdev-all diff, but doing that generates
patches which reapply things which are already applied.

iirc this happens when git-netdev-all is resynced with origin at a
different time from when git-net is resynced with origin.  I get hunks
which reapply (or revert) changes which are in origin.

But I don't presently have any trees which are based on other non-origin
trees so I can't test that.

> I say *generally*, because there might be multiple merge-bases if there 
> are crossing merges between the two branches and there is no well-defined 
> single common point. But that criss-cross case almost never happens for 
> the kernel, because I've been pretty good at trying to teach maintainers 
> to not generate that kind of complex history (it doesn't just obfuscate 
> the above kind of situation, it also makes gitk output harder-to-read than 
> it otherwise would be).
> 
> That said, your script (that does a merge) should have been able to get 
> the diff too, and in fact handle even the criss-cross case. It's written a 
> bit strangely (like having that really old-fashioned way of using git 
> merge, passing in HEAD explicitly etc).

Well.  It is a couple of years old.

I'll try the simple version later, see what happens.  Thanks.
