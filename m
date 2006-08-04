From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Thu, 3 Aug 2006 21:01:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 06:01:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8qsP-0001XH-2S
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 06:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWHDEB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 00:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWHDEB2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 00:01:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751390AbWHDEB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 00:01:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7441OnW024517
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 3 Aug 2006 21:01:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7441Na6019515;
	Thu, 3 Aug 2006 21:01:23 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24770>



On Thu, 3 Aug 2006, Jon Smirl wrote:
>
> I've made 500K object files with my cvs2svn front end. This is 500K of
> revision files and no tree files. Now I run get-repack. It says done
> counting zero objects. What needs to be update so that repack will
> find all of my objects?

Just enumerate them by hand, and pass the list off to git-pack-objects.

IOW, you can _literally_ do something like this

	(cd .git/objects ; find . -type f -name '[0-9a-f]*' | tr -d '\./') |
		git-pack-objects tmp-pack

and it will generate a pack-file and index (called "tmp-pack-*.pack" and 
"tmp-pack-*.idx" respectively) that contains all your lose objects.

Now, that said, pack-file will generally _suck_ if you actually do it like 
the above. You actually want to pass in the object names _together_ with 
the filenames they were generated from, so that git-pack-objects can use 
its heuristics for finding good delta candidates.

So what you actually want to do is pass in a set of object names with the 
name of the file they came with (space in between). See for example

	git-rev-list --objects HEAD^..

output for how something like that might look (git-pack-objects is 
designed to take the "git-rev-list --objects" output as its input).

> git-fsck isn't happy either since I have no HEAD.

Yeah, you cannot (and mustn't) run anything like git-fsck-objects or "git 
prune" until you've connected them all up somehow.

		Linus
