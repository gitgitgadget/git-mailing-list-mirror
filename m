From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 07/10] pack-objects: Allow --max-pack-size to be used
 together with --stdout
Date: Mon, 23 May 2011 02:52:00 +0200
Message-ID: <1306111923-16859-8-git-send-email-johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:52:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOJNv-0000SO-1F
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 02:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab1EWAwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 20:52:32 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53497 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578Ab1EWAwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 20:52:30 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM001RIIFC4YA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:24 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 6DE181EA611E_DD9AFC8B	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:24 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9CB6C1EA2905_DD9AFC6F	for <git@vger.kernel.org>; Mon,
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174210>

Currently we refuse combining --max-pack-size with --stdout since there's
no way to make multiple packs when the pack is written to stdout. However,
we want to be able to limit the maximum size of the pack created by
--stdout (and abort pack-objects if we are unable to meet that limit).

Therefore, when used together with --stdout, we reinterpret --max-pack-size
to indicate the maximum pack size which - if exceeded - will cause
pack-objects to abort with an error message.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-pack-objects.txt |    3 ++
 builtin/pack-objects.c             |    9 ++++---
 t/t5300-pack-object.sh             |   43 ++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e43904e..24cf975 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -112,6 +112,9 @@ base-name::
 	If specified,  multiple packfiles may be created.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
++
+When used together with --stdout, the command will fail with an error
+message if the pack output exceeds the given limit.
 
 --max-commit-count=<n>::
 	This option is only useful together with --stdout.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f0fc187..e226053 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -229,7 +229,7 @@ static unsigned long write_object(struct sha1file *f,
 
 	if (!entry->delta)
 		usable_delta = 0;	/* no delta */
-	else if (!pack_size_limit)
+	else if (!pack_size_limit || pack_to_stdout)
 	       usable_delta = 1;	/* unlimited packfile */
 	else if (entry->delta->idx.offset == (off_t)-1)
 		usable_delta = 0;	/* base was written to another pack */
@@ -478,6 +478,9 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
+			if (nr_written != nr_remaining)
+				die("unable to make pack within the pack size"
+				    " limit (%lu bytes)", pack_size_limit);
 			sha1close(f, sha1, CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
 			sha1close(f, sha1, CSUM_FSYNC);
@@ -2327,9 +2330,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit = pack_size_limit_cfg;
-	if (pack_to_stdout && pack_size_limit)
-		die("--max-pack-size cannot be used to build a pack for transfer.");
-	if (pack_size_limit && pack_size_limit < 1024*1024) {
+	if (!pack_to_stdout && pack_size_limit && pack_size_limit < 1024*1024) {
 		warning("minimum pack size limit is 1 MiB");
 		pack_size_limit = 1024*1024;
 	}
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 80df631..46c1214 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -396,6 +396,49 @@ test_expect_success 'verify resulting packs' '
 	git verify-pack test-11-*.pack
 '
 
+test_expect_success '--stdout ignores pack.packSizeLimit' '
+	git pack-objects --stdout <obj-list >test-12.pack &&
+	git index-pack --strict test-12.pack
+'
+
+test_expect_success 'verify resulting pack' '
+	git verify-pack test-12.pack
+'
+
+test_expect_success 'honor --max-pack-size' '
+	git config --unset pack.packSizeLimit &&
+	packname_13=$(git pack-objects --max-pack-size=3m test-13 <obj-list) &&
+	test 2 = $(ls test-13-*.pack | wc -l)
+'
+
+test_expect_success 'verify resulting packs' '
+	git verify-pack test-13-*.pack
+'
+
+test_expect_success 'tolerate --max-pack-size smaller than biggest object' '
+	packname_14=$(git pack-objects --max-pack-size=1 test-14 <obj-list) &&
+	test 5 = $(ls test-14-*.pack | wc -l)
+'
+
+test_expect_success 'verify resulting packs' '
+	git verify-pack test-14-*.pack
+'
+
+test_expect_success '--stdout works with large enough --max-pack-size' '
+	git pack-objects --stdout --max-pack-size=10m <obj-list >test-15.pack &&
+	git index-pack --strict test-15.pack
+'
+
+test_expect_success 'verify resulting pack' '
+	git verify-pack test-15.pack
+'
+
+test_expect_success '--stdout fails when pack exceeds --max-pack-size' '
+	test_must_fail git pack-objects --stdout --max-pack-size=1 <obj-list >test-16.pack 2>errs &&
+	test_must_fail git index-pack --strict test-16.pack &&
+	grep -q "pack size limit" errs
+'
+
 test_expect_success 'make a few more commits' '
 	git reset --hard $commit &&
 	echo "change" > file &&
-- 
1.7.5.rc1.3.g4d7b
