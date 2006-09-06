From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: file rename causes history to disappear
Date: Wed, 6 Sep 2006 09:37:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609060922110.27779@g5.osdl.org>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
 <44FEED4B.30909@garzik.org> <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 06 18:41:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL0ST-0005pb-NT
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 18:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWIFQkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 12:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWIFQkq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 12:40:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751646AbWIFQko (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 12:40:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86GbvnW008946
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 09:37:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86GbuvP015418;
	Wed, 6 Sep 2006 09:37:56 -0700
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
X-Spam-Status: No, hits=-0.482 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26540>



On Wed, 6 Sep 2006, Linus Torvalds wrote:
> 
> 	git log -- drivers/scsi drivers/ata include/linux/ata.h
> 
>    So taking a filename-based approach is actually more _powerful_. You 
>    can emulate the "follow a single file" behaviour on top of it, but you 
>    can't sanely go the other way.

Side note: one thing that I wanted to do, but never got around to, is to 
allow wildcards in the tree-parsing code. It might be too expensive, but 
it's still occasionally something I'd like to do:

	git log -- 'mm/*.c'

to track every single C file in the VM (even if they don't exist right 
_now_).

Notice the difference between

	git log mm/*.c

and the above idea - the latter does actually work, but it only tracks the 
C files that exist right now under mm/. But it should be possible (and is 
potentially useful) to let the wildcard act over the history, rather than 
just a single point in time.

Because one additional advantage of thinking in terms of pathnames is 
exactly the fact that wildcards make sense in a way that they do _not_ 
make sense if you think of tracking "inodes". Exactly because "pathnames 
are forever", and a pathname has validity and exists regardless of whether 
a repository contains a _file_ with that name at any particular point in 
time.

So right now git does do the wildcard thing, but only for "git ls-files" 
(and through that, things like "git add", which used to be implemented in 
terms of ls-files). So you can do

	git add '*.c'

to add all C files (recursively - it's not the shell matcher).

			Linus
