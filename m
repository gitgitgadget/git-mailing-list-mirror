From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix git-pull output message
Date: Wed, 28 Sep 2005 08:29:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509280823260.3308@g5.osdl.org>
References: <72499e3b05092803027175bab0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 28 17:30:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKdsv-0005AO-UB
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 17:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVI1PaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 11:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVI1PaJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 11:30:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751295AbVI1PaH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 11:30:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8SFTl4s015695
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Sep 2005 08:29:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8SFTkq7003019;
	Wed, 28 Sep 2005 08:29:46 -0700
To: Robert Watson <robert.oo.watson@gmail.com>
In-Reply-To: <72499e3b05092803027175bab0@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9433>



On Wed, 28 Sep 2005, Robert Watson wrote:
> 
> Notice that the git.git directory is truncated.  It seems the
> intension is to truncate at the .git
> directory level.  The following patch fixes it.

No, the intention really is to remove the ".git" at the end. At least 
that's how I use it.

I like seeing my merges say

    Merge branch 'for-linus' from master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband

even though the _real_ directory was ".../infiniband.git/", simply because 
the ".git" doesn't really add any extra information when you're already in 
git.

_outside_ of git, the ".git" tells you something: it tells you that you're 
entering a git archive. But when merging in git, that part is kind of 
taken for granted, isn't it?

This also matches what "git-receive-pack" and "git-upload-pack" does:

	...
        /* chdir to the directory. If that fails, try appending ".git" */
        if (chdir(dir) < 0) {
                if (chdir(mkpath("%s.git", dir)) < 0)
                        die("unable to cd to %s", dir);
        }

        /* If we have a ".git" directory, chdir to it */
        chdir(".git");
	...

Note how it _both_ will append ".git" to the directory name (if it can't 
find one without ".git" _and_ will try to chdir to a ".git" directory 
_within_ the directory name.

So if you use the native pack ssh interfaces, you really can say

	git pull master.kernel.org:.../infiniband

because the tools (well, the "native pack" ones - not the http/rsync/scp
ones) will automatically DTRT.

		Linus
