Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB843BBD9
	for <git@vger.kernel.org>; Wed, 15 May 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806391; cv=none; b=reWd7TWObduahhCDx+gUHiz6amBeutnDqeyFseGB70R5s/abGGK9hfTJgjEuMPDAJvRQnXbm3v8fg+NlTFTnXa8Lbp3F4AKeqRagjWX2wFkVv8frS8X8NsbXXIGlcd4Rar+pXaFaerT7Th/fJJHONg6s+R/RUbih5FMU3CUwKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806391; c=relaxed/simple;
	bh=y7iuTQqsPMJHhV4RqvI9dtz/2rFxX92G6n3iFTtYRqg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPbY0ShweOGgglaghf4mWKrTUJs8l22jOlP3F3qnTzyIFyOMsw4LqeiKmxXes+c72jtNEMeRoHiUx7tuYa/EC7BJ02iSIYt7OS+aIXzWjrObDgUmoF8Ko9yE4VtI9H6uJnJGsD2lIcAtG5PiiWuLRaktFMcxeHtWSF/GMkO3oIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YemDuVJo; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YemDuVJo"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2472E1F605;
	Wed, 15 May 2024 16:48:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=y7iuTQqsPMJHhV4RqvI9dtz/2
	rFxX92G6n3iFTtYRqg=; b=YemDuVJoq49S/v49BOAGtrABjlg8SBkrSlz7HfK7i
	usqHWcL0RygWv3LFYxKLqzCkUOPwISu5NJTit0o4b7ssY3HvHkfwyh03S6/sWApJ
	wlUdNvCRuim55lOP0Dbap3QsGC7bvdZOfHPT5QQRcP38KZESQxPaL6yOju8D+xDo
	Fg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C43A1F604;
	Wed, 15 May 2024 16:48:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A5321F603;
	Wed, 15 May 2024 16:48:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFC PATCH] trace2: completely compiling out trace2 subsystem
Date: Wed, 15 May 2024 13:48:54 -0700
Message-ID: <xmqqle4avm15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8B92F2C6-12FC-11EF-BD24-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

This patch is primarily for fun value to see how much overhead we
are incurring when trace2 is compiled in but not activated with
GIT_TRACE2_* environment variables.  You can build with

	$ make NO_TRACE2=3DNoThanks

In the following "hyperfine" output, invocations of "git" are
running "git" built from the tip of 'master', and invocations of
"./git" are running one built with this patch.

Obviously the overhead is more prominent for trivial commands, like
cat-file of a single object:

Benchmark 1: git cat-file commit HEAD
  Time (mean =C2=B1 =CF=83):       9.6 ms =C2=B1   0.3 ms    [User: 0.9 m=
s, System: 9.3 ms]
  Range (min =E2=80=A6 max):     9.1 ms =E2=80=A6  11.5 ms    256 runs
=20
Benchmark 1: ./git cat-file commit HEAD
  Time (mean =C2=B1 =CF=83):       9.0 ms =C2=B1   0.2 ms    [User: 0.8 m=
s, System: 9.0 ms]
  Range (min =E2=80=A6 max):     8.6 ms =E2=80=A6   9.9 ms    264 runs

or asking the name of a single rev:

Benchmark 1: git rev-parse HEAD
  Time (mean =C2=B1 =CF=83):       6.4 ms =C2=B1   0.3 ms    [User: 0.7 m=
s, System: 6.5 ms]
  Range (min =E2=80=A6 max):     6.0 ms =E2=80=A6   8.4 ms    367 runs
=20
Benchmark 1: ./git rev-parse HEAD
  Time (mean =C2=B1 =CF=83):       6.0 ms =C2=B1   0.2 ms    [User: 0.6 m=
s, System: 6.4 ms]
  Range (min =E2=80=A6 max):     5.6 ms =E2=80=A6   7.8 ms    381 runs
=20
And the main operation of anything more involved, like showing the
topmost few commits, would dwarf the overhead out, but the
difference is still visible (about 0.6 ms, which is consistent with
the above two comparisons):

