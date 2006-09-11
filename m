From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 19:55:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609101949580.27779@g5.osdl.org>
References: <20060910190332.17667.qmail@science.horizon.com>
 <Pine.LNX.4.64.0609101254590.27779@g5.osdl.org> <17668.38032.20688.991295@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, jonsmirl@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 04:55:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMbxk-0007Ag-OK
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 04:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWIKCzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 22:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWIKCzj
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 22:55:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932210AbWIKCzj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 22:55:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8B2tOnW005103
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Sep 2006 19:55:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8B2tNJq028150;
	Sun, 10 Sep 2006 19:55:23 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17668.38032.20688.991295@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-0.515 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26831>



On Mon, 11 Sep 2006, Paul Mackerras wrote:
> 
> Do you think there is any way to speed up the cold-cache case for
> git-ls-remote and git-rev-parse with thousands of heads and tags?

Nothing obvious comes to mind.

If we did the same pack-file approach that we do for objects, the problem 
ends up being that _updating_ things is really hard. What we could do (and 
might work) is that a "git repack" would create a "packed representation 
of the heads too".

The issue is that once you create a pack, you _really_ don't want to use 
read-modify-write to modify it ever afterwards. That's how you get nasty 
corruption. The "append-only" side of the git object database is really 
what makes things so stable, and packing multiple heads in the same file 
automatically means that if something goes wrong, it's _disastrously_ 
wrong, in a way it isn't when you have separate files.

So we could generate a "pack of references", but then any modifications 
would be done with the current loose "file objects" approach, and just 
have the filesystem override the pack-files. The problem then actually 
becomes one of _deleting_ branches, because then we'd have to add a 
"negative branch" loose object. Ugly.

An alternate approach might be to keep the current filesystem layour, but 
simply do the readdir over the whole reference situation in one pass, then 
sort them by inode number, and look them up in order. That would help on 
some filesystems, at least.

		Linus
