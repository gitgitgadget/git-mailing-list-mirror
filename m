From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Teach checkout the -n|--dry-run option
Date: Sun, 08 May 2011 22:50:08 +0200
Message-ID: <4DC70200.1080201@web.de>
References: <4DC47242.6060205@web.de> <7vhb97xx5g.fsf@alter.siamese.dyndns.org> <7vfwoqwby5.fsf@alter.siamese.dyndns.org> <4DC67CF4.80901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 22:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJAvg-0005vD-M5
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 22:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab1EHUuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 16:50:12 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:33981 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab1EHUuK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 16:50:10 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 66F7C19EE90D0;
	Sun,  8 May 2011 22:50:09 +0200 (CEST)
Received: from [93.240.113.59] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QJAvZ-0007Iv-00; Sun, 08 May 2011 22:50:09 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DC67CF4.80901@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Zr5IS48zZxVGla/spfnCuT7kKTmg6+mvCpTDq
	DKnIpOcSyZdSEPGNMq2Y7sxHlnFumQ8PCHSS3GmlKgFmStOdcH
	LL222sCeF4WX7H50NMAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173181>

Am 08.05.2011 13:22, schrieb Jens Lehmann:
> Am 07.05.2011 21:24, schrieb Junio C Hamano:
>> We may also want to add "read-tree -n" so that you do not have to specify
>> a dummy index output only to prevent from writing the real index over,
>> though.
> 
> Hmm, wouldn't using "read-tree --index-output=/dev/null" be equivalent to
> "read-tree -n"? But nonetheless it might make sense to add the -n option.

No idea how I could manage to test "read-tree --index-output=/dev/null"
successfully without getting an "unable to write new index file" error.

But using read-tree works for me, so what about something like this,
maybe with some more tests?

-------------8<---------------
Subject: [PATCH] Teach read-tree the -n|--dry-run option

Using this option tells read-tree to not update the index. That makes it
possible to check if updating the index would be successful without
changing it.

As using --dry-run is expected to have no side effects, this option makes
no sense together with "-u".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-read-tree.txt |    5 +++++
 builtin/read-tree.c             |    7 +++++--
 t/t1000-read-tree-m-3way.sh     |    2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 26fdadc..a35849f 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -53,6 +53,11 @@ OPTIONS
 	trees that are not directly related to the current
 	working tree status into a temporary index file.

+-n::
+--dry-run::
+	Don't write the index file. This option isn't allowed together
+	with -u.
+
 -v::
 	Show the progress of checking files out.

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 93c9281..693576f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -98,7 +98,7 @@ static struct lock_file lock_file;

 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
-	int i, newfd, stage = 0;
+	int i, newfd, stage = 0, dry_run = 0;
 	unsigned char sha1[20];
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
@@ -130,6 +130,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
 			    "don't check the working tree after merging", 1),
+		OPT__DRY_RUN(&dry_run, "don't update the index"),
 		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
 			    "skip applying sparse checkout filter", 1),
 		OPT_SET_INT(0, "debug-unpack", &opts.debug_unpack,
@@ -183,6 +184,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		die("--exclude-per-directory is meaningless unless -u");
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
+	if (opts.update && dry_run)
+		die("--dry-run contradicts -u");

 	if (opts.merge) {
 		if (stage < 2)
@@ -219,7 +222,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	if (unpack_trees(nr_trees, t, &opts))
 		return 128;

-	if (opts.debug_unpack)
+	if (opts.debug_unpack || dry_run)
 		return 0; /* do not write the index out */

 	/*
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index ca8a409..bcfb5e6 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -259,6 +259,8 @@ test_expect_success \
     "rm -f .git/index AA &&
      cp .orig-A/AA AA &&
      git update-index --add AA &&
+     git read-tree -n -m $tree_O $tree_A $tree_B &&
+     test_must_fail check_result &&
      git read-tree -m $tree_O $tree_A $tree_B &&
      check_result"

-- 
1.7.5.1.218.g8af57
