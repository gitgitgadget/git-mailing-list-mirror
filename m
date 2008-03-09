From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add a library function to add an alternate to the
 alternates file
Date: Mon, 10 Mar 2008 00:04:19 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803092357230.3975@racer.site>
References: <alpine.LNX.1.00.0803091842100.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 00:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYUZc-0006lt-A1
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 00:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbYCIXES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 19:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbYCIXER
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 19:04:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:49904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753152AbYCIXEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 19:04:16 -0400
Received: (qmail invoked by alias); 09 Mar 2008 23:04:15 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp030) with SMTP; 10 Mar 2008 00:04:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nCNNn2rDnILd+ncjzZDQzHSroXlzbX9g0NzPNKp
	OMKqqDGT8zV69o
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803091842100.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76681>

Hi,

On Sun, 9 Mar 2008, Daniel Barkalow wrote:

> This is in the core so that, if the alternates file has already been 
> read, the addition can be parsed and put into effect for the current 
> process.

Yes, I like your two patches.

BTW so to avoid clashing, I just send what my cumulative "clean-up" patch 
for builtin-clone is:

-- snipsnap --
[PATCH] builtin-clone: misc clean-ups

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Obviously to be squashed into 10/11 (now 11/12 ;-)

	Oh, BTW I did not start to look into falling back to copying when 
	hard-linking fails, but it should be as easy as switching the 
	order of

               if (option_no_hardlinks) {
                        if (copy_file(dest, src, 0666))
                                die("failed to copy file to %s\n", dest);
               } else {
                        if (link(src, dest))
                                die("failed to create link %s\n", dest);
               }

	around, issue a "warning (...)" instead of die()ing, setting 
	option_no_hardlinks = 1, and replace the else with
	if (!option_no_hardlinks).

	But first I have to sleep (and maybe the fairies were at work when 
	I wake up...)

 builtin-clone.c |  101 ++++++++++++++++++++++++-------------------------------
 1 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 3890e12..ac5a7d0 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -128,9 +128,15 @@ static char *guess_dir_name(const char *repo, int is_bundle)
 	return xstrndup(start, end - start);
 }
 
-void setup_reference(const char *repo)
+static int is_directory(const char *path)
 {
 	struct stat buf;
+
+	return !stat(path, &buf) && S_ISDIR(buf.st_mode);
+}
+
+static void setup_reference(const char *repo)
+{
 	const char *ref_git;
 	char *ref_git_copy;
 
@@ -138,16 +144,11 @@ void setup_reference(const char *repo)
 	struct transport *transport;
 	const struct ref *extra;
 
-	if (!option_reference)
-		return;
-
 	ref_git = make_absolute_path(option_reference);
 
-	if (!stat(mkpath("%s/.git/objects", ref_git), &buf) &&
-	    S_ISDIR(buf.st_mode))
+	if (is_directory(mkpath("%s/.git/objects", ref_git)))
 		ref_git = mkpath("%s/.git", ref_git);
-	else if (stat(mkpath("%s/objects", ref_git), &buf) ||
-		 !S_ISDIR(buf.st_mode))
+	else if (!is_directory(mkpath("%s/objects", ref_git)))
 		die("reference repository '%s' is not a local directory.",
 		    option_reference);
 
@@ -166,8 +167,7 @@ void setup_reference(const char *repo)
 	free(ref_git_copy);
 }
 
-static void
-walk_objects(char *src, char *dest)
+static void copy_or_link_directory(char *src, char *dest)
 {
 	struct dirent *de;
 	struct stat buf;
@@ -196,12 +196,12 @@ walk_objects(char *src, char *dest)
 		strcpy(src + src_len + 1, de->d_name);
 		strcpy(dest + dest_len + 1, de->d_name);
 		if (stat(src, &buf)) {
-			fprintf(stderr, "failed to stat %s, ignoring\n", src);
+			warning ("failed to stat %s\n", src);
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
 			if (de->d_name[0] != '.')
-				walk_objects(src, dest);
+				copy_or_link_directory(src, dest);
 			continue;
 		}
 
@@ -217,8 +217,8 @@ walk_objects(char *src, char *dest)
 	}
 }
 
