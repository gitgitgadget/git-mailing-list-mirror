From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 12:37:37 -0400
Message-ID: <200504201237.38374.mason@suse.com>
References: <200504191250.10286.mason@suse.com> <200504201122.35448.mason@suse.com> <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SVoZC/UDV5K3uhy"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:34:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOI97-0004eD-Ed
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 18:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVDTQiC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 12:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDTQiC
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 12:38:02 -0400
Received: from ns.suse.de ([195.135.220.2]:33206 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261718AbVDTQhm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 12:37:42 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 43E2B1609676;
	Wed, 20 Apr 2005 18:37:41 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_SVoZC/UDV5K3uhy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 20 April 2005 11:40, Linus Torvalds wrote:
> On Wed, 20 Apr 2005, Chris Mason wrote:
> > Thanks for looking at this.  Your new tree is faster, it gets the commit
> > 100 patches time down from 1m5s to 50s.
>
> It really _shouldn't_ be faster. It still does the compression, and throws
> the end result away.

Well, that's a little odd.  I had thought about making sure you did this 
change and forgotten.  1 minute benchmarks are a horrible idea since they run 
into noise with cache writebacks.  I should know better...

At any rate, the time for a single write-tree is pretty consistent.  Before it 
was around .5 seconds, and with this change it goes down to .128s.  My patch 
was .024.

The 100 patch time is down to 32s (3 run average).  This is close enough that 
I don't think my patch is worth it if no other part of git can benefit from 
having trees in the index.

>
> To actually go faster, it _should_ need this patch. Untested. See if it
> works..

Thanks. This one missed the filling in the returnsha1.  New patch attached.

-chris

--Boundary-00=_SVoZC/UDV5K3uhy
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="file-check.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="file-check.diff"

diff -u linus.back/sha1_file.c linus/sha1_file.c
--- linus.back/sha1_file.c	2005-04-20 12:31:00.240181016 -0400
+++ linus/sha1_file.c	2005-04-20 12:13:56.339837528 -0400
@@ -173,12 +173,27 @@
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
+		goto out;
+	}
+
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, Z_BEST_COMPRESSION);
@@ -195,8 +210,10 @@
 	deflateEnd(&stream);
 	size = stream.total_out;
 
-	if (write_sha1_buffer(sha1, compressed, size) < 0)
-		return -1;
+	if (write(fd, compressed, size) != size)
+		die("unable to write file");
+	close(fd);
+out:		
 	if (returnsha1)
 		memcpy(returnsha1, sha1, 20);
 	return 0;

--Boundary-00=_SVoZC/UDV5K3uhy--
