From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Wed, 13 Jul 2005 13:44:58 -0700
Message-ID: <20050713204458.GB11403@taniwha.stupidest.org>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org> <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org> <Pine.LNX.4.58.0507131256490.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 22:47:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dso8f-0007qu-1R
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVGMUqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVGMUqo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:46:44 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:39299 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262822AbVGMUpA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 16:45:00 -0400
Received: from pimout1-ext.prodigy.net (pimout1-int.prodigy.net [207.115.5.65])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j6DKj2eE026486
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 16:45:02 -0400
X-ORBL: [63.202.173.158]
Received: from stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout1-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j6DKiwE5028156;
	Wed, 13 Jul 2005 16:44:58 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 3D612529BBC; Wed, 13 Jul 2005 13:44:58 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507131256490.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2005 at 01:05:02PM -0700, Linus Torvalds wrote:

> This is really complicated, for no good reason.

What should I be doing?

> The _object_ directories should be linked, but it's really wrong to link 
> the "refs/" directories and expect them to have COW behaviour.

I'm confused.

This function in only used to update various files, one of which is
.git/HEAD

The complexity I added was to deal with a situation where we have

  tree1/
	.git/HEAD -> refs/head/master

and I do "cp -Rl tree1 tree2" giving me:

  tree2/
	.git/HEAD -> refs/head/master

  and .git/refs/head/master is hardlinked between both trees.

Cogito will do "echo <foo> > .git/HEAD" which update *both* tree1 and
tree2 which is not what I want.  So the idea is to readlink and do the
update using echo + rename to get the CoW semantics I desire.


Yes, weird things happen if you have out-of-treel links but I suspect
if you do that with cogito you've probably lost anyhow.

> I've tried to make most of the git tools write the refs objects
> "safely" too, ie things like "git-receive-pack" (the receiving end
> of a "git-send-pack") will write the new ref to a lock-file and then
> do a "rename()" to set it.

Yes, git is probably fine.  Cogito isn't.

> That is COW-safe, but the thing is, it's incredibly painful for many
> other operations, and I won't guarantee that git in general is
> always going to be COW-safe wrt all the git files.

What operations is this painful for?
