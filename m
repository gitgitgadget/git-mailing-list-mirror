From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 4/9] pack-objects: Teach new option --max-object-count,
 similar to --max-pack-size
Date: Sun, 15 May 2011 23:37:15 +0200
Message-ID: <1305495440-30836-5-git-send-email-johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 23:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLj0y-0000ID-Pg
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab1EOViD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 17:38:03 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55744 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233Ab1EOVh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 17:37:58 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL9009PCAQV0Y80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:44 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id BBE661EA5FBC_DD047A8B	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:44 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5EE671EA314B_DD047A8F	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:44 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL900KSQAQK8000@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:44 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1305495440-30836-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173671>

The new --max-object-count option behaves similarly to --max-pack-size,
except that the decision to split packs is determined by the number of
objects in the pack, and not by the size of the pack.

The new option also has a corresponding configuration variable, named
pack.objectCountLimit, which works similarly to pack.packSizeLimit,
subject to the difference mentioned above.

As with --max-pack-size, you can use --max-object-count together with
--stdout to put a limit on the number of objects in the pack written to
stdout. If the pack would exceed this limit, pack-objects will abort with
an error message.

Finally, for completeness, the new option is also added to git-repack,
which simply forwards it to pack-objects

Documentation and tests are included.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt           |    8 ++++++
 Documentation/git-pack-objects.txt |    9 +++++++
 Documentation/git-repack.txt       |    6 +++++
 builtin/pack-objects.c             |   20 ++++++++++++++++
 git-repack.sh                      |   27 +++++++++++----------
 t/t5300-pack-object.sh             |   44 ++++++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 285c7f7..056e01f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1523,6 +1523,14 @@ pack.packSizeLimit::
 	Common unit suffixes of 'k', 'm', or 'g' are
 	supported.
 
+pack.objectCountLimit::
+	The maximum number of objects in a pack.  This setting only
+	affects packing to a file when repacking, i.e. the git://
+	protocol is unaffected.  It can be overridden by the
+	`\--max-object-count` option of linkgit:git-repack[1].
+	The default is unlimited. Common unit suffixes of 'k', 'm',
+	or 'g' are supported.
+
 pager.<cmd>::
 	If the value is boolean, turns on or off pagination of the
 	output of a particular git subcommand when writing to a tty.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index ca97463..5ab1fe9 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -116,6 +116,15 @@ base-name::
 When used together with --stdout, the command will fail with an error
 message if the pack output exceeds the given limit.
 
+--max-object-count=<n>::
+	Maximum number of objects in each output pack file. The number
+	can be suffixed with "k", "m", or "g". If specified, multiple
+	packfiles may be created. The default is unlimited, unless
+	the config variable `pack.objectCountLimit` is set.
++
+When used together with --stdout, the command will fail with an error
+message if the pack output exceeds the given limit.
+
 --honor-pack-keep::
 	This flag causes an object already in a local pack that
 	has a .keep file to be ignored, even if it would have
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0decee2..f9a44b8 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -109,6 +109,12 @@ other objects in that pack they already have locally.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
+--max-object-count=<n>::
+	Maximum number of objects in each output pack file. The number
+	can be suffixed with "k", "m", or "g". If specified, multiple
+	packfiles may be created. The default is unlimited, unless
+	the config variable `pack.objectCountLimit` is set.
+
 
 Configuration
 -------------
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 69f1c51..c4fbc54 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -74,6 +74,7 @@ static const char *base_name;
 static int progress = 1;
 static int window = 10;
 static unsigned long pack_size_limit, pack_size_limit_cfg;
