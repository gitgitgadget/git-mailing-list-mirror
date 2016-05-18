From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] upload-pack: provide a hook for running pack-objects
Date: Wed, 18 May 2016 18:45:37 -0400
Message-ID: <20160518224537.GF22443@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:45:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3ADp-0002uS-HZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbcERWpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:45:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:41579 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750736AbcERWpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:45:40 -0400
Received: (qmail 32684 invoked by uid 102); 18 May 2016 22:45:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:45:39 -0400
Received: (qmail 27731 invoked by uid 107); 18 May 2016 22:45:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:45:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 18:45:37 -0400
Content-Disposition: inline
In-Reply-To: <20160518223712.GA18317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295024>

When upload-pack serves a client request, it turns to
pack-objects to do the heavy lifting of creating a
packfile. There's no easy way to intercept the call to
pack-objects, but there are a few good reasons to want to do
so:

  1. If you're debugging a client or server issue with
     fetching, you may want to store a copy of the generated
     packfile.

  2. If you're gathering data from real-world fetches for
     performance analysis or debugging, storing a copy of
     the arguments and stdin lets you replay the pack
     generation at your leisure.

  3. You may want to insert a caching layer around
     pack-objects; it is the most CPU- and memory-intensive
     part of serving a fetch, and its output is a pure
     function[1] of its input, making it an ideal place to
     consolidate identical requests.

This patch adds a simple "hook" interface to intercept calls
to pack-objects. The new test demonstrates how it can be
used for debugging (using it for caching is a
straightforward extension; the tricky part is writing the
actual caching layer).

This hook is unlike the normal hook scripts found in the
"hooks/" directory of a repository. Because we promise that
upload-pack is safe to run in an untrusted repository, we
cannot execute arbitrary code or commands found in the
repository (neither in hooks/, nor in the config). So
instead, this hook is triggered from a config variable that
is explicitly ignored in the per-repo config.

The config variable holds the actual shell command to run as
the hook.  Another approach would be to simply treat it as a
boolean: "should I respect the upload-pack hooks in this
repo?", and then run the script from "hooks/" as we usually
do. However, that isn't as flexible; there's no way to run a
hook approved by the site administrator (e.g., in
"/etc/gitconfig") on a repository whose contents are not
trusted. The approach taken by this patch is more
fine-grained, if a little less conventional for git hooks
(it does behave similar to other configured commands like
diff.external, etc).

[1] Pack-objects isn't _actually_ a pure function. Its
    output depends on the exact packing of the object
    database, and if multi-threading is used for delta
    compression, can even differ racily. But for the
    purposes of caching, that's OK; of the many possible
    outputs for a given input, it is sufficient only that we
    output one of them.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt     | 15 +++++++++++
 t/t5544-pack-objects-hook.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c                | 13 +++++++++-
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100755 t/t5544-pack-objects-hook.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e4cd291..b9b0541 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2872,6 +2872,21 @@ uploadpack.keepAlive::
 	`uploadpack.keepAlive` seconds. Setting this option to 0
 	disables keepalive packets entirely. The default is 5 seconds.
 
+uploadpack.packObjectsHook::
+	If this option is set, when `upload-pack` would run
+	`git pack-objects` to create a packfile for a client, it will
+	run this shell command instead.  The `pack-objects` command and
+	arguments it _would_ have run (including the `git pack-objects`
+	at the beginning) are appended to the shell command. The stdin
+	and stdout of the hook are treated as if `pack-objects` itself
+	was run. I.e., `upload-pack` will feed input intended for
+	`pack-objects` to the hook, and expects a completed packfile on
+	stdout.
++
+Note that this configuration variable is ignored if it is seen in the
+repository-level config (this is a safety measure against fetching from
+untrusted repositories).
+
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
 	start, instead, with <base>. In cases where some site serves a
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
new file mode 100755
index 0000000..4357af1
--- /dev/null
+++ b/t/t5544-pack-objects-hook.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='test custom script in place of pack-objects'
+. ./test-lib.sh
+
+test_expect_success 'create some history to fetch' '
+	test_commit one &&
+	test_commit two
+'
+
+test_expect_success 'create debugging hook script' '
+	write_script .git/hook <<-\EOF
+		echo >&2 "hook running"
+		echo "$*" >hook.args
+		cat >hook.stdin
+		"$@" <hook.stdin >hook.stdout
+		cat hook.stdout
+	EOF
+'
+
+clear_hook_results () {
+	rm -rf .git/hook.* dst.git
+}
+
+test_expect_success 'hook runs via global config' '
+	clear_hook_results &&
+	test_config_global uploadpack.packObjectsHook ./hook &&
+	git clone --no-local . dst.git 2>stderr &&
+	grep "hook running" stderr
+'
+
+test_expect_success 'hook outputs are sane' '
+	# check that we recorded a usable pack
+	git index-pack --stdin <.git/hook.stdout &&
+
+	# check that we recorded args and stdin. We do not check
+	# the full argument list or the exact pack contents, as it would make
+	# the test brittle. So just sanity check that we could replay
+	# the packing procedure.
+	grep "^git" .git/hook.args &&
+	$(cat .git/hook.args) <.git/hook.stdin >replay
+'
+
+test_expect_success 'hook runs from -c config' '
+	clear_hook_results &&
+	git clone --no-local \
+	  -u "git -c uploadpack.packObjectsHook=./hook upload-pack" \
+	  . dst.git 2>stderr &&
+	grep "hook running" stderr
+'
+
+test_expect_success 'hook does not run from repo config' '
+	clear_hook_results &&
+	test_config uploadpack.packObjectsHook "./hook" &&
+	git clone --no-local . dst.git 2>stderr &&
+	! grep "hook running" stderr &&
+	test_path_is_missing .git/hook.args &&
+	test_path_is_missing .git/hook.stdin &&
+	test_path_is_missing .git/hook.stdout
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index f19444d..8979be6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -52,6 +52,7 @@ static int keepalive = 5;
 static int use_sideband;
 static int advertise_refs;
 static int stateless_rpc;
+static const char *pack_objects_hook;
 
 static void reset_timeout(void)
 {
@@ -93,6 +94,14 @@ static void create_pack_file(void)
 	int i;
 	FILE *pipe_fd;
 
+	if (!pack_objects_hook)
+		pack_objects.git_cmd = 1;
+	else {
+		argv_array_push(&pack_objects.args, pack_objects_hook);
+		argv_array_push(&pack_objects.args, "git");
+		pack_objects.use_shell = 1;
+	}
+
 	if (shallow_nr) {
 		argv_array_push(&pack_objects.args, "--shallow-file");
 		argv_array_push(&pack_objects.args, "");
@@ -115,7 +124,6 @@ static void create_pack_file(void)
 	pack_objects.in = -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
-	pack_objects.git_cmd = 1;
 
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
@@ -812,6 +820,9 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
 			keepalive = -1;
+	} else if (current_config_scope() != CONFIG_SCOPE_REPO) {
+		if (!strcmp("uploadpack.packobjectshook", var))
+			return git_config_string(&pack_objects_hook, var, value);
 	}
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
-- 
2.8.2.888.gecb1fe3
