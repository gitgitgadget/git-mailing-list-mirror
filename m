From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On the many files problem
Date: Mon, 31 Dec 2007 12:45:04 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0712311237521.32517@woody.linux-foundation.org>
References: <87y7bdweca.fsf@enceladus.ygingras.net> <alpine.LFD.0.9999.0712291055470.2778@woody.linux-foundation.org> <873atjtbmu.fsf@enceladus.ygingras.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Yannick Gingras <ygingras@ygingras.net>
X-From: git-owner@vger.kernel.org Mon Dec 31 21:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9RWS-0005RY-KG
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 21:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbXLaUph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 15:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbXLaUph
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 15:45:37 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39331 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743AbXLaUpg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Dec 2007 15:45:36 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBVKj5pj000633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Dec 2007 12:45:06 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBVKj4El009070;
	Mon, 31 Dec 2007 12:45:04 -0800
In-Reply-To: <873atjtbmu.fsf@enceladus.ygingras.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.118 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_12,J_CHICKENPOX_33
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69419>



On Mon, 31 Dec 2007, Yannick Gingras wrote:
> 
> This is really interesting and I would not have suspected it.  But it
> begs the question: why does Git use the base-16 hash instead of the
> base-64 hash?  

Because I was stupid, and I'ma lot more used to hex numbers than to 
base-64.

Also, the way the original encoding worked, the SHA1 of the object was 
actually the SHA1 of the *compressed* object, so you could verify the 
integrity of the object writing by just doing a

	sha1sum .git/objects/4f/a7491b073032b57c7fcf28c9222a5fa7b3a6b9

and it would return 4fa7491b073032b57c7fcf28c9222a5fa7b3a6b9 if everything 
was good. That was a nice bonus in the first few days of git development, 
when it all was a set of very low-level object routines hung together with 
prayers and duct-tape.

So consider it historical. It wasn't worth fixing, since it became obvious 
that the real fix would never be to try to make the individual files or 
filenames smaller.

> >    (Also, a "readdir() + stat()" loop will often get *much* worse access 
> >    patterns if you've mixed deletions and creations)
> 
> This is something that will be interesting to benchmark later on.  So,
> an application with a lot of turnaround, say a mail server, should
> delete and re-create the directories from time to time?  I assume this
> is specific to some file system types.

This is an issue only for certain filesystems, and it's also an issue only 
for certain access patterns.

A mail server, for example, will seldom *scan* the directory. It will just 
open individual files by name. So it won't be hit by the "readdir+stat" 
issue, unless you actually do a "ls -l".

(There are exceptions. Some mailbox formats use a file per email in a 
directory. And yes, they tend to suck from a performance angle).

And you can avoid it. For example, on most unixish filesystems, you can 
get better IO access patterns by doing the readdir() into an array, then 
sorting it by inode number, and then doing the stat() in that order: that 
*often* (but not always - there's no guarantee what the inode number 
actually means) gives you better disk access patterns.

			Linus
