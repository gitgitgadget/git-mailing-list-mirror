From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling very large numbers of symbolic references?
Date: Tue, 25 Jul 2006 16:20:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607251612480.29649@g5.osdl.org>
References: <87psfteb4l.fsf@hades.wkstn.nix> <Pine.LNX.4.64.0607251508540.29649@g5.osdl.org>
 <87psftb7v8.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 01:21:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5WD7-0002qg-0z
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 01:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWGYXVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 19:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWGYXVE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 19:21:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030248AbWGYXVD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 19:21:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6PNKxnW024933
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Jul 2006 16:21:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6PNKwkW014611;
	Tue, 25 Jul 2006 16:20:59 -0700
To: Nix <nix@esperi.org.uk>
In-Reply-To: <87psftb7v8.fsf@hades.wkstn.nix>
X-Spam-Status: No, hits=-0.518 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24193>



On Wed, 26 Jul 2006, Nix wrote:
> 
> Well, actually I was considering trying a combination of two things:
> 
>  - a new type of multi-entry ref (as you suggested), perhaps in a file
>    refs/inactive-heads, which is merged with the heads list by lookup
>    operations only (so merge would see them, but ls-remote would not:
>    `invisible heads' if you will)

Yes, that should work. Make sure that you tell git-fsck-objects and 
git-prune that those heads are reachable, though.

Of course, if you end up having one "master" head (that is the "merge" of 
all branches), that would take care of the reachability issue too: you 
don't actually need to create a _real_ merge, you can just make sure that 
there is a commit that points to all new heads you create. It could even 
have a totally dummy tree node, ie you could do

	oldhead=$(git-rev-parse HEAD^0) || exit
	newhead=$(git commit-tree $oldhead -p $oldhead -p new-bug-head < changelog) || exit
	git update-ref HEAD $newhead $oldhead

which would just update the commit list with a fake "merge" commit merging 
"new-bug-head" into the stream of top commits (using the same tree as the 
previous "HEAD" commit had) so that it's always reachable.

Something like that, anyway. That way you can do a "git clone" and you get 
all the bug commits through a single HEAD.

		Linus
