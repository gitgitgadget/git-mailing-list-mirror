From: Mike Crowe <mac@mcrowe.com>
Subject: [PATCH] push: Improve --recurse-submodules support
Date: Wed,  2 Dec 2015 09:56:12 +0000
Message-ID: <1449050172-1119-1-git-send-email-mac@mcrowe.com>
References: <20151202095451.GA22568@mcrowe.com>
Cc: Mike Crowe <mac@mcrowe.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 10:57:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a44A1-00019a-4q
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 10:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986AbbLBJ5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 04:57:06 -0500
Received: from relay.appriver.com ([207.97.230.34]:65200 "EHLO
	relay.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346AbbLBJ5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 04:57:04 -0500
Received: from [86.30.112.98] (HELO elite.brightsign)
  by relay.appriver.com (CommuniGate Pro SMTP 6.1.2)
  with ESMTP id 649790392; Wed, 02 Dec 2015 04:57:01 -0500
Received: from chuckie.brightsign ([172.30.1.25] helo=chuckie)
	by elite.brightsign with esmtp (Exim 4.84)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1a449i-0002TY-Nt; Wed, 02 Dec 2015 09:56:58 +0000
Received: from mac by chuckie with local (Exim 4.84)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1a449i-0000KW-NU; Wed, 02 Dec 2015 09:56:58 +0000
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20151202095451.GA22568@mcrowe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281884>

b33a15b08131514b593015cb3e719faf9db20208 added support for the
push.recurseSubmodules config option. After it was merged Junio C Hamano
suggested some improvements:

 - Declare recurse_submodules on a separate line.

 - Accept multiple --recurse-submodules options on command line with the
   last one winning. (This simplified the implementation too.)

Also slightly improve one of the tests added in
b33a15b08131514b593015cb3e719faf9db20208.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---

 builtin/push.c                 | 12 +++---------
 t/t5531-deep-submodule-push.sh | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 12 deletions(-)

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
index 9fda7b0..9a637f5 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -126,7 +126,7 @@ test_expect_success 'push succeeds if submodule commit not on remote but using o
 	)
 '
 
-test_expect_success 'push fails if submodule commit not on remote using check from cmdline overriding config' '
+test_expect_success 'push recurse-submodules cmdline overrides config' '
 	(
 		cd work/gar/bage &&
 		>recurse-check-on-command-line-overriding-config &&
@@ -142,8 +142,38 @@ test_expect_success 'push fails if submodule commit not on remote using check fr
 		git fetch ../pub.git &&
 		git diff --quiet FETCH_HEAD master^ &&
 		# Check that the submodule commit did not get there
-		cd gar/bage &&
-		git diff --quiet origin/master master^
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+		# Now try the reverse which should succeed
+		git -c push.recurseSubmodules=check push --recurse-submodules=on-demand ../pub.git master &&
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		(cd gar/bage && git diff --quiet origin/master master)
+	)
+'
+
+test_expect_success 'push recurse-submodules on cmdline overrides earlier cmdline' '
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
+		test_must_fail git push --recurse-submodules=on-demand --recurse-submodules=check ../pub.git master &&
+		# Check that the supermodule commit did not get there
+		git fetch ../pub.git &&
+		git diff FETCH_HEAD master^ &&
+		git diff --quiet FETCH_HEAD master^ &&
+		# Check that the submodule commit did not get there
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+		# But the options in the other order should push the submodule
+		git push --recurse-submodules=check --recurse-submodules=on-demand ../pub.git master &&
+		# Check that the submodule commit did get there
+		git fetch ../pub.git &&
+		(cd gar/bage && git diff --quiet origin/master master)
 	)
 '
 
-- 
2.1.4
