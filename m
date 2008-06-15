From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 04/20] WindowedFile fragments copying: copyToStream()
Date: Sun, 15 Jun 2008 23:45:33 +0200
Message-ID: <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804C-0001bl-UU
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbYFOVqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbYFOVqP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:15 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:31828 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbYFOVqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958498ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hw5CgaICKHHHn7/2lDvLOIrnnPkv+XmI071Ql1Px0kc=;
        b=dleVZ8KAz07AcWGeUUI9inVI2hO+Px5QCRLBQPa1RSR/jAKD8oSbUFfJh7kaN+LMlZ
         MeHRU5oI3MrOFBG0Fsd+5iHNwGiEpGCjYulkToVikFsqQMb3XNQFAtjifd/GJBSZIoIv
         y7YFxwWD1J5RKliAr5qH8M6ADlloB6dsTurPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O9aNRj5EhvZhyZ+eVyPcGwvEXAa1O6y/b/Rw8BYsvDAulNiyAu7HZ2H0J1dTaNj9/C
         5q6IZGRiX+nmLPzUEcWof8dT2nA7WxcKtiV6B+PnByeceV0vDZznzgyNmPI2RLtNvpaE
         s51w9zyn4KWEmNiFxDgysYbPgXW90y6wslD1w=
Received: by 10.151.78.11 with SMTP id f11mr9426131ybl.100.1213566369381;
        Sun, 15 Jun 2008 14:46:09 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id p6sm15748428qbp.17.2008.06.15.14.46.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:08 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85129>

Method supports direct rewriting of file segment to the specified output
stream.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   43 ++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 323b396..fff8990 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -40,6 +40,7 @@ package org.spearce.jgit.lib;
 import java.io.EOFException;
 import java.io.File;
 import java.io.IOException;
+import java.io.OutputStream;
 import java.io.RandomAccessFile;
 import java.nio.MappedByteBuffer;
 import java.nio.channels.FileChannel.MapMode;
@@ -195,6 +196,48 @@ public class WindowedFile {
 			throw new EOFException();
 	}
 
+	/**
+	 * Copy the requested number of bytes to the provided output stream.
+	 * <p>
+	 * This routine always reads until either the requested number of bytes has
+	 * been copied or EOF has been reached.
+	 * </p>
+	 * 
+	 * @param position
+	 *            the starting offset, as measured in bytes from the beginning
+	 *            of this file, to copy from.
+	 * @param buf
+	 *            temporary buffer to copy bytes into. In case of a big amount
+	 *            of data to copy, size of at least few kB is recommended. It
+	 *            does not need to be of size <code>cnt</code>, however.
+	 * @param cnt
+	 *            number of bytes to copy. Must not exceed
+	 *            <code>file.length - position</code>.
+	 * @param out
+	 *            output stream where read data is written out. No buffering is
+	 *            guaranteed by this method.
+	 * @param curs
+	 *            current cursor for reading data from the file.
+	 * @throws IOException
+	 *             a necessary window was not found in the window cache and
+	 *             trying to load it in from the operating system failed.
+	 * @throws EOFException
+	 *             the file ended before <code>cnt</code> bytes could be read.
+	 */
+	public void copyToStream(long position, final byte[] buf, long cnt,
+			final OutputStream out, final WindowCursor curs)
+			throws IOException, EOFException {
+		while (cnt > 0) {
+			int toRead = (int) Math.min(cnt, buf.length);
+			int read = read(position, buf, 0, toRead, curs);
+			if (read != toRead)
+				throw new EOFException();
+			position += read;
+			cnt -= read;
+			out.write(buf, 0, read);
+		}
+	}
+
 	void readCompressed(final long position, final byte[] dstbuf,
 			final WindowCursor curs) throws IOException, DataFormatException {
 		final Inflater inf = InflaterCache.get();
-- 
1.5.5.1
