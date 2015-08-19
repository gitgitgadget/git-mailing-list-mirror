From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 7/9] builtin/send-pack.c: Use option parsing API
Date: Wed, 19 Aug 2015 11:26:45 -0400
Message-ID: <1439998007-28719-8-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5HD-0005AP-PO
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbHSP1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:35 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35479 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbHSP1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:18 -0400
Received: by iodt126 with SMTP id t126so12999436iod.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Lk/6G63maSjdBi+c425wTcQBU2Nx5sKTTWioza1Fjk=;
        b=FKOV85TYpY080Oz8rCq2ddACkT4LlfdujmTUMO3XoRqrobTv1b1mk/qRDD/y4G7GSV
         dF1YjVOTI1F48xglflaebL3+PxWEgtHMmUoD8Q5oCNhBrjc9Jf52v9ohFcJb/AS8X12Z
         H0gh4GLgeUUsP/2bohPED2fprgTiaChvaVnxsnb/dnvFEakLMp9OWBtfR+9XdEKjVJeF
         zWvYcbpoxsgQHuhgOBhhFvHRirAw3WJKeas2c86lNXBHjyEuSwQRofYCNdjNh2RX4D6+
         hjHKQZFM2TP+YTOm8RJaE7AN3Ju3GVU0hK7oodKZGyRXpIo8kBqqvjvaadVigwVWmeIY
         Y0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Lk/6G63maSjdBi+c425wTcQBU2Nx5sKTTWioza1Fjk=;
        b=OcddGATVon6lfwRE5XKRrNJVexCEa41TPH8Vf6gC25CsAwnX0oStlR1sIJrpaeQFPK
         4P7IJQL4T2b+/OO3u5DsFtqYCnDRwiQXtJlyJ6aEMWEDXMSeGZirguQmFp9B/bA+uf/0
         mdxkjh4hSlqZ1eh8I6orGdtXyuptMN2VEIIKZu2gFFZfHEVs+6cY17ObhUmJifcJARXz
         +qWQ7Sup6NK5WrKZamUzS/RaruS0JFgKpDVtn06b0wzrlbYXPqPM/cfUC8IgxyXVLFcs
         GrT97q+0H6tACPvwfsmmEQp47K7cTeknlBPZ2TBIPHZss/ptY3hCeAI4Vgnfdxq0XydZ
         IEdw==
X-Gm-Message-State: ALoCoQnh2XcSI5DIoTn0s8T9XdgH+sGTyaqi8gchxj/CBuxJoquAMhqo4+OijrlDs5zDpjwwFnI0
X-Received: by 10.107.19.94 with SMTP id b91mr12144674ioj.144.1439998038287;
        Wed, 19 Aug 2015 08:27:18 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276192>

The old option parsing code in this plumbing command predates this
API, so option parsing was done more manually. Using the new API
brings send-pack more in line with push, and accepts new variants
like --no-* for negating options.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 builtin/send-pack.c | 163 +++++++++++++++++++---------------------------------
 1 file changed, 59 insertions(+), 104 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 23b2962..5f2c744 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -12,10 +12,15 @@
 #include "version.h"
 #include "sha1-array.h"
 #include "gpg-interface.h"
+#include "gettext.h"
 
-static const char send_pack_usage[] =
-"git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]\n"
-"  --all and explicit <ref> specification are mutually exclusive.";
+static const char * const send_pack_usage[] = {
+	N_("git send-pack [--all | --mirror] [--dry-run] [--force] "
+	  "[--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] "
+	  "[<host>:]<directory> [<ref>...]\n"
+	  "  --all and explicit <ref> specification are mutually exclusive."),
+	NULL,
+};
 
 static struct send_pack_args args;
 
@@ -107,116 +112,66 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int ret;
 	int helper_status = 0;
 	int send_all = 0;
+	int verbose = 0;
 	const char *receivepack = "git-receive-pack";
+	unsigned dry_run = 0;
+	unsigned send_mirror = 0;
+	unsigned force_update = 0;
+	unsigned quiet = 0;
+	unsigned push_cert = 0;
+	unsigned use_thin_pack = 0;
+	unsigned atomic = 0;
+	unsigned stateless_rpc = 0;
 	int flags;
 	unsigned int reject_reasons;
 	int progress = -1;
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
 
