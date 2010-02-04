From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 3/3] make --max-pack-size argument to 'git pack-object' count
 in bytes
Date: Wed, 03 Feb 2010 22:48:28 -0500
Message-ID: <1265255308-20514-3-git-send-email-nico@fluxnic.net>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 04:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncsho-00058V-Jo
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 04:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557Ab0BDDse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 22:48:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38281 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756494Ab0BDDsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 22:48:31 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXA000WCT8S3332@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 22:48:29 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.149.g0b0b7
In-reply-to: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138944>

The value passed to --max-pack-size used to count in MiB which was
inconsistent with the corresponding configuration variable as well as
other command arguments which are defined to count in bytes with an
optional unit suffix.  This brings --max-pack-size in line with the
rest of Git.

Also, in order not to cause havoc with people used to the previous
megabyte scale, and because this is a sane thing to do anyway, a
minimum size of 1 MiB is enforced to avoid an explosion of pack files.

Adjust and extend test suite accordingly.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 Documentation/RelNotes-1.7.0.txt   |    8 +++++++-
 Documentation/config.txt           |   11 +++++++----
 Documentation/git-pack-objects.txt |    5 +++--
 Documentation/git-repack.txt       |    8 +++++---
 builtin-pack-objects.c             |   11 ++++++-----
 t/t5300-pack-object.sh             |   14 ++++++++------
 6 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index 323ae54..e66945c 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -38,7 +38,7 @@ Notes on behaviour change
    whitespaces is reported with zero exit status when run with
    --exit-code, and there is no "diff --git" header for such a change.
 
- * external diff and textconv helpers are now executed using the shell.
+ * External diff and textconv helpers are now executed using the shell.
    This makes them consistent with other programs executed by git, and
    allows you to pass command-line parameters to the helpers. Any helper
    paths containing spaces or other metacharacters now need to be
@@ -46,6 +46,12 @@ Notes on behaviour change
    environment, and diff.*.command and diff.*.textconv in the config
    file.
 
+ * The --max-pack-size argument to 'git repack' and 'git pack-objects' was
+   assuming the provided size to be expressed in MiB, unlike the
+   corresponding config variable and other similar options accepting a size
+   value.  It is now expecting a size expressed in bytes, with a possible
+   unit suffix of 'k', 'm', or 'g'.
+
 Updates since v1.6.6
 --------------------
 
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 36ad992..4c36aa9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1368,10 +1368,13 @@ you can use linkgit:git-index-pack[1] on the *.pack file to regenerate
 the `{asterisk}.idx` file.
 
 pack.packSizeLimit::
-	The default maximum size of a pack.  This setting only affects
-	packing to a file, i.e. the git:// protocol is unaffected.  It
-	can be overridden by the `\--max-pack-size` option of
-	linkgit:git-repack[1].
+	The maximum size of a pack.  This setting only affects
+	packing to a file when repacking, i.e. the git:// protocol
+	is unaffected.  It can be overridden by the `\--max-pack-size`
+	option of linkgit:git-repack[1]. The minimum size allowed is
+	limited to 1 MiB. The default is unlimited.
+	Common unit suffixes of 'k', 'm', or 'g' are
+	supported.
 
 pager.<cmd>::
 	Allows turning on or off pagination of the output of a
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 097a147..ffd5025 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -105,8 +105,9 @@ base-name::
 	`--window-memory=0` makes memory usage unlimited, which is the
 	default.
 
---max-pack-size=<n>::
-	Maximum size of each output packfile, expressed in MiB.
+--max-pack-size=[N]::
+	Maximum size of each output pack file. The size can be suffixed with
+	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
 	If specified,  multiple packfiles may be created.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 538895c..e2f2fa2 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -98,10 +98,12 @@ other objects in that pack they already have locally.
 	`--window-memory=0` makes memory usage unlimited, which is the
 	default.
 
---max-pack-size=<n>::
-	Maximum size of each output packfile, expressed in MiB.
+--max-pack-size=[N]::
+	Maximum size of each output pack file. The size can be suffixed with
+	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
 	If specified,  multiple packfiles may be created.
-	The default is unlimited.
+	The default is unlimited, unless the config variable
+	`pack.packSizeLimit` is set.
 
 
 Configuration
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3186035..dcfe62a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -77,7 +77,7 @@ static int allow_ofs_delta;
 static const char *base_name;
 static int progress = 1;
 static int window = 10;
-static uint32_t pack_size_limit, pack_size_limit_cfg;
+static unsigned long pack_size_limit, pack_size_limit_cfg;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
@@ -2192,10 +2192,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!prefixcmp(arg, "--max-pack-size=")) {
-			char *end;
 			pack_size_limit_cfg = 0;
-			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
-			if (!arg[16] || *end)
+			if (!git_parse_ulong(arg+16, &pack_size_limit))
 				usage(pack_usage);
 			continue;
 		}
@@ -2335,9 +2333,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit = pack_size_limit_cfg;
-
 	if (pack_to_stdout && pack_size_limit)
 		die("--max-pack-size cannot be used to build a pack for transfer.");
+	if (pack_size_limit && pack_size_limit < 1024*1024) {
+		warning("minimum pack size limit is 1 MiB");
+		pack_size_limit = 1024*1024;
+	}
 
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index ac81114..c80f3a3 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -16,7 +16,9 @@ test_expect_success \
      perl -e "print \"a\" x 4096;" > a &&
      perl -e "print \"b\" x 4096;" > b &&
      perl -e "print \"c\" x 4096;" > c &&
-     git update-index --add a b c &&
+     test-genrandom "seed a" 2097152 > a_big &&
+     test-genrandom "seed b" 2097152 > b_big &&
+     git update-index --add a a_big b b_big c &&
      cat c >d && echo foo >>d && git update-index --add d &&
      tree=`git write-tree` &&
      commit=`git commit-tree $tree </dev/null` && {
@@ -375,19 +377,19 @@ test_expect_success 'index-pack with --strict' '
 '
 
 test_expect_success 'honor pack.packSizeLimit' '
-	git config pack.packSizeLimit 200 &&
+	git config pack.packSizeLimit 3m &&
  	packname_10=$(git pack-objects test-10 <obj-list) &&
- 	test 3 = $(ls test-10-*.pack | wc -l)
+ 	test 2 = $(ls test-10-*.pack | wc -l)
 '
 
 test_expect_success 'verify resulting packs' '
 	git verify-pack test-10-*.pack
 '
 
-test_expect_success 'tolerate absurdly small packsizelimit' '
-	git config pack.packSizeLimit 2 &&
+test_expect_success 'tolerate packsizelimit smaller than biggest object' '
+	git config pack.packSizeLimit 1 &&
 	packname_11=$(git pack-objects test-11 <obj-list) &&
-	test $(wc -l <obj-list) = $(ls test-11-*.pack | wc -l)
+	test 3 = $(ls test-11-*.pack | wc -l)
 '
 
 test_expect_success 'verify resulting packs' '
-- 
1.7.0.rc1.149.g0b0b7
