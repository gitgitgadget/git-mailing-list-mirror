From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On the many files problem
Date: Sat, 29 Dec 2007 11:12:38 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712291055470.2778@woody.linux-foundation.org>
References: <87y7bdweca.fsf@enceladus.ygingras.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Yannick Gingras <ygingras@ygingras.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 20:13:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8h7O-0003be-4R
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 20:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbXL2TMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 14:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755402AbXL2TMm
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 14:12:42 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52296 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753253AbXL2TMl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Dec 2007 14:12:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBTJCclU026392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 29 Dec 2007 11:12:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBTJCc03006827;
	Sat, 29 Dec 2007 11:12:38 -0800
In-Reply-To: <87y7bdweca.fsf@enceladus.ygingras.net>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69324>



On Sat, 29 Dec 2007, Yannick Gingras wrote:
> 
> I'm coding an application that will potentially store quite a bunch of
> files in the same directory so I wondered how I should do it.  I tried
> a few different files systems and I tried path hashing, that is,
> storing the file that hashes to d3b07384d113 in d/d3/d3b07384d113.  As
> far as I can tell, that's what Git does.  It turned out to be slower
> than anything except ext3 without dir_index.

Note that git doesn't hash paths because it *wants* to, but because it 
*needs* to. 

Basically, what git very fundamnentally wants as the basic operation, is 
to look up a SHA1 hashed object. 

> Quick like that, I would be tempted to say that hashing paths always
> makes things slower but the Git development team includes people with
> really intimate knowledge of several file system implementations so
> I'm tempted to say that you guys know something that I don't.

No, no. The fastest way to store a bunch of files is to basically:

 - make the filenames as small as possible

   This improves density, and thus performance. You'll get more files to 
   fit in a smaller directory, and filename compares etc will be faster 
   too.

   If you don't need hashes, but can do with smaller names (for example, 
   your names are really just sequential, and you can use some base-64 
   encoding to make them smaller than numbers), you'll always be better 
   off.

 - store them in a good final order. This is debatable, but depending on 
   your load and the filesystem, it can be better to make sure that you 
   create all files in order, because performance can plummet if you start 
   removing files later.

   I suspect your benchmark *only* tested this case, but if you want to 
   check odder cases, try creating a huge directory, and then deleting 
   most files, and then adding a few new ones. Some filesystems will take 
   a huge hit because they'll still scan the whole directory, even though 
   it's mostly empty!

   (Also, a "readdir() + stat()" loop will often get *much* worse access 
   patterns if you've mixed deletions and creations)

 - it's generally *much* more efficient to have one large file that you 
   read and seek in than having many small ones, so if you can change your 
   load so that you don't have tons of files at all, you'll probably be 
   better off.

Anyway, git is not a good thing to look at for "lots of files" performance 
if you have any options. The reasons git does what it does is:

 - as mentioned, the SHA1 hash is the fundamental unit of lookup, so the 
   name *must* be the hash, since that's all we ever have!

 - If you don't have indexing, you really *really* don't want to have a 
   flat file structure (as your benchmark found out). And git didn't want 
   to assume you have indexing, since a lot of filesystems don't (I 
   suspect a lot of ext3 installations _still_ don't enable it, for 
   example, even if the capability is there!)

So the first point explains the use of hashes for filenames, and the 
second point explains the use of a single level of indexing. But neither 
of them are about absolute performance per se, both are about basic 
requirements.

For good performance, look at the git pack-files. Those are designed to be 
data-dense, and only a few files that can be opened and mapped just once. 
There, performance was one of the guiding goals (along with the ability to 
also use them for streaming, and still being *reasonably* simple, of 
course).

			Linus
