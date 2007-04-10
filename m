From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Mon, 9 Apr 2007 21:46:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb8FY-0003iO-9n
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXDJEqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbXDJEqR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:46:17 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43630 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbXDJEqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:46:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3A4kDPD026657
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 21:46:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3A4kCRo031547;
	Mon, 9 Apr 2007 21:46:12 -0700
In-Reply-To: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44114>



On Mon, 9 Apr 2007, Linus Torvalds wrote:
> 
> NOTE! This series of six patches does not actually contain everything you 
> need to do that - in particular, this series will not actually connect up 
> the magic to make "git add" (and thus "git commit") actually create the 
> gitlink entries for subprojects. That's another (quite small) patch, but I 
> haven't cleaned it up enough to be submittable yet.

Here is, for your enjoyment, the last patch I used to actually test this 
all. I do *not* submit it as a patch for actual inclusion - the other 
patches in the series are, I think, ready to actually be merged. This one 
is not.

It's broken for a few reasons:

 - it allows you to do "git add subproject" to add the subproject to the 
   index (and then use "git commit" to commit it), but even something as 
   simple as "git commit -a" doesn't work right, because the sequence that 
   "git commit -a" uses to update the index doesn't work with the current 
   state of the plumbing (ie the

	git-diff-files --name-only -z |
		git-update-index --remove -z --stdin

   thing doesn't work right.

 - even for "git add", the logic isn't really right. It should take the 
   old index state into account to decide if it wants to add it as a 
   subproject. 

so this patch really isn't very good, but it allows people who are 
interested to perhaps actually test something. For example, my test repo 
was actually created with this:

	[torvalds@woody superproject]$ git log --raw
	commit 649ad968bdd79cb3b0f50feb819b7e9b134d3a1a
	Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
	Date:   Mon Apr 9 21:36:53 2007 -0700
	
	    This commits the modification to sub-project B
	
	:160000 160000 5813084832d3c680a3436b0253639c94ed55445d 17d246a35f27a46762328281eb6e9d4558f91e9d M      sub-B

	commit f3c55ffcc000a8c0fecc6801e8909d084e3d419e
	Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
	Date:   Mon Apr 9 16:12:29 2007 -0700
	
	    Superproject with two subprojects
	
	:000000 160000 0000000... c0daf4c85d48879ab450a6a887bbb241eb0de00a A    sub-A
	:000000 160000 0000000... 5813084832d3c680a3436b0253639c94ed55445d A    sub-B

	commit 45eb14edb43b10e3d3ac7a495a1ec861e85dc36f
	Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
	Date:   Mon Apr 9 15:36:24 2007 -0700
	
	    Add top-level Makefile for super-project
	
	:000000 100644 0000000... 57e8394... A  Makefile

so you can see how things look at a low level (ie a "gitlink" is just a 
tree entry with mode 0160000, and the SHA1 is just the SHA1 of the HEAD 
commit in the subproject)

		Linus

---
diff --git a/dir.c b/dir.c
index 4f5a224..ef284a2 100644
--- a/dir.c
+++ b/dir.c
@@ -378,6 +378,14 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 					continue;
 				/* fallthrough */
 			case DT_DIR:
+				/* Does it have a git directory? If so, it's a DIRLNK */
+				if (!dir->no_dirlinks) {
+					memcpy(fullname + baselen + len, "/.git/", 7);
+					if (!stat(fullname, &st)) {
+						if (S_ISDIR(st.st_mode))
+							break;
+					}
+				}
 				memcpy(fullname + baselen + len, "/", 2);
 				len++;
 				if (dir->show_other_directories &&
diff --git a/dir.h b/dir.h
index 33c31f2..1931609 100644
--- a/dir.h
+++ b/dir.h
@@ -33,7 +33,8 @@ struct dir_struct {
 	int nr, alloc;
 	unsigned int show_ignored:1,
 		     show_other_directories:1,
-		     hide_empty_directories:1;
+		     hide_empty_directories:1,
+		     no_dirlinks;
 	struct dir_entry **entries;
 
 	/* Exclude info */
