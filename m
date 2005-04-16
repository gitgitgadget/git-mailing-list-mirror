From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write_sha1_buffer
Date: Fri, 15 Apr 2005 19:55:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151942130.7211@ppc970.osdl.org>
References: <118833cc05041517502fa52a89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 04:49:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdNS-00064X-Jp
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 04:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVDPCxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 22:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVDPCxT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 22:53:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:6059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262585AbVDPCxQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 22:53:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G2r5s4031206
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 19:53:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G2r4xc030433;
	Fri, 15 Apr 2005 19:53:05 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc05041517502fa52a89@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Morten Welinder wrote:
>
> This write will failing sooner or later when someone's disk fills up. 
> That'll leave someone with a truncated file.

Yes. On the other hand, we could try to do this even better, ie make the 
classic write loop that handles EAGAIN.

No POSIX filesystem is supposed to return EAGAIN, but there are tons of 
"POSIX enough" filesystems. Notably NFS when mounted with "intr" (which 
some people think is wrong, but it tends to be better than the 
alternatives if your network is flaky enough).

But yes, even just a "write failed" is good enough, except you should also 
make sure that you remove the corrupt file. Sure, fsck will catch it, but 
if you don't do an fsck, somebody else might decide not to write the file 
out simply because "it's already there".

(This is also why we should write to a temp-file and then do an atomic
"rename()").

		Linus
