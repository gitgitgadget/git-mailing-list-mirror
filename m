From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/4] add storage size output to 'git verify-pack -v'
Date: Thu, 28 Feb 2008 00:25:20 -0500
Message-ID: <1204176320-31358-5-git-send-email-nico@cam.org>
References: <1204176320-31358-1-git-send-email-nico@cam.org>
 <1204176320-31358-2-git-send-email-nico@cam.org>
 <1204176320-31358-3-git-send-email-nico@cam.org>
 <1204176320-31358-4-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 06:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUbHy-0004gi-Os
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 06:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYB1FZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 00:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYB1FZa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 00:25:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61471 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYB1FZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 00:25:28 -0500
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWX00B63OE9QT70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Feb 2008 00:25:22 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.200.g99e75
In-reply-to: <1204176320-31358-4-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75356>

This can possibly break external scripts that depend on the previous
output, but those script can't possibly be critical to Git usage, and
fixing them should be trivial.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/git-verify-pack.txt |    4 ++--
 contrib/stats/packinfo.pl         |    2 +-
 pack-check.c                      |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index db019a2..ba2a157 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -32,11 +32,11 @@ OUTPUT FORMAT
 -------------
 When specifying the -v option the format used is:
 
-	SHA1 type size offset-in-packfile
+	SHA1 type size size-in-pack-file offset-in-packfile
 
 for objects that are not deltified in the pack, and
 
-	SHA1 type size offset-in-packfile depth base-SHA1
+	SHA1 type size size-in-packfile offset-in-packfile depth base-SHA1
 
 for objects that are deltified.
 
diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
index aab501e..f4a7b62 100755
--- a/contrib/stats/packinfo.pl
+++ b/contrib/stats/packinfo.pl
@@ -93,7 +93,7 @@ my %depths;
 my @depths;
 
 while (<STDIN>) {
-    my ($sha1, $type, $size, $offset, $depth, $parent) = split(/\s+/, $_);
+    my ($sha1, $type, $size, $space, $offset, $depth, $parent) = split(/\s+/, $_);
     next unless ($sha1 =~ /^[0-9a-f]{40}$/);
     $depths{$sha1} = $depth || 0;
     push(@depths, $depth || 0);
diff --git a/pack-check.c b/pack-check.c
index ae25685..0f8ad2c 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -128,11 +128,11 @@ static void show_pack_info(struct packed_git *p)
 						 base_sha1);
 		printf("%s ", sha1_to_hex(sha1));
 		if (!delta_chain_length)
-			printf("%-6s %lu %"PRIuMAX"\n",
-			       type, size, (uintmax_t)offset);
+			printf("%-6s %lu %lu %"PRIuMAX"\n",
+			       type, size, store_size, (uintmax_t)offset);
 		else {
-			printf("%-6s %lu %"PRIuMAX" %u %s\n",
-			       type, size, (uintmax_t)offset,
+			printf("%-6s %lu %lu %"PRIuMAX" %u %s\n",
+			       type, size, store_size, (uintmax_t)offset,
 			       delta_chain_length, sha1_to_hex(base_sha1));
 			if (delta_chain_length <= MAX_CHAIN)
 				chain_histogram[delta_chain_length]++;
-- 
1.5.4.2.200.g99e75
