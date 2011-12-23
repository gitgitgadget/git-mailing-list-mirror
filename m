From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [RFC PATCH] Allow cloning branches selectively
Date: Fri, 23 Dec 2011 20:13:19 +0000
Message-ID: <1324671199-7074-1-git-send-email-cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 21:13:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReBUl-0005Fb-No
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 21:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726Ab1LWUNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 15:13:25 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:40259 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757708Ab1LWUNW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 15:13:22 -0500
Received: from beez.lab.cmartin.tk (145.Red-81-38-112.dynamicIP.rima-tde.net [81.38.112.145])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 43938461AF
	for <git@vger.kernel.org>; Fri, 23 Dec 2011 21:13:14 +0100 (CET)
Received: (nullmailer pid 7111 invoked by uid 1000);
	Fri, 23 Dec 2011 20:13:19 -0000
X-Mailer: git-send-email 1.7.8.352.g876a6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187639>

Sometimes it's useful to clone only a subset of branches from a remote
we're cloning. Teach clone the --fetch option to select which branches
should get fetched.

Each --fetch sets up a fetch refspec for that branch. Previously this
was only possible by initializing a repo and manually setting up the
config.
---

This is still a WIP, as clone will still always fetch and checkout the
remote's HEAD, which leaves you with a detached HEAD if you didn't
want that branch, which is clearly a bug.

Otherwise it works as expected. A better name for this feature would
also be nice, as in git you don't clone branches but repos. Maybe
something like "selectively fetch branches on clone"? If there isn't
an outcry against this I'll add --fetch to the manpage as well.

   cmn

 builtin/clone.c          |   82 ++++++++++++++++++++++++++++++++++------------
 t/t5702-clone-options.sh |   22 +++++++++++--
 2 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 86db954..f14ca2a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -48,6 +48,17 @@ static int option_verbosity;
 static int option_progress;
 static struct string_list option_config;
 static struct string_list option_reference;
+static struct string_list option_fetch;
+static const char **refspecs;
+static int refspecs_nr;
+static int refspecs_alloc;
+
+static void add_refspec(const char *ref)
+{
+	refspecs_nr++;
+	ALLOC_GROW(refspecs, refspecs_nr, refspecs_alloc);
+	refspecs[refspecs_nr-1] = ref;
+}
 
 static int opt_parse_reference(const struct option *opt, const char *arg, int unset)
 {
@@ -88,6 +99,8 @@ static struct option builtin_clone_options[] = {
 		   "use <name> instead of 'origin' to track upstream"),
 	OPT_STRING('b', "branch", &option_branch, "branch",
 		   "checkout <branch> instead of the remote's HEAD"),
+	OPT_STRING_LIST(0, "fetch", &option_fetch, "refspec",
+		   "fetch <refspec> instead of all the branches"),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
@@ -421,13 +434,16 @@ static void remove_junk_on_signal(int signo)
 }
 
 static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec *refspec)
