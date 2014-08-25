From: Jeff King <peff@peff.net>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Mon, 25 Aug 2014 15:09:39 -0400
Message-ID: <20140825190939.GC30953@peff.net>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
 <047d7b624d36142d46050131f336@google.com>
 <20140822154151.GK20185@google.com>
 <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
 <20140822184515.GL20185@google.com>
 <20140823054646.GA18256@peff.net>
 <CAL=YDWk5FxnNWaFXJk3t+H0Q_axETmNeb=puuUqhiDBNeQVDGQ@mail.gmail.com>
 <20140825182636.GO20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:09:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLzeE-0003IN-T0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 21:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933123AbaHYTJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 15:09:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:58611 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933075AbaHYTJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 15:09:41 -0400
Received: (qmail 30354 invoked by uid 102); 25 Aug 2014 19:09:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 14:09:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 15:09:39 -0400
Content-Disposition: inline
In-Reply-To: <20140825182636.GO20185@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255854>

On Mon, Aug 25, 2014 at 11:26:36AM -0700, Jonathan Nieder wrote:

> It's still very puzzling to me.  The comment came at the same time as
> the behavior, in v0.99.9~120 (git-check-ref-format: reject funny ref
> names, 2005-10-13).  Before that, the behavior was even stranger ---
> it checked that there was exactly one slash in the argument.
> 
> I'm willing to believe we might not want that check any more, though.

Yeah, given that among experiences gits, nobody can figure out a
motivation or a history for the feature (and given that it causes
problems), I do not see any problem with loosening it.

> That way, when tools internally use other refs (e.g., FETCH_HEAD),
> git doesn't have to automatically incur the cost of maintaining the
> reflog for those.  What other refs should there be reflogs for?  I
> haven't thought carefully about this.

I think you'd in theory want a reflog for anything. The refs in
refs/tags are not meant to change, but if they do (e.g., somebody
force-pushes a tag to a server) it is nice to have a log of what
happened.  I think the same argument could apply to anything in refs/.

I think more ephemeral things (like MERGE_HEAD) tend to be in the root,
outside of refs. Reflogging those _could_ be useful, but probably isn't
(and in the case of something like FETCH_HEAD, would not record all of
the information anyway).

I wrote the patch below over a year ago and very nearly submitted it. At
GitHub we use reflogs frequently for auditing and forensics, and I
wanted to have such an audit trail for everything. However, we ended up
doing something a little more invasive that I do not think would be that
interesting to upstream (though I am happy to submit a patch if people
think otherwise): we maintain a separate "audit log" for all refs that
is never pruned, and lives on even when refs are deleted.

-- >8 --
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
Looking over the code, I am not sure that it actually works as
advertised with respect to ORIG_HEAD, etc. That would be easy enough to
fix, though.

 Documentation/config.txt |  8 +++++---
 branch.c                 |  2 +-
 builtin/checkout.c       |  2 +-
 builtin/init-db.c        |  2 +-
 cache.h                  |  9 ++++++++-
 config.c                 |  7 ++++++-
 environment.c            |  2 +-
 refs.c                   | 23 +++++++++++++++++------
 t/t1400-update-ref.sh    | 31 +++++++++++++++++++++++++++++++
 9 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c55c22a..27629df 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -405,10 +405,12 @@ core.logAllRefUpdates::
 	"$GIT_DIR/logs/<ref>", by appending the new and old
 	SHA-1, the date/time and the reason of the update, but
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
index 46e8aa8..1d140b7 100644
--- a/branch.c
+++ b/branch.c
@@ -292,7 +292,7 @@ void create_branch(const char *head,
 	}
 
 	if (reflog)
-		log_all_ref_updates = 1;
+		log_all_ref_updates = LOG_REFS_NORMAL;
 
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset to %s",
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f71e745..65bc066 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -586,7 +586,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				char *ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 
 				temp = log_all_ref_updates;
-				log_all_ref_updates = 1;
+				log_all_ref_updates = LOG_REFS_NORMAL;
 				if (log_ref_setup(ref_name, log_file, sizeof(log_file))) {
 					fprintf(stderr, _("Can not do reflog for '%s'\n"),
 					    opts->new_orphan_branch);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..ab0651f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -264,7 +264,7 @@ static int create_default_files(const char *template_path)
 		const char *work_tree = get_git_work_tree();
 		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
-		if (log_all_ref_updates == -1)
+		if (log_all_ref_updates == LOG_REFS_UNSET)
 		    git_config_set("core.logallrefupdates", "true");
 		if (!starts_with(git_dir, work_tree) ||
 		    strcmp(git_dir + strlen(work_tree), "/.git")) {
diff --git a/cache.h b/cache.h
index fcb511d..79c5ae1 100644
--- a/cache.h
+++ b/cache.h
@@ -603,7 +603,6 @@ extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
-extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern int shared_repository;
@@ -634,6 +633,14 @@ extern int core_preload_index;
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
 /*
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
diff --git a/config.c b/config.c
index 058505c..7706fdf 100644
--- a/config.c
+++ b/config.c
@@ -703,7 +703,12 @@ static int git_default_core_config(const char *var, const char *value)
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
index 565f652..3e77237 100644
--- a/environment.c
+++ b/environment.c
@@ -21,7 +21,7 @@ int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
-int log_all_ref_updates = -1; /* unspecified */
+enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int repository_format_version;
diff --git a/refs.c b/refs.c
index 27927f2..3b71e01 100644
--- a/refs.c
+++ b/refs.c
@@ -2707,7 +2707,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	lock->force_write = 1;
 	flag = log_all_ref_updates;
-	log_all_ref_updates = 0;
+	log_all_ref_updates = LOG_REFS_NONE;
 	if (write_ref_sha1(lock, orig_sha1, NULL))
 		error("unable to write current sha1 into %s", oldrefname);
 	log_all_ref_updates = flag;
@@ -2776,17 +2776,28 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+static int should_create_reflog(const char *refname)
+{
+	switch (log_all_ref_updates) {
+	case LOG_REFS_ALWAYS:
+		return 1;
+	case LOG_REFS_NORMAL:
+		return starts_with(refname, "refs/heads/") ||
+		       starts_with(refname, "refs/remotes/") ||
+		       starts_with(refname, "refs/notes/") ||
+		       !strcmp(refname, "HEAD");
+	default:
+		return 0;
+	}
+}
+
 /* This function must set a meaningful errno on failure */
 int log_ref_setup(const char *refname, char *logfile, int bufsize)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 
 	git_snpath(logfile, bufsize, "logs/%s", refname);
-	if (log_all_ref_updates &&
-	    (starts_with(refname, "refs/heads/") ||
-	     starts_with(refname, "refs/remotes/") ||
-	     starts_with(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	if (should_create_reflog(refname)) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			int save_errno = errno;
 			error("unable to create directory for %s", logfile);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 0218e96..7669917 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -983,4 +983,35 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
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
 test_done
-- 
2.1.0.346.ga0367b9
