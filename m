From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 14:11:59 -0400
Message-ID: <200504191412.00227.mason@suse.com>
References: <200504191250.10286.mason@suse.com> <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 20:09:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNx8q-0002ca-Am
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 20:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVDSSMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 14:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDSSMK
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 14:12:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:56036 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261247AbVDSSMF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 14:12:05 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id C1F351609C1F;
	Tue, 19 Apr 2005 20:12:03 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 19 April 2005 13:36, Linus Torvalds wrote:
> On Tue, 19 Apr 2005, Chris Mason wrote:
> > I did a quick experiment with applying/commit 100 patches from the suse
> > kernel into a kernel git tree, which quilt can do in 2 seconds.  git
> > needs 1m5s.
>
> Note that I don't think you want to replace quilt with git. The approaches
> are totally different, and git does _not_ obviate the need for the quilt
> kind of "patch testing".
>
> In fact, git has all the same issues that BK had, and for the same
> fundamental reason: if you do distributed work, you have to always
> "append" stuff, and that means that you can never re-order anything after
> the fact.

Very true, you can't replace quilt with git without ruining both of them.  But 
it would be nice to take a quilt tree and turn it into a git tree for merging 
purposes, or to make use of whatever visualization tools might exist someday.  

> What I _would_ like is the ability to re-use an old tree, though. What you
> really want to do is not pass in a set of directory names and just trust
> that they are correct, but just pass in a directory to compare with, and
> if the contents match, you don't need to write out a new one.
>
> I'll try to whip up something that does what you want done, but doesn't
> need (or take) any untrusted information from the user in the form "trust
> me, it hasn't changed".

We already have a "trust me, it hasn't changed" via update-cache.  If it gets 
called wrong the tree won't reflect reality.  The patch doesn't change the 
write-tree default, but does enable you to give write-tree better information 
about the parts of the tree you want written back to git.

With that said, I hate the patch too.  I didn't see how to compare against the 
old tree without reading each tree object from the old tree, and that should 
be slower then what write-tree does now.  So I wimped out and made the quick 
patch that demonstrates the cause of the performance hit.

The "move .git/index to a tmpfs file" change should be easier though, and has 
a real benefit.  How do you feel about s|.git/index|.git/index_dir/index| in 
the sources?  This gives us the flexibility to link it wherever is needed.

-chris
