From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH v2] fetch: make --prune configurable
Date: Sat, 13 Jul 2013 11:36:24 +0200
Message-ID: <1373708184-22672-1-git-send-email-mschub@elegosoft.com>
Cc: git@vger.kernel.org, Michael Schubert <mschub@elegosoft.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 11:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxwQT-0006sz-9u
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 11:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067Ab3GMJrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 05:47:21 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:40545 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758172Ab3GMJrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 05:47:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id D1BD0DF142;
	Sat, 13 Jul 2013 11:47:17 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQr+QJPUPKab; Sat, 13 Jul 2013 11:47:17 +0200 (CEST)
Received: from localhost.localdomain (g225086070.adsl.alicedsl.de [92.225.86.70])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 79C29DF141;
	Sat, 13 Jul 2013 11:47:17 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.1.g243ed41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230279>

Without "git fetch --prune", remote-tracking branches for a branch
the other side already has removed will stay forever.  Some people
want to always run "git fetch --prune".

To accommodate users who want to either prune always or when fetching
from a particular remote, add two new configuration variables
"fetch.prune" and "remote.<name>.prune":

 - "fetch.prune" allows to enable prune for all fetch operations.

 - "remote.<name>.prune" allows to change the behaviour per remote.

The latter will naturally override the former, and the --[no-]prune
option from the command line will override the configured default.

Since --prune is a potentially destructive operation (Git doesn't
keep reflogs for deleted references yet), we don't want to prune
without users consent, so this configuration will not be on by
default.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Schubert <mschub@elegosoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Junio, thank you for your detailed feedback and writing the patch.

I didn't find time during the week to write a v2 and I don't feel I
should take any credit here, so please feel free to take authorship
completely.

Thanks.


 Documentation/config.txt | 10 ++++++
 builtin/fetch.c          | 39 ++++++++++++++++++++---
 remote.c                 |  3 ++
 remote.h                 |  1 +
 t/t5510-fetch.sh         | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..e4ce7c4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1049,6 +1049,10 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+fetch.prune::
+	If true, fetch will automatically behave as if the `--prune`
+	option was given on the command line.  See also `remote.<name>.prune`.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
@@ -1984,6 +1988,12 @@ remote.<name>.vcs::
 	Setting this to a value <vcs> will cause Git to interact with
 	the remote with the git-remote-<vcs> helper.
 
+remote.<name>.prune::
+	When set to true, fetching from this remote by default will also
+	remove any remote-tracking branches which no longer exist on the
+	remote (as if the `--prune` option was give on the command line).
+	Overrides `fetch.prune` settings, if any.
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b6b1df..08ab948 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -30,7 +30,11 @@ enum {
 	TAGS_SET = 2
 };
 
-static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
+static int fetch_prune_config = -1; /* unspecified */
+static int prune = -1; /* unspecified */
+#define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
+
+static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow;
 static const char *depth;
@@ -54,6 +58,15 @@ static int option_parse_recurse_submodules(const struct option *opt,
 	return 0;
 }
 
+static int git_fetch_config(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "fetch.prune")) {
+		fetch_prune_config = git_config_bool(k, v);
+		return 0;
+	}
+	return 0;
+}
+
 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN(0, "all", &all,
@@ -69,8 +82,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
-	OPT_BOOLEAN('p', "prune", &prune,
-		    N_("prune remote-tracking branches no longer on remote")),
+	OPT_BOOL('p', "prune", &prune,
+		 N_("prune remote-tracking branches no longer on remote")),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
@@ -739,7 +752,10 @@ static int do_fetch(struct transport *transport,
 		return 1;
 	}
 	if (prune) {
-		/* If --tags was specified, pretend the user gave us the canonical tags refspec */
+		/*
+		 * If --tags was specified, pretend that the user gave us
+		 * the canonical tags refspec
+		 */
 		if (tags == TAGS_SET) {
 			const char *tags_str = "refs/tags/*:refs/tags/*";
 			struct refspec *tags_refspec, *refspec;
@@ -848,7 +864,7 @@ static void add_options_to_argv(struct argv_array *argv)
 {
 	if (dry_run)
 		argv_array_push(argv, "--dry-run");
-	if (prune)
+	if (prune > 0)
 		argv_array_push(argv, "--prune");
 	if (update_head_ok)
 		argv_array_push(argv, "--update-head-ok");
@@ -916,6 +932,17 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		    "remote name from which new revisions should be fetched."));
 
 	transport = transport_get(remote, NULL);
+
+	if (prune < 0) {
+		/* no command line request */
+		if (0 <= transport->remote->prune)
+			prune = transport->remote->prune;
+		else if (0 <= fetch_prune_config)
+			prune = fetch_prune_config;
+		else
+			prune = PRUNE_BY_DEFAULT;
+	}
+
 	transport_set_verbosity(transport, verbosity, progress);
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
@@ -973,6 +1000,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
+	git_config(git_fetch_config, NULL);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
diff --git a/remote.c b/remote.c
index 68eb99b..89be211 100644
--- a/remote.c
+++ b/remote.c
@@ -148,6 +148,7 @@ static struct remote *make_remote(const char *name, int len)
 	}
 
 	ret = xcalloc(1, sizeof(struct remote));
+	ret->prune = -1;  /* unspecified */
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
 	if (len)
@@ -419,6 +420,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->skip_default_update = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".skipfetchall"))
 		remote->skip_default_update = git_config_bool(key, value);
