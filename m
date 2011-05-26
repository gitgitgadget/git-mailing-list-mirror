From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/10] revert: Catch incompatible command-line options early
Date: Thu, 26 May 2011 15:53:50 +0000
Message-ID: <1306425233-504-8-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPct9-0001N6-Uy
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab1EZPyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:54:11 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44180 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab1EZPyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:54:09 -0400
Received: by mail-qy0-f181.google.com with SMTP id 14so475045qyg.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=DbYyngpgDLVNTbFst7LVRAyF78IQTtP/XP1BB22f/04=;
        b=jMFRFoL3Fo2QJqTl8nsmShCOjubWbGlg6ClZygdthoaRkt5nRjkuyod7izOZxBoDwa
         3XnLaH+sfEUMs+04XKsTEMHyFwc1NTMa506UB9saNmFfuQ20UbzzPNNtKWcNKoiWyhTO
         1o6TfO8JllXtLPRJIs2CPnZCZbH+E7HkQBRc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MHNuWT8Lt3XuZ8vARcf91hOoDXSaAGi5CUWs6w4P0dzXBsma75HJo+jNIfn0RXZVkb
         tLoYPkajCrLQh3YU4HjrmghnBgZIa8oBsBJrXHezP0/3TGnVeAfbFzBfa9UxyXrsV//i
         d+n3BcCNv51aI+lKDboEf3FODNxHoo9p6Wx3U=
Received: by 10.224.212.2 with SMTP id gq2mr725775qab.88.1306425248906;
        Thu, 26 May 2011 08:54:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.54.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:54:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174532>

Earlier, incompatible command-line options used to be caught in
pick_commits after parse_args has parsed the options and populated the
options structure; a lot of unncessary work has already been done, and
significant amount of cleanup is required to die at this stage.
Instead, hand over this responsibility to parse_args so that the
program can die early.  Also write a die_opt_incompabile function to
handle incompatible options in a general manner; it will be used more
extensively as more command-line options are introduced later in the
series.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2e5f260..1c6c102 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -80,6 +80,22 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
+static void verify_opt_compatible(const char *me, const char *base_opt, ...)
+{
+	const char *this_opt;
+	va_list ap;
+	int set;
+
+	va_start(ap, base_opt);
+	while ((this_opt = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			die(_("%s: %s cannot be used with %s"),
+				me, this_opt, base_opt);
+	}
+	va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
@@ -116,6 +132,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
+	if (opts->allow_ff)
+		verify_opt_compatible(me, "--ff",
+				"--signoff", opts->signoff,
+				"--no-commit", opts->no_commit,
+				"-x", opts->record_origin,
+				"--edit", opts->edit,
+				NULL);
 	opts->commit_argv = argv;
 }
 
@@ -556,17 +579,6 @@ static int pick_commits(struct replay_opts *opts)
 	struct commit *commit;
 
 	setenv(GIT_REFLOG_ACTION, me, 0);
-	if (opts->allow_ff) {
-		if (opts->signoff)
-			die(_("cherry-pick --ff cannot be used with --signoff"));
-		if (opts->no_commit)
-			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (opts->record_origin)
-			die(_("cherry-pick --ff cannot be used with -x"));
-		if (opts->edit)
-			die(_("cherry-pick --ff cannot be used with --edit"));
-	}
-
 	read_and_refresh_cache(me, opts);
 
 	prepare_revs(&revs, opts);
-- 
1.7.5.GIT
