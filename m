From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] fast-import: implement unpack limit
Date: Sun, 24 Apr 2016 04:32:23 +0000
Message-ID: <20160424043223.GA27609@dcvr.yhbt.net>
References: <20160423024225.GA4293@dcvr.yhbt.net>
 <20160423031313.GA15043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 24 06:32:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auBii-0006BO-Jm
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 06:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbcDXEc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 00:32:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40742 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbcDXEc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 00:32:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338C020A0F;
	Sun, 24 Apr 2016 04:32:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160423031313.GA15043@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292311>

Jeff King <peff@peff.net> wrote:
> There we have fetch.unpackLimit and receive.unpackLimit for the two
> operations, plus transfer.unpackLimit to control both of them. This
> doesn't necessarily need to be tied to that config, but you could
> certainly consider it in the same boat. It's a way of transferring a
> load of objects into the repository.

Ah, thanks, I've always overlooked those :x  But it makes sense
to me this way.

> So it would make some sense to me to have fastimport.unpackLimit,
> falling back to transfer.unpackLimit.

Done below, purely as a config option with no CLI switch.
I'm hoping the change in default behavior is acceptable
to match behavior of the other "transfer" mechanisms.
I needed to adjust the t9300 test, though.

-----------------------------8<-----------------------------
Subject: [PATCH] fast-import: implement unpack limit

With many incremental imports, small packs become highly
inefficient due to the need to readdir scan and load many
indices to locate even a single object.  Frequent repacking and
consolidation may be prohibitively expensive in terms of disk
I/O, especially in large repositories where the initial packs
were aggressively optimized and marked with .keep files.

In those cases, users may be better served with loose objects
and relying on "git gc --auto".

This changes the default behavior of fast-import for small
imports found in test cases, so adjustments to t9300 were
necessary.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/config.txt            |  9 +++++++
 Documentation/git-fast-import.txt   |  2 ++
 fast-import.c                       | 31 ++++++++++++++++++++++++
 t/t9300-fast-import.sh              |  2 ++
 t/t9302-fast-import-unpack-limit.sh | 48 +++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+)
 create mode 100755 t/t9302-fast-import-unpack-limit.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..3d8bc97 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1154,6 +1154,15 @@ difftool.<tool>.cmd::
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
 
+fastimport.unpackLimit::
+	If the number of objects imported by linkgit:git-fast-import[1]
+	is below this limit, then the objects will be unpacked into
+	loose object files.  However if the number of imported objects
+	equals or exceeds this limit then the pack will be stored as a
+	pack.  Storing the pack from a fast-import can make the import
+	operation complete faster, especially on slow filesystems.  If
+	not set, the value of `transfer.unpackLimit` is used instead.
+
 fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 66910aa..644df99 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -136,6 +136,8 @@ Performance and Compression Tuning
 	Maximum size of each output packfile.
 	The default is unlimited.
 
+fastimport.unpackLimit::
+	See linkgit:git-config[1]
 
 Performance
 -----------
diff --git a/fast-import.c b/fast-import.c
index 9fc7093..381d3a0 100644
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
+static int unpack_limit = 100;
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
+		if (object_count <= unpack_limit) {
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
@@ -3317,6 +3342,7 @@ static void parse_option(const char *option)
 static void git_pack_config(void)
 {
 	int indexversion_value;
+	int limit;
 	unsigned long packsizelimit_value;
 
 	if (!git_config_get_ulong("pack.depth", &max_depth)) {
@@ -3341,6 +3367,11 @@ static void git_pack_config(void)
 	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
 		max_packsize = packsizelimit_value;
 
+	if (!git_config_get_int("fastimport.unpacklimit", &limit))
+		unpack_limit = limit;
+	else if (!git_config_get_int("transfer.unpacklimit", &limit))
+		unpack_limit = limit;
+
 	git_config(git_default_config, NULL);
 }
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 25bb60b..e6a2b8a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -52,6 +52,7 @@ echo "$@"'
 ###
 
 test_expect_success 'empty stream succeeds' '
+	git config fastimport.unpackLimit 0 &&
 	git fast-import </dev/null
 '
 
@@ -2675,6 +2676,7 @@ test_expect_success 'R: blob bigger than threshold' '
 	echo >>input &&
 
 	test_create_repo R &&
+	git --git-dir=R/.git config fastimport.unpackLimit 0 &&
 	git --git-dir=R/.git fast-import --big-file-threshold=1 <input
 '
 
diff --git a/t/t9302-fast-import-unpack-limit.sh b/t/t9302-fast-import-unpack-limit.sh
new file mode 100755
index 0000000..0f686d2
--- /dev/null
+++ b/t/t9302-fast-import-unpack-limit.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+test_description='test git fast-import unpack limit'
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
+	git -c fastimport.unpackLimit=2 fast-import --done <input &&
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
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	branch
+	COMMIT
+
+	done
+	INPUT_END
+
+	git -c fastimport.unpackLimit=2 fast-import --done <input &&
+	git fsck --no-progress &&
+	test $(find .git/objects/?? -type f | wc -l) -eq 2 &&
+	test $(find .git/objects/pack -type f | wc -l) -eq 2
+'
+
+test_done
-- 
EW
