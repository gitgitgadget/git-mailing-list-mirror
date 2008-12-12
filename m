From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unable to index file
Date: Fri, 12 Dec 2008 10:07:51 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812120956050.3340@localhost.localdomain>
References: <f25d5ad20812120647m646698d7t9849c8ccb08c465e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ramon Tayag <ramon.tayag@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBCRq-0003yw-T9
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 19:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757823AbYLLSH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 13:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758261AbYLLSHz
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 13:07:55 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34276 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757643AbYLLSHy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2008 13:07:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBCI7qWr019721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Dec 2008 10:07:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBCI7pjV026902;
	Fri, 12 Dec 2008 10:07:51 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <f25d5ad20812120647m646698d7t9849c8ccb08c465e@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.426 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102921>



On Fri, 12 Dec 2008, Ramon Tayag wrote:
> 
> I've come across a problem that I don't believe lies in Rails.  You
> needn't be familiar, I think, with Rails to see what's wrong.
> 
> I can't seem to add the files that are in
> http://dev.rubyonrails.org/archive/rails_edge.zip
> 
> 1) Unpack the zip
> 2) Initialize a git repo inside the folder that was unpacked
> 3) git add .
> 
> See the errors.. :o http://pastie.org/337571

What platform/filesystem is this?

Git is rather particular about symlinks, and it looks like your platform 
does something odd, and that makes git unhappy about your symlink.

In particular:

	ls -l vendor/rails/actionpack/test/fixtures/layout_tests/layouts/ 
	...
	lrwxrwxrwx 1 root root 48 2008-12-12 18:22 symlinked -> ../../symlink_parent

notice how the symlink content is "../../symlink_parent", but then take a 
look at the _size_ of the symlink: 48 bytes.

Git expects the lstat() information to match the return from readlink(), 
and it doesn't.

For exact details, see "index_path()" in sha1_file.c:

        case S_IFLNK:   
                len = xsize_t(st->st_size);
                target = xmalloc(len + 1);
                if (readlink(path, target, len + 1) != st->st_size) {
                        char *errstr = strerror(errno);

ie we consider it an error if we get less than st_size characters back 
from readlink().

Now, admittedly git is probably being really annoyingly anal about this 
all, and we probably should loosen the restrictions on it a bit, but I'd 
like to know why it happens. I cannot recall this having been reported 
before, so it's some specific filesystem or OS that causes this, I think.

		Linus