Benchmark 1: git log -5
  Time (mean =C2=B1 =CF=83):      16.9 ms =C2=B1   0.4 ms    [User: 1.6 m=
s, System: 15.8 ms]
  Range (min =E2=80=A6 max):    16.2 ms =E2=80=A6  18.6 ms    159 runs
=20
Benchmark 1: ./git log -5
  Time (mean =C2=B1 =CF=83):      16.3 ms =C2=B1   0.4 ms    [User: 1.4 m=
s, System: 15.5 ms]
  Range (min =E2=80=A6 max):    15.8 ms =E2=80=A6  17.6 ms    165 runs

Because quite a lot of parts of our test suite, besides the obvious
ones like t0210 that are about testing trace2 output, depend on
reading and parsing output from trace2, this patch will break quite
a many of them.  If people feel that an option to completely compile
out the trace2 subsystem is worth adding, these test breakages would
need to be fixed before this main change can be merged.

This patch invents a prerequisite "TRACE2" to help these tests that
rely on the availability of trace2 subsystem and marks just one such
tests that depends on it as an example.

Also, I have no confidence in stubbing out the compat/stub and
compat/win32 versions of procinfo stuff done by this patch.  Again,
if people are interested in this option, those with access to Win32
and !HAVE_PLATFORM_PROCINFO platforms need to tip into the effort.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                                 |  10 +
 compat/linux/procinfo.c                  |   2 +
 compat/stub/procinfo.c                   |   2 +
 compat/win32/trace2_win32_process_info.c |   2 +
 t/t0017-env-helper.sh                    |   2 +-
 t/test-lib.sh                            |   1 +
 trace2.c                                 |   4 +
 trace2.h                                 | 311 ++++++++++++++++++++---
 8 files changed, 294 insertions(+), 40 deletions(-)

diff --git a/Makefile b/Makefile
index cf504963c2..71f78a5854 100644
--- a/Makefile
+++ b/Makefile
@@ -553,6 +553,11 @@ include shared.mak
 # If don't enable any of the *_SHA256 settings in this section, Git
 # will default to its built-in sha256 implementation.
 #
+# =3D=3D Privacy? =3D=3D
+#
+# Define NO_TRACE2 to completely compile out the trace2 subsystem
+# to avoid leaking trace log to anywhere.
+#
 # =3D=3D DEVELOPER defines =3D=3D
 #
 # Define DEVELOPER to enable more compiler warnings. Compiler version
@@ -1539,6 +1544,10 @@ ifneq (,$(INLINE))
 	BASIC_CFLAGS +=3D -Dinline=3D$(INLINE)
 endif
=20
+ifneq (,$(NO_TRACE2))
+	BASIC_CFLAGS +=3D -DNO_TRACE2
+endif
+
 ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS +=3D -Dsocklen_t=3D$(SOCKLEN_T)
 endif
@@ -3134,6 +3143,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PTHREADS=3D\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\=
' >>$@+
 	@echo NO_PYTHON=3D\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>=
$@+
 	@echo NO_REGEX=3D\''$(subst ','\'',$(subst ','\'',$(NO_REGEX)))'\' >>$@=
+
+	@echo NO_TRACE2=3D\''$(subst ','\'',$(subst ','\'',$(NO_TRACE2)))'\' >>=
$@+
 	@echo NO_UNIX_SOCKETS=3D\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCK=
ETS)))'\' >>$@+
 	@echo PAGER_ENV=3D\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>=
$@+
 	@echo SANITIZE_LEAK=3D\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)=
))'\' >>$@+
diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 4bb2d66227..c30080fc59 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -42,6 +42,7 @@
  */
 #define STAT_PARENT_PID_READ_N 64
=20
+#ifndef NO_TRACE2
 static int parse_proc_stat(struct strbuf *sb, struct strbuf *name,
 			    int *statppid)
 {
@@ -174,3 +175,4 @@ void trace2_collect_process_info(enum trace2_process_=
info_reason reason)
=20
 	return;
 }
+#endif
diff --git a/compat/stub/procinfo.c b/compat/stub/procinfo.c
index 12c0a23c9e..933f20c628 100644
--- a/compat/stub/procinfo.c
+++ b/compat/stub/procinfo.c
@@ -2,6 +2,7 @@
=20
 #include "trace2.h"
