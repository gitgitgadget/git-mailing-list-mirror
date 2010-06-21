From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/3] builtin/checkout: change -b from an OPTION_STRING to a OPTION_SET_INT
Date: Tue, 22 Jun 2010 01:19:41 +0800
Message-ID: <1277140782-4064-3-git-send-email-rctay89@gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
 <1277140782-4064-1-git-send-email-rctay89@gmail.com>
 <1277140782-4064-2-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 21 19:20:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQkfi-0007d1-6Q
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 19:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129Ab0FURUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 13:20:24 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63896 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758063Ab0FURUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 13:20:22 -0400
Received: by mail-px0-f174.google.com with SMTP id 12so1459027pxi.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cUe00DtOqCRLvwh+5z8iLds2rzMw7Y4wSUFa/iudJ3s=;
        b=vRSLxKZLYAocggh4DYUztXVCMlul0Fb8RITOv51Jw/3dSCMeBSmvyFEqZEYXynCpFz
         2J67SPWGjxL0TAVFflrZzdxIHqBsb7WLB04QnD5jwzzHyA8e5wmtwBYeHDltEU4Dk+x1
         qHlrZR3GCfeN5C20Qst+lwtyTB867rVcJvU6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eUA9infhu0zfJvdGOrMET1fTtfts9yzYTzimIijxoFJ4UwbFsFbCxeUw09GAR1UKsH
         88Am+0OyHuT0IX+zkj+cFB6VZmU0Kje4mW0wnbzVzul89rghWqDi17rgGIgcRvKLrT6r
         1ef9tMehdF9PHJiTvsRW3GXuS+I5GJ268EB8A=
Received: by 10.115.132.22 with SMTP id j22mr4204986wan.125.1277140822170;
        Mon, 21 Jun 2010 10:20:22 -0700 (PDT)
Received: from localhost.localdomain (cm134.zeta152.maxonline.com.sg [116.87.152.134])
        by mx.google.com with ESMTPS id b6sm32760016wam.21.2010.06.21.10.20.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 10:20:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277140782-4064-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149422>

This is in preparation for multiple levels of "-b".

To check this change's interaction with --track, the following tests
(obtained with grep -l "\-\-track" t/*.sh)were run, and they passed.

  t1507-rev-parse-upstream.sh
  t3200-branch.sh
  t5505-remote.sh
  t5520-pull.sh
  t6040-tracking-info.sh
  t7201-co.sh

(t9114-git-svn-dcommit-merge.sh was excluded as I don't have svn.)

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/checkout.c |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..e794e1e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -32,7 +32,8 @@ struct checkout_opts {
 	int writeout_stage;
 	int writeout_error;
 
-	const char *new_branch;
+	int new_branch;
+	const char *new_branch_name;
 	const char *new_orphan_branch;
 	int new_branch_log;
 	enum branch_track track;
@@ -492,7 +493,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc;
-	if (opts->new_branch) {
+	if (opts->new_branch_name) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				int temp;
@@ -511,9 +512,9 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			}
 		}
 		else
-			create_branch(old->name, opts->new_branch, new->name, 0,
+			create_branch(old->name, opts->new_branch_name, new->name, 0,
 				      opts->new_branch_log, opts->track);
-		new->name = opts->new_branch;
+		new->name = opts->new_branch_name;
 		setup_branch_path(new);
 	}
 
@@ -531,7 +532,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 					new->name);
 			else
 				fprintf(stderr, "Switched to%s branch '%s'\n",
-					opts->new_branch ? " a new" : "",
+					opts->new_branch_name ? " a new" : "",
 					new->name);
 		}
 		if (old->path && old->name) {
@@ -657,7 +658,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	int dwim_new_local_branch = 1;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
-		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
+		OPT_SET_INT('b', NULL, &opts.new_branch,
+			    "create and checkout a new branch", 1),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
@@ -692,8 +694,17 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   || opts.new_branch_log || opts.merge || opts.force))
 		die ("--patch is incompatible with all other options");
 
+	if (opts.new_branch > 0) {
+		const char *arg = argv[0];
+		if (!argc || !strcmp(arg, "--"))
+			die ("Missing branch name");
+		opts.new_branch_name = arg;
+		argv++;
+		argc--;
+	}
+
 	/* --track without -b should DWIM */
-	if (0 < opts.track && !opts.new_branch) {
+	if (0 < opts.track && !opts.new_branch_name) {
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die ("--track needs a branch name");
@@ -704,7 +715,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
 			die ("Missing branch name; try -b");
-		opts.new_branch = argv0 + 1;
+		opts.new_branch_name = argv0 + 1;
 	}
 
 	if (opts.new_orphan_branch) {
@@ -712,7 +723,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			die("--orphan and -b are mutually exclusive");
 		if (opts.track > 0)
 			die("--orphan cannot be used with -t");
-		opts.new_branch = opts.new_orphan_branch;
+		opts.new_branch_name = opts.new_orphan_branch;
 	}
 
 	if (conflict_style) {
@@ -771,13 +782,13 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			if (!patch_mode &&
 			    dwim_new_local_branch &&
 			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
-			    !opts.new_branch &&
+			    !opts.new_branch_name &&
 			    !check_filename(NULL, arg) &&
 			    argc == 1) {
 				const char *remote = unique_tracking_name(arg);
 				if (!remote || get_sha1(remote, rev))
 					goto no_reference;
-				opts.new_branch = arg;
+				opts.new_branch_name = arg;
 				arg = remote;
 				/* DWIMmed to create local branch */
 			}
@@ -853,13 +864,13 @@ no_reference:
 	if (patch_mode)
 		return interactive_checkout(new.name, NULL, &opts);
 
-	if (opts.new_branch) {
+	if (opts.new_branch_name) {
 		struct strbuf buf = STRBUF_INIT;
-		if (strbuf_check_branch_ref(&buf, opts.new_branch))
+		if (strbuf_check_branch_ref(&buf, opts.new_branch_name))
 			die("git checkout: we do not like '%s' as a branch name.",
-			    opts.new_branch);
+			    opts.new_branch_name);
 		if (!get_sha1(buf.buf, rev))
-			die("git checkout: branch %s already exists", opts.new_branch);
+			die("git checkout: branch %s already exists", opts.new_branch_name);
 		strbuf_release(&buf);
 	}
 
-- 
1.7.1.513.g4f18
