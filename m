Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067A322C6D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568293; cv=none; b=cUYrFiBruVWVxriGBamO/gZ6X9znjA9FyKsaau2eDblYPHIY0ljl+g8YkSU7R6WgWS66AX1p/1auCoO3YyN7gym/4l2MbaUKM3WGBDX2nTx8K1ZN6kQrsiDBXoSXLfiv0W2Nq8NSCrl9SvHV/dLwjUK//aO1/WR6tp9qOkVtBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568293; c=relaxed/simple;
	bh=vvu6jzN3MUPudDlwkqxodmMZBHujCgUl06ccx4axQVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mL9S7refNO7MTQ0+RgOcqG33oQ8ghqU72QNZZirnVztJGVK8TjHsWKYo/CNiMJ6zeCtOIyTq/Ctwqvpx44QhkQs3YHRGLmpOppZezfmK8iwENyC3pDTS8T3EazVQwj6WoM9WPC2w78+uOKE0N/kWVj/hNfI/e0Z0QDwjEtbcFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fhgF625dwz9tKs;
	Fri, 27 Mar 2026 00:38:02 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
From: Wesley Schwengle <wesleys@opperschaap.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 3/3] connect: Add support for per-remote and per-namespace SSH options
Date: Thu, 26 Mar 2026 19:37:38 -0400
Message-ID: <20260326233739.2911354-4-wesleys@opperschaap.net>
In-Reply-To: <20260326233739.2911354-1-wesleys@opperschaap.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4fhgF625dwz9tKs

