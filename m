From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place
 (breaks CoW use)
Date: Wed, 13 Jul 2005 13:05:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131256490.17536@g5.osdl.org>
References: <20050712190552.GA7178@taniwha.stupidest.org>
 <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org>
 <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 22:10:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsnYO-0002CU-Uh
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVGMUGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVGMUGa
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:06:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262748AbVGMUFh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 16:05:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6DK54jA015129
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 13:05:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6DK53Zc000734;
	Wed, 13 Jul 2005 13:05:03 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050713185339.GA9260@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Chris Wedgwood wrote:

> On Wed, Jul 13, 2005 at 09:03:26AM +0200, Matthias Urlichs wrote:
> 
> > You are ;-) the tree itsels is no symlinked, but HEAD points to
> > refs/heads/<branch> by default.
> 
> Thanks for pointing that out.  I honestly never noticed that.
> 
> How about the following?

This is really complicated, for no good reason.

The _object_ directories should be linked, but it's really wrong to link 
the "refs/" directories and expect them to have COW behaviour.

I've tried to make most of the git tools write the refs objects "safely" 
too, ie things like "git-receive-pack" (the receiving end of a 
"git-send-pack") will write the new ref to a lock-file and then do a 
"rename()" to set it. That is COW-safe, but the thing is, it's incredibly 
painful for many other operations, and I won't guarantee that git in 
general is always going to be COW-safe wrt all the git files.

For example, the "git clone -l" behaviour will _only_ link the objects 
subdirectory. The rest is copied. Unless there's a bug there somewhere.

		Linus
