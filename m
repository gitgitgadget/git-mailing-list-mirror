From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 13:23:04 -0400
Message-ID: <200504201323.05447.mason@suse.com>
References: <200504191250.10286.mason@suse.com> <200504201237.38374.mason@suse.com> <Pine.LNX.4.58.0504200957030.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5/oZCLJefJQcKIS"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 19:27:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIxr-00053Y-Of
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVDTR3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVDTR1O
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:27:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61830 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261762AbVDTRXK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:23:10 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E26E79177;
	Wed, 20 Apr 2005 19:23:07 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 6CF0F14CD96; Wed, 20 Apr 2005 19:23:07 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504200957030.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_5/oZCLJefJQcKIS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 20 April 2005 13:06, Linus Torvalds wrote:
> On Wed, 20 Apr 2005, Chris Mason wrote:
> > At any rate, the time for a single write-tree is pretty consistent. 
> > Before it was around .5 seconds, and with this change it goes down to
> > .128s.
>
> Oh, wow.
>
> I bet your SHA1 implementation is done with hand-optimized and scheduled
> x86 MMX code or something, while my poor G5 is probably using some slow
> generic routine. As a result, it only improved by 33% for me since the
> compression was just part of the picture, but with your cheap SHA1 the
> compression costs really dominated, and so it's almost four times faster
> for you.

Aha, I was wondering why your write-tree speeds sounded so bad...this athlon 
machine is ~2years old now.

Your comments about costs for writing the index file got me thinking, so I 
benchmarked how long the update-cache takes if we don't do the sha1 of the 
index file.  There was almost no difference at all.  update-cache currently 
takes about .152 seconds

The code to write the cache calls write() for every cache entry, writing just 
a few bytes at a time.  I changed it to collect these into a 16k buffer, 
which brings me down to .044s.  This might not help as much on ext23, since 
they are faster than reiser for tiny writes.

The patch below with your current tree brings my 100 patch test down to 22 
seconds again.

-chris

--Boundary-00=_5/oZCLJefJQcKIS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="read-cache-fast.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="read-cache-fast.diff"

--- linus.back/read-cache.c	2005-04-20 10:14:23.268310000 -0400
+++ linus/read-cache.c	2005-04-20 13:05:13.200083672 -0400
@@ -232,11 +232,12 @@
 	SHA_CTX c;
 	struct cache_header hdr;
 	int i;
+	char *buf;
+	int len = 0;
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
 	hdr.hdr_version = htonl(1);
 	hdr.hdr_entries = htonl(entries);
-
 	SHA1_Init(&c);
 	SHA1_Update(&c, &hdr, offsetof(struct cache_header, sha1));
 	for (i = 0; i < entries; i++) {
@@ -246,13 +247,31 @@
 	}
 	SHA1_Final(hdr.sha1, &c);
 
+	buf = malloc(16384);
+	if (!buf) {
+		return -1;
+	}
 	if (write(newfd, &hdr, sizeof(hdr)) != sizeof(hdr))
 		return -1;
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		int size = ce_size(ce);
-		if (write(newfd, ce, size) != size)
+		if (size > 16384) {
+			if (write(newfd, ce, size) != size)
+				return -1;
+			continue;
+		}
+		if (len + size > 16384) {
+			if (write(newfd, buf, len) != len)
+				return -1;
+			len = 0;
+		}
+		memcpy(buf + len, ce, size);
+		len += size;
+	}
+	if (len) {
+		if (write(newfd, buf, len) != len)
 			return -1;
 	}
 	return 0;

--Boundary-00=_5/oZCLJefJQcKIS--
