From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 9 Jul 2009 10:18:31 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:19:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOxHH-0005Br-V4
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 19:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbZGIRTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 13:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZGIRTQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 13:19:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56942 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752220AbZGIRTP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 13:19:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69HIWro000454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 10:18:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69HIVGZ029015;
	Thu, 9 Jul 2009 10:18:31 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.965 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122996>



On Thu, 9 Jul 2009, Linus Torvalds wrote:
> 
> Here's an alternative version that just makes the thing return the DT_xyz 
> flag rather than the mode (and it returns DT_REG for symlinks too, because 
> it knows nobody cares - we only really care about "directory or not")

Btw, I'm wondering whether this "look if 'dir/file' exists in index and is 
up-to-date" is really safe.

We don't really verify the whole path when we mark things ce_uptodate(). 
Part of what read_directory() does is to find directory entries, and in 
the process things like "git add" will notice if there's a conflict with 
existing index entries.

So if a directory has changed into a symlink to a directory, this 
particular optimization will actually hide that, I suspect. I haven't 
tested, though. But it might be worth-while to see what happens when you 
had a directory structure, and then do

	mkdir dir
	touch dir/a
	touch dir/b
	git add dir

	mv dir new-dir
	ln -s new-dir dir
	git status

Quite frankly, I'd personally be perfectly ok with git _not_ noticing 
subtle things like this automatically, but..

		Linus
