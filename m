From: Mike Crowe <mac@mcrowe.com>
Subject: [PATCH 2/2] push: Use "last one wins" convention for --recurse-submodules
Date: Thu,  3 Dec 2015 13:10:35 +0000
Message-ID: <1449148235-29569-2-git-send-email-mac@mcrowe.com>
References: <20151203131006.GA5119@mcrowe.com>
 <1449148235-29569-1-git-send-email-mac@mcrowe.com>
Cc: Mike Crowe <mac@mcrowe.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 14:11:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4TfI-0000nq-98
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 14:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759935AbbLCNLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 08:11:12 -0500
Received: from relay.appriver.com ([207.97.230.34]:62491 "EHLO
	relay.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759764AbbLCNLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 08:11:11 -0500
Received: from [86.30.112.98] (HELO elite.brightsign)
  by relay.appriver.com (CommuniGate Pro SMTP 6.1.2)
  with ESMTP id 650626443; Thu, 03 Dec 2015 08:11:09 -0500
Received: from chuckie.brightsign ([172.30.1.25] helo=chuckie)
	by elite.brightsign with esmtp (Exim 4.84)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1a4Tf7-000B60-GJ; Thu, 03 Dec 2015 13:11:05 +0000
Received: from mac by chuckie with local (Exim 4.84)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1a4Tf7-0007oE-Fa; Thu, 03 Dec 2015 13:11:05 +0000
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449148235-29569-1-git-send-email-mac@mcrowe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281953>

Use the "last one wins" convention for --recurse-submodules rather than
treating conflicting options as an error.

Also, fix the declaration of the file-scope recurse_submodules global
variable to put it on a separate line.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---
 builtin/push.c                 | 12 +++---------
 t/t5531-deep-submodule-push.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index f9b59b4..cc29277 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -21,7 +21,8 @@ static int thin = 1;
 static int deleterefs;
 static const char *receivepack;
 static int verbosity;
-static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int progress = -1;
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 static struct push_cas_option cas;
 
@@ -455,9 +456,6 @@ static int option_parse_recurse_submodules(const struct option *opt,
 {
 	int *recurse_submodules = opt->value;
 
-	if (*recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
-		die("%s can only be used once.", opt->long_name);
-
 	if (unset)
 		*recurse_submodules = RECURSE_SUBMODULES_OFF;
 	else if (arg)
@@ -532,7 +530,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int flags = 0;
 	int tags = 0;
 	int push_cert = -1;
-	int recurse_submodules_from_cmdline = RECURSE_SUBMODULES_DEFAULT;
 	int rc;
 	const char *repo = NULL;	/* default repository */
 	struct option options[] = {
@@ -550,7 +547,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules_from_cmdline, N_("check|on-demand|no"),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("check|on-demand|no"),
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
@@ -581,9 +578,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
-	if (recurse_submodules_from_cmdline != RECURSE_SUBMODULES_DEFAULT)
-		recurse_submodules = recurse_submodules_from_cmdline;
-
 	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
 		flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
 	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 721be32..198ce84 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -171,6 +171,47 @@ test_expect_success 'push recurse-submodules on command line overrides config' '
 	)
 '
 
+test_expect_success 'push recurse-submodules last one wins on command line' '
+	(
+		cd work/gar/bage &&
+		>recurse-check-on-command-line-overriding-earlier-command-line &&
+		git add recurse-check-on-command-line-overriding-earlier-command-line &&
+		git commit -m "Recurse on command-line overridiing earlier command-line junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse on command-line overriding earlier command-line for gar/bage" &&
+
+		# should result in "check"
+		test_must_fail git push --recurse-submodules=on-demand --recurse-submodules=check ../pub.git master &&
+		# Check that the supermodule commit did not get there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master^ &&
+		# Check that the submodule commit did not get there
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+
+		# should result in "no"
+		git push --recurse-submodules=on-demand --recurse-submodules=no ../pub.git master &&
+		# Check that the supermodule commit did get there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		# Check that the submodule commit did not get there
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+
+		# should result in "no"
+		git push --recurse-submodules=on-demand --no-recurse-submodules ../pub.git master &&
+		# Check that the submodule commit did not get there
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+
+		# But the options in the other order should push the submodule
+		git push --recurse-submodules=check --recurse-submodules=on-demand ../pub.git master &&
+		# Check that the submodule commit did get there
+		git fetch ../pub.git &&
+		(cd gar/bage && git diff --quiet origin/master master)
+	)
+'
+
 test_expect_success 'push succeeds if submodule commit not on remote using on-demand from cmdline overriding config' '
 	(
 		cd work/gar/bage &&
-- 
2.1.4
