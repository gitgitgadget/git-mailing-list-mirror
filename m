Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1875C34047
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD6B2067D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="D+PgYtDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgBRULJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:11:09 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:58738 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRULJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1582056665; bh=2+HbzB/LO0nVyr4wCi7eONdH1Y5Fx2CdqR1o5/aVkUU=;
        h=From:To:Cc:Subject:Date;
        b=D+PgYtDQTTh4Trjo1m+5fh96YQexFnCwuWLZn2fsk8N3QxmyC4I73L+hodxQh/YRu
         +SJ9sQ/eJD+EEoWvgRYF2ERDG/Xq1uMn+t/JcF/MWLRo5kgoUdbi/MDv/vNbfGK4DB
         oWBkfTyirybyenvpfvAuXWz++kM6B5KoqpKg/lvE=
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, "Jeff King" <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] push: introduce --push-option-if-able
Date:   Tue, 18 Feb 2020 15:09:14 -0500
Message-Id: <20200218200913.128519-1-sir@cmpwn.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This introduces a --push-option-if-able, and along with it updates
send-pack, transport, push, etc to track the list of push options
specified via this flag. These options will be used if the remote
supports push options, but will not cause the push operation to
terminate if the remote does not support push options.

This is desirable in the following scenario: you frequently use two git
hosts, A and B, of which only B supports push options. If you wish to
set a push option globally (via git config push.pushOptions), any
attempts to push to host A will fail, requiring you to explicitly
override it at the command line. This renders the push.pushOption
config value basically useless for a lot of users.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
Previous version of this patch made --push-option non-fatal in the face
of a server which does not support push options. Following feedback that
this might be risky when the push options are relied upon to prevent
some undesirable default behavior from occuring, I've implemented the
suggested --push-option-if-able as an alternative. Thanks to Jeff King
for the review.

