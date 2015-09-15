From: Jeff King <peff@peff.net>
Subject: [PATCH 16/67] archive-tar: use xsnprintf for trivial formatting
Date: Tue, 15 Sep 2015 11:37:42 -0400
Message-ID: <20150915153741.GP29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:37:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsIp-0006ra-UL
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbbIOPhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:37:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:59314 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752868AbbIOPho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:37:44 -0400
Received: (qmail 11731 invoked by uid 102); 15 Sep 2015 15:37:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:37:44 -0500
Received: (qmail 7056 invoked by uid 107); 15 Sep 2015 15:37:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:37:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:37:42 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277917>

When we generate tar headers, we sprintf() values directly
into a struct with the fixed-size header values. For the
most part this is fine, as we are formatting small values
(e.g., the octal format of "mode & 0x7777" is of fixed
length). But it's still a good idea to use xsnprintf here.
It communicates to readers what our expectation is, and it
provides a run-time check that we are not overflowing the
buffers.

The one exception here is the mtime, which comes from the
epoch time of the commit we are archiving. For sane values,
this fits into the 12-byte value allocated in the header.
But since git can handle 64-bit times, if I claim to be a
visitor from the year 10,000 AD, I can overflow the buffer.
This turns out to be harmless, as we simply overflow into
the chksum field, which is then overwritten.

This case is also best as an xsnprintf. It should never come
up, short of extremely malformed dates, and in that case we
are probably better off dying than silently truncating the
date value (and we cannot expand the size of the buffer,
since it is dictated by the ustar format). Our friends in
the year 5138 (when we legitimately flip to a 12-digit
epoch) can deal with that problem then.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index d543f93..501ca97 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -167,21 +167,21 @@ static void prepare_header(struct archiver_args *args,
 			   struct ustar_header *header,
 			   unsigned int mode, unsigned long size)
 {
-	sprintf(header->mode, "%07o", mode & 07777);
-	sprintf(header->size, "%011lo", S_ISREG(mode) ? size : 0);
-	sprintf(header->mtime, "%011lo", (unsigned long) args->time);
+	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
+	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
+	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
 
-	sprintf(header->uid, "%07o", 0);
-	sprintf(header->gid, "%07o", 0);
+	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
+	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
 	strlcpy(header->uname, "root", sizeof(header->uname));
 	strlcpy(header->gname, "root", sizeof(header->gname));
-	sprintf(header->devmajor, "%07o", 0);
-	sprintf(header->devminor, "%07o", 0);
+	xsnprintf(header->devmajor, sizeof(header->devmajor), "%07o", 0);
+	xsnprintf(header->devminor, sizeof(header->devminor), "%07o", 0);
 
 	memcpy(header->magic, "ustar", 6);
 	memcpy(header->version, "00", 2);
 
-	sprintf(header->chksum, "%07o", ustar_header_chksum(header));
+	snprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));
 }
 
 static int write_extended_header(struct archiver_args *args,
@@ -193,7 +193,7 @@ static int write_extended_header(struct archiver_args *args,
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_EXT_HEADER;
 	mode = 0100666;
-	sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
+	xsnprintf(header.name, sizeof(header.name), "%s.paxheader", sha1_to_hex(sha1));
 	prepare_header(args, &header, mode, size);
 	write_blocked(&header, sizeof(header));
 	write_blocked(buffer, size);
@@ -235,8 +235,8 @@ static int write_tar_entry(struct archiver_args *args,
 			memcpy(header.prefix, path, plen);
 			memcpy(header.name, path + plen + 1, rest);
 		} else {
-			sprintf(header.name, "%s.data",
-				sha1_to_hex(sha1));
+			xsnprintf(header.name, sizeof(header.name), "%s.data",
+				  sha1_to_hex(sha1));
 			strbuf_append_ext_header(&ext_header, "path",
 						 path, pathlen);
 		}
@@ -259,8 +259,8 @@ static int write_tar_entry(struct archiver_args *args,
 
 	if (S_ISLNK(mode)) {
 		if (size > sizeof(header.linkname)) {
-			sprintf(header.linkname, "see %s.paxheader",
-			        sha1_to_hex(sha1));
+			xsnprintf(header.linkname, sizeof(header.linkname),
+				  "see %s.paxheader", sha1_to_hex(sha1));
 			strbuf_append_ext_header(&ext_header, "linkpath",
 			                         buffer, size);
 		} else
-- 
2.6.0.rc2.408.ga2926b9
