X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git fetch with multiple remotes failing?
Date: Tue, 31 Oct 2006 08:32:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0610310819170.25218@g5.osdl.org>
References: <20061031155913.GA5157@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 31 Oct 2006 16:32:37 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061031155913.GA5157@mellanox.co.il>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30589>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GewXM-0001gq-Jh for gcvg-git@gmane.org; Tue, 31 Oct
 2006 17:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423559AbWJaQcY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 11:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423561AbWJaQcY
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 11:32:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10939 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1423559AbWJaQcY (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 11:32:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9VGW7Po019970
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 31
 Oct 2006 08:32:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9VGW60u001727; Tue, 31 Oct
 2006 08:32:06 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Sender: git-owner@vger.kernel.org



On Tue, 31 Oct 2006, Michael S. Tsirkin wrote:
> 
> $ cat .git/remotes/origin
> URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Pull: +refs/heads/master:refs/heads/linus_master
> $ cat .git/remotes/jejb-scsi-misc-2.6
> URL: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
> Pull: +refs/heads/master:refs/heads/jejb-scsi-misc-2.6
> $ git fetch -f origin jejb-scsi-misc-2.6
> error: no such remote ref refs/heads/jejb-scsi-misc-2.6
> Fetch failure:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> Looks I must give remotes one by one?

Yes. A single "fetch" will only ever connect to a single repository. If 
you want to fetch from multiple repositories, you have to do multiple 
connections, and thus multiple "fetch"es.

The protocol doesn't even really allow for connecting to two different 
repositories with one connection.

There's also a purely syntactic issue: when you say

	git fetch -f origin jejb-scsi-misc-2.6

then the "origin" is considered to specify the repository (and any 
"default branches") and any subsequent arguments are considered to 
override the _branch_ information in that repository. So the above command 
literally means "fetch branch 'jejb-scsi-misc-2.6' from the repository 
described by 'origin'".

Btw, this _syntactic_ issue is separate from the issue of actually 
initiating multiple connections. For example, "git push" actually 
understands that you can push multiple different repositories at once, but 
even then you can't specify it on the command line directly, for the exact 
same reason as the above "git fetch" thing: the first argument is 
considered the "repository" specifier, and any subsequent arguments are 
specifiers for which branches/tags to push.

So for "git push" (where it makes sense to push the same branches multiple 
times), you can actually do what I do:

 - .git/config contains:

	[remote "all"]
		url = master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6
		url = login.osdl.org:linux-2.6.git

 - and not "git push all master" will push the "master" branch to _both_ 
   of those remote repositories.

However, even that doesn't really make sense for "git fetch": while it is 
a sensible operation to push the same branch-specifier to more than one 
repository, it does _not_ make sense to _fetch_ the same branch-specifier 
from more than one repository.

So multiple fetches would only make sense if you don't allow any branch 
specifiers (and then they'd be fetched from whatever branches the 
"remotes" file says). But that would make "git fetch" have two totally 
different modes, so that's not very good either.

And in the end, even a "git push all" that pushes to multiple repositories 
will actually end up connecting once for each repository, so it's really 
just a shorthand for doing multiple "git push"es. There's no real 
technical advantage, just a convenience.

So I'd suggest just doing

	git fetch origin
	git fetch jejb-scsi-misc-2.6

separately. Sadly, there's not even any way to fake this out with a git 
alias.

