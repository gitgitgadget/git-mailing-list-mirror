X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Is cp -al safe with git?
Date: Thu, 16 Nov 2006 11:19:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611161108020.3349@woody.osdl.org>
References: <ejibnp$mmq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 19:19:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejibnp$mmq$1@sea.gmane.org>
X-MIMEDefang-Filter: osdl$Revision: 1.157 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31619>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkmlq-0001hZ-Mb for gcvg-git@gmane.org; Thu, 16 Nov
 2006 20:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424366AbWKPTTa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 14:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424372AbWKPTTa
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 14:19:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51860 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1424366AbWKPTT3 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 14:19:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGJJMoZ024524
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 11:19:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGJJLiJ002952; Thu, 16 Nov
 2006 11:19:22 -0800
To: Johannes Sixt <johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Johannes Sixt wrote:
>
> For one reason or another I would like to "clone" a local repo including the
> checked-out working tree with cp -al instead of cg-clone/git-clone, i.e.
> have all files hard-linked instead of copied.

It works, but I don't think you should depend on it.

> Can the copies be worked on independently without interference (with the git
> tool set)?

We _tried_ to make sure it is ok, but since it's not a normal mode of 
operation, I would not guarantee it.

> One thing I noticed is that git-reset or probably git-checkout-index breaks
> links of files that need not be changed by the reset.

Yes and no. They do _not_ actually break links of files that they know 
stay the same, but your example breaks the internal knowledge by using 
that "cp -al". That changes the modification time of the inodes, so git 
thinks that the files _may_ have changed, and when you do a "git reset", 
it will overwrite them all.

> Example:
> 
> # make 2 files, commit
> $ mkdir orig && cd orig
> $ git-init-db 
> defaulting to local storage area
> $ echo foo > a && cp a b && git-add a b && git-commit -a -m 1
> Committing initial tree 99b876dbe094cb7d3850f1abe12b4c5426bb63ea
> 
> # 2nd commit modifies only one file:
> $ echo bar > a && git-commit -a -m 2
> 
> # create the copy:
> $ cd ..
> $ cp -al orig copy
> $ cd copy
> 
> # working files are hard-linked:
> $ ls -l
> total 8
> -rw-r--r-- 2 jsixt users 4 Nov 16 19:24 a
> -rw-r--r-- 2 jsixt users 4 Nov 16 19:23 b
> 
> # nuke a commit:
> $ git-reset --hard HEAD^
> $ ls -l
> total 8
> -rw-r--r-- 1 jsixt users 4 Nov 16 19:24 a
> -rw-r--r-- 1 jsixt users 4 Nov 16 19:24 b
> 
> I'd have expected that the hard-link of b remained and only a's link were
> broken. Does it mean that git-reset writes every single file also for large
> trees like the kernel? I cannot believe this. Can someone scratch the
> tomatoes off my eyes please?

If you do a

	git update-index --refresh

(or, more easily, a "git status", which will do the index refresh for you) 
before you do the "git reset", you will get:

	$ ls -l
	total 8
	-rw-r--r-- 1 jsixt users 4 Nov 16 19:24 a
	-rw-r--r-- 2 jsixt users 4 Nov 16 19:24 b

like you want to. The reason "git reset" overwrites _both_ files in your 
example is that the stat() information for those files changed, so "git 
reset" thinks they are both dirty and both need to be rewritten.

That said, I would seriously suggest that you try these things out, and 
realize that most people do _not_ use the hardlinked approach. For all I 
know, some piece of git might change some files in-place. I don't _think_ 
we do, and it would strictly speaking be a bug, but because people don't 
use it that way, you'd be the guinea pig.

I think we'll happily fix any bugs you find, but that may not make you any 
happier if the bug corrupted your lifes work ;)

In general, you might want to use

	git clone -l -s

instead, but that will _not_ hardlink the actual checked-out contents, so 
it's not going to get the kind of sharing you look for. On the other hand, 
especially with good maintenance (doing "git repack -l -d -a" etc), you 
may end up sharing _more_ that way at least in the repository object 
database (but never in the actual checked-out directories).

