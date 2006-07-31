From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix double "close()" in ce_compare_data
Date: Mon, 31 Jul 2006 09:55:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jul 31 18:56:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7b3K-0008Bv-AK
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 18:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWGaQzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 12:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWGaQzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 12:55:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030238AbWGaQzX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 12:55:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6VGtGnW027006
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Jul 2006 09:55:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6VGtFGB012123;
	Mon, 31 Jul 2006 09:55:16 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.5 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24525>


Doing an "strace" on "git diff" shows that we close() a file descriptor 
twice (getting EBADFD on the second one) when we end up in ce_compare_data 
if the index does not match the checked-out stat information.

The "index_fd()" function will already have closed the fd for us, so we 
should not close it again.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

The way I found this also showed a potential performance problem: if you 
do a "git reset --hard" (or similar) after you have changes in your tree, 
it will write the index file with the same timestamp as the checked out 
files that it re-wrote.

That will also then forever afterwards (well, until the next "git 
update-index --refresh") cause the "uncommon" timestamp case in 
ce_match_stat(), where we check the index-file timestamp against the 
timestamp of the stat data, to trigger.

Not very good. The "ce_modified_check_fs()" tests can be quite expensive 
if you have lots of those files because we end up then calling the 
"ce_compare_data()" function a lot. And suddenly "git diff" doesn't take a 
tenth of a second any more.

We should really try to have some way to re-generate the index 
automatically when this case triggers, so that we only need to do it 
_once_ rather than keep doing it forever while the index is "potentially 
stale".

Any ideas?

diff --git a/read-cache.c b/read-cache.c
index c0b0313..f92cdaa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -61,7 +61,7 @@ static int ce_compare_data(struct cache_
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, 0, NULL))
 			match = memcmp(sha1, ce->sha1, 20);
-		close(fd);
+		/* index_fd() closed the file descriptor already */
 	}
 	return match;
 }
