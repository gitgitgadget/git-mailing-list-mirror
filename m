From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] git count-objects: handle packs bigger than 4G
Date: Tue, 29 Dec 2009 20:09:15 +0100
Message-ID: <m2637pbns4.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 20:09:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPhRm-0002Nu-Vc
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 20:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbZL2TJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 14:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZL2TJW
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 14:09:22 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:42147 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZL2TJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 14:09:20 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 9D8E41C1582E
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 20:09:18 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 39B079019D
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 20:09:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id un1NR30VyUQp for <git@vger.kernel.org>;
	Tue, 29 Dec 2009 20:09:17 +0100 (CET)
Received: from igel.home (DSL01.83.171.175.195.ip-pool.NEFkom.net [83.171.175.195])
	by mail.mnet-online.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 20:09:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id A2A2ECA28C; Tue, 29 Dec 2009 20:09:16 +0100 (CET)
X-Yow: FUN is never having to say you're SUSHI!!
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135818>

Use off_t to count sizes of packs and objects to avoid overflow after
4Gb.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 builtin-count-objects.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 1b0b6c8..2bdd8eb 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -11,7 +11,7 @@
 
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
-			  unsigned long *loose_size,
+			  off_t *loose_size,
 			  unsigned long *packed_loose,
 			  unsigned long *garbage)
 {
@@ -77,7 +77,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	int len = strlen(objdir);
 	char *path = xmalloc(len + 50);
 	unsigned long loose = 0, packed = 0, packed_loose = 0, garbage = 0;
-	unsigned long loose_size = 0;
+	off_t loose_size = 0;
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose),
 		OPT_END(),
@@ -103,7 +103,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	if (verbose) {
 		struct packed_git *p;
 		unsigned long num_pack = 0;
-		unsigned long size_pack = 0;
+		off_t size_pack = 0;
 		if (!packed_git)
 			prepare_packed_git();
 		for (p = packed_git; p; p = p->next) {
@@ -116,15 +116,15 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			num_pack++;
 		}
 		printf("count: %lu\n", loose);
-		printf("size: %lu\n", loose_size / 1024);
+		printf("size: %lu\n", (unsigned long) (loose_size / 1024));
 		printf("in-pack: %lu\n", packed);
 		printf("packs: %lu\n", num_pack);
-		printf("size-pack: %lu\n", size_pack / 1024);
+		printf("size-pack: %lu\n", (unsigned long) (size_pack / 1024));
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 	}
 	else
 		printf("%lu objects, %lu kilobytes\n",
-		       loose, loose_size / 1024);
+		       loose, (unsigned long) (loose_size / 1024));
 	return 0;
 }
-- 
1.6.6

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
