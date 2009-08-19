From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 7/6] git clone: Add --recursive to automatically checkout
 (nested) submodules
Date: Thu, 20 Aug 2009 01:07:43 +0200
Message-ID: <200908200107.43146.johan@herland.net>
References: <1250646324-961-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, barkalow@iabervon.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 01:08:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduG7-0006Pd-Pv
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZHSXHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbZHSXHp
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:07:45 -0400
Received: from smtp.getmail.no ([84.208.15.66]:42063 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753373AbZHSXHo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 19:07:44 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KON00C6VC8XAY50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 20 Aug 2009 01:07:45 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KON0095SC8V9D20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 20 Aug 2009 01:07:45 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.19.225417
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <1250646324-961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126593>

Many projects using submodules expect all submodules to be checked out
in order to build/work correctly. A common command sequence for
developers on such projects is:

	git clone url/to/project
	cd project
	git submodule update --init (--recursive)

This patch introduces the --recursive option to git-clone. The new
option causes git-clone to recursively clone and checkout all
submodules of the cloned project. Hence, the above command sequence
can be reduced to:

	git clone --recursive url/to/project

--recursive is ignored if no checkout is done by the git-clone.

The patch also includes documentation and a selftest.

Signed-off-by: Johan Herland <johan@herland.net>
---

Hi,

It just hit me today that yesterday's patch series missed the last part
of the puzzle...

I'm not at all married to the '--recursive' name for this option, but
I wasn't able to think of anything better that wasn't too long.


Have fun! :)

...Johan


 Documentation/git-clone.txt  |   10 +++++++++-
 builtin-clone.c              |   11 ++++++++++-
 t/t7407-submodule-foreach.sh |   12 ++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2c63a0f..88ea272 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] [--] <repository> [<directory>]
+	  [--depth <depth>] [--recursive] [--] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -147,6 +147,14 @@ objects from the source repository into a pack in the cloned repository.
 	with a long history, and would want to send in fixes
 	as patches.
 
+--recursive::
+	After the clone is created, initialize all submodules within,
+	using their default settings. This is equivalent to running
+	'git submodule update --init --recursive' immediately after
+	the clone is finished. This option is ignored if the cloned
+	repository does not have a worktree/checkout (i.e. if any of
+	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+
 <repository>::
 	The (possibly remote) repository to clone from.  See the
 	<<URLS,URLS>> section below for more information on specifying
diff --git a/builtin-clone.c b/builtin-clone.c
index 32dea74..0d2b4a8 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -38,7 +38,7 @@ static const char * const builtin_clone_usage[] = {
 };
 
 static int option_quiet, option_no_checkout, option_bare, option_mirror;
-static int option_local, option_no_hardlinks, option_shared;
+static int option_local, option_no_hardlinks, option_shared, option_recursive;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
 static char *option_upload_pack = "git-upload-pack";
@@ -59,6 +59,8 @@ static struct option builtin_clone_options[] = {
 		    "don't use local hardlinks, always copy"),
 	OPT_BOOLEAN('s', "shared", &option_shared,
 		    "setup as shared repository"),
+	OPT_BOOLEAN(0, "recursive", &option_recursive,
+		    "setup as shared repository"),
 	OPT_STRING(0, "template", &option_template, "path",
 		   "path the template repository"),
 	OPT_STRING(0, "reference", &option_reference, "repo",
@@ -73,6 +75,10 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
+static const char *argv_submodule[] = {
+	"submodule", "update", "--init", "--recursive", NULL
+};
+
 static char *get_repo_path(const char *repo, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", ".git", "" };
@@ -608,6 +614,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		err |= run_hook(NULL, "post-checkout", sha1_to_hex(null_sha1),
 				sha1_to_hex(remote_head->old_sha1), "1", NULL);
+
+		if (!err && option_recursive)
+			err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
 	}
 
 	strbuf_release(&reflog_msg);
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index de1730d..25ec281 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -220,4 +220,16 @@ test_expect_success 'test "status --recursive"' '
 	test_cmp expect actual
 '
 
+test_expect_success 'use "git clone --recursive" to checkout all submodules' '
+	git clone --recursive super clone4 &&
+	test -d clone4/.git &&
+	test -d clone4/sub1/.git &&
+	test -d clone4/sub2/.git &&
+	test -d clone4/sub3/.git &&
+	test -d clone4/nested1/.git &&
+	test -d clone4/nested1/nested2/.git &&
+	test -d clone4/nested1/nested2/nested3/.git &&
+	test -d clone4/nested1/nested2/nested3/submodule/.git
+'
+
 test_done
-- 
1.6.4.304.g1365c.dirty
