From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why O_EXCL would make this difference?  I am puzzled..
Date: Thu, 14 Jul 2005 09:52:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507140944580.19183@g5.osdl.org>
References: <7v8y09g5sq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507140904440.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 18:54:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt6xU-0002QU-Gz
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 18:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVGNQxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 12:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVGNQxE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 12:53:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4285 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbVGNQxD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 12:53:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6EGqrjA006004
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Jul 2005 09:52:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6EGqmYl022250;
	Thu, 14 Jul 2005 09:52:51 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0507140904440.19183@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Jul 2005, Linus Torvalds wrote:
> 
> I'll strace the dang thing.

It's the "Adding" case in git-merge-one-file-script, which does

	git-checkout-cache -u -f -- "$4"

and it's because of this:

	lstat64("DF", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	unlink("DF")                            = -1 EISDIR (Is a directory)
	.. unpack the object ..
	open("DF", O_WRONLY|O_CREAT|O_TRUNC|O_EXCL, 0666) = -1 EEXIST (File exists)

ie the problem is that we actually _have_ a test for this, but it's:

	if (errno == EISDIR && force) {

but if the directory already exists, we do that wrong.

Btw, this also shows a different problem: the symlink handling doesn't do 
any of this, so you cannot even force a directory to become a symlink.

I think both problems can be fixed by just moving the (EISDIR && force) 
test down to the "unlink()".

Will try.

		Linus
