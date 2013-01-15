From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 03/19] reset.c: pass pathspec around instead of (prefix, argv) pair
Date: Mon, 14 Jan 2013 21:47:35 -0800
Message-ID: <1358228871-7142-4-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOP-0007EL-2z
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab3AOFs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:28 -0500
Received: from mail-gg0-f202.google.com ([209.85.161.202]:44205 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab3AOFs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:26 -0500
Received: by mail-gg0-f202.google.com with SMTP id k1so588142ggn.3
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=mntXwCelr0NIuXdzOQR9duzz5UcNsvFPmh5tscfxK6c=;
        b=gJ2WKkpqK6jyCEAZGxh0fxMNu2SUkoK7TA0TjlFbWVYtlC0t6hrHQfJfRlNF1RsPeM
         iqzrgF1YTMyc6dhhCr/pTpj6XnZjU/u5MzN/YAeHqKP02LiQoxSfg+yEUXWNqetQv8kf
         1K2IRImVX2bns72smEH0vFNKD2AM9DQJL3p7qsPz+Mm+rXd9gUOhyEg4+S770cW77z5r
         /uNC+40X/c8P3r5qg2KXpy3JKVyWaea2Dr+2IH/EvrRNn1pufl5VMSCAA8wSgod3ljoG
         CBgscFrcrM9KYmX7yCFbj7beV3BBu6qyt/njA3Nyw6XQ9CWiDzXc/MpsSW+Sp3hzUZ4U
         X6bw==
X-Received: by 10.236.159.198 with SMTP id s46mr47103034yhk.40.1358228906312;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id a24si819342yhi.0.2013.01.14.21.48.26
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 2DB0A82004A;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id D286E1011EA; Mon, 14 Jan 2013 21:48:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmpuyFYodCCjEzbP2ukIQOq0pJi/CnsOBa9GXCsBJMbhrm6z/vx8JklaZCc6kf1Fzlosg+gT00NRbfcIpNnWpIZrJkha4qMDzs1r5BYwlSf9Pfx6LFd1ioezcB+l9kPRz6GIHJG0GfHb27bSgOFZJ9v0CgG2Ni/AKn5cSNdWi/SE0aqVRnZL/uMvVMgL1Pwktg3cuJT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213576>

We use the path arguments in two places in reset.c: in
interactive_reset() and read_from_tree(). Both of these call
get_pathspec(), so we pass the (prefix, argv) pair to both
functions. Move the call to get_pathspec() out of these methods, for
two reasons: 1) One argument is simpler than two. 2) It lets us use
the (arguably clearer) "if (pathspec)" in place of "if (i < argc)".

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 65413d0..045c960 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -153,26 +153,15 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	}
 }
 
-static int interactive_reset(const char *revision, const char **argv,
-			     const char *prefix)
-{
-	const char **pathspec = NULL;
-
-	if (*argv)
-		pathspec = get_pathspec(prefix, argv);
-
-	return run_add_interactive(revision, "--patch=reset", pathspec);
-}
-
-static int read_from_tree(const char *prefix, const char **argv,
-		unsigned char *tree_sha1, int refresh_flags)
+static int read_from_tree(const char **pathspec, unsigned char *tree_sha1,
+			  int refresh_flags)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int index_fd;
 	struct diff_options opt;
 
 	memset(&opt, 0, sizeof(opt));
-	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt);
+	diff_tree_setup_paths(pathspec, &opt);
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 
@@ -216,6 +205,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
+	const char **pathspec = NULL;
 	struct commit *commit;
 	struct strbuf msg = STRBUF_INIT;
 	const struct option options[] = {
@@ -287,22 +277,25 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("Could not parse object '%s'."), rev);
 	hashcpy(sha1, commit->object.sha1);
 
+	if (i < argc)
+		pathspec = get_pathspec(prefix, argv + i);
+
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return interactive_reset(rev, argv + i, prefix);
+		return run_add_interactive(rev, "--patch=reset", pathspec);
 	}
 
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
-	if (i < argc) {
+	if (pathspec) {
 		if (reset_type == MIXED)
 			warning(_("--mixed with paths is deprecated; use 'git reset -- <paths>' instead."));
 		else if (reset_type != NONE)
 			die(_("Cannot do %s reset with paths."),
 					_(reset_type_names[reset_type]));
-		return read_from_tree(prefix, argv + i, sha1,
+		return read_from_tree(pathspec, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
 	if (reset_type == NONE)
-- 
1.8.1.1.454.gce43f05
