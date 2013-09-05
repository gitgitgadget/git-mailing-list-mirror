From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 20/38] pack v4: honor pack.compression config option
Date: Thu, 05 Sep 2013 02:19:43 -0400
Message-ID: <1378362001-1738-21-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwm-0008OR-Co
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669Ab3IEGV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321Ab3IEGUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:19 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G422XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 6EB4F2DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233919>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index c8d3053..45f8427 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -16,6 +16,7 @@
 #include "varint.h"
 
 
+static int pack_compression_seen;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 
 struct data_entry {
@@ -1047,12 +1048,30 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	sha1close(f, NULL, CSUM_CLOSE | CSUM_FSYNC);
 }
 
+static int git_pack_config(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "pack.compression")) {
+		int level = git_config_int(k, v);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die("bad pack compression level %d", level);
+		pack_compression_level = level;
+		pack_compression_seen = 1;
+		return 0;
+	}
+	return git_default_config(k, v, cb);
+}
+
 int main(int argc, char *argv[])
 {
 	if (argc != 3) {
 		fprintf(stderr, "Usage: %s <src_packfile> <dst_packfile>\n", argv[0]);
 		exit(1);
 	}
+	git_config(git_pack_config, NULL);
+	if (!pack_compression_seen && core_compression_seen)
+		pack_compression_level = core_compression_level;
 	process_one_pack(argv[1], argv[2]);
 	if (0)
 		dict_dump();
-- 
1.8.4.38.g317e65b
