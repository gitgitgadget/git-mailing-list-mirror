From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 15:04:58 -0400
Message-ID: <200504201504.59541.mason@suse.com>
References: <200504191250.10286.mason@suse.com> <200504201323.05447.mason@suse.com> <Pine.LNX.4.58.0504201040400.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bfqZCE4E/ZEDLge"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 21:02:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOKRr-0002ve-25
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 21:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVDTTFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 15:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDTTFX
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 15:05:23 -0400
Received: from mail.suse.de ([195.135.220.2]:43659 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261530AbVDTTFH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 15:05:07 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 25C49160A3B1;
	Wed, 20 Apr 2005 21:05:06 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504201040400.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_bfqZCE4E/ZEDLge
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 20 April 2005 13:52, Linus Torvalds wrote:
> On Wed, 20 Apr 2005, Chris Mason wrote:
> > The patch below with your current tree brings my 100 patch test down to
> > 22 seconds again.
>
> If you ever have a cache_entry bigger than 16384, your code will write
> things out in the wrong order (write the new cache without flushing the
> old buffer).

Whoops

> Finally, if you really want to go fast, you should really try to make your
> writes powers-of-two, ie fill up the buffer entirely rather than saying
> "if I were to overflow, flush it now". It doesn't matter that much for
> some filesystems (especially local and append-only like the patterns are
> here), but it can definitely matter for the stupid ones.

Well, the difference there should be pretty hard to see with any benchmark.
But I was being lazy...new patch attached.  This one gets the same perf 
numbers, if this is still wrong then I really need some more coffee.

-chris


--Boundary-00=_bfqZCE4E/ZEDLge
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="read-cache-fast.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="read-cache-fast.diff"

--- linus.back/read-cache.c	2005-04-20 10:14:23.268310000 -0400
+++ linus/read-cache.c	2005-04-20 14:54:28.554518320 -0400
@@ -232,11 +232,13 @@
 	SHA_CTX c;
 	struct cache_header hdr;
 	int i;
+	#define BUFLEN 16384
+	static char buf[BUFLEN];
+	int len = 0;
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
 	hdr.hdr_version = htonl(1);
 	hdr.hdr_entries = htonl(entries);
-
 	SHA1_Init(&c);
 	SHA1_Update(&c, &hdr, offsetof(struct cache_header, sha1));
 	for (i = 0; i < entries; i++) {
@@ -246,13 +248,37 @@
 	}
 	SHA1_Final(hdr.sha1, &c);
 
-	if (write(newfd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		return -1;
-
+	/* hdr is small right now, but just
+	 * in case someone changes that...
+	 */
+	if (sizeof(hdr) < BUFLEN) {
+		memcpy(buf, &hdr, sizeof(hdr));
+		len += sizeof(hdr);
+	} else {
+		if (write(newfd, &hdr, sizeof(hdr)) != sizeof(hdr))
+			return -1;
+	}
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		int size = ce_size(ce);
-		if (write(newfd, ce, size) != size)
+		char *p = (char *)ce;
+		while(size > 0) {
+			int count = size;
+			if (count > BUFLEN - len)
+				count = BUFLEN - len;
+			memcpy(buf + len, p, count);
+			size -= count;
+			len += count;
+			p += count;
+			if (len == BUFLEN) {
+				if (write(newfd, buf, len) != len)
+					return -1;
+				len = 0;
+			}
+		}
+	}
+	if (len) {
+		if (write(newfd, buf, len) != len)
 			return -1;
 	}
 	return 0;

--Boundary-00=_bfqZCE4E/ZEDLge--
