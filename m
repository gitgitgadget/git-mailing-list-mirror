From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: [PATCH 1/2] "-" and "@{-1}" on various programs
Date: Mon, 16 Mar 2015 11:11:42 -0400
Message-ID: <1426518703-15785-2-git-send-email-kenny.lee28@gmail.com>
References: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 16:12:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXWhD-00010Y-31
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 16:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934199AbbCPPMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 11:12:35 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36475 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934197AbbCPPMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 11:12:31 -0400
Received: by qcto4 with SMTP id o4so46308018qct.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Bo09IRozTRVBAtB4QHZDxN7UPOiBmIId759HkD0k/Q=;
        b=HVKJHzjc8ghNe7fSWLygEA4cODjD1x5hJ8lEnq+qAraefixsu/FR4XDP/yrBAFvFIb
         oYoG6KLoMAFnY/SdRbfGNMDukb6Cidq5BiMml8ymPgF8418PN36cRZy241dR87emJrk9
         /m/6fRi6QzIQIwkouJtaxIDC7edRB5/Z0KKADnqe41sKc5WyTT3MVD6drAFITgMR5ael
         b+aDV3QQhKOJjSL4uMdNOWTcv1A3DqAMz3CpPokmC3AIofdMFw0R0EpJSW3xR/w6rxdS
         bH/y0o0L23WajNOXLP6LttCc816BPVtspzPbO54lud3CY3FEPk3VH66pbJBWBmkd3/CK
         B+Uw==
X-Received: by 10.140.16.99 with SMTP id 90mr75390647qga.105.1426518750272;
        Mon, 16 Mar 2015 08:12:30 -0700 (PDT)
Received: from fujitsu.wireless.concordia.ca ([132.205.236.24])
        by mx.google.com with ESMTPSA id t102sm7636693qgt.45.2015.03.16.08.12.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2015 08:12:29 -0700 (PDT)
X-Mailer: git-send-email 2.3.2.224.gae1335b
In-Reply-To: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265563>

From: Junio C Hamano <gitster@pobox.com>

JFF stands for just for fun.

This is not meant to give out a model answer and is known to be
incomplete, but I was wondering if it would be a better direction to
allow "-" as a stand-in for "@{-1}" everywhere we allow a branch
name, losing workarounds at the surface level we have for checkout,
merge and revert.

The first three paths are to remove the surface workarounds that
become unnecessary.  The one in sha1_name.c is the central change.

The change in revision.c is to allow a single "-" to be recognized
as a potential revision name (without this change, what begins with
"-" is either an option or an unknown option).

So you could do things like "git reset - $path" but also things like
"git log -" after switching out of a branch.

What does not work are what needs further tweaking in revision.c
parser.  "git checkout master && git checkout next && git log -.."
should show what next has on top of master but I didn't touch the
range notation so it does not work, for example.

 builtin/checkout.c |  3 ---
 builtin/merge.c    |  3 +--
 builtin/revert.c   |  2 --
 revision.c         |  2 +-
 sha1_name.c        | 57 +++++++++++++++++++++++++++++++++---------------------
 5 files changed, 37 insertions(+), 30 deletions(-)

Signed-off-by: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
---
 builtin/checkout.c |  3 ---
 builtin/merge.c    |  3 +--
 builtin/revert.c   |  2 --
 revision.c         |  2 +-
 sha1_name.c        | 57 +++++++++++++++++++++++++++++++++---------------------
 5 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3e141fc..f86bad7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -951,9 +951,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 	else if (dash_dash_pos >= 2)
 		die(_("only one reference expected, %d given."), dash_dash_pos);
 
-	if (!strcmp(arg, "-"))
-		arg = "@{-1}";
-
 	if (get_sha1_mb(arg, rev)) {
 		/*
 		 * Either case (3) or (4), with <something> not being
diff --git a/builtin/merge.c b/builtin/merge.c
index 3b0f8f9..03b260f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1164,8 +1164,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				argc = setup_with_upstream(&argv);
 			else
 				die(_("No commit specified and merge.defaultToUpstream not set."));
-		} else if (argc == 1 && !strcmp(argv[0], "-"))
-			argv[0] = "@{-1}";
+		}
 	}
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
diff --git a/builtin/revert.c b/builtin/revert.c
index 56a2c36..dc98b4e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -170,8 +170,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
-		if (!strcmp(argv[1], "-"))
-			argv[1] = "@{-1}";
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
 		s_r_opt.assume_dashdash = 1;
 		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
diff --git a/revision.c b/revision.c
index 66520c6..7778bbd 100644
--- a/revision.c
+++ b/revision.c
@@ -2198,7 +2198,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (*arg == '-') {
+		if (arg[0] == '-' && arg[1]) {
 			int opts;
 
 			opts = handle_revision_pseudo_opt(submodule,
diff --git a/sha1_name.c b/sha1_name.c
index 95f9f8f..7a621ba 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -483,6 +483,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 				break;
 			}
 		}
+	} else if (len == 1 && str[0] == '-') {
+		nth_prior = 1;
 	}
 
 	/* Accept only unambiguous ref paths. */
@@ -491,13 +493,16 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 
 	if (nth_prior) {
 		struct strbuf buf = STRBUF_INIT;
-		int detached;
+		int status;
 
 		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
-			detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
+			if (get_sha1(buf.buf, sha1))
+				/* bad---the previous branch no longer exists? */
+				status = -1;
+			else
+				status = 0; /* detached */
 			strbuf_release(&buf);
-			if (detached)
-				return 0;
+			return status;
 		}
 	}
 
@@ -931,35 +936,43 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 					struct strbuf *buf)
 {
 	long nth;
-	int retval;
+	int consumed;
 	struct grab_nth_branch_switch_cbdata cb;
-	const char *brace;
-	char *num_end;
 
-	if (namelen < 4)
-		return -1;
-	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
-		return -1;
-	brace = memchr(name, '}', namelen);
-	if (!brace)
-		return -1;
-	nth = strtol(name + 3, &num_end, 10);
-	if (num_end != brace)
-		return -1;
-	if (nth <= 0)
-		return -1;
+	if (namelen == 1 && name[0] == '-') {
+		nth = 1;
+		consumed = 1;
+	} else {
+		const char *brace;
+		char *num_end;
+
+		if (namelen < 4)
+			return -1;
+		if (name[0] != '@' || name[1] != '{' || name[2] != '-')
+			return -1;
+		brace = memchr(name, '}', namelen);
+		if (!brace)
+			return -1;
+		nth = strtol(name + 3, &num_end, 10);
+		if (num_end != brace)
+			return -1;
+		if (nth <= 0)
+			return -1;
+		consumed = brace - name + 1;
+	}
+
 	cb.remaining = nth;
 	strbuf_init(&cb.buf, 20);
 
-	retval = 0;
 	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
 		strbuf_reset(buf);
 		strbuf_addbuf(buf, &cb.buf);
-		retval = brace - name + 1;
+	} else {
+		consumed = 0;
 	}
 
 	strbuf_release(&cb.buf);
-	return retval;
+	return consumed;
 }
 
 int get_sha1_mb(const char *name, unsigned char *sha1)
-- 
2.3.2.225.gebdc58a
