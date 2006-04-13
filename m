From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement limited context matching in git-apply.
Date: Thu, 13 Apr 2006 06:02:51 -0600
Message-ID: <m1mzep65uc.fsf@ebiederm.dsl.xmission.com>
References: <m1d5fqi23b.fsf@ebiederm.dsl.xmission.com>
	<m13bgmht9v.fsf@ebiederm.dsl.xmission.com>
	<m1irphhj1p.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0604100821340.9504@g5.osdl.org>
	<m1k69xffcz.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0604111100510.10745@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 14:04:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU0Yg-00077a-4B
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 14:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWDMMET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 08:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWDMMES
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 08:04:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61856 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964895AbWDMMES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 08:04:18 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k3DC2roM018594;
	Thu, 13 Apr 2006 06:02:53 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k3DC2pb4018593;
	Thu, 13 Apr 2006 06:02:51 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604111100510.10745@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 11 Apr 2006 11:23:21 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18660>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 10 Apr 2006, Eric W. Biederman wrote:
>> 
>> So at a quick inspection it looks to me like:
>> About .059s to perform to check for missing files.
>> About .019s to write the new tree.
>> About .155s in start up overhead, read_cache, and sanity checks.
>> 
>> So at a first glance it looks like librification to
>> allow the redundant work to be skipped, is where
>> the big speed win on my machine would be.
>
> That sounded wrong to me, so I did a stupid patch to datestamp the 
> different phases of git-write-tree, and here's what it says for me:
>
>      0.000479 setup_git_directory
>      0.008333 read_cache
>      0.000813 ce_stage check
>      0.001838 tree validity check
>      0.037233 write_tree itself
>
> 	real    0m0.051s
> 	user    0m0.044s
> 	sys     0m0.008s
>
> all times are in seconds. 

Ok.  This is interesting and probably reveals what is different
about my setup.  For you user+sys = real.  For me there was
a significant gap.  So it looks like for some reason I was not
succeeding in keeping .git/index hot in the page cache.

When you are I/O bound it does make sense for read_cache
to be the dominate time.  I just need to track what is up
with my machine that makes me I/O bound.  Having too little
ram is an obvious candidate but it is too simple.  Currently
out of 512M I only have 21M in the page cache which sounds
really low.  Something for me to look at.

> Which would imply pretty major surgery - you'd have to add the tree entry 
> information to the index file, and make sure they got invalidated properly 
> (all the way to the root) whenever adding/deleting/updating a path in the 
> index file.
>
> Quite frankly, I don't think it's really worth it.

For the current size of the kernel tree I agree.

It is a potential scaling limitation and if someone starts
tracking really big tress with git it may be worth revisiting.

> Yes, it would speed up applying of huge patch-sets, but it's not like 
> we're really slow at that even now, and I suspect you'd be better off 
> trying to either live with it, or trying to see if you could change your 
> workflow. There clearly _are_ tools that are better at handling pure 
> patches, with quilt being the obvious example.

Probably.  For my workflow not having to switch tool chains is
the biggest win.  Which is part of what the -C is about.


> I routinely apply 100-200 patches in a go, and that's fast enough to not 
> even be an issue. Yes, I have reasonably fast hardware, but we're likely 
> talking thousands of patches in a series for it to be _really_ painful 
> even on pretty basic developer hardware. Even a slow machine should do a 
> few hundred patches in a couple of minutes.
>
> Maybe enough time to get a cup of coffee, but no more than it would take 
> to compile the project.

Agreed.  I did the analysis so I could understand what was going on.
If the analysis revealed low hanging fruit I would have plucked it.

Eric
