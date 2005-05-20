From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-diff-tree -R A B == git-diff-tree B A"?
Date: Fri, 20 May 2005 08:20:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org>
References: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 17:20:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ9HO-0000gx-T1
	for gcvg-git@gmane.org; Fri, 20 May 2005 17:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVETPTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 11:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVETPTB
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 11:19:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:10173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbVETPSX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 11:18:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KFIFU3026588
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 08:18:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KFIEnB016682;
	Fri, 20 May 2005 08:18:15 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Junio C Hamano wrote:
>
> I was preparing a set of tests for diff family because I wanted
> to have something that catches screwups I am going to inflict
> upon them during the coming couple of days.  One of the tests
> accidentally found out that the above is not true in the current
> implementation.  Just an excerpt of relevant lines [*1*]:
> 
> $ git-diff-tree -r $tree_B $tree_A
> 
> +100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
> +100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
> -100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
> -100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
> 
> $ git-diff-tree -R $tree_A $tree_B
> 
> +100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
> -100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
> +100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
> -100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM


Ahh.. "diff-tree" uses the wrong algorithm for selecting name ordering.

It thinks that "DF" and "DF/" sort equally because it just looks at the
name, not the type. So then, becuse the names sort the same, it will sort
them according to where they come from, and you get the behaviour you see.

It doesn't really matter, but you're right, I should fix it to be
consistent.

git-diff-cache and git-diff-files should automaticallu get it right thanks
to reading the whole tree, so it's likely just git-diff-tree that can get 
confused.

		Linus
