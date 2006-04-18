From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Log message printout cleanups
Date: Tue, 18 Apr 2006 09:06:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604180854550.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
 <7vodyzkehq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
 <7vejzvka09.fsf@assigned-by-dhcp.cox.net> <7v7j5nk9bf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604171751540.3701@g5.osdl.org> <7vd5ffig70.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604180827040.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 18:06:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVsiS-0000Q6-9T
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 18:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWDRQGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 12:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWDRQGI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 12:06:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751049AbWDRQGH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 12:06:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3IG62tH007022
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 09:06:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3IG629p015790;
	Tue, 18 Apr 2006 09:06:02 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604180827040.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18859>



On Tue, 18 Apr 2006, Linus Torvalds wrote:
> 
> But this all looks very nice. I agree that "git log --stat" is a very nice 
> way to look at the log, much better than "git-whatchanged". And the thing 
> that has really fallen out of this all is how you can do
> 
> 	git log --stat --full-diff drivers/pci/
> 
> which git-whatchanged historically didn't support (of course, now it 
> does, but you're right, the new "git log" is so nice that I'm starting to 
> teach myself not to use "git whatchanged" any more).

Junio, I just tested the "master" branch, and "git log --stat" doesn't 
work there. You may _think_ it works because you've tested it on the git 
tree, were it looks like it is working, but it's missing setting 
"recursive", so it won't actually go into any subdirectories (so it mostly 
works for git itself which has most stuff in the top-level directory, but 
it almost completely doesn't work for linux)

"git log -r --stat" works, so it's really just a missing that.

Something like this (this is master, not "next").

"next" actually has the same bug, but there it is hidden because "git log" 
sets recursive automatically. Which may or may not be appropriate. It 
might be worthwhile to fix it properly in "next" too (there the same 

	if (...output_format == DIFF_FORMAT_PATCH)
		...recursive = 1;

is in revision.c: setup_revisions()).

		Linus

----
diff --git a/git.c b/git.c
index 140ed18..f98c9ba 100644
--- a/git.c
+++ b/git.c
@@ -344,7 +344,8 @@ static int cmd_log(int argc, const char 
 			opt.ignore_merges = 0;
 		if (opt.dense_combined_merges)
 			opt.diffopt.output_format = DIFF_FORMAT_PATCH;
-		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH)
+		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH ||
+		    opt.diffopt.output_format == DIFF_FORMAT_DIFFSTAT)
 			opt.diffopt.recursive = 1;
 		if (!full_diff && rev.prune_data)
 			diff_tree_setup_paths(rev.prune_data, &opt.diffopt);
