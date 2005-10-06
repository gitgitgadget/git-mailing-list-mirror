From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Wed, 5 Oct 2005 19:18:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510042155090.31407@g5.osdl.org> <7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510050725510.31407@g5.osdl.org> <7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
 <m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 04:20:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENLLc-0002Ja-6O
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 04:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVJFCSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 22:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVJFCSt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 22:18:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750711AbVJFCSr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 22:18:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j962Ig4s007849
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 5 Oct 2005 19:18:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j962IfF0012355;
	Wed, 5 Oct 2005 19:18:41 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.49__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9757>



On Wed, 5 Oct 2005, Eric W. Biederman wrote:
>
> There is another workable strategy.  Modify git-diff-xxx to report
> the sha1 of the tree, or the sha1's of the files the patch applies to.

Not workable.

It fundamentally only works for the first patch in a series. After that, 
the rest will be based off a version that the recipient simply doesn't 
have (well, if it's the _tree_ SHA1, and the recipient has no other 
patches, then they'll match, but that case is uninteresting, since it's 
the trivial case that you always get right by just applying the things in 
the first place).

So you'd have to make it the base for the patch _series_, at a minimum.

And even that likely doesn't work very often. Any time you have a private 
merge or some other patch in your tree, the recipient wouldn't be able to 
parse it.

In practice, I've found that most often it's very trivially obvious _why_ 
a patch doesn't apply (I remember the "other patch" that happened to the 
same file, or I just do a "git-whatchanged -p filename"), and it can be 
useful to allow the person applying the patch to say "ok, try to apply it 
against version xyz, and do a three-way merge".

But it really tends to be fairly rare.

Now obviously, some of that may be kernel-specific - a large part of the 
lack of patch conflicts is that we over the years have actively tried to 
set up the kernel sources so that people seldom step on each other (one 
example is how we have all modules contain their own "init_module()" thing 
and sortign it out in the linker - because the old init/main.c approach 
was _very_ painful since everybody wanted to add lines to the same file).

So it may turn out that other projects might have different wishes for how 
something like this would work. But I doubt it works very well to rely on 
commit-level SHA1's - it's more likely to work if you try the "last few 
tagged releases etc", since patches that don't apply are often against the 
previous release (and if they don't apply there either, then it's probably 
not worth fighting over anyway).

		Linus
