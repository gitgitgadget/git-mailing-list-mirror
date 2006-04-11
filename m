From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Implement limited context matching in git-apply.
Date: Tue, 11 Apr 2006 11:23:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604111100510.10745@g5.osdl.org>
References: <m1d5fqi23b.fsf@ebiederm.dsl.xmission.com>
 <m13bgmht9v.fsf@ebiederm.dsl.xmission.com> <m1irphhj1p.fsf_-_@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.64.0604100821340.9504@g5.osdl.org> <m1k69xffcz.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 20:24:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTNWp-0000pj-9R
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 20:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWDKSXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 14:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWDKSXs
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 14:23:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750980AbWDKSXr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 14:23:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3BINMtH030747
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Apr 2006 11:23:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3BINLbo002491;
	Tue, 11 Apr 2006 11:23:21 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1k69xffcz.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18617>



On Mon, 10 Apr 2006, Eric W. Biederman wrote:
> 
> So at a quick inspection it looks to me like:
> About .059s to perform to check for missing files.
> About .019s to write the new tree.
> About .155s in start up overhead, read_cache, and sanity checks.
> 
> So at a first glance it looks like librification to
> allow the redundant work to be skipped, is where
> the big speed win on my machine would be.

That sounded wrong to me, so I did a stupid patch to datestamp the 
different phases of git-write-tree, and here's what it says for me:

     0.000479 setup_git_directory
     0.008333 read_cache
     0.000813 ce_stage check
     0.001838 tree validity check
     0.037233 write_tree itself

	real    0m0.051s
	user    0m0.044s
	sys     0m0.008s

all times are in seconds. 

There is some overhead from the actual process startup (the timestamp 
numbers add up to 0.048696 seconds, which is less than the 0.051 reported 
by "time" - since I didn't datestamp everything), but the biggest chunk by 
far (about three quarters of the total time, including _all_ the setup 
like executing the process) is the actual call to write_tree() itself.

So it probably wouldn't actually be that big a win performance-wise to 
make write_tree() a library and call it directly from git-apply with some 
flag.

To really speed up write-tree, you'd have to know which trees to write, 
and just skip the rest (and know what SHA1's the ones you skipped had: 
it's not enough to just skip them, since you need the SHA1's of even the 
trees you skipped to write the parent tree, and you _will_ change at 
least the top parent tree if you had a valid patch).

Which would imply pretty major surgery - you'd have to add the tree entry 
information to the index file, and make sure they got invalidated properly 
(all the way to the root) whenever adding/deleting/updating a path in the 
index file.

Quite frankly, I don't think it's really worth it.

Yes, it would speed up applying of huge patch-sets, but it's not like 
we're really slow at that even now, and I suspect you'd be better off 
trying to either live with it, or trying to see if you could change your 
workflow. There clearly _are_ tools that are better at handling pure 
patches, with quilt being the obvious example.

I routinely apply 100-200 patches in a go, and that's fast enough to not 
even be an issue. Yes, I have reasonably fast hardware, but we're likely 
talking thousands of patches in a series for it to be _really_ painful 
even on pretty basic developer hardware. Even a slow machine should do a 
few hundred patches in a couple of minutes.

Maybe enough time to get a cup of coffee, but no more than it would take 
to compile the project.

			Linus
