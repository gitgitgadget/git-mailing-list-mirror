From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Mon, 18 Mar 2013 22:28:06 -0700
Message-ID: <20130319052805.GO5062@elie.Belkin>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
 <20130319034822.GL5062@elie.Belkin>
 <7vli9kkoci.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 06:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHp6F-0004uQ-LX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 06:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab3CSF2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 01:28:12 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:39913 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3CSF2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 01:28:11 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so79923dak.30
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 22:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/QjBlOuwba3TVf/t0924G777waPumNql7qOXdk7x4EY=;
        b=ls/t3Q63EjxM65ax47l+wshvQ0b+Nypfwbknl8OT0n3mV32bDafIwQRXXsmNDuPkr4
         CAKU4MNHxldfvNt/TxvlUVmBPzXxTj6rnDuGGp+szX0lHqlwoILdlyOiNc8BlZGi5ZGc
         kQP2ybNgfQ9J/mYybpbxs6dqUwVio3GtJ514xta/EGc+3eYDWnYYgA7cMEaQuN9r++Ms
         huu0AhbfOEc77i6j7RMgv24+czVGUoUgiUXf2jbLiq8On7V+uEvSh071qXhSqhc5+y6A
         e59afu5dkwsXe9HDjZDtQQlzO46Rvzpq0Qt1+7Aful/oij3H2R4HjRZKvxvgJzteGjv7
         PhRQ==
X-Received: by 10.68.198.34 with SMTP id iz2mr1059635pbc.148.1363670891253;
        Mon, 18 Mar 2013 22:28:11 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id hp1sm11084379pac.3.2013.03.18.22.28.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 22:28:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vli9kkoci.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218482>

Junio C Hamano wrote:

> The implemenation appears to run an extra diff_files() in addition
> to the one we already have to run in order to implement the "add -u"
> to collect modified/deleted paths.  Is that the best we can do?  
>
> I am wondering if we can special case the no-pathspec case to have
> add_files_to_cache() call underlying run_diff_files() without any
> pathspec, inspect the paths that are modified and/or deleted in the
> update_callback, add ones that are under the $prefix while noticing
> the ones outside as warning worthy events.

Yes, that can work, for example like this (replacing the patch you're
replying to).

-- >8 --
Subject: add -u: only show pathless 'add -u' warning when changes exist outside cwd

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
 builtin/add.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a424e69d..e3ed5d93 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,6 +26,7 @@ static int take_worktree_changes;
 struct update_callback_data {
 	int flags;
 	int add_errors;
+	const char **implicit_dot;
 };
 
 static const char *option_with_implicit_dot;
@@ -94,10 +95,26 @@ static void update_callback(struct diff_queue_struct *q,
 {
 	int i;
 	struct update_callback_data *data = cbdata;
+	const char **implicit_dot = data->implicit_dot;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
+
+		/*
+		 * Check if "git add -A" or "git add -u" was run from a
+		 * subdirectory with a modified file outside that directory,
+		 * and warn if so.
+		 *
+		 * "git add -u" will behave like "git add -u :/" instead of
+		 * "git add -u ." in the future.  This warning prepares for
+		 * that change.
+		 */
+		if (implicit_dot &&
+		    !match_pathspec(implicit_dot, path, strlen(path), 0, NULL)) {
+			warn_pathless_add();
+			continue;
+		}
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
@@ -121,17 +138,30 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
+#define ADD_CACHE_IMPLICIT_DOT 32
 int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
+
+	data.flags = flags & ~ADD_CACHE_IMPLICIT_DOT;
+	data.add_errors = 0;
+	data.implicit_dot = NULL;
+	if (flags & ADD_CACHE_IMPLICIT_DOT) {
+		/*
+		 * Check for modified files throughout the worktree so
+		 * update_callback has a chance to warn about changes
+		 * outside the cwd.
+		 */
+		data.implicit_dot = pathspec;
+		pathspec = NULL;
+	}
+
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	init_pathspec(&rev.prune_data, pathspec);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
-	data.flags = flags;
-	data.add_errors = 0;
 	rev.diffopt.format_callback_data = &data;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
@@ -371,6 +401,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	int implicit_dot = 0;
 
 	git_config(add_config, NULL);
 
@@ -400,10 +431,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
@@ -416,7 +448,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0)) |
+		 (implicit_dot ? ADD_CACHE_IMPLICIT_DOT : 0);
 
 	if (require_pathspec && argc == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-- 
1.8.2.rc3
