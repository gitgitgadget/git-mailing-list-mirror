From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Semantics of a workspace checkpoint
Date: Thu, 16 Jun 2005 19:00:58 +1000
Message-ID: <2cfc403205061602004a713808@mail.gmail.com>
References: <2cfc4032050616012146948b49@mail.gmail.com>
	 <20050616082847.GA10116@pasky.ji.cz>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 10:56:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiqAI-0005UO-Hb
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 10:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFPJBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 05:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFPJBH
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 05:01:07 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:63343 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261215AbVFPJA7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 05:00:59 -0400
Received: by rproxy.gmail.com with SMTP id i8so237657rne
        for <git@vger.kernel.org>; Thu, 16 Jun 2005 02:00:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LRX4IPAjv8ia2Me7wyMlQKhb9PxtwCUjbz8rpx7APG7DcPSst43ItdT6GGI/16Jl5Op+2f7WnmSfUgnhyuVnABsWWzLu8jZjsysjCccM7OVgaH8UzrqJ6JVfWT712Um25f4rdlOx0RGSipJnd7sRQaL9HNDJQG29XJKJXS21g2U=
Received: by 10.38.78.61 with SMTP id a61mr445641rnb;
        Thu, 16 Jun 2005 02:00:58 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 16 Jun 2005 02:00:58 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050616082847.GA10116@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/16/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Thu, Jun 16, 2005 at 10:21:28AM CEST, I got a letter
> where Jon Seymour <jon.seymour@gmail.com> told me that...
> > I'd like to propose these as the semantics for the checkpointing of a workspace
> 
> What are you actually trying to achieve? How would you define a
> checkpoint? Why are checkpoints good? Why don't you just commit?
> Why do you name checkpoints by treeids?

I am trying to achieve a working directory that is -identical- in
every respect to the working directory at the point at which the
checkpoint is made. Of course, to achieve this objective my proposal
should also provide a facility to capture HEAD, and MERGE_HEAD and any
other tags the user might specify. [ so modify the proposal so that
the contents of .git/checkpoint/<treeid>.tgz is a tar contain the
index, and any saved tags ]

The reason that a treeid alone is not sufficient is that a workspace
which has unresolved merges cannot be represented by a treeid alone
and there is no way to make an index contain the exact state of the
working directory without destroying the stage info.

So, my proposal captures the -exact- state of the index, plus the
-exact- state of the working directory [ and, with the modifications
just proposed, any nominated tag ]

The reason that treeid is used is to name the checkpoint is it is a
simple way and error-free way to identify the tree that needs to be
restored in order to restore to the checkpoint. It could be stored in
the .tgz, but there doesn't seem to be a good reason not to name it by
the tree id.

> 
> > On checkpoint, create a file called:
> >
> > .git/checkpoint/<treeid>
> >
> > where the contents of the file are:
> >     exactly identical to the index file immediately prior to the
> > checkpoint being performed
> >
> > and the treeid is the tree that results from:
> >
> >     git-update-cache $(git-diff-files | cut -f2)
> >     git-write-tree
> >
> > To restore from the checkpoint, one does:
> >
> >     /* magic to remove files that are not in the resulting tree */
> >     git-read-tree -m <treeid>
> >     git-checkout-cache -u -f -a
> >     cp .git/checkpoints/<treeid> .git/index
> 
> Why do you actually store the index itself? If you did write-tree, can't
> you just work with that alone? You essentially rebuilt the index by
> git-read-tree -m <treeid>, didn't you? (And half-destroyed it by the cp
> since you trashed the stat information.)
> 

This doesn't achieve the objective for the reasons specified above.

jon.
