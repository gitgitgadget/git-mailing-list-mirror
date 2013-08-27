From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 18/23] pack v4: honor pack.compression config option
Date: Tue, 27 Aug 2013 00:26:02 -0400
Message-ID: <1377577567-27655-19-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEArn-0007MP-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab3H0E0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3H0E0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:34 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600DCD9O4IO90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id EC21F2DA05FA	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233051>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index ed67eb6..2d46d11 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -15,6 +15,7 @@
 #include "pack-revindex.h"
 
 
+static int pack_compression_seen;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 
 struct data_entry {
@@ -1040,12 +1041,30 @@ static void process_one_pack(char *src_pack, char *dst_pack)
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
1.8.4.22.g54757b7
