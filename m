From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] fast-import: implement --min-pack-size parameter
Date: Sat, 23 Apr 2016 02:42:25 +0000
Message-ID: <20160423024225.GA4293@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 04:42:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atnWj-0001Y2-AG
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 04:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbcDWCm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 22:42:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47382 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbcDWCm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 22:42:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801C520A0A;
	Sat, 23 Apr 2016 02:42:25 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292295>

With many incremental imports, small packs become highly
inefficient due to the need to readdir scan and load many
indices to locate even a single object.  Frequent repacking and
consolidation may be prohibitively expensive in terms of disk
I/O, especially in large repositories where the initial packs
were aggressively optimized and marked with .keep files.

In those cases, users may be better served with loose objects
and relying on "git gc --auto".

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  There should be a matching config file directive, but I'm
  not sure how/if it should affect other commands.  So I'm
  not sure if it should be "pack.packSizeMin" or
  "fastimport.packSizeMin" or something else.

  To further reduce disk I/O, the fsync_or_die call in
  fixup_pack_header_footer could probably be moved out of that
  function and become the fphf caller's responsibility.

 Documentation/git-fast-import.txt   |  9 ++++++++
 fast-import.c                       | 30 ++++++++++++++++++++++++++
 t/t9302-fast-import-min-packsize.sh | 42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 t/t9302-fast-import-min-packsize.sh

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 66910aa..8c0ac94 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -136,6 +136,15 @@ Performance and Compression Tuning
 	Maximum size of each output packfile.
 	The default is unlimited.
 
+--min-pack-size=<n>::
+	Mininum size of an output packfile, packfiles smaller
+	than this threshold are unpacked into loose objects and
+	the pack is discarded.  This is useful when performing
+	small, incremental imports as loose objects and relying
+	on `git gc --auto` may be more efficient than generating
+	many tiny packs.
+	The default is to always preserve the pack and never
+	generate loose objects.
 
 Performance
 -----------
diff --git a/fast-import.c b/fast-import.c
index 9fc7093..a00bee5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -166,6 +166,7 @@ Format of STDIN stream:
 #include "quote.h"
 #include "exec_cmd.h"
 #include "dir.h"
+#include "run-command.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -282,6 +283,7 @@ struct recent_command {
 /* Configured limits on output */
 static unsigned long max_depth = 10;
 static off_t max_packsize;
+static off_t min_packsize;
 static int force_update;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
@@ -950,6 +952,22 @@ static void unkeep_all_packs(void)
 	}
 }
 
+static int loosen_small_pack(const struct packed_git *p)
+{
+	struct child_process unpack = CHILD_PROCESS_INIT;
+
+	if (lseek(p->pack_fd, 0, SEEK_SET) < 0)
+		die_errno("Failed seeking to start of '%s'", p->pack_name);
+
+	unpack.in = p->pack_fd;
+	unpack.git_cmd = 1;
+	unpack.stdout_to_stderr = 1;
+	argv_array_push(&unpack.args, "unpack-objects");
+	argv_array_push(&unpack.args, "-q");
+
+	return run_command(&unpack);
+}
+
 static void end_packfile(void)
 {
 	static int running;
@@ -972,6 +990,12 @@ static void end_packfile(void)
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
 				    pack_data->pack_name, object_count,
 				    cur_pack_sha1, pack_size);
+
+		if (pack_size < min_packsize) {
+			if (loosen_small_pack(pack_data) == 0)
+				goto discard_pack;
+		}
+
 		close(pack_data->pack_fd);
 		idx_name = keep_pack(create_index());
 
@@ -1002,6 +1026,7 @@ static void end_packfile(void)
 		pack_id++;
 	}
 	else {
+discard_pack:
 		close(pack_data->pack_fd);
 		unlink_or_warn(pack_data->pack_name);
 	}
@@ -3237,6 +3262,11 @@ static int parse_one_option(const char *option)
 			v = 1024 * 1024;
 		}
 		max_packsize = v;
+	} else if (skip_prefix(option, "min-pack-size=", &option)) {
+		unsigned long v;
+		if (!git_parse_ulong(option, &v))
+			return 0;
+		min_packsize = v;
 	} else if (skip_prefix(option, "big-file-threshold=", &option)) {
 		unsigned long v;
 		if (!git_parse_ulong(option, &v))
diff --git a/t/t9302-fast-import-min-packsize.sh b/t/t9302-fast-import-min-packsize.sh
new file mode 100755
index 0000000..7dcdccc
--- /dev/null
+++ b/t/t9302-fast-import-min-packsize.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+test_description='test git fast-import min-packsize'
+. ./test-lib.sh
+
+test_expect_success 'create loose objects on import' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/master
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	initial
+	COMMIT
+
+	done
+	INPUT_END
+
+	git fast-import --done --min-pack-size=1g <input &&
+	git fsck --no-progress &&
+	test $(find .git/objects/?? -type f | wc -l) -eq 2 &&
+	test $(find .git/objects/pack -type f | wc -l) -eq 0
+'
+
+test_expect_success 'bigger packs are preserved' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/master
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	incremental should create a pack
+	COMMIT
+	from refs/heads/master^0
+
+	done
+	INPUT_END
+
+	git fast-import --done --min-pack-size=10 <input &&
+	git fsck --no-progress &&
+	test $(find .git/objects/?? -type f | wc -l) -eq 2 &&
+	test $(find .git/objects/pack -type f | wc -l) -eq 2
+'
+
+test_done
-- 
EW
