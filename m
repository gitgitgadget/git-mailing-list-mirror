From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 08:40:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <200504201122.35448.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 17:35:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOHDZ-0001le-Jd
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVDTPib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVDTPib
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:38:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:51871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261688AbVDTPiY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 11:38:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KFcKs4004483
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 08:38:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KFcJgY009560;
	Wed, 20 Apr 2005 08:38:19 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504201122.35448.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Chris Mason wrote:
> 
> Thanks for looking at this.  Your new tree is faster, it gets the commit 100 
> patches time down from 1m5s to 50s.

It really _shouldn't_ be faster. It still does the compression, and throws
the end result away.

To actually go faster, it _should_ need this patch. Untested. See if it 
works..

		Linus
---
sha1_file.c: 40c00b77d0e52b31dda1696f10026fe6f92bc082
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -173,12 +173,27 @@ int write_sha1_file(char *buf, unsigned 
 	z_stream stream;
 	unsigned char sha1[20];
 	SHA_CTX c;
+	char *filename;
+	int fd;
 
 	/* Sha1.. */
 	SHA1_Init(&c);
 	SHA1_Update(&c, buf, len);
 	SHA1_Final(sha1, &c);
 
+	filename = sha1_file_name(sha1);
+	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		if (errno != EEXIST)
+			return -1;
+
+		/*
+		 * We might do collision checking here, but we'd need to
+		 * uncompress the old file and check it. Later.
+		 */
+		return 0;
+	}
+
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, Z_BEST_COMPRESSION);
@@ -195,8 +210,10 @@ int write_sha1_file(char *buf, unsigned 
 	deflateEnd(&stream);
 	size = stream.total_out;
 
-	if (write_sha1_buffer(sha1, compressed, size) < 0)
-		return -1;
+	if (write(fd, compressed, size) != size)
+		die("unable to write file");
+	close(fd);
+		
 	if (returnsha1)
 		memcpy(returnsha1, sha1, 20);
 	return 0;
