From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: [PATCH 1/2] upload-pack: Reinstate the post-upload-pack hook
Date: Mon,  1 Feb 2010 14:02:06 +0530
Message-ID: <1265013127-12589-2-git-send-email-ford_prefect@gentoo.org>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com>
 <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org>
Cc: ford_prefect@gentoo.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 09:32:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbrhp-0000Nf-9F
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 09:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0BAIcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 03:32:15 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:60122 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689Ab0BAIcO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 03:32:14 -0500
Received: from localhost.localdomain (unknown [122.171.0.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id B71131B419C;
	Mon,  1 Feb 2010 08:32:11 +0000 (UTC)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138594>

This time, we introduce a build-time flag (ALLOW_INSECURE_HOOKS) to make
sure that anybody who wants to use these hooks is adequately warned.
---
 Documentation/git-upload-pack.txt |    2 +
 Documentation/githooks.txt        |   34 +++++++++++++++
 Makefile                          |    8 ++++
 config.mak.in                     |    1 +
 t/Makefile                        |    4 ++
 t/t5501-post-upload-pack.sh       |   69 ++++++++++++++++++++++++++++++
 upload-pack.c                     |   85 ++++++++++++++++++++++++++++++++++++-
 7 files changed, 202 insertions(+), 1 deletions(-)
 create mode 100644 t/t5501-post-upload-pack.sh

diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index b8e49dc..63f3b5c 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -20,6 +20,8 @@ The UI for the protocol is on the 'git-fetch-pack' side, and the
 program pair is meant to be used to pull updates from a remote
 repository.  For push operations, see 'git-send-pack'.
 
+After finishing the operation successfully, `post-upload-pack`
+hook is called (see linkgit:githooks[5]).
 
 OPTIONS
 -------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 29eeae7..47bcfd1 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -310,6 +310,40 @@ Both standard output and standard error output are forwarded to
 'git-send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
+post-upload-pack
+----------------
+
+Note that this hook is POTENTIALLY INSECURE. It is run as the user who
+is pulling, so an attacker can make a victim run arbitrary code by
+convincing him to clone a repository. To enable this hook, git must be
+compiled with the ALLOW_INSECURE_HOOKS option.
+
+After upload-pack successfully finishes its operation, this hook is called
+for logging purposes.
+
+The hook is passed various pieces of information, one per line, from its
+standard input.  Currently the following items can be fed to the hook, but
+more types of information may be added in the future:
+
+want SHA-1::
+    40-byte hexadecimal object name the client asked to include in the
+    resulting pack.  Can occur one or more times in the input.
+
+have SHA-1::
+    40-byte hexadecimal object name the client asked to exclude from
+    the resulting pack, claiming to have them already.  Can occur zero
+    or more times in the input.
+
+time float::
+    Number of seconds spent for creating the packfile.
+
+size decimal::
+    Size of the resulting packfile in bytes.
+
+kind string:
+    Either "clone" (when the client did not give us any "have", and asked
+    for all our refs with "want"), or "fetch" (otherwise).
+
 pre-auto-gc
 ~~~~~~~~~~~
 
diff --git a/Makefile b/Makefile
index 57045de..e29eb33 100644
--- a/Makefile
+++ b/Makefile
@@ -210,6 +210,10 @@ all::
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
+# Define ALLOW_INSECURE_HOOKS to enable hooks that have security implications
+# in some setups (such as pre-/post-upload hooks that run with the user id of
+# the user who is pulling).
+#
 # Define DEFAULT_PAGER to a sensible pager command (defaults to "less") if
 # you want to use something different.  The value will be interpreted by the
 # shell at runtime when it is used.
@@ -1366,6 +1370,10 @@ ifdef USE_NED_ALLOCATOR
        COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 endif
 
+ifdef ALLOW_INSECURE_HOOKS
+	BASIC_CFLAGS += -DALLOW_INSECURE_HOOKS
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
diff --git a/config.mak.in b/config.mak.in
index 67b12f7..c5bb125 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -58,3 +58,4 @@ SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
 NO_PTHREADS=@NO_PTHREADS@
 THREADED_DELTA_SEARCH=@THREADED_DELTA_SEARCH@
 PTHREAD_LIBS=@PTHREAD_LIBS@
+ALLOW_INSECURE_HOOKS=@ALLOW_INSECURE_HOOKS@
diff --git a/t/Makefile b/t/Makefile
index bd09390..af3c99e 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -16,6 +16,10 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
+ifndef ALLOW_INSECURE_HOOKS
+	T := $(filter-out t5501-post-upload-pack.sh,$(T))
+endif
+
 all: pre-clean
 	$(MAKE) aggregate-results-and-cleanup
 
diff --git a/t/t5501-post-upload-pack.sh b/t/t5501-post-upload-pack.sh
new file mode 100644
index 0000000..d89fb51
--- /dev/null
+++ b/t/t5501-post-upload-pack.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='post upload-hook'
+
+. ./test-lib.sh
+
+LOGFILE=".git/post-upload-pack-log"
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	git reset --hard A &&
+	test_commit C &&
+	git branch prev B &&
+	mkdir -p .git/hooks &&
+	{
+		echo "#!$SHELL_PATH" &&
+		echo "cat >post-upload-pack-log"
+	} >".git/hooks/post-upload-pack" &&
+	chmod +x .git/hooks/post-upload-pack
+'
+
+test_expect_success initial '
+	rm -fr sub &&
+	git init sub &&
+	(
+		cd sub &&
+		git fetch --no-tags .. prev
+	) &&
+	want=$(sed -n "s/^want //p" "$LOGFILE") &&
+	test "$want" = "$(git rev-parse --verify B)" &&
+	! grep "^have " "$LOGFILE" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = fetch
+'
+
+test_expect_success second '
+	rm -fr sub &&
+	git init sub &&
+	(
+		cd sub &&
+		git fetch --no-tags .. prev:refs/remotes/prev &&
+		git fetch --no-tags .. master
+	) &&
+	want=$(sed -n "s/^want //p" "$LOGFILE") &&
+	test "$want" = "$(git rev-parse --verify C)" &&
+	have=$(sed -n "s/^have //p" "$LOGFILE") &&
+	test "$have" = "$(git rev-parse --verify B)" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = fetch
+'
+
+test_expect_success all '
+	rm -fr sub &&
+	HERE=$(pwd) &&
+	git init sub &&
+	(
+		cd sub &&
+		git clone "file://$HERE/.git" new
+	) &&
+	sed -n "s/^want //p" "$LOGFILE" | sort >actual &&
+	git rev-parse A B C | sort >expect &&
+	test_cmp expect actual &&
+	! grep "^have " "$LOGFILE" &&
+	kind=$(sed -n "s/^kind //p" "$LOGFILE") &&
+	test "$kind" = clone
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index df15181..c992cb4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -41,6 +41,11 @@ static int use_sideband;
 static int debug_fd;
 static int advertise_refs;
 static int stateless_rpc;
+#ifdef ALLOW_INSECURE_HOOKS
+static int allow_insecure_hooks = 1;
+#else
+static int allow_insecure_hooks = 0;
+#endif
 
 static void reset_timeout(void)
 {
@@ -148,8 +153,69 @@ static int do_rev_list(int fd, void *create_full_pack)
 	return 0;
 }
 
+static int feed_msg_to_hook(int fd, const char *fmt, ...)
+{
+	int cnt;
+	char buf[1024];
+	va_list params;
+
+	va_start(params, fmt);
+	cnt = vsprintf(buf, fmt, params);
+	va_end(params);
+	return write_in_full(fd, buf, cnt) != cnt;
+}
+
+static int feed_obj_to_hook(const char *label, struct object_array *oa, int i, int fd)
+{
+	return feed_msg_to_hook(fd, "%s %s\n", label,
+				sha1_to_hex(oa->objects[i].item->sha1));
+}
+
+static int run_post_upload_pack_hook(size_t total, struct timeval *tv)
+{
+	const char *argv[2];
+	struct child_process proc;
+	int err, i;
+
+	argv[0] = "hooks/post-upload-pack";
+	argv[1] = NULL;
+
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	if (!allow_insecure_hooks)
+		return 1;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.in = -1;
+	proc.stdout_to_stderr = 1;
+	err = start_command(&proc);
+	if (err)
+		return err;
+	for (i = 0; !err && i < want_obj.nr; i++)
+		err |= feed_obj_to_hook("want", &want_obj, i, proc.in);
+	for (i = 0; !err && i < have_obj.nr; i++)
+		err |= feed_obj_to_hook("have", &have_obj, i, proc.in);
+	if (!err)
+		err |= feed_msg_to_hook(proc.in, "time %ld.%06ld\n",
+					(long)tv->tv_sec, (long)tv->tv_usec);
+	if (!err)
+		err |= feed_msg_to_hook(proc.in, "size %ld\n", (long)total);
+	if (!err)
+		err |= feed_msg_to_hook(proc.in, "kind %s\n",
+					(nr_our_refs == want_obj.nr && !have_obj.nr)
+					? "clone" : "fetch");
+	if (close(proc.in))
+		err = 1;
+	if (finish_command(&proc))
+		err = 1;
+	return err;
+}
+
 static void create_pack_file(void)
 {
+	struct timeval start_tv, tv;
 	struct async rev_list;
 	struct child_process pack_objects;
 	int create_full_pack = (nr_our_refs == want_obj.nr && !have_obj.nr);
@@ -158,9 +224,13 @@ static void create_pack_file(void)
 		"corruption on the remote side.";
 	int buffered = -1;
 	ssize_t sz;
+	ssize_t total_sz;
 	const char *argv[10];
 	int arg = 0;
 
+	gettimeofday(&start_tv, NULL);
+	total_sz = 0;
+
 	if (shallow_nr) {
 		rev_list.proc = do_rev_list;
 		rev_list.data = 0;
@@ -286,7 +356,7 @@ static void create_pack_file(void)
 			sz = xread(pack_objects.out, cp,
 				  sizeof(data) - outsz);
 			if (0 < sz)
-				;
+				total_sz += sz;
 			else if (sz == 0) {
 				close(pack_objects.out);
 				pack_objects.out = -1;
@@ -323,6 +393,19 @@ static void create_pack_file(void)
 	}
 	if (use_sideband)
 		packet_flush(1);
+
+	if (allow_insecure_hooks) {
+		gettimeofday(&tv, NULL);
+		tv.tv_sec -= start_tv.tv_sec;
+		if (tv.tv_usec < start_tv.tv_usec) {
+			tv.tv_sec--;
+			tv.tv_usec += 1000000;
+		}
+		tv.tv_usec -= start_tv.tv_usec;
+		if (run_upload_pack_hook(1, total_sz, &tv))
+			warning("Running post-upload-hook failed");
+	}
+
 	return;
 
  fail:
-- 
1.6.6.1
