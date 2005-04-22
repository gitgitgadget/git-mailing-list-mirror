From: "atani" <atani@atani-software.net>
Subject: (unknown)
Date: Fri, 22 Apr 2005 15:19:54 -0700
Message-ID: <1114208394.7623@tsunami.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Sat Apr 23 00:17:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6SO-0007m5-LF
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDVWUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDVWUu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:20:50 -0400
Received: from atani-software.net ([66.220.5.35]:21388 "HELO
	atani-software.net") by vger.kernel.org with SMTP id S261240AbVDVWT6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 18:19:58 -0400
Received: from tsunami.he.net ([127.0.0.9]) by atani-software.net for <git@vger.kernel.org>; Fri, 22 Apr 2005 15:19:54 -0700
To: GIT Mailing List <git@vger.kernel.org>
Subject: 
X-Mailer: WebMail 1.25
X-IPAddress: 67.113.61.177
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In my tests of using git (both Linus and pasky versions) I had a 
problem with doing "gitadd.sh *" where * expands to include 
directories. This simple patch allows update-cache.c to more 
gracefully handle a directory being passed into the add_file_to_cache 
method.  Without this patch update-cache exits prematurely with an 
error similar to: 
------------- 
fatal: Unable to add plx to database 
------------- 
 
Now it spits out: 
------------- 
'plx' is a directory, ignoring 
------------- 
 
Which from an end user stand point is better. 
 
BTW, so far my tests of using git are positive for my small Dreamcast 
software projects...  I was previously using subversion but find it to 
be a bit of overkill for these small projects. 
 
Martin Schlemmer,  I ran "emerge sync" today and found git has been 
added to portage, version 0.5.  Also note that there are now two "git" 
entries within portage app-misc/git and dev-util/git.  app-misc/git is 
GNU Interactive Tools 
 
Mike 
 
Signed-off-by: Mike Dunston (atani@atani-software.net) 
 
Index: update-cache.c 
=================================================================== 
--- 690494557d393ca78f69a8569880ed4a3aeda276/update-cache.c  
(mode:100644  
sha1:4353b80890ba2afbe22248a4dc25060aa4a429b2) 
+++ uncommitted/update-cache.c  (mode:100644) 
@@ -104,6 +104,11 @@ 
                close(fd); 
                return -1; 
        } 
+       if(S_ISDIR(st.st_mode)) { 
+               printf("'%s' is a directory, ignoring\n", path); 
+               close(fd); 
+               return 0; 
+       } 
        namelen = strlen(path); 
        size = cache_entry_size(namelen); 
        ce = malloc(size); 