Git relied on external SSH configuration (e.g. `~/.ssh/config')zR
or wrapper scripts to select identity files and additional SSH options.

This commit adds support for configuring SSH options directly in
git config. Making it easier for users to select the correct identity at
their respective forges.

The following configuration is supported, in order of precedence:

  1. `remote.<name>.sshIdentityFile' and `remote.<name>.sshOpts'

  2. `core.sshIdentityFile.<owner>' and `core.sshOpts.<owner>'

     Where <owner> is derived from the repository path. Nested groups
     aren't supported: git@host:owner/repo.git becomes "owner",
     git@host:owner/group/repo.git also becomes "owner".

  3. `core.sshIdentityFile' and `core.sshOpts'

When `sshIdentityFile' is configured without `sshOpts', we inject
`-F /dev/null' to prevent selecting additional identities from
`~/.ssh/config'. If `sshOpts' are provided, it is used as-is and the
user is responsible for specifying `-F /dev/null' if desired.

This allows selecting SSH identities and options without relying on
host aliases or wrapper scripts.

Implementation details:

  * Introduce a connection context (cnx_context) to carry the remote
    name and repository owner.
  * Introduce ssh_options to encapsulate resolved SSH configuration.

Limitations:

  * Separate push/pull URLs are not supported.
  * OpenSSH is the only supported ssh implemenation.

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 Documentation/config/core.adoc   |  22 ++++
 Documentation/config/remote.adoc |   9 ++
 connect.c                        | 137 ++++++++++++++++++++-
 t/t57xx-ssh-options-config.sh    | 198 +++++++++++++++++++++++++++++++
 4 files changed, 361 insertions(+), 5 deletions(-)
 create mode 100755 t/t57xx-ssh-options-config.sh

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index a0ebf03e2e..6a221bdf3b 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -263,20 +263,42 @@ specify that no proxy be used for a given domain pattern.
 This is useful for excluding servers inside a firewall from
 proxy use, while defaulting to a common proxy for external domains.
 
 core.sshCommand::
 	If this variable is set, `git fetch` and `git push` will
 	use the specified command instead of `ssh` when they need to
 	connect to a remote system. The command is in the same form as
 	the `GIT_SSH_COMMAND` environment variable and is overridden
 	when the environment variable is set.
 
+core.sshIdentityFile::
+	Default SSH identity file to use for SSH transports. When an
+	`sshIdentityFile` is used, git adds `-o IdentitiesOnly=yes` to the ssh
+	options by default. This feature currently only supports OpenSSH.
+
+core.sshOpts::
+	Default additional options to pass to the SSH command.
+	When `sshIdentityFile` is configured without `sshOpts`, git adds `-F
+	/dev/null` to the SSH invocation.  When `sshOpts` is configured, it is
+	used as-is. This feature currently only supports OpenSSH.
+
+core.sshIdentityFile.<owner>::
+	SSH identity file to use for repositories whose path begins with
+	`<owner>`. For example, `git@host:owner/repo.git` uses `owner`.
+	Overrides `core.sshIdentityFile` when `core.sshIdentityFile.<owner>`
+	equals the owner.
+
+core.sshOpts.<owner>::
+	Default additional SSH options for repositories whose path begins
+	with `<owner>`.
+	Overrides `core.sshOpts` when `core.sshOpts.<owner>` equals the owner.
+
 core.ignoreStat::
 	If true, Git will avoid using lstat() calls to detect if files have
 	changed by setting the "assume-unchanged" bit for those tracked files
 	which it has updated identically in both the index and working tree.
 +
 When files are modified outside of Git, the user will need to stage
 the modified files explicitly (e.g. see 'Examples' section in
 linkgit:git-update-index[1]).
 Git will not normally detect changes to those files.
 +
diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..b40e30eb41 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -113,10 +113,19 @@ remote.<name>.followRemoteHEAD::
 	The default value is "create", which will create `remotes/<name>/HEAD`
 	if it exists on the remote, but not locally; this will not touch an
 	already existing local reference. Setting it to "warn" will print
 	a message if the remote has a different value than the local one;
 	in case there is no local reference, it behaves like "create".
 	A variant on "warn" is "warn-if-not-$branch", which behaves like
 	"warn", but if `HEAD` on the remote is `$branch` it will be silent.
 	Setting it to "always" will silently update `remotes/<name>/HEAD` to
 	the value on the remote.  Finally, setting it to "never" will never
 	change or create the local reference.
+
+remote.<name>.sshIdentityFile::
+	Path to the SSH identity file to use for this remote when connecting
+	over SSH. Overrides `core.sshIdentityFile` and
+	`core.sshIdentityFile.<owner>`.
+
+remote.<name>.sshOpts::
+	Additional options to pass to the SSH command for this remote.
+	Overrides `core.sshOpts` and `core.sshOpts.<owner>`.
diff --git a/connect.c b/connect.c
index 5749ddec9b..d185c1679a 100644
--- a/connect.c
+++ b/connect.c
@@ -21,20 +21,30 @@
 #include "version.h"
 #include "protocol.h"
 #include "alias.h"
 #include "bundle-uri.h"
 #include "promisor-remote.h"
 
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
 static const char *next_server_feature_value(const char *feature, size_t *len, size_t *offset);
 
+struct cnx_context {
+	char *owner;
+	const char *remote_name;
+};
+
+struct ssh_options {
+	const char *identity_file;
+	struct strvec ssh_opts;
+};
+
 static int check_ref(const char *name, unsigned int flags)
 {
 	if (!flags)
 		return 1;
 
 	if (!skip_prefix(name, "refs/", &name))
 		return 0;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
 	if ((flags & REF_NORMAL) && check_refname_format(name,
@@ -1295,34 +1305,140 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 			    version, '\0');
 	}
 
 	packet_write(fd[1], request.buf, request.len);
 
 	free(target_host);
 	strbuf_release(&request);
 	return conn;
 }
 
+static const char *get_ssh_config_values(struct cnx_context context,
+		const char *lookup) {
+	struct strbuf key = STRBUF_INIT;
+	const char *value = NULL;
+
+	if (context.remote_name) {
+		strbuf_addf(&key, "remote.%s.%s", context.remote_name, lookup);
+		if (!repo_config_get_string_tmp(the_repository, key.buf, &value)) {
+			strbuf_release(&key);
+			return value;
+		}
+		strbuf_reset(&key);
+	}
+	if (context.owner) {
+		strbuf_addf(&key, "core.%s.%s", lookup, context.owner);
+		if (!repo_config_get_string_tmp(the_repository, key.buf, &value)) {
+			strbuf_release(&key);
+			return value;
+		}
+		strbuf_reset(&key);
+	}
+	strbuf_addf(&key, "core.%s", lookup);
+	if (!repo_config_get_string_tmp(the_repository, key.buf, &value)) {
+		strbuf_release(&key);
+		return value;
+	}
+
+	strbuf_release(&key);
+	return NULL;
+}
+
+/*
+ * Returns the first path component of `path`, which the caller must free().
+ * Returns NULL if `path` is NULL or has no '/' separator.
+ */
+static char *repo_namespace(const char *path)
+{
+	const char *slash;
+
+	if (!path)
+		return NULL;
+
+	while (*path == '/')
+		path++;
+
+	slash = strchr(path, '/');
+	if (!slash)
+		return NULL;
+
+	return xstrndup(path, slash - path);
+}
+
+static struct ssh_options *get_ssh_options(struct cnx_context context)
+{
+	struct ssh_options *opts = xcalloc(1, sizeof(*opts));
+	const char *sshopts;
+	strvec_init(&opts->ssh_opts);
+
+	opts->identity_file = get_ssh_config_values(context,
+						       "sshIdentityFile");
+
+	sshopts = get_ssh_config_values(context, "sshOpts");
+
+	if (sshopts) {
+		const char **argv = NULL;
+		char *cmdline = xstrdup(sshopts);
+		int argc = split_cmdline(cmdline, &argv);
+		int i;
+
+		if (argc < 0)
+			die(_("bad sshOpts value: '%s'"), sshopts);
+
+		for (i = 0; i < argc; i++)
+			strvec_push(&opts->ssh_opts, argv[i]);
+
+		free((void *)argv);
+		free(cmdline);
+	}
+
+	return opts;
+}
+
+static void clear_ssh_options(struct ssh_options *opts)
+{
+	strvec_clear(&opts->ssh_opts);
+	free(opts);
+}
+
 /*
  * Append the appropriate environment variables to `env` and options to
  * `args` for running ssh in Git's SSH-tunneled transport.
  */
 static void push_ssh_options(struct strvec *args, struct strvec *env,
 			     enum ssh_variant variant, const char *port,
-			     enum protocol_version version, int flags)
+			     enum protocol_version version,
+			     struct ssh_options *ssh_options, int flags)
 {
 	if (variant == VARIANT_SSH &&
 	    version > 0) {
 		strvec_push(args, "-o");
 		strvec_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
 		strvec_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 			     version);
+
+	}
+	if (variant == VARIANT_SSH) {
+		if (ssh_options->identity_file) {
+			strvec_push(args, "-i");
+			strvec_push(args, ssh_options->identity_file);
+			strvec_push(args, "-o");
+			strvec_push(args, "IdentitiesOnly=yes");
+		}
+
+		if (ssh_options->identity_file && !ssh_options->ssh_opts.nr) {
+			strvec_push(args, "-F");
+			strvec_push(args, "/dev/null");
+		}
+		if (ssh_options->ssh_opts.nr > 0) {
+			strvec_pushv(args, ssh_options->ssh_opts.v);
+		}
 	}
 
 	if (flags & CONNECT_IPV4) {
 		switch (variant) {
 		case VARIANT_AUTO:
 			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
 			die(_("ssh variant 'simple' does not support -4"));
 		case VARIANT_SSH:
 		case VARIANT_PLINK:
@@ -1362,21 +1478,21 @@ static void push_ssh_options(struct strvec *args, struct strvec *env,
 			strvec_push(args, "-P");
 		}
 
 		strvec_push(args, port);
 	}
 }
 
 /* Prepare a child_process for use by Git's SSH-tunneled transport. */
 static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 			  const char *port, enum protocol_version version,
-			  int flags)
+			  struct ssh_options *ssh_options, int flags)
 {
 	const char *ssh;
 	enum ssh_variant variant;
 
 	if (looks_like_command_line_option(ssh_host))
 		die(_("strange hostname '%s' blocked"), ssh_host);
 
 	ssh = get_ssh_command();
 	if (ssh) {
 		variant = determine_ssh_variant(ssh, 1);
@@ -1396,29 +1512,29 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 
 	if (variant == VARIANT_AUTO) {
 		struct child_process detect = CHILD_PROCESS_INIT;
 
 		detect.use_shell = conn->use_shell;
 		detect.no_stdin = detect.no_stdout = detect.no_stderr = 1;
 
 		strvec_push(&detect.args, ssh);
 		strvec_push(&detect.args, "-G");
 		push_ssh_options(&detect.args, &detect.env,
-				 VARIANT_SSH, port, version, flags);
+				 VARIANT_SSH, port, version, ssh_options, flags);
 		strvec_push(&detect.args, ssh_host);
 
 		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
 	}
 
 	strvec_push(&conn->args, ssh);
 	push_ssh_options(&conn->args, &conn->env, variant, port, version,
-			 flags);
+			 ssh_options, flags);
 	strvec_push(&conn->args, ssh_host);
 }
 
 /*
  * This returns the dummy child_process `no_fork` if the transport protocol
  * does not need fork(2), or a struct child_process object if it does.  Once
  * done, finish the connection with finish_connect() with the value returned
  * from this function (it is safe to call finish_connect() with NULL to
  * support the former case).
  *
@@ -1475,20 +1591,22 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		/* remove repo-local variables from the environment */
 		for (var = local_repo_env; *var; var++)
 			strvec_push(&conn->env, *var);
 
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			char *ssh_host = hostandport;
 			const char *port = NULL;
+			struct ssh_options *ssh_options;
+			struct cnx_context context;
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
 			if (!port)
 				port = get_port(ssh_host);
 
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
 				printf("Diag: protocol=%s\n", prot_name(protocol));
 				printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
@@ -1496,22 +1614,31 @@ struct child_process *git_connect(int fd[2], const char *url,
 				printf("Diag: path=%s\n", path ? path : "NULL");
 				printf("Diag: remote=%s\n", remote_name ? remote_name : "NULL");
 
 				free(hostandport);
 				free(path);
 				child_process_clear(conn);
 				free(conn);
 				strbuf_release(&cmd);
 				return NULL;
 			}
+
+			context.owner = repo_namespace(path);
+			context.remote_name = remote_name;
+			ssh_options = get_ssh_options(context);
+
 			conn->trace2_child_class = "transport/ssh";
-			fill_ssh_args(conn, ssh_host, port, version, flags);
+			fill_ssh_args(conn, ssh_host, port, version,
+				      ssh_options, flags);
+
+			clear_ssh_options(ssh_options);
+			free(context.owner);
 		} else {
 			transport_check_allowed("file");
 			conn->trace2_child_class = "transport/file";
 			if (version > 0) {
 				strvec_pushf(&conn->env,
 					     GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 					     version);
 			}
 		}
 		strvec_push(&conn->args, cmd.buf);
diff --git a/t/t57xx-ssh-options-config.sh b/t/t57xx-ssh-options-config.sh
new file mode 100755
index 0000000000..6db5c3fa0b
--- /dev/null
+++ b/t/t57xx-ssh-options-config.sh
@@ -0,0 +1,198 @@
+#!/bin/sh
+
+test_description='test git ssh options patch'
+
+. ./test-lib.sh
+
+write_script fake-ssh <<-\EOF &&
+echo "ssh: $*" >"$TRASH_DIRECTORY/ssh-output"
+exit 0
+EOF
+
+test_expect_success 'setup ssh wrapper' '
+	GIT_SSH="$PWD/fake-ssh" &&
+	export GIT_SSH &&
+	GIT_SSH_VARIANT=ssh &&
+	export GIT_SSH_VARIANT &&
+	export TRASH_DIRECTORY &&
+	>"$TRASH_DIRECTORY"/ssh-output
+'
+
+test_expect_success 'add remote' '
+	git remote add origin git@myhost:owner/repo.git
+'
+
+test_expect_success 'create branch' '
+	git commit -m "Empty commit" --allow-empty && \
+	git branch foo
+'
+
+expect_ssh () {
+	test_when_finished '(cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)' &&
+	echo "ssh: $@" >"$TRASH_DIRECTORY/ssh-expect" &&
+	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
+}
+
+test_expect_success 'core sshIdentityFile is passed to ssh w/ fetch-pack' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_must_fail git fetch-pack git@myhost:owner/repo.git &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -i /.ssh/id_test \
+		   -o IdentitiesOnly=yes -F /dev/null git@myhost \
+		   "git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshIdentityFile is passed to ssh w/ fetch-pack and ssh:// uri' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_must_fail git fetch-pack ssh://git@myhost/owner/repo.git &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -i /.ssh/id_test \
+		   -o IdentitiesOnly=yes -F /dev/null git@myhost \
+		   "git-upload-pack '\''/owner/repo.git'\''"
+'
+
+test_expect_success 'core sshIdentityFile is passed to ssh w/ send-pack' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_must_fail git send-pack git@myhost:owner/repo.git &&
+	expect_ssh -i /.ssh/id_test \
+		-o IdentitiesOnly=yes -F /dev/null git@myhost \
+		"git-receive-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshIdentityFile is passed to ssh w/ ls-remote' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_must_fail git ls-remote &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -i /.ssh/id_test \
+		-o IdentitiesOnly=yes -F /dev/null git@myhost \
+		"git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshIdentityFile is passed to ssh w/ fetch' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_must_fail git fetch &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -i /.ssh/id_test \
+		-o IdentitiesOnly=yes -F /dev/null git@myhost \
+		"git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshIdentityFile is passed to ssh w/ push' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_must_fail git push origin foo &&
+	expect_ssh -i /.ssh/id_test \
+		-o IdentitiesOnly=yes -F /dev/null git@myhost \
+		"git-receive-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshOpts is passed to ssh w/ fetch-pack' '
+	test_config core.sshOpts "-v -F /dev/null" &&
+	test_must_fail git fetch-pack git@myhost:owner/repo.git &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -v -F /dev/null git@myhost \
+		"git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshOpts is passed to ssh w/ fetch-pack and ssh:// uri' '
+	test_config core.sshOpts "-v -F /dev/null" &&
+	test_must_fail git fetch-pack ssh://git@myhost/owner/repo.git &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -v -F /dev/null git@myhost \
+		"git-upload-pack '\''/owner/repo.git'\''"
+'
+
+test_expect_success 'core sshOpts is passed to ssh w/ send-pack' '
+	test_config core.sshOpts "-v -F /dev/null" &&
+	test_must_fail git send-pack git@myhost:owner/repo.git &&
+	expect_ssh -v -F /dev/null git@myhost \
+		"git-receive-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshOpts is passed to ssh w/ ls-remote' '
+	test_config core.sshOpts "-v -F /dev/null" &&
+	test_must_fail git ls-remote &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -v -F /dev/null git@myhost \
+		"git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshOpts is passed to ssh w/ fetch' '
+	test_config core.sshOpts "-v -F /dev/null" &&
+	test_must_fail git fetch &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -v -F /dev/null git@myhost \
+		"git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'core sshOpts is passed to ssh w/ push' '
+	test_config core.sshOpts "-v -F /dev/null" &&
+	test_must_fail git push origin foo &&
+	expect_ssh -v -F /dev/null git@myhost \
+		"git-receive-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'owner overrides core on fetch-pack' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_config core.sshIdentityFile.owner /.ssh/id_test_owner &&
+	test_config core.sshOpts "-v" &&
+	test_config core.sshOpts.owner "-v -F /dev/null" &&
+	test_must_fail git fetch-pack git@myhost:owner/repo.git &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -i /.ssh/id_test_owner \
+		-o IdentitiesOnly=yes -v -F /dev/null git@myhost \
+		"git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'owner overrides core on send-pack' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_config core.sshIdentityFile.owner /.ssh/id_test_owner &&
+	test_config core.sshOpts "-v" &&
+	test_config core.sshOpts.owner "-v -F /dev/null" &&
+	test_must_fail git send-pack git@myhost:owner/repo.git &&
+	expect_ssh -i /.ssh/id_test_owner -o IdentitiesOnly=yes \
+		-v -F /dev/null git@myhost \
+		"git-receive-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'remote overrides core on ls-remote' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_config remote.origin.sshIdentityFile /.ssh/id_test_remote &&
+	test_config core.sshOpts "-v" &&
+	test_config remote.origin.sshOpts "-v -F /dev/null" &&
+	test_must_fail git ls-remote &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -i /.ssh/id_test_remote \
+		-o IdentitiesOnly=yes -v -F /dev/null git@myhost \
+		"git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'remote overrides core on fetch' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_config remote.origin.sshIdentityFile /.ssh/id_test_remote &&
+	test_config core.sshOpts "-v" &&
+	test_config remote.origin.sshOpts "-v -F /dev/null" &&
+	test_must_fail git fetch &&
+	expect_ssh -o SendEnv=GIT_PROTOCOL -i /.ssh/id_test_remote \
+		-o IdentitiesOnly=yes -v -F /dev/null git@myhost \
+		"git-upload-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'remote overrides core on push' '
+	test_config core.sshIdentityFile /.ssh/id_test &&
+	test_config remote.origin.sshIdentityFile /.ssh/id_test_remote &&
+	test_config core.sshOpts "-v" &&
+	test_config remote.origin.sshOpts "-v -F /dev/null" &&
+	test_must_fail git push origin foo &&
+	expect_ssh -i /.ssh/id_test_remote -o IdentitiesOnly=yes \
+		-v -F /dev/null git@myhost \
+		"git-receive-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success "remote no SSH identity file or sshOpts are not injected" '
+	test_must_fail git push origin foo &&
+	expect_ssh git@myhost "git-receive-pack '\''owner/repo.git'\''"
+'
+
+test_expect_success 'remote overrides owner on push' '
+	test_config core.sshIdentityFile.owner /.ssh/id_test &&
+	test_config remote.origin.sshIdentityFile /.ssh/id_test_remote &&
+	test_config core.sshOpts.owner "-v" &&
+	test_config remote.origin.sshOpts "-v -F /dev/null" &&
+	test_must_fail git push origin foo &&
+	expect_ssh -i /.ssh/id_test_remote -o IdentitiesOnly=yes \
+		-v -F /dev/null git@myhost \
+		"git-receive-pack '\''owner/repo.git'\''"
+'
+
+
+test_done
-- 
2.53.0.722.g8e572876c5