+		struct refspec *refspec, int refspec_nr)
 {
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
 	struct ref **tail = head ? &head->next : &local_refs;
+	int i;
+
+	for (i = 0; i < refspec_nr; i++)
+		get_fetch_map(refs, &refspec[i], &tail, 0);
 
-	get_fetch_map(refs, refspec, &tail, 0);
 	if (!option_mirror)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
 
@@ -482,7 +498,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0;
 
 	struct refspec *refspec;
-	const char *fetch_pattern;
 
 	junk_pid = getpid();
 
@@ -508,6 +523,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (option_mirror && refspecs)
+		die(_("--mirror and --fetch options are incompatible"));
+
 	if (!option_origin)
 		option_origin = "origin";
 
@@ -594,30 +612,55 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (option_bare) {
-		if (option_mirror)
+		git_config_set("core.bare", "true");
+		if (option_mirror) {
 			src_ref_prefix = "refs/";
-		strbuf_addstr(&branch_top, src_ref_prefix);
+			strbuf_addf(&key, "remote.%s.mirror", option_origin);
+			git_config_set(key.buf, "true");
+			strbuf_reset(&key);
+		}
 
-		git_config_set("core.bare", "true");
+		strbuf_addstr(&branch_top, src_ref_prefix);
 	} else {
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+	strbuf_reset(&key);
+	strbuf_addf(&key, "remote.%s.fetch", option_origin);
+
+	/* If the user didn't override it, use the default values */
+	if (option_fetch.nr == 0) {
+		strbuf_reset(&value);
+		strbuf_addf(&value, "+%s*:%s*", src_ref_prefix,
+			    branch_top.buf);
 
-	if (option_mirror || !option_bare) {
-		/* Configure the remote */
-		strbuf_addf(&key, "remote.%s.fetch", option_origin);
 		git_config_set_multivar(key.buf, value.buf, "^$", 0);
-		strbuf_reset(&key);
+		add_refspec(strbuf_detach(&value, NULL));
+	} else {
+		int i;
+		for (i = 0; i < option_fetch.nr; i++) {
+			const char *ref = option_fetch.items[i].string;
+			if (!valid_fetch_refspec(ref))
+				die(_("Not a valid fetch refspec: %s"), ref);
+
+			/* If we only got a branch name, make it a proper refspec */
+			if (!strchr(ref, ':')) {
+				strbuf_reset(&value);
+				strbuf_addf(&value, "refs/heads/%s:%s%s",
+					    ref, branch_top.buf, ref);
+				ref = value.buf;
+			}
 
-		if (option_mirror) {
-			strbuf_addf(&key, "remote.%s.mirror", option_origin);
-			git_config_set(key.buf, "true");
-			strbuf_reset(&key);
+			printf("Adding refpsec %s\n", ref);
+			git_config_set_multivar(key.buf, value.buf, "^$", 0);
+			add_refspec(strbuf_detach(&value, NULL));
 		}
+
+		strbuf_reset(&value);
+		strbuf_reset(&key);
 	}
 
+	strbuf_reset(&key);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -625,14 +668,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
-	refspec = parse_fetch_refspec(1, &fetch_pattern);
-
-	strbuf_reset(&value);
+	refspec = parse_fetch_refspec(refspecs_nr, refspecs);
 
 	if (is_local) {
 		refs = clone_local(path, git_dir);
-		mapped_refs = wanted_peer_refs(refs, refspec);
+		mapped_refs = wanted_peer_refs(refs, refspec, refspecs_nr);
 	} else {
 		struct remote *remote = remote_get(option_origin);
 		transport = transport_get(remote, remote->url[0]);
@@ -654,7 +694,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		refs = transport_get_remote_refs(transport);
 		if (refs) {
-			mapped_refs = wanted_peer_refs(refs, refspec);
+			mapped_refs = wanted_peer_refs(refs, refspec, refspecs_nr);
 			transport_fetch_refs(transport, mapped_refs);
 		}
 	}
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 02cb024..53d914f 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -8,15 +8,17 @@ test_expect_success 'setup' '
 	mkdir parent &&
 	(cd parent && git init &&
 	 echo one >file && git add file &&
-	 git commit -m one)
+	 git commit -m one &&
+	 git branch other)
 
 '
 
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&
-	(cd clone-o && git rev-parse --verify refs/remotes/foo/master)
-
+	(cd clone-o &&
+	 git rev-parse --verify refs/remotes/foo/master &&
+	 git rev-parse --verify refs/remotes/foo/other)
 '
 
 test_expect_success 'redirected clone' '
@@ -33,4 +35,18 @@ test_expect_success 'redirected clone -v' '
 
 '
 
+test_expect_success 'select one branch to fetch' '
+	git clone --progress --fetch=master "file://$(pwd)/parent" clone-select-one &&
+	(cd clone-sel &&
+	 git rev-parse --verify refs/remotes/origin/master &&
+	 test_must_fail git rev-parse --verify refs/remotes/origin/other)
+'
+
+test_expect_success 'select several branches to fetch' '
+	git clone --progress --fetch=master --fetch=other "file://$(pwd)/parent" clone-select-many &&
+	(cd clone-sel2 &&
+	 git rev-parse --verify refs/remotes/origin/master &&
+	 git rev-parse --verify refs/remotes/origin/other)
+'
+
 test_done
-- 
1.7.8.352.g876a6f
