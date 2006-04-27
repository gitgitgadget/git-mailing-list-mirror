From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bug: git-repack -a -d produces broken pack on NFS
Date: Thu, 27 Apr 2006 15:11:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
References: <20060427213207.GA6709@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 28 00:11:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZEi4-0004fb-UJ
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 00:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWD0WLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 18:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWD0WLh
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 18:11:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751818AbWD0WLg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 18:11:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3RMBFtH004070
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Apr 2006 15:11:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3RMBDkj014416;
	Thu, 27 Apr 2006 15:11:14 -0700
To: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060427213207.GA6709@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19246>



On Thu, 27 Apr 2006, Alex Riesen wrote:
>
> NFS server: 2.6.15
> Client: 2.6.17-rc2
> mount options: tigra:/home /net/home nfs rw,nosuid,nodev,noatime,vers=3,rsize=8192,wsize=32768,hard,intr,proto=udp,timeo=7,retrans=3,addr=tigra 0 0

It's repeatable? Can you check if it goes away if your remove "intr"?

That said, the pack-file should all be written with the "sha1write()" 
interface, which is very careful indeed.

I wonder if the _pack-file_ itself might be ok, and the problem is an 
index file corruption. For some reason we check the index file first, 
which is insane. We should check that the pack-file matches its _own_ SHA1 
first, and check the index file second.

So the appended patch would be sensible: before we bother to look at the 
index file at all, we should check the pack-file itself.

If it's just the index file that is corrupt, you may even have a chance to 
recover the data.

The index file is also written with sha1write(), though, so I really don't 
see where it would break. Unless you just simply literally have data 
corruption on the server for some strange reason.

		Linus
---
diff --git a/pack-check.c b/pack-check.c
index 84ed90d..e575879 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -29,12 +29,12 @@ static int verify_packfile(struct packed
 	pack_base = p->pack_base;
 	SHA1_Update(&ctx, pack_base, pack_size - 20);
 	SHA1_Final(sha1, &ctx);
-	if (memcmp(sha1, index_base + index_size - 40, 20))
-		return error("Packfile %s SHA1 mismatch with idx",
-			     p->pack_name);
 	if (memcmp(sha1, pack_base + pack_size - 20, 20))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
+	if (memcmp(sha1, index_base + index_size - 40, 20))
+		return error("Packfile %s SHA1 mismatch with idx",
+			     p->pack_name);
 
 	/* Make sure everything reachable from idx is valid.  Since we
 	 * have verified that nr_objects matches between idx and pack,
