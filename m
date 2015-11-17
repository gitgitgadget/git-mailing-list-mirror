From: Mike Crowe <mac@mcrowe.com>
Subject: [PATCHv2] push: add recurseSubmodules config option
Date: Tue, 17 Nov 2015 11:05:56 +0000
Message-ID: <1447758356-7727-1-git-send-email-mac@mcrowe.com>
Cc: Mike Crowe <mac@mcrowe.com>, Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 12:06:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zye5l-0004JC-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 12:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbbKQLGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 06:06:24 -0500
Received: from relay.appriver.com ([207.97.230.34]:57908 "EHLO
	relay.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbbKQLGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 06:06:22 -0500
Received: from [86.30.112.98] (HELO elite.brightsign)
  by relay.appriver.com (CommuniGate Pro SMTP 6.1.2)
  with ESMTP id 641434457; Tue, 17 Nov 2015 06:06:20 -0500
Received: from chuckie.brightsign ([172.30.1.25] helo=chuckie)
	by elite.brightsign with esmtp (Exim 4.84)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1Zye5V-000EEu-3l; Tue, 17 Nov 2015 11:06:13 +0000
Received: from mac by chuckie with local (Exim 4.84)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1Zye5V-00021K-3D; Tue, 17 Nov 2015 11:06:13 +0000
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281400>

The --recurse-submodules command line parameter has existed for some
time but it has no config file equivalent.

Following the style of the corresponding parameter for git fetch, let's
invent push.recurseSubmodules to provide a default for this
parameter. This also requires the addition of --recurse-submodules=no to
allow the configuration to be overridden on the command line when
required.

The most straightforward way to implement this appears to be to make
push use code in submodule-config in a similar way to fetch.

Signed-off-by: Mike Crowe <mac@mcrowe.com>

---
 Documentation/config.txt       |  14 ++++
 Documentation/git-push.txt     |  24 ++++---
 builtin/push.c                 |  39 +++++++----
 submodule-config.c             |  29 ++++++++
 submodule-config.h             |   1 +
 submodule.h                    |   1 +
 t/t5531-deep-submodule-push.sh | 152 ++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 234 insertions(+), 26 deletions(-)

Changes from v1:

 * Incorporate feedback from Eric Sunshine:

 ** push.recurseSubmodules config option now supports 'no' value.

 ** --no-recurse-submodules is now a synonym for
    --recurse-submodules=no.

 ** use "git -c" rather than "git config" in tests to avoid leaving
    config options set if a test fails.

 * Fix several && chain failures in tests noticed by Stefan Beller.

 * Minor tweaks to documentation

 * Fix minor naming issues in tests

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 391a0c3..5a9f2ee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2226,6 +2226,20 @@ push.gpgSign::
 	override a value from a lower-priority config file. An explicit
 	command-line flag always overrides this config option.
 
+push.recurseSubmodules::
+	Make sure all submodule commits used by the revisions to be pushed
+	are available on a remote-tracking branch. If the value is 'check'
+	then Git will verify that all submodule commits that changed in the
+	revisions to be pushed are available on at least one remote of the
+	submodule. If any commits are missing, the push will be aborted and
+	exit with non-zero status. If the value is 'on-demand' then all
+	submodules that changed in the revisions to be pushed will be
+	pushed. If on-demand was not able to push all necessary revisions
+	it will also be aborted and exit with non-zero status. If the value
+	is 'no' then default behavior of ignoring submodules when pushing
+	is retained. You may override this configuration at time of push by
+	specifying '--recurse-submodules=check|on-demand|no'.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 85a4d7d..4c775bc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -257,16 +257,20 @@ origin +master` to force a push to the `master` branch). See the
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
---recurse-submodules=check|on-demand::
-	Make sure all submodule commits used by the revisions to be
-	pushed are available on a remote-tracking branch. If 'check' is
-	used Git will verify that all submodule commits that changed in
-	the revisions to be pushed are available on at least one remote
-	of the submodule. If any commits are missing the push will be
-	aborted and exit with non-zero status. If 'on-demand' is used
-	all submodules that changed in the revisions to be pushed will
-	be pushed. If on-demand was not able to push all necessary
-	revisions it will also be aborted and exit with non-zero status.
+--no-recurse-submodules::
+--recurse-submodules=check|on-demand|no::
+	May be used to make sure all submodule commits used by the
+	revisions to be pushed are available on a remote-tracking branch.
+	If 'check' is used Git will verify that all submodule commits that
+	changed in the revisions to be pushed are available on at least one
+	remote of the submodule. If any commits are missing the push will
+	be aborted and exit with non-zero status. If 'on-demand' is used
+	all submodules that changed in the revisions to be pushed will be
+	pushed. If on-demand was not able to push all necessary revisions
+	it will also be aborted and exit with non-zero status. A value of
+	'no' or using '--no-recurse-submodules' can be used to override the
+	push.recurseSubmodules configuration variable when no submodule
+	recursion is required.
 
 --[no-]verify::
 	Toggle the pre-push hook (see linkgit:githooks[5]).  The
diff --git a/builtin/push.c b/builtin/push.c
index 3bda430..f9b59b4 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -9,6 +9,7 @@
 #include "transport.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "submodule-config.h"
 #include "send-pack.h"
 
 static const char * const push_usage[] = {
@@ -20,7 +21,7 @@ static int thin = 1;
 static int deleterefs;
 static const char *receivepack;
 static int verbosity;
-static int progress = -1;
+static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 static struct push_cas_option cas;
 
@@ -452,22 +453,17 @@ static int do_push(const char *repo, int flags)
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
 {
-	int *flags = opt->value;
+	int *recurse_submodules = opt->value;
 
-	if (*flags & (TRANSPORT_RECURSE_SUBMODULES_CHECK |
-		      TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND))
+	if (*recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
 		die("%s can only be used once.", opt->long_name);
 
-	if (arg) {
-		if (!strcmp(arg, "check"))
-			*flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
-		else if (!strcmp(arg, "on-demand"))
-			*flags |= TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
-		else
-			die("bad %s argument: %s", opt->long_name, arg);
-	} else
-		die("option %s needs an argument (check|on-demand)",
-				opt->long_name);
+	if (unset)
+		*recurse_submodules = RECURSE_SUBMODULES_OFF;
+	else if (arg)
+		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
+	else
+		die("%s missing parameter", opt->long_name);
 
 	return 0;
 }
@@ -522,6 +518,10 @@ static int git_push_config(const char *k, const char *v, void *cb)
 					return error("Invalid value for '%s'", k);
 			}
 		}
+	} else if (!strcmp(k, "push.recursesubmodules")) {
+		const char *value;
+		if (!git_config_get_value("push.recursesubmodules", &value))
+			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
 	}
 
 	return git_default_config(k, v, NULL);
@@ -532,6 +532,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int flags = 0;
 	int tags = 0;
 	int push_cert = -1;
+	int recurse_submodules_from_cmdline = RECURSE_SUBMODULES_DEFAULT;
 	int rc;
 	const char *repo = NULL;	/* default repository */
 	struct option options[] = {
@@ -549,7 +550,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, "check|on-demand",
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules_from_cmdline, N_("check|on-demand|no"),
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
@@ -580,6 +581,14 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
+	if (recurse_submodules_from_cmdline != RECURSE_SUBMODULES_DEFAULT)
+		recurse_submodules = recurse_submodules_from_cmdline;
+
+	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
+		flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
+	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
+		flags |= TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
+
 	if (tags)
 		add_refspec("refs/tags/*");
 
diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..fe8ceab 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -228,6 +228,35 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_fetch_recurse(opt, arg, 1);
 }
 
+static int parse_push_recurse(const char *opt, const char *arg,
+			       int die_on_error)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		/* There's no simple "on" value when pushing */
+		if (die_on_error)
+			die("bad %s argument: %s", opt, arg);
+		else
+			return RECURSE_SUBMODULES_ERROR;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (!strcmp(arg, "on-demand"))
+			return RECURSE_SUBMODULES_ON_DEMAND;
+		else if (!strcmp(arg, "check"))
+			return RECURSE_SUBMODULES_CHECK;
+		else if (die_on_error)
+			die("bad %s argument: %s", opt, arg);
+		else
+			return RECURSE_SUBMODULES_ERROR;
+	}
+}
+
+int parse_push_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	return parse_push_recurse(opt, arg, 1);
+}
+
 static void warn_multiple_config(const unsigned char *commit_sha1,
 				 const char *name, const char *option)
 {
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..9bfa65a 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -19,6 +19,7 @@ struct submodule {
 };
 
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_submodule_config_option(const char *var, const char *value);
 const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
diff --git a/submodule.h b/submodule.h
index 5507c3d..ddff512 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,7 @@ struct diff_options;
 struct argv_array;
 
 enum {
+	RECURSE_SUBMODULES_CHECK = -4,
 	RECURSE_SUBMODULES_ERROR = -3,
 	RECURSE_SUBMODULES_NONE = -2,
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 6507487..9fda7b0 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -64,7 +64,12 @@ test_expect_success 'push fails if submodule commit not on remote' '
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Third commit for gar/bage" &&
-		test_must_fail git push --recurse-submodules=check ../pub.git master
+		# the push should fail with --recurse-submodules=check
+		# on the command line...
+		test_must_fail git push --recurse-submodules=check ../pub.git master &&
+
+		# ...or if specified in the configuration..
+		test_must_fail git -c push.recurseSubmodules=check push ../pub.git master
 	)
 '
 
@@ -79,6 +84,151 @@ test_expect_success 'push succeeds after commit was pushed to remote' '
 	)
 '
 
+test_expect_success 'push succeeds if submodule commit not on remote but using on-demand on command line' '
+	(
+		cd work/gar/bage &&
+		>recurse-on-demand-on-command-line &&
+		git add recurse-on-demand-on-command-line &&
+		git commit -m "Recurse on-demand on command line junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse on-demand on command line for gar/bage" &&
+		git push --recurse-submodules=on-demand ../pub.git master &&
+		# Check that the supermodule commit got there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		# Check that the submodule commit got there too
+		cd gar/bage &&
+		git diff --quiet origin/master master
+	)
+'
+
+test_expect_success 'push succeeds if submodule commit not on remote but using on-demand from config' '
+	(
+		cd work/gar/bage &&
+		>recurse-on-demand-from-config &&
+		git add recurse-on-demand-from-config &&
+		git commit -m "Recurse on-demand from config junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse on-demand from config for gar/bage" &&
+		git -c push.recurseSubmodules=on-demand push ../pub.git master &&
+		# Check that the supermodule commit got there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		# Check that the submodule commit got there too
+		cd gar/bage &&
+		git diff --quiet origin/master master
+	)
+'
+
+test_expect_success 'push fails if submodule commit not on remote using check from cmdline overriding config' '
+	(
+		cd work/gar/bage &&
+		>recurse-check-on-command-line-overriding-config &&
+		git add recurse-check-on-command-line-overriding-config &&
+		git commit -m "Recurse on command-line overridiing config junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse on command-line overriding config for gar/bage" &&
+		test_must_fail git -c push.recurseSubmodules=on-demand push --recurse-submodules=check ../pub.git master &&
+		# Check that the supermodule commit did not get there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master^ &&
+		# Check that the submodule commit did not get there
+		cd gar/bage &&
+		git diff --quiet origin/master master^
+	)
+'
+
+test_expect_success 'push succeeds if submodule commit not on remote using on-demand from cmdline overriding config' '
+	(
+		cd work/gar/bage &&
+		>recurse-on-demand-on-command-line-overriding-config &&
+		git add recurse-on-demand-on-command-line-overriding-config &&
+		git commit -m "Recurse on-demand on command-line overriding config junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse on-demand on command-line overriding config for gar/bage" &&
+		git -c push.recurseSubmodules=check push --recurse-submodules=on-demand ../pub.git master &&
+		# Check that the supermodule commit got there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		# Check that the submodule commit got there
+		cd gar/bage &&
+		git diff --quiet origin/master master
+	)
+'
+
+test_expect_success 'push succeeds if submodule commit disabling recursion from cmdline overriding config' '
+	(
+		cd work/gar/bage &&
+		>recurse-disable-on-command-line-overriding-config &&
+		git add recurse-disable-on-command-line-overriding-config &&
+		git commit -m "Recurse disable on command-line overriding config junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse disable on command-line overriding config for gar/bage" &&
+		git -c push.recurseSubmodules=check push --recurse-submodules=no ../pub.git master &&
+		# Check that the supermodule commit got there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		# But that the submodule commit did not
+		( cd gar/bage && git diff --quiet origin/master master^ ) &&
+		# Now push it to avoid confusing future tests
+		git push --recurse-submodules=on-demand ../pub.git master
+	)
+'
+
+test_expect_success 'push succeeds if submodule commit disabling recursion from cmdline (alternative form) overriding config' '
+	(
+		cd work/gar/bage &&
+		>recurse-disable-on-command-line-alt-overriding-config &&
+		git add recurse-disable-on-command-line-alt-overriding-config &&
+		git commit -m "Recurse disable on command-line alternative overriding config junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse disable on command-line alternative overriding config for gar/bage" &&
+		git -c push.recurseSubmodules=check push --no-recurse-submodules ../pub.git master &&
+		# Check that the supermodule commit got there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		# But that the submodule commit did not
+		( cd gar/bage && git diff --quiet origin/master master^ ) &&
+		# Now push it to avoid confusing future tests
+		git push --recurse-submodules=on-demand ../pub.git master
+	)
+'
+
+test_expect_success 'push fails if recurse submodules option passed as yes' '
+	(
+		cd work/gar/bage &&
+		>recurse-push-fails-if-recurse-submodules-passed-as-yes &&
+		git add recurse-push-fails-if-recurse-submodules-passed-as-yes &&
+		git commit -m "Recurse push fails if recurse submodules option passed as yes"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse push fails if recurse submodules option passed as yes for gar/bage" &&
+		test_must_fail git push --recurse-submodules=yes ../pub.git master &&
+		test_must_fail git -c push.recurseSubmodules=yes push ../pub.git master &&
+		git push --recurse-submodules=on-demand ../pub.git master
+	)
+'
+
 test_expect_success 'push fails when commit on multiple branches if one branch has no remote' '
 	(
 		cd work/gar/bage &&
-- 
2.1.4
