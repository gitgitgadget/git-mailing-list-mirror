From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already
 there
Date: Thu, 29 Sep 2005 11:26:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509291120170.3308@g5.osdl.org>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 20:29:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL377-0001Jp-Q1
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 20:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVI2S0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVI2S0b
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 14:26:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932444AbVI2S0a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 14:26:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8TIQR4s019674
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 11:26:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8TIQPr6030162;
	Thu, 29 Sep 2005 11:26:26 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9495>



On Thu, 29 Sep 2005, Johannes Schindelin wrote:
>
> With this patch, instead of blindly asking for every remote ref, fetch-pack
> first looks in the local repository if that ref is already there.

No. This is WRONG.

It may seem like a sane thing to do, but it is very very horribly broken.

The fact is, if an earlier fetch was interrupted, or if you've used things
like rsync, you may have disconnected objects in your object store. The 
fact that you have a particular commit object is _not_ a guarantee that 
you have everything that leads up to it.

The "fetch" semantics are simple: we only write out new refs _after_ we've 
fetched all the objects that point to them. That means that while we 
cannot trust a "oh, I already have this commit, let's skip it", we _can_ 
trust "oh, I already have these refs, let's skip them".

So please do _not_ add logic like this to git-fetch. I'd _much_ rather
fetch some objects twice than end up with a corrupt repository.

		Linus
