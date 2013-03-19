From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] add -u: only show pathless 'add -u' warning when changes
 exist outside cwd
Date: Mon, 18 Mar 2013 20:48:22 -0700
Message-ID: <20130319034822.GL5062@elie.Belkin>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 04:48:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHnXi-0003Sy-U3
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 04:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab3CSDs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 23:48:28 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:36042 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3CSDs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 23:48:27 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so29195daj.36
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 20:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RS06FXS+fNobETPTIwlfZXZinRIqyN6l3Iq+ukWgWkE=;
        b=dm8OU/1tRtNaNRDclMRezBFM9VqhhtudijzgWTLcum9ixCJa8rUt9luCU1U+I7uqc7
         qFPtaJNOBQjD6bJkVPiktESFdYBkG47GO0KPVFn3GsiKfGaG2opmMaNP15RUyvfNe43G
         j53AabRPrkdKvt4ku6IWa18W/l6sx2JrxHdrC+qIVuOqRmrHw9nKm5auOnsZQKMm7zBt
         ho8pkCbqgAo6cf+J7TAd4LC4MA7wplBHvItQ02w2GZMWhXjcuO/axYPaILkjhXSn/BBg
         OB9MNbDZHehmEmovye3+Rd8jYf3AyqninepRunDbIEjaxOpsPU62jeAGIv/g7h+OYFHm
         Kv6Q==
X-Received: by 10.66.182.227 with SMTP id eh3mr1071464pac.6.1363664907123;
        Mon, 18 Mar 2013 20:48:27 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id z1sm22501866pbw.19.2013.03.18.20.48.25
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 20:48:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319034415.GI5062@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218476>

A common workflow in large projects is to chdir into a subdirectory of
interest and only do work there:

	cd src
	vi foo.c
	make test
	git add -u
	git commit

The upcoming change to 'git add -u' behavior would not affect such a
workflow: when the only changes present are in the current directory,
'git add -u' will add all changes, and whether that happens via an
implicit "." or implicit ":/" parameter is an unimportant
implementation detail.

The warning about use of 'git add -u' with no pathspec is annoying
because it serves no purpose in this case.  So suppress the warning
unless there are changes outside the cwd that are not being added.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a424e69d..f05ec1c1 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -89,6 +89,22 @@ static int fix_unmerged_status(struct diff_filepair *p,
 		return DIFF_STATUS_MODIFIED;
 }
 
+static void warn_if_outside_pathspec(struct diff_queue_struct *q,
+				     struct diff_options *opt, void *cbdata)
+{
+	int i;
+	const char **pathspec = cbdata;
+
+	for (i = 0; i < q->nr; i++) {
+		const char *path = q->queue[i]->one->path;
+
+		if (!match_pathspec(pathspec, path, strlen(path), 0, NULL)) {
+			warn_pathless_add();
+			return;
+		}
+	}
+}
+
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt, void *cbdata)
 {
@@ -121,20 +137,26 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
+static void diff_files_with_callback(const char *prefix, const char **pathspec,
+				     diff_format_fn_t callback, void *data)
 {
-	struct update_callback_data data;
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	init_pathspec(&rev.prune_data, pathspec);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = update_callback;
-	data.flags = flags;
-	data.add_errors = 0;
-	rev.diffopt.format_callback_data = &data;
+	rev.diffopt.format_callback = callback;
+	rev.diffopt.format_callback_data = data;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+}
+
+int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
+{
+	struct update_callback_data data;
+	data.flags = flags;
+	data.add_errors = 0;
+	diff_files_with_callback(prefix, pathspec, update_callback, &data);
 	return !!data.add_errors;
 }
 
@@ -371,6 +393,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	int implicit_dot = 0;
 
 	git_config(add_config, NULL);
 
@@ -400,10 +423,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	if (option_with_implicit_dot && !argc) {
 		static const char *here[2] = { ".", NULL };
-		if (prefix)
+		if (prefix && addremove)
 			warn_pathless_add();
 		argc = 1;
 		argv = here;
+		implicit_dot = 1;
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
@@ -450,6 +474,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		goto finish;
 	}
 
+	/*
+	 * Check if "git add -A" or "git add -u" was run from a
+	 * subdirectory with a modified file outside that directory,
+	 * and warn if so.
+	 *
+	 * "git add -u" will behave like "git add -u :/" instead of
+	 * "git add -u ." in the future.  This warning prepares for
+	 * that change.
+	 */
+	if (implicit_dot)
+		diff_files_with_callback(prefix, NULL,
+				warn_if_outside_pathspec, pathspec);
+
 	if (pathspec) {
 		int i;
 		struct path_exclude_check check;
-- 
1.8.2.rc3
