From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Teach fast-import to honor pack.compression and pack.depth
Date: Sun, 20 Jan 2008 23:36:54 -0500
Message-ID: <20080121043654.GA27521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 05:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGoPX-0000XZ-Cc
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 05:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbYAUEg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 23:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756899AbYAUEg6
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 23:36:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56724 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891AbYAUEg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 23:36:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JGoOp-0006pu-Ce; Sun, 20 Jan 2008 23:36:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3CAC020FBAE; Sun, 20 Jan 2008 23:36:54 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71215>

We now use the configured pack.compression and pack.depth values
within fast-import, as like builtin-pack-objects fast-import is
generating a packfile for consumption by the Git tools.

We use the same behavior as builtin-pack-objects does for these
options, allowing core.compression to supply the default value
for pack.compression.

The default setting for pack.depth within fast-import is still 10
as users will generally repack fast-import generated packfiles by
`repack -f`.  A large delta depth within the fast-import packfile
can significantly slow down such a later repack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This may be post 1.5.4 material, but its pretty trivial.

 fast-import.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 45b4edf..f6872fe 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -275,6 +275,8 @@ struct recent_command
 static unsigned long max_depth = 10;
 static off_t max_packsize = (1LL << 32) - 1;
 static int force_update;
+static int pack_compression_level = Z_DEFAULT_COMPRESSION;
+static int pack_compression_seen;
 
 /* Stats and misc. counters */
 static uintmax_t alloc_count;
@@ -1038,7 +1040,7 @@ static int store_object(
 		delta = NULL;
 
 	memset(&s, 0, sizeof(s));
-	deflateInit(&s, zlib_compression_level);
+	deflateInit(&s, pack_compression_level);
 	if (delta) {
 		s.next_in = delta;
 		s.avail_in = deltalen;
@@ -1066,7 +1068,7 @@ static int store_object(
 			delta = NULL;
 
 			memset(&s, 0, sizeof(s));
-			deflateInit(&s, zlib_compression_level);
+			deflateInit(&s, pack_compression_level);
 			s.next_in = (void *)dat->buf;
 			s.avail_in = dat->len;
 			s.avail_out = deflateBound(&s, s.avail_in);
@@ -2282,6 +2284,27 @@ static void import_marks(const char *input_file)
 	fclose(f);
 }
 
+static int git_pack_config(const char *k, const char *v)
+{
+	if (!strcmp(k, "pack.depth")) {
+		max_depth = git_config_int(k, v);
+		if (max_depth > MAX_DEPTH)
+			max_depth = MAX_DEPTH;
+		return 0;
+	}
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
+	return git_default_config(k, v);
+}
+
 static const char fast_import_usage[] =
 "git-fast-import [--date-format=f] [--max-pack-size=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
 
@@ -2289,7 +2312,10 @@ int main(int argc, const char **argv)
 {
 	unsigned int i, show_stats = 1;
 
-	git_config(git_default_config);
+	git_config(git_pack_config);
+	if (!pack_compression_seen && core_compression_seen)
+		pack_compression_level = core_compression_level;
+
 	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf, 0);
 	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
-- 
1.5.4.rc4.1109.g30426
