From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] verify-pack --stat-only: show histogram without
 verifying
Date: Fri,  7 Aug 2009 20:36:34 -0700
Message-ID: <1249702594-7815-3-git-send-email-gitster@pobox.com>
References: <1249702594-7815-1-git-send-email-gitster@pobox.com>
 <1249702594-7815-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 05:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZcjt-00062d-4z
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 05:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbZHHDgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 23:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbZHHDgm
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 23:36:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094AbZHHDgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 23:36:40 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18CBD2D06
	for <git@vger.kernel.org>; Fri,  7 Aug 2009 23:36:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 766D92D05 for
 <git@vger.kernel.org>; Fri,  7 Aug 2009 23:36:40 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.151.g786db
In-Reply-To: <1249702594-7815-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AFA1D95E-83CC-11DE-BEEE-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125242>

When this option is given, the command does not verify the pack contents,
but shows the delta chain histogram.  If used with --verbose, the usual
list of objects is also shown.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-verify-pack.txt |    8 +++++-
 builtin-verify-pack.c             |   49 +++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index d791a80..97f7f91 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -25,7 +25,13 @@ OPTIONS
 -v::
 --verbose::
 	After verifying the pack, show list of objects contained
-	in the pack.
+	in the pack and a histogram of delta chain length.
+
+-s::
+--stat-only::
+	Do not verify the pack contents; only show the histogram of delta
+	chain length.  With `--verbose`, list of objects is also shown.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index b5bd28e..b6079ae 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -6,10 +6,14 @@
 
 #define MAX_CHAIN 50
 
-static void show_pack_info(struct packed_git *p)
+#define VERIFY_PACK_VERBOSE 01
+#define VERIFY_PACK_STAT_ONLY 02
+
+static void show_pack_info(struct packed_git *p, unsigned int flags)
 {
 	uint32_t nr_objects, i;
 	int cnt;
+	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
 	unsigned long chain_histogram[MAX_CHAIN+1], baseobjects;
 
 	nr_objects = p->num_objects;
@@ -32,16 +36,19 @@ static void show_pack_info(struct packed_git *p)
 		type = packed_object_info_detail(p, offset, &size, &store_size,
 						 &delta_chain_length,
 						 base_sha1);
-		printf("%s ", sha1_to_hex(sha1));
+		if (!stat_only)
+			printf("%s ", sha1_to_hex(sha1));
 		if (!delta_chain_length) {
-			printf("%-6s %lu %lu %"PRIuMAX"\n",
-			       type, size, store_size, (uintmax_t)offset);
+			if (!stat_only)
+				printf("%-6s %lu %lu %"PRIuMAX"\n",
+				       type, size, store_size, (uintmax_t)offset);
 			baseobjects++;
 		}
 		else {
-			printf("%-6s %lu %lu %"PRIuMAX" %u %s\n",
-			       type, size, store_size, (uintmax_t)offset,
-			       delta_chain_length, sha1_to_hex(base_sha1));
+			if (!stat_only)
+				printf("%-6s %lu %lu %"PRIuMAX" %u %s\n",
+				       type, size, store_size, (uintmax_t)offset,
+				       delta_chain_length, sha1_to_hex(base_sha1));
 			if (delta_chain_length <= MAX_CHAIN)
 				chain_histogram[delta_chain_length]++;
 			else
@@ -66,10 +73,12 @@ static void show_pack_info(struct packed_git *p)
 		       chain_histogram[0] > 1 ? "s" : "");
 }
 
-static int verify_one_pack(const char *path, int verbose)
+static int verify_one_pack(const char *path, unsigned int flags)
 {
 	char arg[PATH_MAX];
 	int len;
+	int verbose = flags & VERIFY_PACK_VERBOSE;
+	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
 	struct packed_git *pack;
 	int err;
 
@@ -105,14 +114,19 @@ static int verify_one_pack(const char *path, int verbose)
 		return error("packfile %s not found.", arg);
 
 	install_packed_git(pack);
-	err = verify_pack(pack);
 
-	if (verbose) {
+	if (!stat_only)
+		err = verify_pack(pack);
+	else
+		err = open_pack_index(pack);
+
+	if (verbose || stat_only) {
 		if (err)
 			printf("%s: bad\n", pack->pack_name);
 		else {
-			show_pack_info(pack);
-			printf("%s: ok\n", pack->pack_name);
+			show_pack_info(pack, flags);
+			if (!stat_only)
+				printf("%s: ok\n", pack->pack_name);
 		}
 	}
 
@@ -120,17 +134,20 @@ static int verify_one_pack(const char *path, int verbose)
 }
 
 static const char * const verify_pack_usage[] = {
-	"git verify-pack [-v|--verbose] <pack>...",
+	"git verify-pack [-v|--verbose] [-s|--stat-only] <pack>...",
 	NULL
 };
 
 int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 {
 	int err = 0;
-	int verbose = 0;
+	unsigned int flags = 0;
 	int i;
 	const struct option verify_pack_options[] = {
-		OPT__VERBOSE(&verbose),
+		OPT_BIT('v', "verbose", &flags, "verbose",
+			VERIFY_PACK_VERBOSE),
+		OPT_BIT('s', "stat-only", &flags, "show statistics only",
+			VERIFY_PACK_STAT_ONLY),
 		OPT_END()
 	};
 
@@ -140,7 +157,7 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 	if (argc < 1)
 		usage_with_options(verify_pack_usage, verify_pack_options);
 	for (i = 0; i < argc; i++) {
-		if (verify_one_pack(argv[i], verbose))
+		if (verify_one_pack(argv[i], flags))
 			err = 1;
 		discard_revindex();
 	}
-- 
1.6.4.151.g786db