-	git_config(git_gpg_config, NULL);
+	struct option options[] = {
+		OPT__VERBOSITY(&verbose),
+		OPT_STRING(0, "receive-pack", &receivepack, "receive-pack", N_("receive pack program")),
+		OPT_STRING(0, "exec", &receivepack, "receive-pack", N_("receive pack program")),
+		OPT_STRING(0, "remote", &remote_name, "remote", N_("remote name")),
+		OPT_BOOL(0, "all", &send_all, N_("push all refs")),
+		OPT_BOOL('n' , "dry-run", &dry_run, N_("dry run")),
+		OPT_BOOL(0, "mirror", &send_mirror, N_("mirror all refs")),
+		OPT_BOOL('f', "force", &force_update, N_("force updates")),
+		OPT_BOOL(0, "signed", &push_cert, N_("GPG sign the push")),
+		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
+		OPT_BOOL(0, "thin", &use_thin_pack, N_("use thin pack")),
+		OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
+		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
+		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
+		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
+		{ OPTION_CALLBACK,
+		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
+		  N_("require old value of ref to be at this value"),
+		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
+		OPT_END()
+	};
 
-	argv++;
-	for (i = 1; i < argc; i++, argv++) {
-		const char *arg = *argv;
-
-		if (*arg == '-') {
-			if (starts_with(arg, "--receive-pack=")) {
-				receivepack = arg + 15;
-				continue;
-			}
-			if (starts_with(arg, "--exec=")) {
-				receivepack = arg + 7;
-				continue;
-			}
-			if (starts_with(arg, "--remote=")) {
-				remote_name = arg + 9;
-				continue;
-			}
-			if (!strcmp(arg, "--all")) {
-				send_all = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--dry-run")) {
-				args.dry_run = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--mirror")) {
-				args.send_mirror = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--force")) {
-				args.force_update = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--quiet")) {
-				args.quiet = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--verbose")) {
-				args.verbose = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--signed")) {
-				args.push_cert = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--progress")) {
-				progress = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--no-progress")) {
-				progress = 0;
-				continue;
-			}
-			if (!strcmp(arg, "--thin")) {
-				args.use_thin_pack = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--atomic")) {
-				args.atomic = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--stateless-rpc")) {
-				args.stateless_rpc = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--stdin")) {
-				from_stdin = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--helper-status")) {
-				helper_status = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--" CAS_OPT_NAME)) {
-				if (parse_push_cas_option(&cas, NULL, 0) < 0)
-					exit(1);
-				continue;
-			}
-			if (!strcmp(arg, "--no-" CAS_OPT_NAME)) {
-				if (parse_push_cas_option(&cas, NULL, 1) < 0)
-					exit(1);
-				continue;
-			}
-			if (starts_with(arg, "--" CAS_OPT_NAME "=")) {
-				if (parse_push_cas_option(&cas,
-							  strchr(arg, '=') + 1, 0) < 0)
-					exit(1);
-				continue;
-			}
-			usage(send_pack_usage);
-		}
-		if (!dest) {
-			dest = arg;
-			continue;
-		}
-		refspecs = (const char **) argv;
-		nr_refspecs = argc - i;
-		break;
+	git_config(git_gpg_config, NULL);
+	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
+	if (argc > 0) {
+		dest = argv[0];
+		refspecs = (const char **)(argv + 1);
+		nr_refspecs = argc - 1;
 	}
+
 	if (!dest)
-		usage(send_pack_usage);
+		usage_with_options(send_pack_usage, options);
+
+	args.verbose = verbose;
+	args.dry_run = dry_run;
+	args.send_mirror = send_mirror;
+	args.force_update = force_update;
+	args.quiet = quiet;
+	args.push_cert = push_cert;
+	args.progress = progress;
+	args.use_thin_pack = use_thin_pack;
+	args.atomic = atomic;
+	args.stateless_rpc = stateless_rpc;
 
 	if (from_stdin) {
 		struct argv_array all_refspecs = ARGV_ARRAY_INIT;
@@ -245,7 +200,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	 */
 	if ((refspecs && (send_all || args.send_mirror)) ||
 	    (send_all && args.send_mirror))
-		usage(send_pack_usage);
+		usage_with_options(send_pack_usage, options);
 
 	if (remote_name) {
 		remote = remote_get(remote_name);
-- 
2.5.0.276.gf5e568e
