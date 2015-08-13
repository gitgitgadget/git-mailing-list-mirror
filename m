From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 6/7] Support signing pushes iff the server supports it
Date: Thu, 13 Aug 2015 15:00:50 -0400
Message-ID: <1439492451-11233-7-git-send-email-dborowitz@google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:01:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxkW-0003Bg-U3
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbbHMTBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:01:08 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37989 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbbHMTBB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:01:01 -0400
Received: by igfj19 with SMTP id j19so42691875igf.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jjo/4v+5ZfCTfX1pLbdANOoLJa0982CS4/kY7uS3TV8=;
        b=gUxwXQItS//B2VqG0lq8LaQlf9/HB5N5/d1thPrVKo/Xa1OCcDL9usnhwE8hbjzta8
         n7h0i8AKOc/QFG4Z9gt2ld5/M0A5ttaIHDg2DpE4T3bEYRImUMIE7Cx4MToUBI05MQkO
         66hbmNIRPsiQcdry4XT6B7VTOYD2tHF0mlAZPNfYPc4EZTRTsuCndpgr5Xf5C/xC/ViC
         zwB49zU5iHFssHRZUoQ5diKQvvarAMLgH+x+jyMU6smXgqmF9Vol9wTMxYim9vfcHpBM
         CDP51IDIcJFOgLsXdIov4eXnPi0iVH0yWlZvZx4aUAPDGzFxooKoq7K16gZrpDrWWFZs
         4ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jjo/4v+5ZfCTfX1pLbdANOoLJa0982CS4/kY7uS3TV8=;
        b=caMjvH3BgUZVxs8YtAyExmKls3lQvhIr9q3BTTtGDmQEQ5iUojKJBYWV+N/1GlM50q
         vhDq5qR3JzKCqDGc1S8UZSzZjCe9ZfIzUi2CdcRoV+gRLdwh7fa5UA9a0LQlMshcymX7
         tOxAobRrOCrHiU+nMUhS+7k1qlFn6HFJ39O7F0mAq9y4+krp4yWeenSz6s2jZhjGejRm
         woNGgIlrqAbeYpyyyo9AwbpvAawC0713O6K/tmA4qwnTXxxuXPUKTVEGUFB6qzgqDbVG
         vK4LNwEzn8UReKK9GrLgppSndhsbzNhXj60jJx6WKRd5xxr+bOyYIWnEJBKSlmxRbdcZ
         i+fA==
X-Gm-Message-State: ALoCoQnIWb0ZlvR4+7GBvtIuQcCfLXIa3Owx62ZEOdX8k15uJBraaDVNCbkpWjvfdWxAwAd+fmbB
X-Received: by 10.50.176.138 with SMTP id ci10mr32331392igc.32.1439492460611;
        Thu, 13 Aug 2015 12:01:00 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id c91sm2078646ioj.43.2015.08.13.12.00.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 12:00:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275876>

Add a new flag --signed-if-possible to push and send-pack that sends a
push certificate if and only if the server advertised a push cert
nonce. If not, at least warn the user that their push may not be as
secure as they thought.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/git-push.txt      |  9 +++++++--
 Documentation/git-send-pack.txt |  9 +++++++--
 builtin/push.c                  |  4 +++-
 builtin/send-pack.c             |  6 +++++-
 remote-curl.c                   | 14 ++++++++++----
 send-pack.c                     | 18 +++++++++++++++---
 send-pack.h                     |  8 +++++++-
 transport-helper.c              | 34 +++++++++++++++++-----------------
 transport.c                     |  8 +++++++-
 transport.h                     |  5 +++--
 10 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f8b8b8b..fcfdf73 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
-	   [-u | --set-upstream] [--signed]
+	   [-u | --set-upstream] [--signed] [--signed-if-possible]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
@@ -139,7 +139,12 @@ already exists on the remote side.
 	logged.  See linkgit:git-receive-pack[1] for the details
 	on the receiving end.  If the `gpg` executable is not available,
 	or if the server does not support signed pushes, the push will
-	fail.
+	fail. Takes precedence over --signed-if-possible.
+
+--signed-if-possible::
+	Like --signed, but only if the server supports signed pushes. If
+	the server supports signed pushes but the `gpg` is not available,
+	the push will fail.
 
 --[no-]atomic::
 	Use an atomic transaction on the remote side if available.
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index dde13b0..5789208 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
-		[--verbose] [--thin] [--atomic] [--signed]
+		[--verbose] [--thin] [--atomic] [--signed] [--signed-if-possible]
 		[<host>:]<directory> [<ref>...]
 
 DESCRIPTION
@@ -75,7 +75,12 @@ be in a separate packet, and the list must end with a flush packet.
 	logged.  See linkgit:git-receive-pack[1] for the details
 	on the receiving end.  If the `gpg` executable is not available,
 	or if the server does not support signed pushes, the push will
-	fail.
+	fail. Takes precedence over --signed-if-possible.
+
+--signed-if-possible::
+	Like --signed, but only if the server supports signed pushes. If
+	the server supports signed pushes but the `gpg` is not available,
+	the push will fail.
 
 <host>::
 	A remote host to house the repository.  When this
