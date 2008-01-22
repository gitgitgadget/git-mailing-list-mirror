From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] File system difference handling in git
Date: Tue, 22 Jan 2008 08:56:28 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801220829080.2957@woody.linux-foundation.org>
References: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 17:57:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHMQu-0005oS-Pc
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 17:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbYAVQ4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 11:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYAVQ4h
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 11:56:37 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59748 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817AbYAVQ4g (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 11:56:36 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MGuTvq019316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 08:56:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MGuST2030391;
	Tue, 22 Jan 2008 08:56:29 -0800
In-Reply-To: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71461>



On Tue, 22 Jan 2008, Reece Dunn wrote:
> 
>   1.  File name representation
> 
> For Linux file systems (correct me if I am wrong here), they all store
> the file name as-is. The question here is what happens on
> Windows-based file systems (e.g. NTFS) that are being read on Linux?

Generally, Linux tries to follow the conventions of the filesystem, so 
it's generally case-preserving and case-sensitive (but not normalizing in 
any way - the case sensitivity is literally a upcase lookup table, so you 
do "upcase(c1) == upcase(c2)" for each UCS-2 character, no combining or 
decomposition).

But the fs volume can specify if it's a case-sensitive volume or not. And 
the volume will also actually contain the "upcase[]" array that defines 
the case-sensitivity, so exactly *which* characters are equivalent isn't 
actually defined by any external entity, it's defined by the particular 
filesystem instance itself!

There's a default upcase table which is probably the one almost everybody 
uses.

Caveat: I've never used NTFS myself, so I don't have any personal 
knowledge. I can see the sources, and what it thinks it is doing, but 
whether it works that way or not I'll leave to others.

Also, note: at least as far as Linux is concerned, NTFS is pure UCS-2. Not 
UTF-16. 

> For Mac filesystems, you have the Unicode character decomposition
> issues to deal with.
> 
> For Windows, you have UTF-16 filename support.

.. and for pretty much all unixes, you also have potentially Latin1 or any 
other local convention (eg EUC-JP or EUC-KR). 

Sometimes you'd have to guess from the name itself what it is (ie there 
might be a mixture). In those cases, it's probably best to *not* even try 
to convert to unicode.

> There are two basic usages for file/directory names: passing the name
> to the Operating System; getting the name from the Operating System.
> Therefore, you have:
> 
>    os_to_git_path( const NATIVECHAR * ospath, strbuf * gitpath );
>    git_to_os_path( const char * gitpath, const NATIVECHAR * ospath, int oslen );

It's not going to be that simple. And if you want type safety, it's the 
"ospath" that needs to be "char *", since that's what you get from the OS 
and it's really the "index form" that you want to protect from giving 
unconverted by mistake to "lstat()" and friends.

And it's going to be really quite painful even with the compiler pointing 
out each point where you use an "index name" with an operation that wants 
an "OS name".

It would be interesting to see how painful it is (make the actual 
"conversion" be a no-op at first, just casting the pointer), but I suspect 
the answer is "very".

			Linus