=20
+#ifndef NO_TRACE2
 /*
  * Stub. See sample implementations in compat/linux/procinfo.c and
  * compat/win32/trace2_win32_process_info.c.
@@ -9,3 +10,4 @@
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
 {
 }
+#endif
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trac=
e2_win32_process_info.c
index 3ef0936f6f..d73cb71b08 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -6,6 +6,7 @@
 #include <psapi.h>
 #include <tlhelp32.h>
=20
+#ifndef NO_TRACE2
 /*
  * An arbitrarily chosen value to limit the size of the ancestor
  * array built in git_processes().
@@ -191,3 +192,4 @@ void trace2_collect_process_info(enum trace2_process_=
info_reason reason)
 		BUG("trace2_collect_process_info: unknown reason '%d'", reason);
 	}
 }
+#endif
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index fc14ba091c..13780b376e 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -81,7 +81,7 @@ test_expect_success 'test-tool env-helper --type=3Dulon=
g' '
 	test_must_be_empty actual.err
 '
=20
-test_expect_success 'test-tool env-helper reads config thanks to trace2'=
 '
+test_expect_success TRACE2 'test-tool env-helper reads config thanks to =
trace2' '
 	mkdir home &&
 	git config -f home/.gitconfig include.path cycle &&
 	git config -f home/cycle include.path .gitconfig &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 79d3e0e7d9..ab314049e0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1773,6 +1773,7 @@ test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
 test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
+test -z "$NO_TRACE2" && test_set_prereq TRACE2
=20
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
diff --git a/trace2.c b/trace2.c
index f894532d05..08537cea01 100644
--- a/trace2.c
+++ b/trace2.c
@@ -16,6 +16,8 @@
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
=20
+#ifndef NO_TRACE2
+
 static int trace2_enabled;
 static int trace2_redact =3D 1;
=20
@@ -1040,3 +1042,5 @@ const char *trace2_session_id(void)
 {
 	return tr2_sid_get();
 }
+
+#endif
diff --git a/trace2.h b/trace2.h
index 1f0669bbd2..53eb44a032 100644
--- a/trace2.h
+++ b/trace2.h
@@ -35,6 +35,12 @@
  *
  */
=20
+#ifdef NO_TRACE2
+#define EXTERN_ static inline
+#else
+#define EXTERN_ /* nothing */
+#endif
+
 struct child_process;
 struct repository;
 struct json_writer;
@@ -70,7 +76,7 @@ struct json_writer;
  * The main trace2_initialize_fl() may be called a little later
  * after more infrastructure is established.
  */
-void trace2_initialize_clock(void);
+EXTERN_ void trace2_initialize_clock(void);
=20
 /*
  * Initialize TRACE2 tracing facility if any of the builtin TRACE2
@@ -84,26 +90,26 @@ void trace2_initialize_clock(void);
  * Cleanup/Termination is handled automatically by a registered
  * atexit() routine.
  */
-void trace2_initialize_fl(const char *file, int line);
+EXTERN_ void trace2_initialize_fl(const char *file, int line);
=20
 #define trace2_initialize() trace2_initialize_fl(__FILE__, __LINE__)
=20
 /*
  * Return 1 if trace2 is enabled (at least one target is active).
  */
-int trace2_is_enabled(void);
+EXTERN_ int trace2_is_enabled(void);
=20
 /*
  * Emit a 'start' event with the original (unmodified) argv.
  */
-void trace2_cmd_start_fl(const char *file, int line, const char **argv);
+EXTERN_ void trace2_cmd_start_fl(const char *file, int line, const char =
**argv);
=20
 #define trace2_cmd_start(argv) trace2_cmd_start_fl(__FILE__, __LINE__, (=
argv))
=20
 /*
  * Emit an 'exit' event.
  */
-void trace2_cmd_exit_fl(const char *file, int line, int code);
+EXTERN_ void trace2_cmd_exit_fl(const char *file, int line, int code);
=20
 #define trace2_cmd_exit(code) (trace2_cmd_exit_fl(__FILE__, __LINE__, (c=
