From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] fetch: make --prune configurable
Date: Fri, 12 Jul 2013 15:38:46 -0700
Message-ID: <7vppunietl.fsf@alter.siamese.dyndns.org>
References: <1373288217-20580-1-git-send-email-mschub@elegosoft.com>
	<7vk3l0zypa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 00:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxlzd-0001cH-48
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 00:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856Ab3GLWjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 18:39:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757852Ab3GLWiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 18:38:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45EBF30C0B;
	Fri, 12 Jul 2013 22:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/O+DgqLpjJn0Q//9ITy44m6upU8=; b=MeGZs7
	FNQTdv28GMS6DK0CMYaof0z5WnvLDogRZiY0MF3VfuOh+7lKXOJUdI4ShkIuqypO
	zFHsesc71jfT0K6bQw/bj9480Ec05Kbdlry0PBTZbaZujfh9CKRNwG1/5TuSZuIn
	1z0XYJr/vHMrPZYpjPEldACVcGiKyd3e6eD5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MTYTVtnGQnkarobbWIAB4ABzPtxvpvkG
	RzcTRviTtaGMneqP8i95OeRDf967X5XP2quFGAy3Tv5dLFTycITrcGGj/LgsSlcj
	wIuc4b+MmV/nc6Q8fJs6BPPfdOGaxMzSbyX2skmyDAhs5n9pmhv3xtqCp43V3CuI
	0YQMHbR+12k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39BCA30C0A;
	Fri, 12 Jul 2013 22:38:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07C2230C06;
	Fri, 12 Jul 2013 22:38:50 +0000 (UTC)
In-Reply-To: <7vk3l0zypa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 08 Jul 2013 11:36:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D30A21AC-EB43-11E2-BD9A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230264>

Here is my previous review comments in a squashable patch form.  The
result seems to pass all 27 combinations (fetch.prune, remote.*.prune
and command line all are tristate yes/no/unspecified).

Without the fix-up in *.c files, three combinations seem to fail.

 Documentation/config.txt |   3 +-
 builtin/fetch.c          |  41 +++++++++-------
 remote.c                 |   1 +
 t/t5510-fetch.sh         | 118 ++++++++++++++++++++++++++++++++---------------
 4 files changed, 108 insertions(+), 55 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fc39f3a..e4ce7c4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1051,7 +1051,7 @@ fetch.unpackLimit::
 
 fetch.prune::
 	If true, fetch will automatically behave as if the `--prune`
-	option was given on the command line.
+	option was given on the command line.  See also `remote.<name>.prune`.
 
 format.attach::
 	Enable multipart/mixed attachments as the default for
@@ -1992,6 +1992,7 @@ remote.<name>.prune::
 	When set to true, fetching from this remote by default will also
 	remove any remote-tracking branches which no longer exist on the
 	remote (as if the `--prune` option was give on the command line).
+	Overrides `fetch.prune` settings, if any.
 
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 082450b..08ab948 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -30,13 +30,10 @@ enum {
 	TAGS_SET = 2
 };
 
-enum {
-	PRUNE_UNSET = 0,
-	PRUNE_DEFAULT = 1,
-	PRUNE_FORCE = 2
-};
+static int fetch_prune_config = -1; /* unspecified */
+static int prune = -1; /* unspecified */
+#define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
 
-static int prune = PRUNE_DEFAULT;
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow;
@@ -64,12 +61,10 @@ static int option_parse_recurse_submodules(const struct option *opt,
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "fetch.prune")) {
-		int boolval = git_config_bool(k, v);
-		if (boolval)
-			prune = PRUNE_FORCE;
+		fetch_prune_config = git_config_bool(k, v);
 		return 0;
 	}
-	return git_default_config(k, v, cb);
+	return 0;
 }
 
 static struct option builtin_fetch_options[] = {
@@ -87,8 +82,8 @@ static struct option builtin_fetch_options[] = {
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
@@ -756,8 +751,11 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		return 1;
 	}
-	if (prune == PRUNE_FORCE || (transport->remote->prune && prune)) {
-		/* If --tags was specified, pretend the user gave us the canonical tags refspec */
+	if (prune) {
+		/*
+		 * If --tags was specified, pretend that the user gave us
+		 * the canonical tags refspec
+		 */
 		if (tags == TAGS_SET) {
 			const char *tags_str = "refs/tags/*:refs/tags/*";
 			struct refspec *tags_refspec, *refspec;
@@ -866,10 +864,8 @@ static void add_options_to_argv(struct argv_array *argv)
 {
 	if (dry_run)
 		argv_array_push(argv, "--dry-run");
-	if (prune == PRUNE_FORCE)
+	if (prune > 0)
 		argv_array_push(argv, "--prune");
-	else if (prune == PRUNE_UNSET)
-		argv_array_push(argv, "--no-prune");
 	if (update_head_ok)
 		argv_array_push(argv, "--update-head-ok");
 	if (force)
@@ -936,6 +932,17 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
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
diff --git a/remote.c b/remote.c
index d0ddbef..89be211 100644
--- a/remote.c
+++ b/remote.c
@@ -148,6 +148,7 @@ static struct remote *make_remote(const char *name, int len)
 	}
 
 	ret = xcalloc(1, sizeof(struct remote));
+	ret->prune = -1;  /* unspecified */
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
 	if (len)
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 33fe3d5..019535f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -471,43 +471,87 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	)
 '
 
-test_expect_success 'fetch should prune when fetch.prune is true' '
-  cd "$D" &&
-  git branch somebranch &&
-  (
-    cd one &&
-    git fetch &&
-    test -f .git/refs/remotes/origin/somebranch
-  ) &&
-  git branch -d somebranch &&
-  (
-    cd one &&
-    git config fetch.prune true &&
-    git fetch --no-prune &&
-    test -f .git/refs/remotes/origin/somebranch &&
-    git fetch &&
-    ! test -f .git/refs/remotes/origin/somebranch
-  )
-'
-
-test_expect_success 'fetch should prune when remote.<name>.prune is true' '
-  cd "$D" &&
-  git branch somebranch &&
-  (
-    cd one &&
-    git fetch &&
-    test -f .git/refs/remotes/origin/somebranch
-  ) &&
-  git branch -d somebranch &&
-  (
-    cd one &&
-    git config remote.origin.prune true &&
-    git fetch --no-prune &&
-    test -f .git/refs/remotes/origin/somebranch &&
-    git fetch &&
-    ! test -f .git/refs/remotes/origin/somebranch
-  )
-'
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
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
1.8.3.2-941-gda9c3c8
