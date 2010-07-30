From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] ls-files: learn a debugging dump format
Date: Sat, 31 Jul 2010 00:35:59 +0200
Message-ID: <0792cec2ca5e15ef34375eadc4007203db93d9e6.1280529198.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 31 00:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeyBj-0002H7-0M
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 00:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab0G3WgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 18:36:04 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:48234 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab0G3WgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 18:36:03 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 31 Jul
 2010 00:36:00 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 31 Jul
 2010 00:36:00 +0200
X-Mailer: git-send-email 1.7.2.1.342.g676a4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152268>

Teach git-ls-files a new option --debug that just tacks all available
data from the cache onto each file's line.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I made this while trying to find a pattern in the failures of t0025.
Unless I missed something, there's really no other way to get at this
data, so it might be a useful feature in general.


 Documentation/git-ls-files.txt |    6 ++++++
 builtin/ls-files.c             |    9 +++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..235cae7 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -132,6 +132,12 @@ OPTIONS
 	lines, show only a partial prefix.
 	Non default number of digits can be specified with --abbrev=<n>.
 
+--debug::
+	After each line that describes a file, add more data about its
+	cache entry.  This is intended to show as much information as
+	possible for manual inspection; the exact format may change at
+	any time.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1b9b8a8..cc202c5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -25,6 +25,7 @@
 static int show_killed;
 static int show_valid_bit;
 static int line_terminator = '\n';
+static int debug_mode;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -162,6 +163,13 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		       ce_stage(ce));
 	}
 	write_name(ce->name, ce_namelen(ce));
+	if (debug_mode) {
+		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
+		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
+		printf("  dev: %d\tino: %d\n", ce->ce_dev, ce->ce_ino);
+		printf("  uid: %d\tgid: %d\n", ce->ce_uid, ce->ce_gid);
+		printf("  size: %d\tflags: %x\n", ce->ce_size, ce->ce_flags);
+	}
 }
 
 static int show_one_ru(struct string_list_item *item, void *cbdata)
@@ -519,6 +527,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
 			"pretend that paths removed since <tree-ish> are still present"),
 		OPT__ABBREV(&abbrev),
+		OPT_BOOLEAN(0, "debug", &debug_mode, "show debugging data"),
 		OPT_END()
 	};
 
-- 
1.7.2.1.342.g676a4
