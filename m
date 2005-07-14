From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why O_EXCL would make this difference?  I am puzzled..
Date: Thu, 14 Jul 2005 09:08:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507140904440.19183@g5.osdl.org>
References: <7v8y09g5sq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 18:14:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt6Ly-000469-Ne
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 18:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVGNQOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 12:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVGNQLa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 12:11:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263055AbVGNQJO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 12:09:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6EG91jA002631
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Jul 2005 09:09:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6EG8x8o019694;
	Thu, 14 Jul 2005 09:09:00 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y09g5sq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Jul 2005, Junio C Hamano wrote:
>
> The bisect search found that the commit
> 
> 	Make "git-checkout" create files with O_EXCL
> 
> makes the test t1005 fail.  But it is getting late so I give up
> to figuire this out tonight.

Ahh, thanks for noticing.

It says

	* expecting success: rm -f .git/index &&
	     rm -fr DF &&
	     mkdir DF &&
	     echo DF/DF >DF/DF &&
	     git-update-cache --add DF/DF &&
	     read_tree_twoway $treeDFDF $treeDF &&
	     git-ls-files --stage >DFDFcheck.out &&
	     diff -u DF.out DFDFcheck.out &&
	     check_cache_at DF clean && # different from pure 2-way
	     :
	100644 052efc3abbc31348f7abd34535b1953d38273257 3       DF
	100644 b90ea14b2dd74b6f377c10870b3757344bbe077c 1       DF/DF
	100644 b90ea14b2dd74b6f377c10870b3757344bbe077c 2       DF/DF
	Adding DF
	error: git-checkout-cache: unable to create file DF (File exists)
	Removing DF/DF
	100644 052efc3abbc31348f7abd34535b1953d38273257 0       DF
	DF: dirty
	* FAIL 24: DF vs DF/DF case test (#2) rm -f .git/index &&

Which is strange. If the path already exists, the "lstat(path, &st)" 
should have returned 0 in checkout_entry (which is the only caller of 
"write_entry()"), and that code does an "unlink(path)" before it calls 
write-entry. So I was sure O_EXCL wouldn't make any difference, but I'm 
obviously wrong, wrong, wrong.

I'll strace the dang thing.

		Linus