+static unsigned long object_count_limit, object_count_limit_cfg;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
@@ -227,6 +228,10 @@ static unsigned long write_object(struct sha1file *f,
 	else
 		limit = pack_size_limit - write_offset;
 
+	/* Trigger new pack when we reach object count limit */
+	if (object_count_limit && nr_written >= object_count_limit)
+		return 0;
+
 	if (!entry->delta)
 		usable_delta = 0;	/* no delta */
 	else if (!pack_size_limit || pack_to_stdout)
@@ -1897,6 +1902,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		pack_size_limit_cfg = git_config_ulong(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.objectcountlimit")) {
+		object_count_limit_cfg = git_config_ulong(k, v);
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -2182,6 +2191,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				usage(pack_usage);
 			continue;
 		}
+		if (!prefixcmp(arg, "--max-object-count=")) {
+			object_count_limit_cfg = 0;
+			if (!git_parse_ulong(arg+19, &object_count_limit))
+				usage(pack_usage);
+			continue;
+		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
@@ -2322,6 +2337,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		warning("minimum pack size limit is 1 MiB");
 		pack_size_limit = 1024*1024;
 	}
+	if (!pack_to_stdout && !object_count_limit)
+		object_count_limit = object_count_limit_cfg;
 
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
@@ -2349,6 +2366,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (non_empty && !nr_result)
 		return 0;
+	if (pack_to_stdout && object_count_limit && object_count_limit < nr_result)
+		die("unable to make pack within the object count limit"
+			" (%lu objects)", object_count_limit);
 	if (nr_result)
 		prepare_pack(window, depth);
 	write_pack_file();
diff --git a/git-repack.sh b/git-repack.sh
index 624feec..e8693a6 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -7,19 +7,20 @@ OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git repack [options]
 --
-a               pack everything in a single pack
-A               same as -a, and turn unreachable objects loose
-d               remove redundant packs, and run git-prune-packed
-f               pass --no-reuse-delta to git-pack-objects
-F               pass --no-reuse-object to git-pack-objects
-n               do not run git-update-server-info
-q,quiet         be quiet
-l               pass --local to git-pack-objects
+a                  pack everything in a single pack
+A                  same as -a, and turn unreachable objects loose
+d                  remove redundant packs, and run git-prune-packed
+f                  pass --no-reuse-delta to git-pack-objects
+F                  pass --no-reuse-object to git-pack-objects
+n                  do not run git-update-server-info
+q,quiet            be quiet
+l                  pass --local to git-pack-objects
  Packing constraints
-window=         size of the window used for delta compression
-window-memory=  same as the above, but limit memory size instead of entries count
-depth=          limits the maximum delta depth
-max-pack-size=  maximum size of each packfile
+window=            size of the window used for delta compression
+window-memory=     same as the above, but limit memory size instead of entries count
+depth=             limits the maximum delta depth
+max-pack-size=     maximum size of each packfile
+max-object-count=  maximum number of objects in each packfile
 "
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
@@ -38,7 +39,7 @@ do
 	-f)	no_reuse=--no-reuse-delta ;;
 	-F)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
-	--max-pack-size|--window|--window-memory|--depth)
+	--max-pack-size|--max-object-count|--window|--window-memory|--depth)
 		extra="$extra $1=$2"; shift ;;
 	--) shift; break;;
 	*)	usage ;;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 00f1bd8..d133c28 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -439,6 +439,50 @@ test_expect_success '--stdout fails when pack exceeds --max-pack-size' '
 	grep -q "pack size limit" errs
 '
 
+test_expect_success 'honor pack.objectCountLimit' '
+	git config pack.objectCountLimit 5 &&
+	packname_17=$(git pack-objects test-17 <obj-list) &&
+	test 2 = $(ls test-17-*.pack | wc -l)
+'
+
+test_expect_success 'verify resulting packs' '
+	git verify-pack test-17-*.pack
+'
+
+test_expect_success '--stdout ignores pack.objectCountLimit' '
+	git pack-objects --stdout <obj-list >test-18.pack &&
+	git index-pack --strict test-18.pack
+'
+
+test_expect_success 'verify resulting pack' '
+	git verify-pack test-18.pack
+'
+
+test_expect_success 'honor --max-object-count' '
+	git config --unset pack.objectCountLimit &&
+	packname_19=$(git pack-objects --max-object-count=5 test-19 <obj-list) &&
+	test 2 = $(ls test-19-*.pack | wc -l)
+'
+
+test_expect_success 'verify resulting packs' '
+	git verify-pack test-19-*.pack
+'
+
+test_expect_success '--stdout works with large enough --max-object-count' '
+	git pack-objects --stdout --max-object-count=8 <obj-list >test-20.pack &&
+	git index-pack --strict test-20.pack
+'
+
+test_expect_success 'verify resulting pack' '
+	git verify-pack test-20.pack
+'
+
+test_expect_success '--stdout fails when pack exceeds --max-object-count' '
+	test_must_fail git pack-objects --stdout --max-object-count=1 <obj-list >test-21.pack 2>errs &&
+	test_must_fail git index-pack --strict test-21.pack &&
+	grep -q "object count limit" errs
+'
+
 #
 # WARNING!
 #
-- 
1.7.5.rc1.3.g4d7b
