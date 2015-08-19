From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 8/9] Support signing pushes iff the server supports it
Date: Wed, 19 Aug 2015 11:26:46 -0400
Message-ID: <1439998007-28719-9-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5HC-0005AP-Q3
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbHSP13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:29 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33587 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbHSP1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:21 -0400
Received: by iods203 with SMTP id s203so13024103iod.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x2yPzHh3ZEIdmCQ33j/sDoi8cKYOCoawcOUW4JYO9U0=;
        b=nWAOfbTrKZedMljSTbJySZXBIAX534rG9kiKiI4dWJbmh+13uxs2p4Z8m3p9sFnEcc
         HO8nqccnbOEa5T0sAYxrhkWy4vG5qSqJ1nMbNl9JErKBqZp24CIaM0941c1PpCubzYAu
         dLoebYuEEM8hp1dY4+shRkn4w5PSU/J+rppc/xRWYqKu5VZHtO4B6GrnGkCrVPhY48bP
         KSfXqJs8Bse2egU5O4Q05kGe0+Zg1P6iVhV5EaR3K16wxTq++N11eQXukLbULF2NXOXK
         ccN4fhWb07Gq6/wM8AugBABEIe6RMg5Nvaz6HRzGP27SyqI0G4GsnEyDALdSKWHKSDHe
         8D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x2yPzHh3ZEIdmCQ33j/sDoi8cKYOCoawcOUW4JYO9U0=;
        b=aBTRgEW7QdMJNZKRmKETMp0CQ2mbjBewBR+fNcvjimJ8jy+RA9nLGhXFsXELluZnWm
         w1rMsefaP51TM03QvlAawVq04X+P0oOcwJ1T4o3vX+7V/VCJDZru5w0egdtuhIUF7jS4
         +8Uk8HSIIKtLKHzbNuMCOOpFXPLLTZv6CN40D4A+YnxorK7Etp1L2tgw6YJh7wML/N7Y
         +t6hYAZkSAS5ZcmxTVOTFfospUe28RkYCjjI/5Q249m7/4NwXvpuGG9MwqD9dFE4O4kX
         2pdBh2UyFvcDphTRr06c7zBxqvTSVoOWYGCyo00osKx30bH8YjTDYuQ20cfT5wyCMcTg
         jTtw==
X-Gm-Message-State: ALoCoQkEHV+3eJrgphtVqdcMdSae7fySVl8gnYdI4BJw53VobknYkV4aHVQRTEq7pIHY8DiPc6bm
X-Received: by 10.107.11.17 with SMTP id v17mr14580094ioi.184.1439998040568;
        Wed, 19 Aug 2015 08:27:20 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276191>

Add a new flag --signed-if-possible to push and send-pack that sends a
push certificate if and only if the server advertised a push cert
nonce. If not, at least warn the user that their push may not be as
secure as they thought.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/git-push.txt      | 17 +++++++++-------
 Documentation/git-send-pack.txt | 16 +++++++++------
 builtin/push.c                  | 20 ++++++++++++++++++-
 builtin/send-pack.c             |  6 ++++--
 remote-curl.c                   | 16 ++++++++++-----
 send-pack.c                     | 43 ++++++++++++++++++++++++++++++++++-------
 send-pack.h                     | 12 +++++++++++-
 transport-helper.c              | 34 ++++++++++++++++----------------
 transport.c                     |  8 +++++++-
 transport.h                     |  5 +++--
 10 files changed, 128 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index da0a98d..1495e34 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
