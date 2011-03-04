From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git cat-file does not terminate
Date: Fri, 4 Mar 2011 11:00:47 -0500
Message-ID: <20110304160047.GA9662@sigill.intra.peff.net>
References: <4D70E340.3050309@tweerlei.de>
 <20110304154014.GE24660@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert Wruck <wruck@tweerlei.de>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 04 17:00:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvXR1-0000GE-GW
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 17:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab1CDQAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 11:00:50 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39115 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab1CDQAt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 11:00:49 -0500
Received: (qmail 4903 invoked by uid 111); 4 Mar 2011 16:00:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 04 Mar 2011 16:00:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2011 11:00:47 -0500
Content-Disposition: inline
In-Reply-To: <20110304154014.GE24660@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168444>

On Fri, Mar 04, 2011 at 04:40:14PM +0100, Peter Baumann wrote:

> > I "fixed" it by limiting each write to 64k (thus looping in
> > write_in_full) but maybe somebody knows about that cygwin behaviour?
> > 
> > This seems to be the cause of the dreaded "No newline found after
> > blob" when running `git svn clone` under cygwin on a repository with
> > large files.
> > 
> > You could argue that this is a cygwin bug but maybe limiting each
> > write to a maximum size is a simple workaround.
> > 
> Maybe you could post a patch, so everyone can see the technical implications
> and discuss the fix?

It would probably look like the patch below, though it really feels like
the right solution is to fix the cygwin bug.

-Peff

---
diff --git a/Makefile b/Makefile
index 4c31d1a..e7d3285 100644
--- a/Makefile
+++ b/Makefile
@@ -167,6 +167,9 @@ all::
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
+# Define MAX_WRITE_SIZE to N if your platform has unpredictable results for
+# write() calls larger than N (e.g., cygwin).
+#
 # Define ASCIIDOC7 if you want to format documentation with AsciiDoc 7
 #
 # Define DOCBOOK_XSL_172 if you want to format man pages with DocBook XSL v1.72
@@ -928,6 +931,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	MAX_WRITE_SIZE=65536
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
@@ -1495,6 +1499,10 @@ ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
 
+ifdef MAX_WRITE_SIZE
+	BASIC_CFLAGS += -DMAX_WRITE_SIZE=$(MAX_WRITE_SIZE)
+endif
+
 ifdef BLK_SHA1
 	SHA1_HEADER = "block-sha1/sha1.h"
 	LIB_OBJS += block-sha1/sha1.o
diff --git a/wrapper.c b/wrapper.c
index 056e9d6..a7a2437 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -133,6 +133,10 @@ ssize_t xread(int fd, void *buf, size_t len)
 ssize_t xwrite(int fd, const void *buf, size_t len)
 {
 	ssize_t nr;
+#ifdef MAX_WRITE_SIZE
+	if (len > MAX_WRITE_SIZE)
+		len = MAX_WRITE_SIZE;
+#endif
 	while (1) {
 		nr = write(fd, buf, len);
 		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