It was also suggested to add remote.*.pushOption{,IfAble}, but seeing as
remote.*.pushOption is not presently supported I think this is best
saved for a later patch (it's definitely a good idea, though).

 Documentation/config/push.txt      |  6 +++++
 Documentation/git-push.txt         | 14 +++++++++++-
 Documentation/git-receive-pack.txt | 10 +++++++++
 Documentation/githooks.txt         |  3 ++-
 builtin/push.c                     | 35 +++++++++++++++++++++++++-----
 send-pack.c                        |  9 ++++++--
 send-pack.h                        |  2 +-
 submodule.c                        | 11 +++++++++-
 submodule.h                        |  1 +
 transport-helper.c                 |  3 +++
 transport.c                        |  2 ++
 transport.h                        |  5 +++++
 12 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 54871f8213..6ad0c6808a 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -99,6 +99,12 @@ This will result in only b (a and c are cleared).
 
 --
 
+push.pushOptionIfAble::
+	When no `--push-option-if-able=<option>` argument is given
+	from the command line, `git push` behaves as if each <value>
+	of this variable is given as `--push-option-if-able=<value>`.
+	In other respects, it is equivalent to push.pushOption.
+
 push.recurseSubmodules::
 	Make sure all submodule commits used by the revisions to be pushed
 	are available on a remote-tracking branch. If the value is 'check'
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3b8053447e..5f8504b05e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
-	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
+	   [-u | --set-upstream][-o <string> | --push-option=<string>]
+	   [--push-option-if-able=<string>]
 	   [--[no-]signed|--signed=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
@@ -224,6 +225,17 @@ already exists on the remote side.
 	line, the values of configuration variable `push.pushOption`
 	are used instead.
 
+--push-option-if-able=<option>::
+	Identical to --push-option, but does not terminate the push if the
+	remote does not support push options. This is useful, for example,
+	if you wish to globally enable a push option for use on a specific
+	git host, but also occasionally push to hosts which do not have
+	push options enabled. If you were to use --push-option instead,
+	pushing to the latter would cause the push to be aborted.
+	When no `--push-option-if-able=<option>` is given from the command
+	line, the values of configuration variable `push.pushOptionIfAble`
+	are used instead.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 25702ed730..992ef5784f 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -109,6 +109,16 @@ the following environment variables:
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
 
+The number of push options given on the command line of
+`git push --push-option=...` can be read from the environment
+variable `GIT_PUSH_OPTION_COUNT`, and the options themselves are
+found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
+If it is negotiated to not use the push options phase, the
+environment variables will not be set. If the client selects
+to use push options, but doesn't transmit any, the count variable
+will be set to zero, `GIT_PUSH_OPTION_COUNT=0`. In order for to receive push
+options, `receive.advertisePushOptions` must be enabled on the server.
+
 If the pre-receive hook exits with a non-zero exit status no updates
 will be performed, and the update, post-receive and post-update
 hooks will not be invoked either.  This can be useful to quickly
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3dccab5375..48103116fd 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -283,7 +283,8 @@ found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
 If it is negotiated to not use the push options phase, the
 environment variables will not be set. If the client selects
 to use push options, but doesn't transmit any, the count variable
-will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
+will be set to zero, `GIT_PUSH_OPTION_COUNT=0`. In order for to receive push
+options, `receive.advertisePushOptions` must be enabled on the server.
 
 See the section on "Quarantine Environment" in
 linkgit:git-receive-pack[1] for some caveats.
diff --git a/builtin/push.c b/builtin/push.c
index 6dbf0f0bb7..ddffb3d2f0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -60,6 +60,7 @@ static struct push_cas_option cas;
 static struct refspec rs = REFSPEC_INIT_PUSH;
 
 static struct string_list push_options_config = STRING_LIST_INIT_DUP;
+static struct string_list push_options_if_able_config = STRING_LIST_INIT_DUP;
 
 static const char *map_refspec(const char *ref,
 			       struct remote *remote, struct ref *local_refs)
@@ -389,6 +390,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 
 static int do_push(const char *repo, int flags,
 		   const struct string_list *push_options,
+		   const struct string_list *push_options_if_able,
 		   struct remote *remote)
 {
 	int i, errs;
@@ -396,7 +398,7 @@ static int do_push(const char *repo, int flags,
 	int url_nr;
 	struct refspec *push_refspec = &rs;
 
-	if (push_options->nr)
+	if (push_options->nr || push_options_if_able->nr)
 		flags |= TRANSPORT_PUSH_OPTIONS;
 
 	if (!push_refspec->nr && !(flags & TRANSPORT_PUSH_ALL)) {
@@ -411,16 +413,20 @@ static int do_push(const char *repo, int flags,
 		for (i = 0; i < url_nr; i++) {
 			struct transport *transport =
 				transport_get(remote, url[i]);
-			if (flags & TRANSPORT_PUSH_OPTIONS)
+			if (flags & TRANSPORT_PUSH_OPTIONS) {
 				transport->push_options = push_options;
+				transport->push_options_if_able = push_options_if_able;
+			}
 			if (push_with_options(transport, push_refspec, flags))
 				errs++;
 		}
 	} else {
 		struct transport *transport =
 			transport_get(remote, NULL);
-		if (flags & TRANSPORT_PUSH_OPTIONS)
+		if (flags & TRANSPORT_PUSH_OPTIONS) {
 			transport->push_options = push_options;
+			transport->push_options_if_able = push_options_if_able;
+		}
 		if (push_with_options(transport, push_refspec, flags))
 			errs++;
 	}
@@ -510,6 +516,15 @@ static int git_push_config(const char *k, const char *v, void *cb)
 			else
 				string_list_append(&push_options_config, v);
 		return 0;
+	} else if (!strcmp(k, "push.pushoptionifable")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else
+			if (!*v)
+				string_list_clear(&push_options_if_able_config, 0);
+			else
+				string_list_append(&push_options_if_able_config, v);
+		return 0;
 	} else if (!strcmp(k, "color.push")) {
 		push_use_color = git_config_colorbool(k, v);
 		return 0;
@@ -533,7 +548,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int rc;
 	const char *repo = NULL;	/* default repository */
 	struct string_list push_options_cmdline = STRING_LIST_INIT_DUP;
-	struct string_list *push_options;
+	struct string_list push_options_if_able_cmdline = STRING_LIST_INIT_DUP;
+	struct string_list *push_options, *push_options_if_able;
 	const struct string_list_item *item;
 	struct remote *remote;
 
@@ -571,6 +587,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
 		OPT_STRING_LIST('o', "push-option", &push_options_cmdline, N_("server-specific"), N_("option to transmit")),
+		OPT_STRING_LIST(0, "push-option-if-able", &push_options_if_able_cmdline, N_("server-specific"), N_("option to transmit, if supported by remote")),
 		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 				TRANSPORT_FAMILY_IPV4),
 		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
@@ -584,6 +601,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	push_options = (push_options_cmdline.nr
 		? &push_options_cmdline
 		: &push_options_config);
+	push_options_if_able = (push_options_if_able_cmdline.nr
+		? &push_options_if_able_cmdline
+		: &push_options_if_able_config);
 	set_push_cert_flags(&flags, push_cert);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
@@ -641,10 +661,15 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, push_options)
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
+	for_each_string_list_item(item, push_options_if_able)
+		if (strchr(item->string, '\n'))
+			die(_("push options must not have new line characters"));
 
-	rc = do_push(repo, flags, push_options, remote);
+	rc = do_push(repo, flags, push_options, push_options_if_able, remote);
 	string_list_clear(&push_options_cmdline, 0);
 	string_list_clear(&push_options_config, 0);
+	string_list_clear(&push_options_if_able_config, 0);
+	string_list_clear(&push_options_if_able_cmdline, 0);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/send-pack.c b/send-pack.c
index 0407841ae8..60705405f4 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -438,10 +438,13 @@ int send_pack(struct send_pack_args *args,
 
 	use_atomic = atomic_supported && args->atomic;
 
-	if (args->push_options && !push_options_supported)
+	if (args->push_options && args->push_options->nr && !push_options_supported)
 		die(_("the receiving end does not support push options"));
+	if (args->push_options_if_able && args->push_options_if_able->nr && !push_options_supported)
+		warning(_("the receiving end does not support push options"));
 
-	use_push_options = push_options_supported && args->push_options;
+	use_push_options = push_options_supported
+		&& (args->push_options || args->push_options_if_able);
 
 	if (status_report)
 		strbuf_addstr(&cap_buf, " report-status");
@@ -536,6 +539,8 @@ int send_pack(struct send_pack_args *args,
 		packet_buf_flush(&req_buf);
 		for_each_string_list_item(item, args->push_options)
 			packet_buf_write(&req_buf, "%s", item->string);
+		for_each_string_list_item(item, args->push_options_if_able)
+			packet_buf_write(&req_buf, "%s", item->string);
 	}
 
 	if (args->stateless_rpc) {
diff --git a/send-pack.h b/send-pack.h
index e148fcd960..644968ba06 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -27,7 +27,7 @@ struct send_pack_args {
 		push_cert:2,
 		stateless_rpc:1,
 		atomic:1;
-	const struct string_list *push_options;
+	const struct string_list *push_options, *push_options_if_able;
 };
 
 struct option;
diff --git a/submodule.c b/submodule.c
index 31f391d7d2..2386a2ad56 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1050,6 +1050,7 @@ static int push_submodule(const char *path,
 			  const struct remote *remote,
 			  const struct refspec *rs,
 			  const struct string_list *push_options,
+			  const struct string_list *push_options_if_able,
 			  int dry_run)
 {
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
@@ -1064,6 +1065,12 @@ static int push_submodule(const char *path,
 				argv_array_pushf(&cp.args, "--push-option=%s",
 						 item->string);
 		}
+		if (push_options_if_able && push_options_if_able->nr) {
+			const struct string_list_item *item;
+			for_each_string_list_item(item, push_options_if_able)
+				argv_array_pushf(&cp.args, "--push-option-if-able=%s",
+						 item->string);
+		}
 
 		if (remote->origin != REMOTE_UNCONFIGURED) {
 			int i;
@@ -1123,6 +1130,7 @@ int push_unpushed_submodules(struct repository *r,
 			     const struct remote *remote,
 			     const struct refspec *rs,
 			     const struct string_list *push_options,
+			     const struct string_list *push_options_if_able,
 			     int dry_run)
 {
 	int i, ret = 1;
@@ -1157,7 +1165,8 @@ int push_unpushed_submodules(struct repository *r,
 		const char *path = needs_pushing.items[i].string;
 		fprintf(stderr, _("Pushing submodule '%s'\n"), path);
 		if (!push_submodule(path, remote, rs,
-				    push_options, dry_run)) {
+				    push_options, push_options_if_able,
+				    dry_run)) {
 			fprintf(stderr, _("Unable to push submodule '%s'\n"), path);
 			ret = 0;
 		}
diff --git a/submodule.h b/submodule.h
index c81ec1a9b6..38047c7ef1 100644
--- a/submodule.h
+++ b/submodule.h
@@ -116,6 +116,7 @@ int push_unpushed_submodules(struct repository *r,
 			     const struct remote *remote,
 			     const struct refspec *rs,
 			     const struct string_list *push_options,
+			     const struct string_list *push_options_if_able,
 			     int dry_run);
 /*
  * Given a submodule path (as in the index), return the repository
diff --git a/transport-helper.c b/transport-helper.c
index 20a7185ec4..e0cf40ffa2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -865,6 +865,9 @@ static void set_common_push_options(struct transport *transport,
 		for_each_string_list_item(item, transport->push_options)
 			if (set_helper_option(transport, "push-option", item->string) != 0)
 				die(_("helper %s does not support 'push-option'"), name);
+		for_each_string_list_item(item, transport->push_options_if_able)
+			if (set_helper_option(transport, "push-option-if-able", item->string) != 0)
+				die(_("helper %s does not support 'push-option-if-able'"), name);
 	}
 }
 
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..47861a4e65 100644
--- a/transport.c
+++ b/transport.c
@@ -691,6 +691,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.push_options = transport->push_options;
+	args.push_options_if_able = transport->push_options_if_able;
 	args.url = transport->url;
 
 	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
@@ -1195,6 +1196,7 @@ int transport_push(struct repository *r,
 						      transport->remote,
 						      rs,
 						      transport->push_options,
+						      transport->push_options_if_able,
 						      pretend)) {
 				oid_array_clear(&commits);
 				trace2_region_leave("transport_push", "push_submodules", r);
diff --git a/transport.h b/transport.h
index e0131daab9..1ceeaf43fe 100644
--- a/transport.h
+++ b/transport.h
@@ -91,6 +91,11 @@ struct transport {
 	 * on the remote side, if both sides support the push options capability.
 	 */
 	const struct string_list *push_options;
+	/*
+	 * Like push_options, but if the remote does not support push options,
+	 * the push continues regardless.
+	 */
+	const struct string_list *push_options_if_able;
 
 	/*
 	 * These strings will be passed to the remote side on each command
-- 
2.25.0