-	   [-u | --set-upstream] [--signed]
+	   [-u | --set-upstream]
+	   [--[no-]signed|--sign=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
@@ -132,14 +133,16 @@ already exists on the remote side.
 	with configuration variable 'push.followTags'.  For more
 	information, see 'push.followTags' in linkgit:git-config[1].
 
-
---signed::
+--[no-]signed::
+--sign=(true|false|if-asked)::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
-	logged.  See linkgit:git-receive-pack[1] for the details
-	on the receiving end.  If the attempt to sign with `gpg` fails,
-	or if the server does not support signed pushes, the push will
-	fail.
+	logged.  If `false` or `--no-signed`, no signing will be
+	attempted.  If `true` or `--signed`, the push will fail if the
+	server does not support signed pushes.  If set to `if-asked`,
+	sign if and only if the server supports signed pushes.  The push
+	will also fail if the actual call to `gpg --sign` fails.  See
+	linkgit:git-receive-pack[1] for the details on the receiving end.
 
 --[no-]atomic::
 	Use an atomic transaction on the remote side if available.
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 0a0a3fb..6aa91e8 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
-		[--verbose] [--thin] [--atomic] [--signed]
+		[--verbose] [--thin] [--atomic]
+		[--[no-]signed|--sign=(true|false|if-asked)]
 		[<host>:]<directory> [<ref>...]
 
 DESCRIPTION
@@ -69,13 +70,16 @@ be in a separate packet, and the list must end with a flush packet.
 	fails to update then the entire push will fail without changing any
 	refs.
 
---signed::
+--[no-]signed::
+--sign=(true|false|if-asked)::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
-	logged.  See linkgit:git-receive-pack[1] for the details
-	on the receiving end.  If the attempt to sign with `gpg` fails,
-	or if the server does not support signed pushes, the push will
-	fail.
+	logged.  If `false` or `--no-signed`, no signing will be
+	attempted.  If `true` or `--signed`, the push will fail if the
+	server does not support signed pushes.  If set to `if-asked`,
+	sign if and only if the server supports signed pushes.  The push
+	will also fail if the actual call to `gpg --sign` fails.  See
+	linkgit:git-receive-pack[1] for the details on the receiving end.
 
 <host>::
 	A remote host to house the repository.  When this
diff --git a/builtin/push.c b/builtin/push.c
index 57c138b..85a82cd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -9,6 +9,7 @@
 #include "transport.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "send-pack.h"
 
 static const char * const push_usage[] = {
 	N_("git push [<options>] [<repository> [<refspec>...]]"),
@@ -495,6 +496,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
 	int tags = 0;
+	int push_cert = -1;
 	int rc;
 	const char *repo = NULL;	/* default repository */
 	struct option options[] = {
@@ -526,7 +528,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
-		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		{ OPTION_CALLBACK,
+		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
+		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
 		OPT_END()
 	};
@@ -548,6 +552,20 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
+	switch (push_cert) {
+	case SEND_PACK_PUSH_CERT_NEVER:
+		flags &= ~(TRANSPORT_PUSH_CERT_ALWAYS | TRANSPORT_PUSH_CERT_IF_ASKED);
+		break;
+	case SEND_PACK_PUSH_CERT_ALWAYS:
+		flags |= TRANSPORT_PUSH_CERT_ALWAYS;
+		flags &= ~TRANSPORT_PUSH_CERT_IF_ASKED;
+		break;
+	case SEND_PACK_PUSH_CERT_IF_ASKED:
+		flags |= TRANSPORT_PUSH_CERT_IF_ASKED;
+		flags &= ~TRANSPORT_PUSH_CERT_ALWAYS;
+		break;
+	}
+
 	rc = do_push(repo, flags);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 5f2c744..0ce3bc8 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -118,7 +118,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	unsigned send_mirror = 0;
 	unsigned force_update = 0;
 	unsigned quiet = 0;
-	unsigned push_cert = 0;
+	int push_cert = 0;
 	unsigned use_thin_pack = 0;
 	unsigned atomic = 0;
 	unsigned stateless_rpc = 0;
@@ -137,7 +137,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('n' , "dry-run", &dry_run, N_("dry run")),
 		OPT_BOOL(0, "mirror", &send_mirror, N_("mirror all refs")),
 		OPT_BOOL('f', "force", &force_update, N_("force updates")),
-		OPT_BOOL(0, "signed", &push_cert, N_("GPG sign the push")),
+		{ OPTION_CALLBACK,
+		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
+		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BOOL(0, "thin", &use_thin_pack, N_("use thin pack")),
 		OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
diff --git a/remote-curl.c b/remote-curl.c
index af7b678..71fbbb6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -11,6 +11,7 @@
 #include "argv-array.h"
 #include "credential.h"
 #include "sha1-array.h"
+#include "send-pack.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -26,7 +27,8 @@ struct options {
 		followtags : 1,
 		dry_run : 1,
 		thin : 1,
-		push_cert : 1;
+		/* One of the SEND_PACK_PUSH_CERT_* constants. */
+		push_cert : 2;
 };
 static struct options options;
 static struct string_list cas_options = STRING_LIST_INIT_DUP;
@@ -109,9 +111,11 @@ static int set_option(const char *name, const char *value)
 		return 0;
 	} else if (!strcmp(name, "pushcert")) {
 		if (!strcmp(value, "true"))
-			options.push_cert = 1;
+			options.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
 		else if (!strcmp(value, "false"))
-			options.push_cert = 0;
+			options.push_cert = SEND_PACK_PUSH_CERT_NEVER;
+		else if (!strcmp(value, "if-asked"))
+			options.push_cert = SEND_PACK_PUSH_CERT_IF_ASKED;
 		else
 			return -1;
 		return 0;
@@ -880,8 +884,10 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv_array_push(&args, "--thin");
 	if (options.dry_run)
 		argv_array_push(&args, "--dry-run");
-	if (options.push_cert)
-		argv_array_push(&args, "--signed");
+	if (options.push_cert == SEND_PACK_PUSH_CERT_ALWAYS)
+		argv_array_push(&args, "--signed=yes");
+	else if (options.push_cert == SEND_PACK_PUSH_CERT_IF_ASKED)
+		argv_array_push(&args, "--signed=if-asked");
 	if (options.verbosity == 0)
 		argv_array_push(&args, "--quiet");
 	else if (options.verbosity > 1)
diff --git a/send-pack.c b/send-pack.c
index 2a64fec..c6a4030 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -12,6 +12,29 @@
 #include "version.h"
 #include "sha1-array.h"
 #include "gpg-interface.h"
+#include "cache.h"
+
+int option_parse_push_signed(const struct option *opt,
+			     const char *arg, int unset)
+{
+	if (unset) {
+		*(int *)(opt->value) = SEND_PACK_PUSH_CERT_NEVER;
+		return 0;
+	}
+	switch (git_parse_maybe_bool(arg)) {
+	case 1:
+		*(int *)(opt->value) = SEND_PACK_PUSH_CERT_ALWAYS;
+		return 0;
+	case 0:
+		*(int *)(opt->value) = SEND_PACK_PUSH_CERT_NEVER;
+		return 0;
+	}
+	if (!strcasecmp("if-asked", arg)) {
+		*(int *)(opt->value) = SEND_PACK_PUSH_CERT_IF_ASKED;
+		return 0;
+	}
+	die("bad %s argument: %s", opt->long_name, arg);
+}
 
 static int feed_object(const unsigned char *sha1, int fd, int negative)
 {
@@ -370,14 +393,20 @@ int send_pack(struct send_pack_args *args,
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
 		atomic_supported = 1;
-	if (args->push_cert) {
-		int len;
 
+	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
+		int len;
 		push_cert_nonce = server_feature_value("push-cert", &len);
-		if (!push_cert_nonce)
+		if (push_cert_nonce) {
+			reject_invalid_nonce(push_cert_nonce, len);
+			push_cert_nonce = xmemdupz(push_cert_nonce, len);
+		} else if (args->push_cert == SEND_PACK_PUSH_CERT_ALWAYS) {
 			die(_("the receiving end does not support --signed push"));
-		reject_invalid_nonce(push_cert_nonce, len);
-		push_cert_nonce = xmemdupz(push_cert_nonce, len);
+		} else if (args->push_cert == SEND_PACK_PUSH_CERT_IF_ASKED) {
+			warning(_("not sending a push certificate since the"
+				  " receiving end does not support --signed"
+				  " push"));
+		}
 	}
 
 	if (!remote_refs) {
@@ -413,7 +442,7 @@ int send_pack(struct send_pack_args *args,
 	if (!args->dry_run)
 		advertise_shallow_grafts_buf(&req_buf);
 
-	if (!args->dry_run && args->push_cert)
+	if (!args->dry_run && push_cert_nonce)
 		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
 					       cap_buf.buf, push_cert_nonce);
 
@@ -452,7 +481,7 @@ int send_pack(struct send_pack_args *args,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *old_hex, *new_hex;
 
-		if (args->dry_run || args->push_cert)
+		if (args->dry_run || push_cert_nonce)
 			continue;
 
 		if (check_to_send_update(ref, args) < 0)
diff --git a/send-pack.h b/send-pack.h
index b664648..57f222a 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -1,6 +1,11 @@
 #ifndef SEND_PACK_H
 #define SEND_PACK_H
 
+/* Possible values for push_cert field in send_pack_args. */
+#define SEND_PACK_PUSH_CERT_NEVER 0
+#define SEND_PACK_PUSH_CERT_IF_ASKED 1
+#define SEND_PACK_PUSH_CERT_ALWAYS 2
+
 struct send_pack_args {
 	const char *url;
 	unsigned verbose:1,
@@ -12,11 +17,16 @@ struct send_pack_args {
 		use_thin_pack:1,
 		use_ofs_delta:1,
 		dry_run:1,
-		push_cert:1,
+		/* One of the SEND_PACK_PUSH_CERT_* constants. */
+		push_cert:2,
 		stateless_rpc:1,
 		atomic:1;
 };
 
+struct option;
+int option_parse_push_signed(const struct option *opt,
+			     const char *arg, int unset);
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs, struct sha1_array *extra_have);
diff --git a/transport-helper.c b/transport-helper.c
index 5d99a6b..fd5723f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -257,7 +257,6 @@ static const char *boolean_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP,
 	TRANS_OPT_FOLLOWTAGS,
-	TRANS_OPT_PUSH_CERT
 	};
 
 static int set_helper_option(struct transport *transport,
@@ -763,6 +762,21 @@ static int push_update_refs_status(struct helper_data *data,
 	return ret;
 }
 
+static void set_common_push_options(struct transport *transport,
+				   const char *name, int flags)
+{
+	if (flags & TRANSPORT_PUSH_DRY_RUN) {
+		if (set_helper_option(transport, "dry-run", "true") != 0)
+			die("helper %s does not support dry-run", name);
+	} else if (flags & TRANSPORT_PUSH_CERT_ALWAYS) {
+		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)
+			die("helper %s does not support --signed", name);
+	} else if (flags & TRANSPORT_PUSH_CERT_IF_ASKED) {
+		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "if-asked") != 0)
+			die("helper %s does not support --signed=if-asked", name);
+	}
+}
+
 static int push_refs_with_push(struct transport *transport,
 			       struct ref *remote_refs, int flags)
 {
@@ -830,14 +844,7 @@ static int push_refs_with_push(struct transport *transport,
 
 	for_each_string_list_item(cas_option, &cas_options)
 		set_helper_option(transport, "cas", cas_option->string);
-
-	if (flags & TRANSPORT_PUSH_DRY_RUN) {
-		if (set_helper_option(transport, "dry-run", "true") != 0)
-			die("helper %s does not support dry-run", data->name);
-	} else if (flags & TRANSPORT_PUSH_CERT) {
-		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)
-			die("helper %s does not support --signed", data->name);
-	}
+	set_common_push_options(transport, data->name, flags);
 
 	strbuf_addch(&buf, '\n');
 	sendline(data, &buf);
@@ -858,14 +865,7 @@ static int push_refs_with_export(struct transport *transport,
 	if (!data->refspecs)
 		die("remote-helper doesn't support push; refspec needed");
 
-	if (flags & TRANSPORT_PUSH_DRY_RUN) {
-		if (set_helper_option(transport, "dry-run", "true") != 0)
-			die("helper %s does not support dry-run", data->name);
-	} else if (flags & TRANSPORT_PUSH_CERT) {
-		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)
-			die("helper %s does not support --signed", data->name);
-	}
-
+	set_common_push_options(transport, data->name, flags);
 	if (flags & TRANSPORT_PUSH_FORCE) {
 		if (set_helper_option(transport, "force", "true") != 0)
 			warning("helper %s does not support 'force'", data->name);
diff --git a/transport.c b/transport.c
index 3dd6e30..ebe3b3b 100644
--- a/transport.c
+++ b/transport.c
@@ -826,10 +826,16 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.progress = transport->progress;
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
-	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
 	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.url = transport->url;
 
+	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
+		args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
+	else if (flags & TRANSPORT_PUSH_CERT_IF_ASKED)
+		args.push_cert = SEND_PACK_PUSH_CERT_IF_ASKED;
+	else
+		args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
+
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
 
diff --git a/transport.h b/transport.h
index 79190df..d682b77 100644
--- a/transport.h
+++ b/transport.h
@@ -123,8 +123,9 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
-#define TRANSPORT_PUSH_CERT 2048
-#define TRANSPORT_PUSH_ATOMIC 4096
+#define TRANSPORT_PUSH_CERT_ALWAYS 2048
+#define TRANSPORT_PUSH_CERT_IF_ASKED 4096
+#define TRANSPORT_PUSH_ATOMIC 8192
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.5.0.276.gf5e568e
