From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP PATCH 4/4] Teach checkout-index to recursively checkout submodules
Date: Fri, 09 Apr 2010 23:40:35 +0200
Message-ID: <4BBF9ED3.9010502@web.de>
References: <4BBF9D6F.2000006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 23:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0LwQ-0000Re-2E
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 23:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757817Ab0DIVkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 17:40:37 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:37099 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0DIVkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 17:40:36 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1223A156499CA;
	Fri,  9 Apr 2010 23:40:36 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0LwJ-0006hs-00; Fri, 09 Apr 2010 23:40:35 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BBF9D6F.2000006@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19CMvwmbXYRiGuFhCdPBYNHFhFU6ntRHhP2uZcQ
	sSfiHb8KzxUrDGklo+Juqx6br5N99PkS8yFWWnDWVeKMZrd8XA
	p4bHcYT1/zB4kfhBQA3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144478>

Change the default behavior of "git checkout-index" to check out submodules
too. This can be prevented by using the new "--ignore-submodules" option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-checkout-index.txt |    9 ++++++++-
 builtin/checkout-index.c             |    6 ++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index d6aa6e1..dbd6625 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
 		   [--stage=<number>|all]
-		   [--temp]
+		   [--temp] [--ignore-submodules]
 		   [-z] [--stdin]
 		   [--] [<file>]\*

@@ -68,6 +68,13 @@ OPTIONS
 	Only meaningful with `--stdin`; paths are separated with
 	NUL character instead of LF.

+--ignore-submodules::
+	Since version 1.8.0 the default behavior is to checkout populated
+	submodules recursively. When this option is used, the work trees of
+	submodules will not be updated, only the hash recorded in the
+	superproject will be changed (this was the default behavior until
+	1.8.0).
+
 \--::
 	Do not interpret any more arguments as options.

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c35bad3..1e16d0d 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -213,7 +213,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int all = 0;
 	int read_from_stdin = 0;
 	int prefix_length;
-	int force = 0, quiet = 0, not_new = 0;
+	int force = 0, quiet = 0, not_new = 0, ignore_submodules = 0;
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOLEAN('a', "all", &all,
 			"checks out all files in the index"),
@@ -238,6 +238,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "stage", NULL, NULL,
 			"copy out the files from named stage",
 			option_parse_stage),
+		OPT_BOOLEAN(0, "ignore-submodules", &ignore_submodules,
+			"don't update submodule work trees"),
 		OPT_END()
 	};

@@ -254,7 +256,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
-	state.ignore_submodules = 1;
+	state.ignore_submodules = ignore_submodules;

 	if (state.base_dir_len || to_tempfile) {
 		/* when --prefix is specified we do not
-- 
1.7.1.rc0.248.g09203