+	else if (!strcmp(subkey, ".prune"))
+		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index cf56724..4db3498 100644
--- a/remote.h
+++ b/remote.h
@@ -40,6 +40,7 @@ struct remote {
 	int fetch_tags;
 	int skip_default_update;
 	int mirror;
+	int prune;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d7a19a1..019535f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -471,6 +471,88 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	)
 '
 
+# configured prune tests
+
+set_config_tristate () {
+	# var=$1 val=$2
+	case "$2" in
+	unset)  test_unconfig "$1" ;;
+	*)	git config "$1" "$2" ;;
+	esac
+}
+
+test_configured_prune () {
+	fetch_prune=$1 remote_origin_prune=$2 cmdline=$3 expected=$4
+
+	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${3:+ $3}; $4" '
+		# make sure a newbranch is there in . and also in one
+		git branch -f newbranch &&
+		(
+			cd one &&
+			test_unconfig fetch.prune &&
+			test_unconfig remote.origin.prune &&
+			git fetch &&
+			git rev-parse --verify refs/remotes/origin/newbranch
+		)
+
+		# now remove it
+		git branch -d newbranch &&
+
+		# then test
+		(
+			cd one &&
+			set_config_tristate fetch.prune $fetch_prune &&
+			set_config_tristate remote.origin.prune $remote_origin_prune &&
+
+			git fetch $cmdline &&
+			case "$expected" in
+			pruned)
+				test_must_fail git rev-parse --verify refs/remotes/origin/newbranch
+				;;
+			kept)
+				git rev-parse --verify refs/remotes/origin/newbranch
+				;;
+			esac
+		)
+	'
+}
+
+test_configured_prune unset unset ""		kept
+test_configured_prune unset unset "--no-prune"	kept
+test_configured_prune unset unset "--prune"	pruned
+
+test_configured_prune false unset ""		kept
+test_configured_prune false unset "--no-prune"	kept
+test_configured_prune false unset "--prune"	pruned
+
+test_configured_prune true  unset ""		pruned
+test_configured_prune true  unset "--prune"	pruned
+test_configured_prune true  unset "--no-prune"	kept
+
+test_configured_prune unset false ""		kept
+test_configured_prune unset false "--no-prune"	kept
+test_configured_prune unset false "--prune"	pruned
+
+test_configured_prune false false ""		kept
+test_configured_prune false false "--no-prune"	kept
+test_configured_prune false false "--prune"	pruned
+
+test_configured_prune true  false ""		kept
+test_configured_prune true  false "--prune"	pruned
+test_configured_prune true  false "--no-prune"	kept
+
+test_configured_prune unset true  ""		pruned
+test_configured_prune unset true  "--no-prune"	kept
+test_configured_prune unset true  "--prune"	pruned
+
+test_configured_prune false true  ""		pruned
+test_configured_prune false true  "--no-prune"	kept
+test_configured_prune false true  "--prune"	pruned
+
+test_configured_prune true  true  ""		pruned
+test_configured_prune true  true  "--prune"	pruned
+test_configured_prune true  true  "--no-prune"	kept
+
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
 	test_commit oneside &&
-- 
1.8.3.1.g243ed41
