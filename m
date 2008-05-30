From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: reducing prune sync()s
Date: Thu, 29 May 2008 19:17:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805291905360.3141@woody.linux-foundation.org>
References: <20080529205743.GC17123@redhat.com>  <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org> <1212112295.3094.3.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Dillow <dave@thedillows.org>
X-From: git-owner@vger.kernel.org Fri May 30 04:18:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1uCS-0000fw-Kq
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 04:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbYE3CRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 22:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbYE3CRm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 22:17:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42328 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742AbYE3CRm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2008 22:17:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4U2H8lS013634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 May 2008 19:17:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4U2H6BW002162;
	Thu, 29 May 2008 19:17:07 -0700
In-Reply-To: <1212112295.3094.3.camel@obelisk.thedillows.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.399 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83265>



On Thu, 29 May 2008, David Dillow wrote:
> 
> On Thu, 2008-05-29 at 17:27 -0700, Linus Torvalds wrote:
> > That would be much better. The code was ported from shell script, and 
> > there is no fsync() in shell, but the rule should basically be that you 
> > can remove all the objects that correspond to a pack-file after you have 
> > made sure that the pack-file (and it's index - we can re-generate the pack 
> > index, but realistically speaking it's *much* better to not have to) is 
> > stable on disk.
> 
> Even if the data is stable on disk, don't we also need to ensure the
> pack's connectivity to the namespace is also stable? Without an fsync()
> of the directory that contains it, could it go away?

In theory, yes. That said, it would always be in lost+found, so the data 
wouldn't ever get really lost. In that sense it is no different from a lot 
of other theoretical git corruption issues - git in general does *not* 
guarantee that the repository will not need to be "fixed up", it just 
makes a strong case for

 - git will always at least *see* the corruption

   (ie it is by design is very hard to corrupt a git repo silently and 
   subtly!)

 - git makes it very hard to lose data

   Old data is not overwritten, but that doesn't mean that you may not 
   have to _look_ for it!

An example of the latter is how a crash in the middle of "git commit" may 
actually cause partial *new* objects to be on disk (the objects themselves 
are not fsync'ed when written!) and may end up with the ref being updated 
but some object it points to was never written (again, a "git commit" does 
not wait until things are stable!), and the index file may be totally 
corrupt (again, no fsync anywhere!).

So if you have a system crash at a really bad time, you may have a git 
repository that needs manual intervention to actually be *usable*. I hope 
nobody ever believed anything else. That manual intervention may be things 
like:

 - throw away a corrupt .git/index file and re-create it (git read-tree)

 - possibly have to recover refs manually ("git fsck" + look at dangling 
   commits)

 - actually throw away broken commits, and re-create them (ie basically 
   doing a "git reset <known-good-state>" plus re-committing the working 
   tree or perhaps re-doing a whole "git am" series or something)

 - and yes, possibly recover lost inodes from /lost+found

Now, quite frankly, all of these are extremely rare. In most cases they 
will never happen at all, simply because the filesystem itself is more or 
less transactional. 

		Linus
