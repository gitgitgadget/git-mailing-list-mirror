From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 17:09:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603121700410.3618@g5.osdl.org>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
 <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
 <7vk6azcv9y.fsf@assigned-by-dhcp.cox.net> <7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 02:11:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIbZO-0000Hr-Ib
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 02:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWCMBJ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 20:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWCMBJ4
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 20:09:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932316AbWCMBJz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 20:09:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D19mDZ004447
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 17:09:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D19lg4020420;
	Sun, 12 Mar 2006 17:09:47 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17532>



On Sun, 12 Mar 2006, Junio C Hamano wrote:
> 
> To reduce wasted memory, wait until the hash fills up more
> densely before we rehash.  This reduces the working set size a
> bit further.

Umm. Why do you rehash at all?

Just take the size of the "src" file as the initial hash size. 

Also, I think it is likely really wasteful to try to actually hash at 
_each_ character. Instead, let's say that the chunk-size is 8 bytes (like 
you do now), and let's say that you have a 32-bit good hash of those 8 
bytes. What you can do is:

 - for each 8 bytes in the source, hash those 8 bytes (not every byte)
 - for each byte in the other file, hash 8 next bytes. IF it matches a 
   hash in the source with a non-zero count, subtract the count for that 
   hash and move up by _eight_ characters! If it doesn't, add one to 
   "characters not matched" counter, and move up _one_ character, and try 
   again.

At the end of this, you have two counts: the count of characters that you 
couldn't match in the other file, and the count of 8-byte hash-chunks that 
you couldn't match in the first one. Use those two counts to decide if 
it's close or not.

Especially for good matches, this should basically cut your work into an 
eight of what you do now.

Actually, even for bad matches, you cut the first source overhead into one 
eight (the second file will obviously do the "update by 1 byte" most of 
the time).

Don't you think that would be as accurate as what you're doing now (it's 
the same basic notion, after all), and noticeably faster?

			Linus
