From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] shortstatus: a new command
Date: Thu, 6 Aug 2009 11:33:39 -0400
Message-ID: <20090806153339.GC1970@coredump.intra.peff.net>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
 <1249463746-21538-5-git-send-email-gitster@pobox.com>
 <1249463746-21538-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4yY-0000Nx-DN
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbZHFPdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbZHFPdo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:33:44 -0400
Received: from peff.net ([208.65.91.99]:53023 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbZHFPdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 11:33:43 -0400
Received: (qmail 32317 invoked by uid 107); 6 Aug 2009 15:35:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 Aug 2009 11:35:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2009 11:33:39 -0400
Content-Disposition: inline
In-Reply-To: <1249463746-21538-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125087>

On Wed, Aug 05, 2009 at 02:15:46AM -0700, Junio C Hamano wrote:

> ---
>  Makefile         |    1 +
>  builtin-commit.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin.h        |    1 +
>  git.c            |    1 +

Missing docs, of course, and tests would be nice. Is this meant to be
plumbing? If not, the name is too long to type. ;)

> +int cmd_shortstatus(int argc, const char **argv, const char *prefix)
> +{
> +	struct wt_status s;
> +	static int null_termination;
> +	int i;
> +	static struct option builtin_shortstatus_options[] = {
> +		OPT_BOOLEAN('z', "null", &null_termination,
> +			    "terminate entries with NUL"),
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_shortstatus_options,
> +			     builtin_shortstatus_usage, 0);

I think one of the most often-requested things for a "git status"
replacement is that "git status <path>" do path-limiting. Something like
(the extremely not very well tested):

---
diff --git a/builtin-commit.c b/builtin-commit.c
index 7a4ddab..8bc6269 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -891,7 +891,12 @@ int cmd_shortstatus(int argc, const char **argv, const char *prefix)
 
 	read_cache();
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
+
 	wt_status_prepare(&s);
+	ALLOC_GROW(s.path_limit, s.path_limit_nr + argc, s.path_limit_alloc);
+	for (i = 0; i < argc; i++)
+		s.path_limit[s.path_limit_nr++] = argv[i];
+
 	wt_status_collect_changes(&s);
 	for (i = 0; i < s.change.nr; i++) {
 		struct wt_status_change_data *d;
diff --git a/wt-status.c b/wt-status.c
index 5a68297..7399e1b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -60,6 +60,12 @@ void wt_status_prepare(struct wt_status *s)
 	s->fp = stdout;
 	s->index_file = get_index_file();
 	s->change.strdup_strings = 1;
+
+	s->path_limit = xmalloc(2 * sizeof(*s->path_limit));
+	s->path_limit_nr = 1;
+	s->path_limit_alloc = 2;
+	s->path_limit[0] = "dummy argv[0]";
+	s->path_limit[1] = NULL;
 }
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
@@ -283,7 +289,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	struct rev_info rev;
 
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, NULL);
+	setup_revisions(s->path_limit_nr, s->path_limit, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
@@ -295,7 +301,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	struct rev_info rev;
 
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev,
+	setup_revisions(s->path_limit_nr, s->path_limit, &rev,
 		s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
@@ -315,6 +321,10 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 		struct wt_status_change_data *d;
 		struct cache_entry *ce = active_cache[i];
 
+		if (match_pathspec(s->path_limit + 1,
+				ce->name, strlen(ce->name), 0, NULL))
+			continue;
+
 		it = string_list_insert(ce->name, &s->change);
 		d = it->util;
 		if (!d) {
@@ -477,7 +487,7 @@ static void wt_status_print_untracked(struct wt_status *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
 
-	fill_directory(&dir, NULL);
+	fill_directory(&dir, s->path_limit + 1);
 	for(i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (!cache_name_is_other(ent->name, ent->len))
@@ -559,6 +569,9 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
+	ALLOC_GROW(s->path_limit, s->path_limit_nr + 1, s->path_limit_alloc);
+	s->path_limit[s->path_limit_nr] = NULL;
+
 	wt_status_collect_changes(s);
 
 	if (s->is_initial) {
diff --git a/wt-status.h b/wt-status.h
index f80142f..3099e99 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -43,6 +43,8 @@ struct wt_status {
 	FILE *fp;
 	const char *prefix;
 	struct string_list change;
+	const char **path_limit;
+	int path_limit_nr, path_limit_alloc;
 };
 
 int git_status_config(const char *var, const char *value, void *cb);
