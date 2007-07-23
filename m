From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: index-pack died on pread
Date: Mon, 23 Jul 2007 10:04:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 19:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID1L5-0000fD-3G
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 19:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbXGWREw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 13:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756850AbXGWREw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 13:04:52 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44601 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756429AbXGWREv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 13:04:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NH4l7R012351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 10:04:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NH4gal002099;
	Mon, 23 Jul 2007 10:04:42 -0700
In-Reply-To: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53445>



On Mon, 23 Jul 2007, Michal Rokos wrote:
>
> fatal: cannot pread pack file: No such file or directory (n=0,
> errno=2, fd=3, ptr=40452958, len=428, rdy=0, off=123601)

Ok, that's bogus. When "n" is zero, the errno (and thus the error string) 
is not changed by pread, so that's a very misleading error report.

So what seems to have happened is that the pack-file is too short, so we 
got a return value of 0, and then reported it as if it had an errno.

The reason for returning zero from pread would be:

 - broken pread. I don't think HPUX should be a problem, so that's 
   probably not it.

 - the pack-file got truncated

 - the offset is corrupt, and points to beyond the size of the packfile.

In this case, since the offset is just 123601, I suspect it's a truncation 
issue, and your pack-file is simply corrupt. Either because of some 
problem with receiving it, or because of problems on the remote side.

> fetch-pack from 'git://git.kernel.org/pub/scm/git/git' failed.

One thing to look out for is that the "git.kernel.org" machines aren't the 
"primary" ones, and the data gets mirrored from other machines. If the 
mirroring is incomplete, I could imagine that the remote side simply ended 
up terminating the connection, and you ended up with a partial pack-file.

Some of the kernel.org machines ran out of disk space the other day, so 
maybe you happened to hit it in an unlucky window. Does it still happen?

		Linus
