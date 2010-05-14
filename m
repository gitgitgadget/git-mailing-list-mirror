From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log follow question
Date: Fri, 14 May 2010 07:50:26 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au> <20100514043704.GC6075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Albert Krawczyk <albert@burgmann.anu.edu.au>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 14 16:52:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCwG1-0005x2-2a
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 16:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0ENOwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 10:52:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59858 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315Ab0ENOwq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 10:52:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4EEqWlR025300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 May 2010 07:52:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4EEqVx2005062;
	Fri, 14 May 2010 07:52:32 -0700
In-Reply-To: <20100514043704.GC6075@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.445 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147089>



On Fri, 14 May 2010, Jeff King wrote:
> 
> I'm cc'ing Linus, who has more of a clue in both of those areas than I
> do.

I'm pretty sure I mentioned about this exact issue when I posted the 
original follow patches, and it basically boils down to: "--follow" is a 
total hack, and does _not_ use the regular commit filtering function, and 
as a result, fancy things like "--parent" don't really work well with it.

IOW, I'm not at all certain that it is fixable. "--follow_ is a very 
fundamentally non-gitty thing to do, and really is a complete hack. It's a 
fairly _small_ hack - if you didn't know better and looked at the source 
code, you might think that it fits very naturally into git. But no.

Now, it's possible that we could hack up --parent to work with --follow 
too, but quite frankly, I don't know how. Because the --follow hack really 
basically boils down to:

 - do _not_ prune commits at all (this the the thing that normally 
   simplifies the parenthood and removes uninteresting commits)

 - for the whole list of normal commits in "git log", do the patch 
   generation with a magic special hack that looks for renames.

 - if it was a rename, change the path that we magically track, so that 
   next commit that we look at, we'll follow the new (older) path.

 - if the patch is empty, we force-hide the commit (internally, this is 
   the "rev->always_show_header = 0;" thing)

and the key here is that we do all the magic at the _end_ of the queue, 
long after we've done the pruning of commits that normally does the 
parenthood renaming.

If we want --follow and --parent to work together, you'd need to move the 
special rename hack to be in the early phases. I'm sure it's possible. It 
might even be reasonably simple. But it's very fundamentally not what we 
do now.

And no, I'm unlikely to look at it. Sorry. I have used --follow 
occasionally, but it's a hack to see "ok, there it got renamed". It would 
be nice if "gitk --follow <pathname>" worked properly, but it's just not 
something I care very much about.

			Linus
