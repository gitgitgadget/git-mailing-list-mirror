Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5CAF1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdAYVdc (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:33:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:44823 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbdAYVdb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:33:31 -0500
Received: (qmail 4624 invoked by uid 109); 25 Jan 2017 21:33:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 21:33:31 +0000
Received: (qmail 16397 invoked by uid 111); 25 Jan 2017 21:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 16:33:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 16:33:29 -0500
Date:   Wed, 25 Jan 2017 16:33:29 -0500
From:   Jeff King <peff@peff.net>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     git@vger.kernel.org, novalis@novalis.org, pclouds@gmail.com
Subject: Re: [PATCH] tag: add tag.createReflog option
Message-ID: <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
References: <20170125001906.13916-1-cornelius.weig@tngtech.com>
 <20170125180054.7mioop2o6uvqloyt@sigill.intra.peff.net>
 <00712f81-e0ba-52e6-77bc-095a2ed706c4@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00712f81-e0ba-52e6-77bc-095a2ed706c4@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 10:21:48PM +0100, Cornelius Weig wrote:

> On 01/25/2017 07:00 PM, Jeff King wrote:
> 
> >   - Is that the end of it, or is the desire really "I want reflogs for
> >     _everything_"? That seems like a sane thing to want.
> > 
> >     If so, then the update to core.logallrefupdates should turn it into
> >     a tri-state:
> > 
> >       - false; no reflogs
> > 
> >       - true; reflogs for branches, remotes, notes, as now
> > 
> >       - always; reflogs for all refs under "refs/"
> > 
> 
> I think you nailed it. This is much more useful than what I suggested.
> I'll see if I can code it up.

I cheated a little. I actually wrote the "always" patch 3 years ago as
part of another thing I was working on. But in the end I didn't need it,
and never submitted it.

The patch is below for reference. I have no idea whether it even applies
now, let alone runs and does the right thing. But perhaps you can
salvage bits of it (but feel free to ignore it if it makes things
harder).

-- >8 --
From: Jeff King <peff@peff.net>
Date: Mon, 15 Apr 2013 23:31:05 -0400
Subject: [PATCH] teach core.logallrefupdates an "always" mode

When core.logallrefupdates is true, we only create a new
reflog for refs that are under certain well-known
hierarchies. The reason is that we know that some
hierarchies (like refs/tags) do not typically change, and
that unknown hierarchies might not want reflogs at all
(e.g., a hypothetical refs/foo might be meant to change
often and drop old history immediately).

However, sometimes it is useful to override this decision
and simply log for all refs, because the safety and audit
trail is more important than the performance implications of
keeping the log around.

This patch introduces a new "always" mode for the
core.logallrefupdates option which will log updates to
everything under refs/, regardless where in the hierarchy it
is (we still will not log things like ORIG_HEAD and
FETCH_HEAD, which are known to be transient).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |  8 +++++---
 branch.c                 |  2 +-
 builtin/checkout.c       |  2 +-
 builtin/init-db.c        |  2 +-
 cache.h                  |  9 ++++++++-
 config.c                 |  7 ++++++-
 environment.c            |  2 +-
 refs.c                   | 23 +++++++++++++++++------
 t/t1400-update-ref.sh    | 32 ++++++++++++++++++++++++++++++++
 9 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e37ba94a72..cb72e559ec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -390,10 +390,12 @@ core.logAllRefUpdates::
 	"$GIT_DIR/logs/<ref>", by appending the new and old
 	SHA1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
-	variable is set to true, missing "$GIT_DIR/logs/<ref>"
+	variable is set to `true`, a missing "$GIT_DIR/logs/<ref>"
 	file is automatically created for branch heads (i.e. under
-	refs/heads/), remote refs (i.e. under refs/remotes/),
-	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.
+	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
+	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
+	If it is set to `always`, then a missing reflog is automatically
+	created for any ref under `refs/`.
 +
 This information can be used to determine what commit
 was the tip of a branch "2 days ago".
diff --git a/branch.c b/branch.c
index 2bef1e7e71..c11880b181 100644
--- a/branch.c
+++ b/branch.c
@@ -259,7 +259,7 @@ void create_branch(const char *head,
 	}
 
 	if (reflog)
-		log_all_ref_updates = 1;
+		log_all_ref_updates = LOG_REFS_NORMAL;
 
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset to %s",
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a95f..00e231d83b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -564,7 +564,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				char *ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 
 				temp = log_all_ref_updates;
-				log_all_ref_updates = 1;
+				log_all_ref_updates = LOG_REFS_NORMAL;
 				if (log_ref_setup(ref_name, log_file, sizeof(log_file))) {
 					fprintf(stderr, _("Can not do reflog for '%s'\n"),
 					    opts->new_orphan_branch);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 78aa3872dd..0ebad0b37d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -264,7 +264,7 @@ static int create_default_files(const char *template_path)
 		const char *work_tree = get_git_work_tree();
 		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
-		if (log_all_ref_updates == -1)
+		if (log_all_ref_updates == LOG_REFS_UNSET)
 		    git_config_set("core.logallrefupdates", "true");
 		if (prefixcmp(git_dir, work_tree) ||
 		    strcmp(git_dir + strlen(work_tree), "/.git")) {
diff --git a/cache.h b/cache.h
index 2b192d24ac..d2bfabc67f 100644
--- a/cache.h
+++ b/cache.h
@@ -536,7 +536,6 @@ extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
-extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
@@ -556,6 +555,14 @@ extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 
+enum log_refs_config {
+	LOG_REFS_UNSET = -1,
+	LOG_REFS_NONE = 0,
+	LOG_REFS_NORMAL, /* see should_create_reflog for rules */
+	LOG_REFS_ALWAYS
+};
+extern enum log_refs_config log_all_ref_updates;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/config.c b/config.c
index b5696354fa..ffb892c0a0 100644
--- a/config.c
+++ b/config.c
@@ -601,7 +601,12 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.logallrefupdates")) {
-		log_all_ref_updates = git_config_bool(var, value);
+		if (value && !strcasecmp(value, "always"))
+			log_all_ref_updates = LOG_REFS_ALWAYS;
+		else if (git_config_bool(var, value))
+			log_all_ref_updates = LOG_REFS_NORMAL;
+		else
+			log_all_ref_updates = LOG_REFS_NONE;
 		return 0;
 	}
 
diff --git a/environment.c b/environment.c
index 85edd7f95a..1867d31d75 100644
--- a/environment.c
+++ b/environment.c
@@ -19,7 +19,7 @@ int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
-int log_all_ref_updates = -1; /* unspecified */
+enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 const char *git_commit_encoding;
diff --git a/refs.c b/refs.c
index 541fec2065..3cd203ef87 100644
--- a/refs.c
+++ b/refs.c
@@ -1896,7 +1896,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	lock->force_write = 1;
 	flag = log_all_ref_updates;
-	log_all_ref_updates = 0;
+	log_all_ref_updates = LOG_REFS_NONE;
 	if (write_ref_sha1(lock, orig_sha1, NULL))
 		error("unable to write current sha1 into %s", oldrefname);
 	log_all_ref_updates = flag;
@@ -1965,16 +1965,27 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+int should_create_reflog(const char *refname)
+{
+	switch (log_all_ref_updates) {
+	case LOG_REFS_ALWAYS:
+		return 1;
+	case LOG_REFS_NORMAL:
+		return !prefixcmp(refname, "refs/heads/") ||
+		       !prefixcmp(refname, "refs/remotes/") ||
+		       !prefixcmp(refname, "refs/notes/") ||
+		       !strcmp(refname, "HEAD");
+	default:
+		return 0;
+	}
+}
+
 int log_ref_setup(const char *refname, char *logfile, int bufsize)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 
 	git_snpath(logfile, bufsize, "logs/%s", refname);
-	if (log_all_ref_updates &&
-	    (!prefixcmp(refname, "refs/heads/") ||
-	     !prefixcmp(refname, "refs/remotes/") ||
-	     !prefixcmp(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	if (should_create_reflog(refname)) {
 		if (safe_create_leading_directories(logfile) < 0)
 			return error("unable to create directory for %s",
 				     logfile);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e415ee0bbf..f60196d294 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -302,4 +302,36 @@ test_expect_success \
 	'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
 	'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
 
+test_expect_success 'core.logAllRefUpdates=true does not log refs/foo/' '
+	test_config core.logAllRefUpdates true &&
+	test_commit log-true &&
+	git update-ref -m reflog-message refs/heads/logme HEAD &&
+	git update-ref -m reflog-message refs/foo/logme HEAD &&
+	{
+		echo "refs/heads/logme@{0} reflog-message"
+	} >expect &&
+	{
+		git log -g -1 --format="%gD %gs" refs/heads/logme &&
+		git log -g -1 --format="%gD %gs" refs/foo/logme
+	} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'core.logAllRefUpdates=always logs refs/foo/' '
+	test_config core.logAllRefUpdates always &&
+	test_commit log-always &&
+	git update-ref -m reflog-message refs/heads/logme HEAD &&
+	git update-ref -m reflog-message refs/foo/logme HEAD &&
+	{
+		echo "refs/heads/logme@{0} reflog-message"
+		echo "refs/foo/logme@{0} reflog-message"
+	} >expect &&
+	{
+		git log -g -1 --format="%gD %gs" refs/heads/logme &&
+		git log -g -1 --format="%gD %gs" refs/foo/logme
+	} >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
-- 
2.11.0.840.gd37c5973a