ode)))
=20
@@ -112,7 +118,7 @@ void trace2_cmd_exit_fl(const char *file, int line, i=
nt code);
  *
  * Write an error message to the TRACE2 targets.
  */
-void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
+EXTERN_ void trace2_cmd_error_va_fl(const char *file, int line, const ch=
ar *fmt,
 			    va_list ap);
=20
 #define trace2_cmd_error_va(fmt, ap) \
@@ -124,7 +130,7 @@ void trace2_cmd_error_va_fl(const char *file, int lin=
e, const char *fmt,
  * having to parse the argv.  For example, to distinguish invocations fr=
om
  * installed versus debug executables.
  */
-void trace2_cmd_path_fl(const char *file, int line, const char *pathname=
);
+EXTERN_ void trace2_cmd_path_fl(const char *file, int line, const char *=
pathname);
=20
 #define trace2_cmd_path(p) trace2_cmd_path_fl(__FILE__, __LINE__, (p))
=20
@@ -134,7 +140,7 @@ void trace2_cmd_path_fl(const char *file, int line, c=
onst char *pathname);
  * This gives post-processors a way to determine what invoked the comman=
d and
  * learn more about usage patterns.
  */
-void trace2_cmd_ancestry_fl(const char *file, int line, const char **par=
ent_names);
+EXTERN_ void trace2_cmd_ancestry_fl(const char *file, int line, const ch=
ar **parent_names);
=20
 #define trace2_cmd_ancestry(v) trace2_cmd_ancestry_fl(__FILE__, __LINE__=
, (v))
=20
@@ -143,7 +149,7 @@ void trace2_cmd_ancestry_fl(const char *file, int lin=
e, const char **parent_name
  * This gives post-processors a simple field to identify the command
  * without having to parse the argv.
  */
-void trace2_cmd_name_fl(const char *file, int line, const char *name);
+EXTERN_ void trace2_cmd_name_fl(const char *file, int line, const char *=
name);
=20
 #define trace2_cmd_name(v) trace2_cmd_name_fl(__FILE__, __LINE__, (v))
=20
@@ -153,7 +159,7 @@ void trace2_cmd_name_fl(const char *file, int line, c=
onst char *name);
  * different branch.  This gives post-processors a simple field to compa=
re
  * equivalent commands without having to parse the argv.
  */
-void trace2_cmd_mode_fl(const char *file, int line, const char *mode);
+EXTERN_ void trace2_cmd_mode_fl(const char *file, int line, const char *=
mode);
=20
 #define trace2_cmd_mode(sv) trace2_cmd_mode_fl(__FILE__, __LINE__, (sv))
=20
@@ -161,7 +167,7 @@ void trace2_cmd_mode_fl(const char *file, int line, c=
onst char *mode);
  * Emits an "alias" message containing the alias used and the argument
  * expansion.
  */
-void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
+EXTERN_ void trace2_cmd_alias_fl(const char *file, int line, const char =
*alias,
 			 const char **argv);
=20
 #define trace2_cmd_alias(alias, argv) \
@@ -183,7 +189,7 @@ void trace2_cmd_alias_fl(const char *file, int line, =
const char *alias,
  * location of the git and worktree directories, expansion of any "-c"
  * and "-C" command line options, and etc.
  */
-void trace2_cmd_list_config_fl(const char *file, int line);
+EXTERN_ void trace2_cmd_list_config_fl(const char *file, int line);
=20
 #define trace2_cmd_list_config() trace2_cmd_list_config_fl(__FILE__, __L=
INE__)
=20
@@ -196,7 +202,7 @@ void trace2_cmd_list_config_fl(const char *file, int =
line);
  * or:
  *     GIT_TRACE2_ENV_VARS=3D"GIT_HTTP_USER_AGENT,GIT_CONFIG"
  */
-void trace2_cmd_list_env_vars_fl(const char *file, int line);
+EXTERN_ void trace2_cmd_list_env_vars_fl(const char *file, int line);
=20
 #define trace2_cmd_list_env_vars() trace2_cmd_list_env_vars_fl(__FILE__,=
 __LINE__)
