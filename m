From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Destructive side-effect of "cg-status"
Date: Sat, 1 Oct 2005 09:41:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>
References: <20050930160353.F025C352B7B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 01 18:43:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELkRb-0000eN-P1
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 18:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVJAQly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 12:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVJAQly
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 12:41:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49115 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbVJAQlx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 12:41:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j91Gfg4s001653
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Oct 2005 09:41:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j91Gffop023392;
	Sat, 1 Oct 2005 09:41:42 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050930160353.F025C352B7B@atlas.denx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9598>



On Fri, 30 Sep 2005, Wolfgang Denk wrote:
>
> So far I  thought  "cg-status"  is  a  harmless  command  which  just
> displays  some  status information. It ain't so. One of our engineers
> reported a  corrupted  repository  after  I  ran  "cg-status"  in  his
> directory:

Well, it's not corrupted, but yes, the index file ends up unreadable.

> That means, that "cg-status" actually *rewrote* .git/index,  with  me
> (wd)  as  new  owner, and - ignoring my umask - with permissions that
> prevent the original owner (sr) to access the file!

The umask thing looks like a bug. Fixed thus.

Also, arguably we should try to avoid writing the index file when not 
necessary, although the fact is, that cg-status (and "git status") _do_ 
need to actually keep it up-to-date in order to do the right thing. Also 
true of some other programs that might otherwise appear to be read-only 
(ie I've considered doing the same thing for "git diff").

We used to have that optimization, but it was broken. I fixed it but 
disabled it for fear of other bugs.

But honoring umask would seem to be a no-brainer.

		Linus

----
diff --git a/index.c b/index.c
--- a/index.c
+++ b/index.c
@@ -29,7 +29,7 @@ int hold_index_file_for_update(struct ca
 		signal(SIGINT, remove_lock_file_on_signal);
 		atexit(remove_lock_file);
 	}
-	return open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0600);
+	return open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0666);
 }
 
 int commit_index_file(struct cache_file *cf)
