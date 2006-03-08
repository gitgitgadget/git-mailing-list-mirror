From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] write_sha1_file(): Perform Z_FULL_FLUSH between header and
 data
Date: Wed, 8 Mar 2006 13:45:19 +0300
Message-ID: <20060308134519.78ea313d.vsu@altlinux.ru>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
	<7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
	<20060224174422.GA13367@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
	<20060224183554.GA31247@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
	<20060224192354.GC387@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
	<7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602250012230.31162@localhost.localdomain>
	<7vzmk1izpa.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 08 11:46:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGwB0-00061o-3U
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 11:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWCHKpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 05:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWCHKpk
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 05:45:40 -0500
Received: from master.altlinux.org ([62.118.250.235]:50184 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750833AbWCHKpj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 05:45:39 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 3F651E3499; Wed,  8 Mar 2006 13:45:26 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id 36B10E3668D; Wed,  8 Mar 2006 13:45:19 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmk1izpa.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17368>

Data after Z_FULL_FLUSH will be compressed independently of the
header, and could therefore be reused without recompressing when
creating a pack.

---

This passes "make test" and unpacking of the whole git repo with
git-fsck-objects afterwards.

However, a straight reuse still will not be possible, because
sha1write_compressed() uses deflateInit(&stream, Z_DEFAULT_COMPRESSION),
which writes zlib headers around the deflate stream, and the zlib footer
contains adler32 checksum.  So, as a minimum, you will need to
decompress the object data, calculate its adler32 checksum and write the
zlib header yourself.

 sha1_file.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

8b12d9a58e87a4c5b5a2a7b20d06fe29a5afb903
diff --git a/sha1_file.c b/sha1_file.c
index a80d849..34d4da4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1399,7 +1399,8 @@ int write_sha1_file(void *buf, unsigned 
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, Z_BEST_COMPRESSION);
-	size = deflateBound(&stream, len+hdrlen);
+	/* Additional 6 bytes for the Z_FULL_FLUSH marker */
+	size = deflateBound(&stream, hdrlen) + 6 + deflateBound(&stream, len);
 	compressed = xmalloc(size);
 
 	/* Compress it */
@@ -1412,6 +1413,10 @@ int write_sha1_file(void *buf, unsigned 
 	while (deflate(&stream, 0) == Z_OK)
 		/* nothing */;
 
+	/* Flush before data */
+	while (deflate(&stream, Z_FULL_FLUSH) == Z_OK)
+		/* nothing */;
+
 	/* Then the data itself.. */
 	stream.next_in = buf;
 	stream.avail_in = len;
-- 
1.2.GIT
