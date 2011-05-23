From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 05/10] pack-objects: Teach new option --max-commit-count,
 limiting #commits in pack
Date: Mon, 23 May 2011 02:51:58 +0200
Message-ID: <1306111923-16859-6-git-send-email-johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:53:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOJOO-0000eg-72
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 02:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab1EWAwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 20:52:41 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53497 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab1EWAw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 20:52:28 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM001R8IFC4YA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:24 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id F04411EA6107_DD9AFC7B	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:23 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5FF091EA351A_DD9AFC6F	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:22 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM005PMIF9TE20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:22 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1306111923-16859-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174214>

The new --max-commit-count option behaves similarly to --max-object-count,
when used together with --stdout: It limits the number of commits in the
pack written to stdout. If the pack would exceed this limit, pack-objects
will abort with an error message.

Unlike --max-pack-size and --max-object-count, --max-commit-count must
always be used together with --stdout. This is because using the commit
count to split packs is not at all a good heuristic, since Git does not
necessarily distribute commit objects uniformly across packs.

Documentation and tests are included.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-pack-objects.txt |    8 ++++++++
 builtin/pack-objects.c             |   24 +++++++++++++++++++++---
 t/t5300-pack-object.sh             |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 20c8551..e43904e 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -113,6 +113,14 @@ base-name::
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
+--max-commit-count=<n>::
+	This option is only useful together with --stdout.
+	Specifies the maximum number of commits allowed in the created
+	pack. If the number of commits would exceed the given limit,
+	pack-objects will fail with an error message.
+	The number can be suffixed with "k", "m", or "g".
+	The default is unlimited.
+
 --honor-pack-keep::
 	This flag causes an object already in a local pack that
 	has a .keep file to be ignored, even if it would have
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f402a84..f0fc187 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -61,7 +61,7 @@ struct object_entry {
  */
 static struct object_entry *objects;
 static struct pack_idx_entry **written_list;
-static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
+static uint32_t nr_objects, nr_alloc, nr_result, nr_commits, nr_written;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -653,8 +653,11 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	if (ix >= 0) {
 		if (exclude) {
 			entry = objects + object_ix[ix] - 1;
-			if (!entry->preferred_base)
+			if (!entry->preferred_base) {
 				nr_result--;
+				if (entry->type == OBJ_COMMIT)
+					nr_commits--;
+			}
 			entry->preferred_base = 1;
 		}
 		return 0;
@@ -694,8 +697,11 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		entry->type = type;
 	if (exclude)
 		entry->preferred_base = 1;
-	else
+	else {
 		nr_result++;
+		if (type == OBJ_COMMIT)
+			nr_commits++;
+	}
 	if (found_pack) {
 		entry->in_pack = found_pack;
 		entry->in_pack_offset = found_offset;
@@ -2125,6 +2131,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	const char **rp_av;
 	int rp_ac_alloc = 64;
 	int rp_ac;
+	unsigned long commit_count_limit = 0;
 
 	read_replace_refs = 0;
 
@@ -2179,6 +2186,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				usage(pack_usage);
 			continue;
 		}
+		if (!prefixcmp(arg, "--max-commit-count=")) {
+			if (!git_parse_ulong(arg+19, &commit_count_limit))
+				usage(pack_usage);
+			continue;
+		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
@@ -2322,6 +2334,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		pack_size_limit = 1024*1024;
 	}
 
+	if (!pack_to_stdout && commit_count_limit)
+		die("--max-commit-count is only useful together with --stdout.");
+
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
 
@@ -2348,6 +2363,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (non_empty && !nr_result)
 		return 0;
+	if (pack_to_stdout && commit_count_limit && commit_count_limit < nr_commits)
+		die("unable to make pack within the commit count limit"
+			" (%lu commits)", commit_count_limit);
 	if (nr_result)
 		prepare_pack(window, depth);
 	write_pack_file();
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 602806d..80df631 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -396,6 +396,40 @@ test_expect_success 'verify resulting packs' '
 	git verify-pack test-11-*.pack
 '
 
+test_expect_success 'make a few more commits' '
+	git reset --hard $commit &&
+	echo "change" > file &&
+	git add file &&
+	git commit -m second &&
+	commit2=`git rev-parse --verify HEAD` &&
+	echo "more change" >> file &&
+	git commit -a -m third &&
+	commit3=`git rev-parse --verify HEAD` &&
+	echo "even more change" >> file &&
+	git commit -a -m fourth &&
+	commit4=`git rev-parse --verify HEAD` && {
+		echo $commit &&
+		echo $commit2 &&
+		echo $commit3 &&
+		echo $commit4
+	} >>commit-list
+'
+
+test_expect_success '--stdout works with large enough --max-commit-count' '
+	git pack-objects --revs --stdout --max-commit-count=4 <commit-list >test-17.pack &&
+	git index-pack --strict test-17.pack
+'
+
+test_expect_success 'verify resulting pack' '
+	git verify-pack test-17.pack
+'
+
+test_expect_success '--stdout fails when pack exceeds --max-commit-count' '
+	test_must_fail git pack-objects --revs --stdout --max-commit-count=3 <commit-list >test-18.pack 2>errs &&
+	test_must_fail git index-pack --strict test-18.pack &&
+	grep -q "commit count limit" errs
+'
+
 #
 # WARNING!
 #
-- 
1.7.5.rc1.3.g4d7b