-static const struct ref *
-clone_local(const char *src_repo, const char *dest_repo)
+static const struct ref * clone_local(const char *src_repo,
+		const char *dest_repo)
 {
 	const struct ref *ret;
 	char src[PATH_MAX];
@@ -226,15 +226,14 @@ clone_local(const char *src_repo, const char *dest_repo)
 	struct remote *remote;
 	struct transport *transport;
 
-	if (option_shared) {
+	if (option_shared)
 		add_to_alternates_file(src_repo);
-	} else {
+	else {
 		snprintf(src, PATH_MAX, "%s/objects", src_repo);
 		snprintf(dest, PATH_MAX, "%s/objects", dest_repo);
-		walk_objects(src, dest);
+		copy_or_link_directory(src, dest);
 	}
 
-	fprintf(stderr, "Get for %s\n", src_repo);
 	remote = remote_get(src_repo);
 	transport = transport_get(remote, src_repo);
 	ret = transport_get_remote_refs(transport);
@@ -244,22 +243,20 @@ clone_local(const char *src_repo, const char *dest_repo)
 
 static const char *junk_work_tree;
 static const char *junk_git_dir;
-pid_t clone_pid;
+pid_t junk_pid;
 
 static void remove_junk(void)
 {
 	struct strbuf sb;
-	if (getpid() != clone_pid)
+	if (getpid() != junk_pid)
 		return;
 	strbuf_init(&sb, 0);
 	if (junk_git_dir) {
-		fprintf(stderr, "Remove junk %s\n", junk_git_dir);
 		strbuf_addstr(&sb, junk_git_dir);
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
 	}
 	if (junk_work_tree) {
-		fprintf(stderr, "Remove junk %s\n", junk_work_tree);
 		strbuf_addstr(&sb, junk_work_tree);
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
@@ -303,7 +300,8 @@ static const struct ref *locate_head(const struct ref *refs,
 	return NULL;
 }
 
-static struct ref *write_remote_refs(const struct ref *refs, struct refspec *refspec, const char *reflog)
+static struct ref *write_remote_refs(const struct ref *refs,
+		struct refspec *refspec, const char *reflog)
 {
 	struct ref *local_refs = NULL;
 	struct ref **tail = &local_refs;
@@ -332,7 +330,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	struct refspec refspec;
 
-	clone_pid = getpid();
+	junk_pid = getpid();
 
 	argc = parse_options(argc, argv, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -357,20 +355,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
-	if (path != NULL)
-		repo = xstrdup(make_absolute_path(path));
+	if (path)
+		repo = path;
 	else if (!strchr(repo_name, ':'))
 		repo = xstrdup(make_absolute_path(repo_name));
 	else
 		repo = repo_name;
-	fprintf(stderr, "repo is %s\n", repo);
 
-	if (argc == 2) {
+	if (argc == 2)
 		dir = xstrdup(argv[1]);
-	} else {
+	else
 		dir = guess_dir_name(repo_name, is_bundle);
-	}
-	fprintf(stderr, "dir is %s\n", dir);
 
 	if (!stat(dir, &buf))
 		die("destination directory '%s' already exists.", dir);
@@ -386,8 +381,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die("working tree '%s' already exists.", work_tree);
 	}
 
-	atexit(remove_junk);
-
 	if (option_bare || work_tree)
 		git_dir = xstrdup(dir);
 	else {
@@ -401,17 +394,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die("could not create work tree dir '%s'.", work_tree);
 		set_git_work_tree(work_tree);
 	}
+	junk_git_dir = git_dir;
+	atexit(remove_junk);
 
 	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
 
 	set_git_dir(make_absolute_path(git_dir));
 
 	fprintf(stderr, "Initialize %s\n", git_dir);
-	junk_git_dir = git_dir;
 	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
-	fprintf(stderr, "Okay\n");
 
-	setup_reference(git_dir);
+	if (option_reference)
+		setup_reference(git_dir);
 
 	git_config(git_default_config);
 
@@ -420,15 +414,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		git_config_set("core.bare", "true");
 	} else {
-		snprintf(branch_top, sizeof branch_top,
+		snprintf(branch_top, sizeof(branch_top),
 			 "refs/remotes/%s/", option_origin);
 
 		/* Configure the remote */
-		snprintf(key, sizeof key, "remote.%s.url", option_origin);
+		snprintf(key, sizeof(key), "remote.%s.url", option_origin);
 		git_config_set(key, repo);
 
-		snprintf(key, sizeof key, "remote.%s.fetch", option_origin);
-		snprintf(value, sizeof value, "+refs/heads/*:%s*", branch_top);
+		snprintf(key, sizeof(key), "remote.%s.fetch", option_origin);
+		snprintf(value, sizeof(value),
+				"+refs/heads/*:%s*", branch_top);
 		git_config_set_multivar(key, value, "^$", 0);
 	}
 
@@ -437,7 +432,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refspec.src = "refs/heads/";
 	refspec.dst = branch_top;
 
-	if (path != NULL && !is_bundle)
+	if (path && !is_bundle)
 		refs = clone_local(path, git_dir);
 	else {
 		struct remote *remote = remote_get(argv[0]);
@@ -452,18 +447,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (option_quiet)
 			transport->verbose = -1;
 
-		//args.no_progress = 1;
-
-		fprintf(stderr, "Get refs for %s\n", argv[0]);
 		refs = transport_get_remote_refs(transport);
-
 		transport_fetch_refs(transport, refs);
 	}
 
-	// FFFF transport_get_remote_refs() ought to be able to tell
-	// us about HEAD being a symref, and what it's to, if it
-	// actually knows.
-
 	clear_extra_refs();
 
 	mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
@@ -497,21 +484,24 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				      head_points_at->peer_ref->name,
 				      reflog_msg.buf);
 
-			snprintf(key, sizeof key, "branch.%s.remote", head);
+			snprintf(key, sizeof(key), "branch.%s.remote", head);
 			git_config_set(key, option_origin);
-			snprintf(key, sizeof key, "branch.%s.merge", head);
+			snprintf(key, sizeof(key), "branch.%s.merge", head);
 			git_config_set(key, head_points_at->name);
 		}
 	} else if (remote_head) {
 		/* Source had detached HEAD pointing somewhere. */
-		if (!option_bare)
+		if (option_bare)
+			option_no_checkout = 1;
+		else
 			update_ref(reflog_msg.buf, "HEAD",
 				   remote_head->old_sha1,
 				   NULL, REF_NODEREF, DIE_ON_ERR);
 	} else {
 		/* Nothing to checkout out */
 		if (!option_no_checkout)
-			fprintf(stderr, "Warning: Remote HEAD refers to nonexistent ref, unable to checkout.\n");
+			warning ("remote HEAD refers to nonexistent ref, "
+				"unable to checkout.\n");
 		option_no_checkout = 1;
 	}
 
@@ -525,8 +515,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		/* We need to be in the new work tree for the checkout */
 		setup_work_tree();
 
-		fprintf(stderr, "work tree now %s\n", get_git_work_tree());
-
 		fd = hold_locked_index(lock_file, 1);
 
 		memset(&opts, 0, sizeof opts);
@@ -549,7 +537,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	strbuf_release(&reflog_msg);
-	junk_work_tree = NULL;
-	junk_git_dir = NULL;
+	junk_pid = 0;
 	return 0;
 }
-- 
1.5.4.4.642.g1343.dirty
