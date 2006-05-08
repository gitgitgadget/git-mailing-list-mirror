From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix "git diff --stat" with long filenames
Date: Mon, 8 May 2006 09:46:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605080942410.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 08 18:47:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd8sx-0007gu-QQ
	for gcvg-git@gmane.org; Mon, 08 May 2006 18:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWEHQq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 12:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWEHQq6
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 12:46:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932420AbWEHQq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 12:46:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k48GkstH021990
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 09:46:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k48Gkr06015287;
	Mon, 8 May 2006 09:46:54 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19772>


When we cut off the front of a filename to make it fit on the line, we add 
a "..." in front. However, the way the "git diff" code was written, we 
will never reset the prefix back to the empty string, so every single 
filename afterwards will have the "..." prefix, whether appropriate or 
not.

You can see this with "git diff v2.6.16.." on the current kernel tree, 
since there are filenames with long names that changed there:

 [ snip snip ]
 Documentation/filesystems/vfs.txt                  |  229 
 .../firmware_class/firmware_sample_driver.c        |    3 
 .../firmware_sample_firmware_class.c               |    1 
 ...Documentation/fujitsu/frv/kernel-ABI.txt           |  192 
 ...Documentation/hwmon/w83627hf                       |    4 
 [ snip snip ]

notice how the two Documentation/firmware** filenames caused the "..." to 
be added, but then the later filenames don't want it, and it also screws 
up the alignment of the line numbering afterwards.

Trivially fixed by moving the declaration (and initial setting) of the 
"prefix" variable into the for-loop where it is used.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/diff.c b/diff.c
index c845c87..5315270 100644
--- a/diff.c
+++ b/diff.c
@@ -296,7 +296,6 @@ static const char minuses[]= "----------
 
 static void show_stats(struct diffstat_t* data)
 {
-	char *prefix = "";
 	int i, len, add, del, total, adds = 0, dels = 0;
 	int max, max_change = 0, max_len = 0;
 	int total_files = data->nr;
@@ -318,6 +317,7 @@ static void show_stats(struct diffstat_t
 	}
 
 	for (i = 0; i < data->nr; i++) {
+		char *prefix = "";
 		char *name = data->files[i]->name;
 		int added = data->files[i]->added;
 		int deleted = data->files[i]->deleted;
