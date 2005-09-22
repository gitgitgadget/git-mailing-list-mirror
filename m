From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 14:12:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221355330.2553@g5.osdl.org>
References: <E1EIVsD-0001Hu-9m@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 23:15:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIYNc-00007q-86
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 23:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVIVVM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 17:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVIVVM5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 17:12:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030344AbVIVVM4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 17:12:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MLCgBo015661
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 14:12:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MLCcom020623;
	Thu, 22 Sep 2005 14:12:40 -0700
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EIVsD-0001Hu-9m@jdl.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9142>



On Thu, 22 Sep 2005, Jon Loeliger wrote:
> 
> For me, this paragraph suddenly turned on one missing light:
> The default construction of repository branches/heads _mismatches_
> names on local and remote ends: "origin" local came from "master"
> remote.  Did I miss reading that somewhere else? (Likely.)
> 
> And I sat through the Great Remote Name Discussion of '05
> ("How is working on arbitrary remote heads supposed to work in Cogito")
> but I just didn't get it back then.
> 
> (This is an intentional asymmetry, right?  Distributed systems, right?)

Right. It's intentional. The "master" branch tends to be the main one for
everybody, but _my_ "master" branch is clearly _your_ "linus" branch, and
_your_ "master" branch would be the "jon" branch for me.

So it's not "asymmetric". It _is_ symmetric, but it's symmetric the same
way "left" and "right" are symmetric when facing each other - my left is
your right, your left is my right. It's a symmetry, but it's not an 
_identity_.

And obviously, nobody is going to have every possible branch anyway. You
just name the ones you care about (and that, in turn, _will_ break the
symmetry ;)

> In any case, I just tried this:
> 
>     git fetch rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git master:origin
> 
> And got this mess:
> 
>     sent 18136 bytes  received 2731519 bytes  60431.98 bytes/sec
>     total size is 97584183  speedup is 35.49
>     rsync: link_stat "/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/info/alternates" (in pub) failed: No such file or directory (2)
>     rsync error: some files could not be transferred (code 23) at main.c(1173)

Ok, ignore that error.

>     * non-commit: 3fd07d3bf0077dcc0f5a33d2eb1938ea050da8da
>       branch 'master' of rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

Ok, 3fd07d3bf0077dcc0f5a33d2eb1938ea050da8da is my current head, so that 
part looks good. However, the "non-commit" part doesn't look good. It 
_should_ say "committish".

What does

	git-cat-file -t 3fd07d3bf0077dcc0f5a33d2eb1938ea050da8da

say in your tree? I suspect you don't have that object at all, and that
the mirrors are still not in sync (ie I suspect you get a "error: unable
to find 3fd..")

This, btw, is why I hate the rsync protocol. Quite frankly, it sucks. It
was wonderful for bootstrapping git when we didn't have anything else, but
dammit, it's horrid. It has no git knowledge at all, does _zero_ sanity
checking, and leaves the user going "huh" when it fails.

>     * refs/heads/origin: does not fast forward to branch 'master' of rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6;
>       leaving it in 'refs/heads/origin.remote'
> 
> And this is due to kernel.org being Not Quite Right, right?

Yes. It tries to verify that the new commit it stuffs into "origin" is a 
proper superset of the old one (so that you're not losing any data), and 
it fails, since the new commit doesn't even exist in your object list yet.

> Which points out one of the other points of frustration
> that I feel should be addressed eventually:  A whole section
> about "What To Do When It Goes Wonky" needs to be written.

Hey, you seem to have a good example of Wonky, maybe you want to write it?

> OK, so it didn't merge?  Now what?  What got left where?
> How do I recover?  What bits are in my tree, and what bits
> are in the Index, and what bits are in the Object store now?

The good news is, I don't think there's anything to recover. It refused to 
write the new head, because it wasn't valid yet.

Actually, the fact that it even left it as a head might cause problems 
(because now you have a reference to something that doesn't exist), so you 
are probably best off just removing the .git/refs/heads/origin.remote file 
entirely. 

You just need to try again when the mirroring is doing better.

Oh. And I think you might want to change that "rsync:" to "http:" instead. 
It's going to be slower, but at least git-http-fetch should be more 
careful, since it's fetching one object at a time, and validating what it 
fetches that way. The rsync: protocol just does everything totally blidly 
(which makes it fairly efficient, but also means that when things go 
wrong, they are _really_ confusing).

		Linus
