From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PULL] ARM updates
Date: Wed, 8 Jun 2005 08:15:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506080802150.2286@ppc970.osdl.org>
References: <20050608143549.GA7074@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:12:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg2BW-0008Lk-9O
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 17:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFHPN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 11:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFHPN0
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 11:13:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:63415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261304AbVFHPNP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 11:13:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58FD4jA022447
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 08:13:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58FD3Rv024580;
	Wed, 8 Jun 2005 08:13:04 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050608143549.GA7074@dyn-67.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Russell King wrote:
> 
> Please incorporate the latest ARM changes, which can be found at:
> 
> 	master.kernel.org:/home/rmk/linux-2.6-arm.git

Heh, this one showed a problem with some git-apply sanity checks (I use 
"git-apply --stat" to generate the diffstat). 

In particular:

> This will update the following files:
> 
>  arch/arm/mm/minicache.c                |   73 ------------------

You didn't actually delete the file, you made it be zero-sized. Which made 
the patch header be

  diff --git a/arch/arm/mm/minicache.c b/arch/arm/mm/minicache.c
  --- a/arch/arm/mm/minicache.c
  +++ b/arch/arm/mm/minicache.c
  @@ -1,73 +0,0 @@
  ...

and git-apply complains about the fact that the patch deletes the file,
but the file still exists (it can tell both from this: it sees that this
is not a "delete" event, since a "diff --git" would have had a "delete"
header line in it, but it also sees that it's a delete because the patch
has no result lines, ie the final "+0,0" means that there was nothing
left).

Now, git-apply shouldn't actually care _that_ deeply in general, but the 
reason I added that check was exactly because in Linux, I actually want 
zero-sized files to not exist, and it turns out that git-apply did catch 
it..

Anyway, I've made git-apply warn in a nice way (instead of claiming the 
patch is corrupt and exiting), but it did point out that you left 
minixache.c empty, not deleted.

In contrast, the "copypage-xscale.S" file really _was_ deleted by your 
changes, not just made empty.

Russell, do you know why you sometimes generate empty files, and sometimes 
delete them? If you use "patch", add the "-E" flag to it..

		Linus
