X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff opens too many files?
Date: Mon, 20 Nov 2006 09:00:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611200832450.3692@woody.osdl.org>
References: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 20 Nov 2006 17:01:32 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31921>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmCWC-0006R5-OZ for gcvg-git@gmane.org; Mon, 20 Nov
 2006 18:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966206AbWKTRBL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 12:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966204AbWKTRBL
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 12:01:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44769 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S966206AbWKTRBK (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 12:01:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAKH0xix014791
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 20
 Nov 2006 09:01:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAKH0t6d024927; Mon, 20 Nov
 2006 09:00:57 -0800
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 20 Nov 2006, Nguyen Thai Ngoc Duy wrote:
>
> I got this error in a quite big (in files) repository:
> error: open("vnexpress.net/Suc-khoe/2001/04/3B9AF976"): Too many open
> files in system

Ok, "too many open files in system" is ENFILE - you haven't run out of 
file descriptors in _one_ process, but you've exceeded the total number of 
file descriptors in the whole system.

Which is not because we forget to close() something, but because we're 
keeping file descriptors busy another way.

> fatal: cannot hash vnexpress.net/Suc-khoe/2001/04/3B9AF976

Hmm. We keep files mmap'ed in "git diff" for possibly too long. What 
happens is that we mmap a file that we want to diff when we start the 
whole thing, and keep it mapped over the whole diff session, because we're 
potentially going to need to compare it against other files (ie rename 
detection etc). And then we unmap it only at the end (in "diff_flush()" -> 
"diff_free_filepair()" -> "diff_free_filespec_data()").

And that's normally great, and means that we don't need to worry about the 
file data (we map it once, and can keep it in memory), but yeah, if you 
have thousands of files changed, you'll have thousands of mappings. And 
each one will have a pointer to a "struct file" inside the kernel. 

What OS/distro is this? Normally, you shouldn't have that low a limit on 
number of files open, but we do end up potentially opening thousands.

For example, under Linux, you can do this:

	# in one terminal window, do:
	while : ; do cat /proc/sys/fs/file-nr ; sleep 1; done

	# in another one:
	cd linux-repo
	git ls-files '*.c' | xargs touch
	git diff

and if it looks anything like mine, it could be:

	2464    0       349662
	2464    0       349662
	2464    0       349662
*	5920    0       349662
**	7616    0       349662
***	9024    0       349662
****	10944   0       349662
	2464    0       349662
	2464    0       349662


(see how the numnber of active files grows by thousands).

Anyway, there's two possible solutions:

 - simply make sure that you can have that many open files. 

   If it's a Linux system, just increase the value of the file
   /proc/sys/fs/file-max, and you're done. Of course, if you're not the 
   admin of the box, you may need to ask somebody else to do it for you..

 - we could try to make git not keep them mmap'ed for the whole time. 

Junio? This is your speciality, I'm not sure how painful it would be to 
unmap and remap on demand.. (or switch it to some kind of "keep the last 
<n> mmaps active" kind of thing to avoid having thousands and thousands of 
mmaps active).

One simple thing that might be worth it is to simply _not_ use mmap() at 
all for small files. If a file is less than 1kB, it might be better to do 
a malloc() and a read() - partly because it avoids having tons of file 
descriptors, but partly because it's also more efficient from a virtual 
memory usage perspective (not that you're probably very likely to ever 
really hit that problem in practice).

Nguyen - that "use malloc+read" thing might be a quick workaround, but 
only if you have tons of _small_ files (and if you can't easily just 
increase file-max). 