=20
@@ -207,7 +213,7 @@ void trace2_cmd_list_env_vars_fl(const char *file, in=
t line);
  * Use this for new/updated config settings created/updated after
  * trace2_cmd_list_config() is called.
  */
-void trace2_cmd_set_config_fl(const char *file, int line, const char *ke=
y,
+EXTERN_ void trace2_cmd_set_config_fl(const char *file, int line, const =
char *key,
 			      const char *value);
=20
 #define trace2_cmd_set_config(k, v) \
@@ -227,7 +233,7 @@ void trace2_cmd_set_config_fl(const char *file, int l=
ine, const char *key,
  *
  * This function should be called before spawning the child process.
  */
-void trace2_child_start_fl(const char *file, int line,
+EXTERN_ void trace2_child_start_fl(const char *file, int line,
 			   struct child_process *cmd);
=20
 #define trace2_child_start(cmd) trace2_child_start_fl(__FILE__, __LINE__=
, (cmd))
@@ -242,7 +248,7 @@ void trace2_child_start_fl(const char *file, int line=
,
  *
  * This function should be called after reaping the child process.
  */
-void trace2_child_exit_fl(const char *file, int line, struct child_proce=
ss *cmd,
+EXTERN_ void trace2_child_exit_fl(const char *file, int line, struct chi=
ld_process *cmd,
 			  int child_exit_code);
=20
 #define trace2_child_exit(cmd, code) \
@@ -266,7 +272,7 @@ void trace2_child_exit_fl(const char *file, int line,=
 struct child_process *cmd,
  * regular "child_exit" to report the normal process exit information.
  *
  */
-void trace2_child_ready_fl(const char *file, int line,
+EXTERN_ void trace2_child_ready_fl(const char *file, int line,
 			   struct child_process *cmd,
 			   const char *ready);
=20
@@ -283,7 +289,7 @@ void trace2_child_ready_fl(const char *file, int line=
,
  * Returns a unique "exec-id".  This value is used later
  * if the exec() fails and a "exec-result" message is necessary.
  */
-int trace2_exec_fl(const char *file, int line, const char *exe,
+EXTERN_ int trace2_exec_fl(const char *file, int line, const char *exe,
 		   const char **argv);
=20
 #define trace2_exec(exe, argv) trace2_exec_fl(__FILE__, __LINE__, (exe),=
 (argv))
@@ -296,7 +302,7 @@ int trace2_exec_fl(const char *file, int line, const =
char *exe,
  *
  * The "exec_id" should be the value returned from trace2_exec().
  */
-void trace2_exec_result_fl(const char *file, int line, int exec_id, int =
code);
+EXTERN_ void trace2_exec_result_fl(const char *file, int line, int exec_=
id, int code);
=20
 #define trace2_exec_result(id, code) \
 	trace2_exec_result_fl(__FILE__, __LINE__, (id), (code))
@@ -310,7 +316,7 @@ void trace2_exec_result_fl(const char *file, int line=
, int exec_id, int code);
  * taken from the thread-proc function.  A unique thread name will be
  * created from the given base name and the thread id automatically.
  */
-void trace2_thread_start_fl(const char *file, int line,
+EXTERN_ void trace2_thread_start_fl(const char *file, int line,
 			    const char *thread_base_name);
=20
 #define trace2_thread_start(thread_base_name) \
@@ -321,7 +327,7 @@ void trace2_thread_start_fl(const char *file, int lin=
e,
  * thread-proc so that the thread can access and clean up its
  * thread-local storage.
  */
-void trace2_thread_exit_fl(const char *file, int line);
+EXTERN_ void trace2_thread_exit_fl(const char *file, int line);
=20
 #define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
=20
@@ -334,7 +340,7 @@ struct key_value_info;
  * significantly affects program performance or behavior, such as
  * `core.abbrev`, `status.showUntrackedFiles`, or `--no-ahead-behind`.
  */
-void trace2_def_param_fl(const char *file, int line, const char *param,
+EXTERN_ void trace2_def_param_fl(const char *file, int line, const char =
*param,
 			 const char *value, const struct key_value_info *kvi);
=20
 #define trace2_def_param(param, value, kvi) \
@@ -353,7 +359,7 @@ void trace2_def_param_fl(const char *file, int line, =
const char *param,
  * The repo-id field is in anticipation of future in-proc submodule
  * repositories.
  */
-void trace2_def_repo_fl(const char *file, int line, struct repository *r=
epo);
+EXTERN_ void trace2_def_repo_fl(const char *file, int line, struct repos=
itory *repo);
=20
 #define trace2_def_repo(repo) trace2_def_repo_fl(__FILE__, __LINE__, rep=
o)
=20
@@ -375,13 +381,13 @@ void trace2_def_repo_fl(const char *file, int line,=
 struct repository *repo);
  * The `repo` field, if set, will be used to get the "repo-id", so that
  * recursive operations can be attributed to the correct repository.
  */
-void trace2_region_enter_fl(const char *file, int line, const char *cate=
gory,
+EXTERN_ void trace2_region_enter_fl(const char *file, int line, const ch=
ar *category,
 			    const char *label, const struct repository *repo, ...);
=20
 #define trace2_region_enter(category, label, repo) \
 	trace2_region_enter_fl(__FILE__, __LINE__, (category), (label), (repo))
=20
-void trace2_region_enter_printf_va_fl(const char *file, int line,
+EXTERN_ void trace2_region_enter_printf_va_fl(const char *file, int line=
,
 				      const char *category, const char *label,
 				      const struct repository *repo,
 				      const char *fmt, va_list ap);
@@ -390,7 +396,7 @@ void trace2_region_enter_printf_va_fl(const char *fil=
e, int line,
 	trace2_region_enter_printf_va_fl(__FILE__, __LINE__, (category), \
 					 (label), (repo), (fmt), (ap))
=20
-void trace2_region_enter_printf_fl(const char *file, int line,
+EXTERN_ void trace2_region_enter_printf_fl(const char *file, int line,
 				   const char *category, const char *label,
 				   const struct repository *repo,
 				   const char *fmt, ...);
@@ -411,13 +417,13 @@ void trace2_region_enter_printf_fl(const char *file=
, int line,
  * need to match the corresponding "region_enter" message,
  * but it makes the data stream easier to understand.
  */
-void trace2_region_leave_fl(const char *file, int line, const char *cate=
gory,
+EXTERN_ void trace2_region_leave_fl(const char *file, int line, const ch=
ar *category,
 			    const char *label, const struct repository *repo, ...);
=20
 #define trace2_region_leave(category, label, repo) \
 	trace2_region_leave_fl(__FILE__, __LINE__, (category), (label), (repo))
=20
-void trace2_region_leave_printf_va_fl(const char *file, int line,
+EXTERN_ void trace2_region_leave_printf_va_fl(const char *file, int line=
,
 				      const char *category, const char *label,
 				      const struct repository *repo,
 				      const char *fmt, va_list ap);
@@ -426,7 +432,7 @@ void trace2_region_leave_printf_va_fl(const char *fil=
e, int line,
 	trace2_region_leave_printf_va_fl(__FILE__, __LINE__, (category), \
 					 (label), (repo), (fmt), (ap))
=20
-void trace2_region_leave_printf_fl(const char *file, int line,
+EXTERN_ void trace2_region_leave_printf_fl(const char *file, int line,
 				   const char *category, const char *label,
 				   const struct repository *repo,
 				   const char *fmt, ...);
@@ -446,7 +452,7 @@ void trace2_region_leave_printf_fl(const char *file, =
int line,
  * for post-processing.  On printf-based TRACE2 targets, this is convert=
ed
  * into a fixed-format printf message.
  */
-void trace2_data_string_fl(const char *file, int line, const char *categ=
ory,
+EXTERN_ void trace2_data_string_fl(const char *file, int line, const cha=
r *category,
 			   const struct repository *repo, const char *key,
 			   const char *value);
=20
@@ -454,7 +460,7 @@ void trace2_data_string_fl(const char *file, int line=
, const char *category,
 	trace2_data_string_fl(__FILE__, __LINE__, (category), (repo), (key), \
 			      (value))
=20
-void trace2_data_intmax_fl(const char *file, int line, const char *categ=
ory,
+EXTERN_ void trace2_data_intmax_fl(const char *file, int line, const cha=
r *category,
 			   const struct repository *repo, const char *key,
 			   intmax_t value);
=20
@@ -462,7 +468,7 @@ void trace2_data_intmax_fl(const char *file, int line=
, const char *category,
 	trace2_data_intmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
 			      (value))
=20
-void trace2_data_json_fl(const char *file, int line, const char *categor=
y,
+EXTERN_ void trace2_data_json_fl(const char *file, int line, const char =
*category,
 			 const struct repository *repo, const char *key,
 			 const struct json_writer *jw);
=20
@@ -478,13 +484,13 @@ void trace2_data_json_fl(const char *file, int line=
, const char *category,
  * any formatting guidelines.  Post-processors may choose to ignore
  * them.
  */
-void trace2_printf_va_fl(const char *file, int line, const char *fmt,
+EXTERN_ void trace2_printf_va_fl(const char *file, int line, const char =
*fmt,
 			 va_list ap);
=20
 #define trace2_printf_va(fmt, ap) \
 	trace2_printf_va_fl(__FILE__, __LINE__, (fmt), (ap))
=20
-void trace2_printf_fl(const char *file, int line, const char *fmt, ...);
+EXTERN_ void trace2_printf_fl(const char *file, int line, const char *fm=
t, ...);
=20
 #define trace2_printf(...) trace2_printf_fl(__FILE__, __LINE__, __VA_ARG=
S__)
=20
@@ -527,8 +533,8 @@ enum trace2_timer_id {
  * category and timer name values are defined at compile-time in the
  * timer definitions array, so they are not needed here in the API.
  */
-void trace2_timer_start(enum trace2_timer_id tid);
-void trace2_timer_stop(enum trace2_timer_id tid);
+EXTERN_ void trace2_timer_start(enum trace2_timer_id tid);
+EXTERN_ void trace2_timer_stop(enum trace2_timer_id tid);
=20
 /*
  * Define the set of global counters.
@@ -570,7 +576,7 @@ enum trace2_counter_id {
  * available until all threads have exited, so it does not return the
  * new value of the counter.
  */
-void trace2_counter_add(enum trace2_counter_id cid, uint64_t value);
+EXTERN_ void trace2_counter_add(enum trace2_counter_id cid, uint64_t val=
ue);
=20
 /*
  * Optional platform-specific code to dump information about the
@@ -584,8 +590,235 @@ enum trace2_process_info_reason {
 	TRACE2_PROCESS_INFO_EXIT,
 };
=20
-void trace2_collect_process_info(enum trace2_process_info_reason reason)=
;
+EXTERN_ void trace2_collect_process_info(enum trace2_process_info_reason=
 reason);
+
+EXTERN_ const char *trace2_session_id(void);
+
+#ifdef NO_TRACE2
+
+static inline void trace2_initialize_clock(void)
+{
+	; /* noop */
+}
+
+static inline void trace2_initialize_fl(const char *file, int line)
+{
+	; /* noop */
+}
+
+static inline int trace2_is_enabled(void)
+{
+	return 0;
+}
+
+static inline void trace2_cmd_start_fl(const char *file, int line, const=
 char **argv)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_exit_fl(const char *file, int line, int co=
de)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_error_va_fl(const char *file, int line, co=
nst char *fmt,
+			    va_list ap)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_path_fl(const char *file, int line, const =
char *pathname)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_ancestry_fl(const char *file, int line, co=
nst char **parent_names)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_name_fl(const char *file, int line, const =
char *name)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_mode_fl(const char *file, int line, const =
char *mode)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_alias_fl(const char *file, int line, const=
 char *alias,
+			 const char **argv)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_list_config_fl(const char *file, int line)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_list_env_vars_fl(const char *file, int lin=
e)
+{
+	; /* noop */
+}
+
+static inline void trace2_cmd_set_config_fl(const char *file, int line, =
const char *key,
+			      const char *value)
+{
+	; /* noop */
+}
+
+static inline void trace2_child_start_fl(const char *file, int line,
+			   struct child_process *cmd)
+{
+	; /* noop */
+}
+
+static inline void trace2_child_exit_fl(const char *file, int line, stru=
ct child_process *cmd,
+			  int child_exit_code)
+{
+	; /* noop */
+}
+
+static inline void trace2_child_ready_fl(const char *file, int line,
+			   struct child_process *cmd,
+			   const char *ready)
+{
+	; /* noop */
+}
+
+static inline int trace2_exec_fl(const char *file, int line, const char =
*exe,
+		   const char **argv)
+{
+	return -1; /* noop */
+}
+
+static inline void trace2_exec_result_fl(const char *file, int line, int=
 exec_id, int code)
+{
+	; /* noop */
+}
+
+static inline void trace2_thread_start_fl(const char *file, int line, co=
nst char *thread_base_name)
+{
+	; /* noop */
+}
+
+static inline void trace2_thread_exit_fl(const char *file, int line)
+{
+	; /* noop */
+}
+
+static inline void trace2_def_param_fl(const char *file, int line, const=
 char *param,
+			 const char *value, const struct key_value_info *kvi)
+{
+	; /* noop */
+}
+
+static inline void trace2_def_repo_fl(const char *file, int line, struct=
 repository *repo)
+{
+	; /* noop */
+}
+
+static inline void trace2_region_enter_printf_va_fl(const char *file, in=
t line,
+				      const char *category, const char *label,
+				      const struct repository *repo,
+				      const char *fmt, va_list ap)
+{
+	; /* noop */
+}
+
+static inline void trace2_region_enter_fl(const char *file, int line, co=
nst char *category,
+			    const char *label, const struct repository *repo, ...)
+{
+	; /* noop */
+}
+
+static inline void trace2_region_enter_printf_fl(const char *file, int l=
ine,
+				   const char *category, const char *label,
+				   const struct repository *repo,
+				   const char *fmt, ...)
+{
+	; /* noop */
+}
=20
-const char *trace2_session_id(void);
+static inline void trace2_region_leave_printf_va_fl(const char *file, in=
t line,
+				      const char *category, const char *label,
+				      const struct repository *repo,
+				      const char *fmt, va_list ap)
+{
+	; /* noop */
+}
+
+static inline void trace2_region_leave_fl(const char *file, int line, co=
nst char *category,
+			    const char *label, const struct repository *repo, ...)
+{
+	; /* noop */
+}
+
+static inline void trace2_region_leave_printf_fl(const char *file, int l=
ine,
+				   const char *category, const char *label,
+				   const struct repository *repo,
+				   const char *fmt, ...)
+{
+	; /* noop */
+}
+
+static inline void trace2_data_string_fl(const char *file, int line, con=
st char *category,
+			   const struct repository *repo, const char *key,
+			   const char *value)
+{
+	; /* noop */
+}
=20
+static inline void trace2_data_intmax_fl(const char *file, int line, con=
st char *category,
+			   const struct repository *repo, const char *key,
+			   intmax_t value)
+{
+	; /* noop */
+}
+
+static inline void trace2_data_json_fl(const char *file, int line, const=
 char *category,
+			 const struct repository *repo, const char *key,
+			 const struct json_writer *value)
+{
+	; /* noop */
+}
+
+static inline void trace2_printf_va_fl(const char *file, int line, const=
 char *fmt,
+			 va_list ap)
+{
+	; /* noop */
+}
+
+static inline void trace2_printf_fl(const char *file, int line, const ch=
ar *fmt, ...)
+{
+	; /* noop */
+}
+
+static inline void trace2_timer_start(enum trace2_timer_id tid)
+{
+	; /* noop */
+}
+
+static inline void trace2_timer_stop(enum trace2_timer_id tid)
+{
+	; /* noop */
+}
+
+static inline void trace2_counter_add(enum trace2_counter_id cid, uint64=
_t value)
+{
+	; /* noop */
+}
+
+static inline void trace2_collect_process_info(enum trace2_process_info_=
reason reason)
+{
+	; /* noop */
+}
+
+static inline const char *trace2_session_id(void)
+{
+	return "nothing"; /* noop */
+}
+#endif /* NO_TRACE2 */
 #endif /* TRACE2_H */
--=20
2.45.1-190-g19fe900cfc

