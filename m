From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: dangling blob which is not dangling at all
Date: Tue, 31 Jul 2007 19:22:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707311914570.4161@woody.linux-foundation.org>
References: <20070801013450.GA16498@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 04:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG3rT-0002Jw-8W
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 04:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbXHACWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 22:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbXHACWw
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 22:22:52 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41411 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751667AbXHACWv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 22:22:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l712MKkr016576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Jul 2007 19:22:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l712MEqh002398;
	Tue, 31 Jul 2007 19:22:15 -0700
In-Reply-To: <20070801013450.GA16498@raptus.dandreoli.com>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.18__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54398>



On Wed, 1 Aug 2007, Domenico Andreoli wrote:
> 
> $ git fsck --no-reflogs
> dangling blob e5d444e61b834c34710ce8fb5cb176e20e5894e1
>
> $ git-ls-tree 70b58535361eb633d44d4f1275af3421ca6a5ed7
> ...
> 100644 blob e5d444e61b834c34710ce8fb5cb176e20e5894e1    link_stream.c

Have you done clones with stupid protocols (rsync and/or http)?

The simplest explanation for this is that since you didn't do "--full" for 
fsck, then your git-fsck never looked into the pack-files you had. And the 
tree might well exist in a pack-file, and thus not even looked at by fsck.

So try "git fsck --full", and see if that changes the picture.

(Usually, you'd never have a pack-file *and* the loose object it points to 
both at the same time, but especially if you use the dumb transports 
(rsync and/or http), you'll get pack-files from remotes, and thus you 
won't have the normal nice behaviour of pack-files being "old state", and 
loose objects being "new state".

The easiest fixup is likely to just do "git gc", which which do a nice 
repack, and get rid of loose objects that are duplicates of stuff 
that is also in a pack-file.

		Linus
