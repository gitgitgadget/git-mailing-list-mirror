From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do "git add" as a builtin
Date: Thu, 18 May 2006 08:06:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605180800370.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
 <7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
 <7v64k3698l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 17:07:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgk5U-0000fa-6g
	for gcvg-git@gmane.org; Thu, 18 May 2006 17:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWERPGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 11:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWERPGs
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 11:06:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751306AbWERPGr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 11:06:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IF6gtH016066
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 08:06:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IF6fbP022399;
	Thu, 18 May 2006 08:06:41 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64k3698l.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20287>



On Thu, 18 May 2006, Junio C Hamano wrote:
> 
> Well, not good as-is.  This makes it barf on this sequence:
> 
> 	$ rm -f junk
>         $ cd junk
>         $ git init-db
>         $ date >frotz
>         $ mkdir nitfol
>         $ date >nitfol/rezrov
> 	$ git add .		;# OK up to this point - added everything.
> 
> 	$ git add .		;# This is bogus because...
>         fatal: pathspec '' did not match any files

Ahh. The empty pathspec is special.

It's special for a totally stupid reason: it's not a valid pathname, but 
we obviously _turn_ it into a valid pathname when we read the directory 
tree (ie from a filesystem standpoint, it means ".").

So then, when we do the "lstat()", we really _should_ have done the same.

If course, since the lstat() is there just to test for existence, and 
since "." always exists, it's easier to just pass an empty match entirely 
than to turn it into "." and then do an lstat that we know is going to 
succeed.

So the patch would be something trivial like this..

		Linus

---
diff --git a/builtin-add.c b/builtin-add.c
index 7083820..ac9ed2d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -124,7 +124,7 @@ static void prune_directory(struct dir_s
 
 		/* Existing file? We must have ignored it */
 		match = pathspec[i];
-		if (!lstat(match, &st))
+		if (!*match || !lstat(match, &st))
 			continue;
 		die("pathspec '%s' did not match any files", match);
 	}
