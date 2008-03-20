From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Two bugs with renaming
Date: Wed, 19 Mar 2008 21:12:02 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803192059120.3020@woody.linux-foundation.org>
References: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:13:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcC9G-0001Jy-6j
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbYCTEMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbYCTEMW
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:12:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54111 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794AbYCTEMV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 00:12:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2K4C5fs014262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Mar 2008 21:12:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2K4C2GE020837;
	Wed, 19 Mar 2008 21:12:04 -0700
In-Reply-To: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.281 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77621>



On Wed, 19 Mar 2008, John Goerzen wrote:
>
> #######
> # Set up bug #2
> 
> jgoerzen@katherina:/tmp/testrepo$ echo foo > foo
> jgoerzen@katherina:/tmp/testrepo$ git add foo
> jgoerzen@katherina:/tmp/testrepo$ git commit -m 'Added foo'
> jgoerzen@katherina:/tmp/testrepo$ git checkout testbranch
> Switched to branch "testbranch"
> jgoerzen@katherina:/tmp/testrepo$ ls -l
> total 0
> lrwxrwxrwx 1 jgoerzen jgoerzen 16 Mar 19 18:14 files -> /tmp/nonexistant
> drwxr-xr-x 2 jgoerzen jgoerzen 22 Mar 19 18:14 files.upstream
> jgoerzen@katherina:/tmp/testrepo$ git merge master
> fatal: Entry 'files/delete.me' would be overwritten by merge. Cannot merge.
> Merge with strategy recursive failed.

Ok, so if I read this right, you have a D/F conflict, with the current 
branch having a file (or rather, a symlink) called "files", and the branch 
you are trying to merge has a *directory* called "files" in it, and the 
merge gets really unhappy about that conflict.

Now, arguably, it should just see them as two independent issues, and then 
the rename detection will notice that the "files/delete.me" file got 
renamed as "files.upstream/delete.me", so *after* rename detection there 
will be no D/F conflict in the end result, but we see the conflict before 
that all even happens.

Ho humm. 

With the new unpack-trees logic it's pretty easy to *not* unpack with DF 
conflicts (add a flag that tells us to use "base_name_compare()" instead 
of "df_name_compare()" in do_compare_entry()), and maybe we can then make 
builtin-merge-recursive.c set that flag. But then builtin-merge-recursive
would also have to understand about D/F conflicts itself (since now 
unpack_trees() wouldn't give them as conflicts any more).

			Linus
