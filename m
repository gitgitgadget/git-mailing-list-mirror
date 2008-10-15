From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 13:08:36 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org> <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm> <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm> <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <20081015124949.b657a8db.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: david@lang.hm, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCgw-0008Iq-8K
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbYJOUIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYJOUIp
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:08:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38215 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859AbYJOUIo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 16:08:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FK8aVp007642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Oct 2008 13:08:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FK8aV0030710;
	Wed, 15 Oct 2008 13:08:36 -0700
In-Reply-To: <20081015124949.b657a8db.akpm@linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.434 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98314>



On Wed, 15 Oct 2008, Andrew Morton wrote:
> 
> I treat my git directory as a read-only thing.  I only ever modify it
> with git commands.

Ok. 

> > (By the filename, I realize it's a file that doesn't exist in one tree or 
> > the other, and which doesn't get removed at some point. But have you had 
> > merge failures, for example? Is it perhaps a file that was created during 
> > a non-clean merge, and then got left behind due to the merge being 
> > aborted? It would be interesting to know what led up to this..)
> 
> That's certainly a possibility - I get a lot of merge failures.  A real
> lot.  And then quite a bit of rebasing goes on, especially in
> linux-next.  And then there's all the other stuff which Stephen does on
> top of the underlying trees to get something releasable happening.

Is "git checkout -f" part of the scripting? Or "git reset --hard"?

So what I could imagine is happening is:

 - you have a lot of automated merging

 - a merge goes south with a data conflict, and since it's all automated, 
   you just want to throw it away. So you do "git reset --force" to do 
   that.

 - but what "git reset --hard" means is to basically ignore all error 
   cases, including any unmerged entries that it just basically ignores.

 - so it did set the tree back, but the whole point of "--hard" is that it 
   ignores error cases, and doesn't really touch them.

Now, I don't think we ever really deeply thought about what the error 
cases should do when they are ignored. Should the file that is in some 
state we don't like be removed? Or should we just ignore the error and 
return without removing the file? Generally git tries to avoid touching 
things it doesn't understand, but I do think this may explain some pain 
for you, and it may not be the right thing in this case.

(And when I say "this case", I don't really know whether you use "git 
checkout -f" or "git reset --hard" or something else, so I'm not even 
going to say I'm sure exactly _which_ case "this case" actually us :)

Of course, the cheesy way for you to fix this may be to just add a

	git clean -dqfx

to directly after whatever point where you decide to reset and revert to 
an earlier stage. That just says "force remove all files I don't know 
about, including any I might ignore". IOW, "git reset --hard" will 
guarantee that all _tracked_ files are reset, but if you worry about some 
other crud that could have happened due to a failed merge, that additional 
"git clean" may be called for.

Of course, it's going to read the whole directory tree and that's not 
really cheap, but especially if you only do this for error cases, it's 
probably not going to be any worse. And I'm assuming you're not compiling 
in that tree, so you probably don't want to save object files (you can 
remove the "x" part, but then you could still at least in theory get a 
filename clash with something that is ignored and thus didn't get cleaned 
up).

			Linus