diff --git a/builtin/push.c b/builtin/push.c
index 57c138b..95a67c5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -526,7 +526,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
-		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT_ALWAYS),
+		OPT_BIT(0, "signed-if-possible", &flags, N_("GPG sign the push, if supported by the server"),
+			TRANSPORT_PUSH_CERT_IF_POSSIBLE),
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
 		OPT_END()
 	};
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 23b2962..8eebbf4 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -158,7 +158,11 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--signed")) {
-				args.push_cert = 1;
+				args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
+				continue;
+			}
+			if (!strcmp(arg, "--signed-if-possible")) {
+				args.push_cert = SEND_PACK_PUSH_CERT_IF_POSSIBLE;
 				continue;
 			}
 			if (!strcmp(arg, "--progress")) {
diff --git a/remote-curl.c b/remote-curl.c
index af7b678..f049de8 100644
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
+		else if (!strcmp(value, "if-possible"))
+			options.push_cert = SEND_PACK_PUSH_CERT_IF_POSSIBLE;
 		else
 			return -1;
 		return 0;
@@ -880,8 +884,10 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv_array_push(&args, "--thin");
 	if (options.dry_run)
 		argv_array_push(&args, "--dry-run");
-	if (options.push_cert)
+	if (options.push_cert == SEND_PACK_PUSH_CERT_ALWAYS)
 		argv_array_push(&args, "--signed");
+	else if (options.push_cert == SEND_PACK_PUSH_CERT_IF_POSSIBLE)
+		argv_array_push(&args, "--signed-if-possible");
 	if (options.verbosity == 0)
 		argv_array_push(&args, "--quiet");
 	else if (options.verbosity > 1)
diff --git a/send-pack.c b/send-pack.c
index 2a64fec..6ae9f45 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -370,7 +370,7 @@ int send_pack(struct send_pack_args *args,
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
 		atomic_supported = 1;
-	if (args->push_cert) {
+	if (args->push_cert == SEND_PACK_PUSH_CERT_ALWAYS) {
 		int len;
 
 		push_cert_nonce = server_feature_value("push-cert", &len);
@@ -379,6 +379,18 @@ int send_pack(struct send_pack_args *args,
 		reject_invalid_nonce(push_cert_nonce, len);
 		push_cert_nonce = xmemdupz(push_cert_nonce, len);
 	}
+	if (args->push_cert == SEND_PACK_PUSH_CERT_IF_POSSIBLE) {
+		int len;
+
+		push_cert_nonce = server_feature_value("push-cert", &len);
+		if (push_cert_nonce) {
+			reject_invalid_nonce(push_cert_nonce, len);
+			push_cert_nonce = xmemdupz(push_cert_nonce, len);
+		} else
+			warning(_("not sending a push certificate since the"
+				  " receiving end does not support --signed"
+				  " push"));
+	}
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -413,7 +425,7 @@ int send_pack(struct send_pack_args *args,
 	if (!args->dry_run)
 		advertise_shallow_grafts_buf(&req_buf);
 
-	if (!args->dry_run && args->push_cert)
+	if (!args->dry_run && push_cert_nonce)
 		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
 					       cap_buf.buf, push_cert_nonce);
 
@@ -452,7 +464,7 @@ int send_pack(struct send_pack_args *args,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *old_hex, *new_hex;
 
-		if (args->dry_run || args->push_cert)
+		if (args->dry_run || push_cert_nonce)
 			continue;
 
 		if (check_to_send_update(ref, args) < 0)
diff --git a/send-pack.h b/send-pack.h
index b664648..5042b65 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -1,6 +1,11 @@
 #ifndef SEND_PACK_H
 #define SEND_PACK_H
 
+/* Possible values for push_cert field in send_pack_args. */
+#define SEND_PACK_PUSH_CERT_NEVER 0
+#define SEND_PACK_PUSH_CERT_IF_POSSIBLE 1
+#define SEND_PACK_PUSH_CERT_ALWAYS 2
+
 struct send_pack_args {
 	const char *url;
 	unsigned verbose:1,
@@ -12,7 +17,8 @@ struct send_pack_args {
 		use_thin_pack:1,
 		use_ofs_delta:1,
 		dry_run:1,
-		push_cert:1,
+		/* One of the SEND_PACK_PUSH_CERT_* constants. */
+		push_cert:2,
 		stateless_rpc:1,
 		atomic:1;
 };
diff --git a/transport-helper.c b/transport-helper.c
index 5d99a6b..bf4dd22 100644
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
+	} else if (flags & TRANSPORT_PUSH_CERT_IF_POSSIBLE) {
+		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "if-possible") != 0)
+			die("helper %s does not support --signed-if-possible", name);
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
index 3dd6e30..66cd2d3 100644
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
+	else if (flags & TRANSPORT_PUSH_CERT_IF_POSSIBLE)
+		args.push_cert = SEND_PACK_PUSH_CERT_IF_POSSIBLE;
+	else
+		args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
+
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
 
diff --git a/transport.h b/transport.h
index 79190df..49f3e44 100644
--- a/transport.h
+++ b/transport.h
@@ -123,8 +123,9 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
-#define TRANSPORT_PUSH_CERT 2048
-#define TRANSPORT_PUSH_ATOMIC 4096
+#define TRANSPORT_PUSH_CERT_ALWAYS 2048
+#define TRANSPORT_PUSH_CERT_IF_POSSIBLE 4096
+#define TRANSPORT_PUSH_ATOMIC 8192
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.5.0.276.gf5e568e
