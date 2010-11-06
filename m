From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/8] wrapper: move xmmap() to sha1_file.c
Date: Sat, 6 Nov 2010 06:44:11 -0500
Message-ID: <20101106114411.GA27641@burratino>
References: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:44:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEhC8-0001XV-GH
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024Ab0KFLoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:44:23 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57774 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab0KFLoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:44:22 -0400
Received: by gwj21 with SMTP id 21so2645888gwj.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5sScLZ1PryEwK8UzX8HbQPInG2B+sCEZqMQfx2zqZog=;
        b=FPBW9dwfqEbRm1IpSq1MYdjj7yZrJgaW8IL7jiO7N7cfulbMstIBanFmu0aLKfCWiQ
         nqX6NN+LK1xPLhitJw70/W1U7wtCPsbnj7nZyFG2ExoSdJ4nLTkVhOQtwFabwqIwoj2F
         5iPJeS7Py47URAXde7bMC2IMag2O+lxZqh6IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fDRn/GT07znvgntYK95JesakyxUreH/O8X/h0fF44Rqkjyreli/CYLXj8/r4f2vMFr
         R1h6PAQ2uAs3MGv/ZFVrk6XM8OS5SInrwkFcTqJt3MNKIw9PHVGTO8Aosc2bbll4pVCA
         BDySrZDSHUudmuwgaU+VLwxbAgtwvDvqPwHJw=
Received: by 10.151.9.18 with SMTP id m18mr5141051ybi.172.1289043861342;
        Sat, 06 Nov 2010 04:44:21 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p38sm502580ybk.4.2010.11.06.04.44.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:44:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101106113905.GA27405@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160843>

wrapper.o depends on sha1_file.o for a number of reasons.  One is
release_pack_memory().

xmmap function calls mmap, discarding unused pack windows when
necessary to relieve memory pressure.  Simple git programs using
wrapper.o as a friendly libc do not need this functionality.
So move xmmap to sha1_file.o, where release_pack_memory() is.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c |   15 +++++++++++++++
 wrapper.c   |   15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0cd9435..8e299ae 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -576,6 +576,21 @@ void release_pack_memory(size_t need, int fd)
 		; /* nothing */
 }
 
+void *xmmap(void *start, size_t length,
+	int prot, int flags, int fd, off_t offset)
+{
+	void *ret = mmap(start, length, prot, flags, fd, offset);
+	if (ret == MAP_FAILED) {
+		if (!length)
+			return NULL;
+		release_pack_memory(length, fd);
+		ret = mmap(start, length, prot, flags, fd, offset);
+		if (ret == MAP_FAILED)
+			die_errno("Out of memory? mmap failed");
+	}
+	return ret;
+}
+
 void close_pack_windows(struct packed_git *p)
 {
 	while (p->windows) {
diff --git a/wrapper.c b/wrapper.c
index fd8ead3..3195ef3 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -108,21 +108,6 @@ void *xcalloc(size_t nmemb, size_t size)
 	return ret;
 }
 
-void *xmmap(void *start, size_t length,
-	int prot, int flags, int fd, off_t offset)
-{
-	void *ret = mmap(start, length, prot, flags, fd, offset);
-	if (ret == MAP_FAILED) {
-		if (!length)
-			return NULL;
-		release_pack_memory(length, fd);
-		ret = mmap(start, length, prot, flags, fd, offset);
-		if (ret == MAP_FAILED)
-			die_errno("Out of memory? mmap failed");
-	}
-	return ret;
-}
-
 /*
  * xread() is the same a read(), but it automatically restarts read()
  * operations with a recoverable error (EAGAIN and EINTR). xread()
-- 
1.7.2.3.557.gab647.dirty
