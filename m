From: roberto.tyley@gmail.com
Subject: [PATCH] Tolerate zlib deflation with window size < 32Kb
Date: Wed,  3 Aug 2011 23:32:10 +0100
Message-ID: <1312410730-12261-1-git-send-email-roberto.tyley@gmail.com>
Cc: gitster@pobox.com, Roberto Tyley <roberto.tyley@guardian.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 00:32:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojzW-0006Cf-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 00:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735Ab1HCWcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 18:32:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34341 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab1HCWch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 18:32:37 -0400
Received: by wyf22 with SMTP id 22so154342wyf.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Ae/Je1gDH1f+1TmP89XpxfJWaFjttzL7xu0UQ9satJw=;
        b=NDmW9pTcU9DdRcK2ve1/h9RuWNtfw67y2HZaIVNedzUZ4XyIkjXXDi8pD/r7p4nYsJ
         XDDM8OzP+nZsZEqtO1AYlB0eNhLUIqqf6C4w8buxa6+sNnPLmuCzaHJw6Q88ViQT1isq
         cS21yTCMf9RwoVt1HEtLAqsKeaCzwG7Cb5S4o=
Received: by 10.217.3.17 with SMTP id q17mr1062739wes.107.1312410756358;
        Wed, 03 Aug 2011 15:32:36 -0700 (PDT)
Received: from localhost.localdomain ([81.31.102.176])
        by mx.google.com with ESMTPS id ff6sm1014989wbb.49.2011.08.03.15.32.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 15:32:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178641>

From: Roberto Tyley <roberto.tyley@guardian.co.uk>

Git currently reports loose objects as 'corrupt' if they've been
deflated using a window size less than 32Kb, because the
experimental_loose_object() function doesn't recognise the header
byte as a zlib header. This patch makes the function tolerant of
all valid window sizes (15-bit to 8-bit) - but doesn't sacrifice
it's accuracy in distingushing the standard loose-object format
from the experimental (now abandoned) format.

On memory constrained systems zlib may use a much smaller window
size - working on Agit, I found that Android uses a 4KB window;
giving a header byte of 0x48, not 0x78. Consequently all loose
objects generated appear 'corrupt', which is why Agit is a read-only
Git client at this time - I don't want my client to generate Git
repos that other clients treat as broken :(

This patch makes Git tolerant of different deflate settings - it
might appear that it changes experimental_loose_object() to the point
where it could incorrectly identify the experimental format as the
standard one, but the two criteria (bitmask & checksum) can only
give a false result for an experimental object where both of the
following are true:

1) object size is exactly 8 bytes when uncompressed (bitmask)
2) [single-byte in-pack git type&size header] * 256
   + [1st byte of the following zlib header] % 31 = 0 (checksum)

As it happens, for all possible combinations of valid object type
(1-4) and window bits (0-7), the only time when the checksum will be
divisible by 31 is for 0x1838 - ie object type *1*, a Commit - which,
due the fields all Commit objects must contain, could never be as
small as 8 bytes in size.

Given this, the combination of the two criteria (bitmask & checksum)
always correctly determines the buffer format, and is more tolerant
than the previous version.

The alternative to this patch is simply removing support for the
experimental format, which I am also totally cool with.


References:

Android uses a 4KB window for deflation:
http://android.git.kernel.org/?p=platform/libcore.git;a=blob;f=luni/src/main/native/java_util_zip_Deflater.cpp;h=c0b2feff196e63a7b85d97cf9ae5bb2583409c28;hb=refs/heads/gingerbread#l53

Code snippet searching for false positives with the zlib checksum:
https://gist.github.com/1118177


Signed-off-by: Roberto Tyley <roberto.tyley@guardian.co.uk>
---
 sha1_file.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 89d7e5e..2083e8b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1217,14 +1217,34 @@ static int experimental_loose_object(unsigned char *map)
 	unsigned int word;
 
 	/*
-	 * Is it a zlib-compressed buffer? If so, the first byte
-	 * must be 0x78 (15-bit window size, deflated), and the
-	 * first 16-bit word is evenly divisible by 31. If so,
-	 * we are looking at the official format, not the experimental
-	 * one.
+	 * We must determine if the buffer contains the standard
+	 * zlib-deflated stream or the experimental format based
+	 * on the in-pack object format. Compare the header byte
+	 * for each format:
+	 *
+	 * RFC1950 zlib w/ deflate : 0www1000 : 0 <= www <= 7
+	 * Experimental pack-based : Stttssss : ttt = 1,2,3,4
+	 *
+	 * If bit 7 is clear and bits 0-3 equal 8, the buffer MUST be
+	 * in standard loose-object format, UNLESS it is a Git-pack
+	 * format object *exactly* 8 bytes in size when inflated.
+	 *
+	 * However, RFC1950 also specifies that the 1st 16-bit word
+	 * must be divisible by 31 - this checksum tells us our buffer
+	 * is in the standard format, giving a false positive only if
+	 * the 1st word of the Git-pack format object happens to be
+	 * divisible by 31, ie:
+	 *      ((byte0 * 256) + byte1) % 31 = 0
+	 *   =>        0ttt10000www1000 % 31 = 0
+	 *
+	 * As it happens, this case can only arise for www=3 & ttt=1
+	 * - ie, a Commit object, which would have to be 8 bytes in
+	 * size. As no Commit can be that small, we find that the
+	 * combination of these two criteria (bitmask & checksum)
+	 * can always correctly determine the buffer format.
 	 */
 	word = (map[0] << 8) + map[1];
-	if (map[0] == 0x78 && !(word % 31))
+	if ((map[0] & 0x88) == 0x08 && !(word % 31))
 		return 0;
 	else
 		return 1;
-- 
1.7.4.1
