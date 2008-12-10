From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: malloc fails when dealing with huge files
Date: Wed, 10 Dec 2008 11:32:32 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812101121401.3340@localhost.localdomain>
References: <43c10b980812100742t3a65466yb9b7310bfedb2b18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonathan Blanton <jonathan.blanton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAUpT-00013W-EF
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 20:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbYLJTdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 14:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbYLJTdH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 14:33:07 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36261 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755581AbYLJTdG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 14:33:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBAJWXGs009859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Dec 2008 11:32:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBAJWWw8023882;
	Wed, 10 Dec 2008 11:32:33 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <43c10b980812100742t3a65466yb9b7310bfedb2b18@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.427 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102703>



On Wed, 10 Dec 2008, Jonathan Blanton wrote:
>
> I'm using Git for a project that contains huge (multi-gigabyte) files.
>  I need to track these files, but with some of the really big ones,
> git-add aborts with the message "fatal: Out of memory, malloc failed".

git is _really_ not designed for huge files.

By design - good or bad - git does pretty much all single file operations 
with the whole file in memory as one single allocation. 

Now, some of that is hard to fix - or at least would generate much more 
complex code. The _particular_ case of "git add" could be fixed without 
undue pain, but it's not entirely trivial either.

The main offender is probably "index_fd()" that just mmap's the whole file 
in one go and then calls write_sha1_file() which really expects it to be 
one single memory area both for the initial SHA1 create and for the 
compression and writing out of the result.

Changing that to do big files in pieces would not be _too_ painful, but 
it's not just a couple of lines either.

However, git performance with big files would never be wonderful, and 
things like "git diff" would still end up reading not just the whole file, 
but _both_versions_ at the same time. Marking the big files as being 
no-diff might help, though.


			Linus
