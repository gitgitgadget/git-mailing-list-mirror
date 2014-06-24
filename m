From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH (performance tracing)] test git-status performance
Date: Wed, 25 Jun 2014 00:56:40 +0200
Message-ID: <53AA0228.4080600@gmail.com>
References: <53AA0129.1080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzZdt-0003D4-NY
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 00:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbaFXW4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 18:56:42 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:54255 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaFXW4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 18:56:41 -0400
Received: by mail-we0-f172.google.com with SMTP id u57so1077778wes.17
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=k70xSI0UMNbOvmLJ0d0JAgf9/Ou8xF+bDpIgUs9oPy4=;
        b=SORaPCtRrA4IAwJfZC7q0nRlFfSs5mC/ktgl3zKZ0jZQZm1p22MVRLS1kaOItg54jv
         aDJgaaBwe6Q74JmTlt8XlNTYhsUwSCeIv0zP4+Ta9PmSaaiUNkrgOVA1XjTW1k/DbIkp
         WOFOL6dF/U3MRyRzV/Yfgvru6H09KgT7KIsWlEU1NetkzP9HyjwTseuIj3P/zHHKhzVc
         /zCbNmfridahWu2Tn1GUy2zhjzkBO4RpM/bnUwRkilBrP+kYLt8htD+4EuI43iXX8+p2
         VKbRxoJ0EefM3Nq8GXW3UjlvULiUHOBfWZ00nA07FxqSHKXYLiHqYgu9wA94ZQIYmuoX
         WTqw==
X-Received: by 10.180.211.106 with SMTP id nb10mr37683611wic.9.1403650599995;
        Tue, 24 Jun 2014 15:56:39 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id l5sm5824348wif.22.2014.06.24.15.56.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 15:56:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53AA0129.1080109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252424>

Add trace_performance output to functions involved in git-status.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

Applies on top of performance-tracing topic.

 builtin/commit.c |  8 ++++++++
 preload-index.c  |  4 ++++
 read-cache.c     |  2 ++
 wt-status.c      | 11 +++++++++++
 4 files changed, 25 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 94eb8a3..6a38fa2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1322,9 +1322,11 @@ static int git_status_config(const char *k, const char *v, void *cb)
 
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
+	uint64_t start = getnanotime();
 	static struct wt_status s;
 	int fd;
 	unsigned char sha1[20];
+
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_SET_INT('s', "short", &status_format,
@@ -1369,13 +1371,19 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
+	trace_performance_since(start, "cmd_status:setup");
+
 	read_cache_preload(&s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
 
+	start = getnanotime();
+
 	fd = hold_locked_index(&index_lock, 0);
 	if (0 <= fd)
 		update_index_if_able(&the_index, &index_lock);
 
+	trace_performance_since(start, "cmd_status:update_index");
+
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	wt_status_collect(&s);
diff --git a/preload-index.c b/preload-index.c
index 968ee25..189c5a4 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -33,6 +33,7 @@ struct thread_data {
 
 static void *preload_thread(void *_data)
 {
+	uint64_t start = getnanotime();
 	int nr;
 	struct thread_data *p = _data;
 	struct index_state *index = p->index;
@@ -64,6 +65,7 @@ static void *preload_thread(void *_data)
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
+	trace_performance_since(start, "preload_thread");
 	return NULL;
 }
 
@@ -106,8 +108,10 @@ static void preload_index(struct index_state *index,
 int read_index_preload(struct index_state *index,
 		       const struct pathspec *pathspec)
 {
+	uint64_t start = getnanotime();
 	int retval = read_index(index);
 
 	preload_index(index, pathspec);
+	trace_performance_since(start, "read_index_preload");
 	return retval;
 }
diff --git a/read-cache.c b/read-cache.c
index 132d032..5c6b763 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1136,6 +1136,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
 {
+	uint64_t start = getnanotime();
 	int i;
 	int has_errors = 0;
 	int really = (flags & REFRESH_REALLY) != 0;
@@ -1222,6 +1223,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		replace_index_entry(istate, i, new);
 	}
+	trace_performance_since(start, "refresh_index");
 	return has_errors;
 }
 
diff --git a/wt-status.c b/wt-status.c
index 318a191..a744565 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -623,13 +623,24 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
+	uint64_t start = getnanotime();
+
 	wt_status_collect_changes_worktree(s);
 
+	trace_performance_since(start, "wt_status_collect_changes_worktree");
+	start = getnanotime();
+
 	if (s->is_initial)
 		wt_status_collect_changes_initial(s);
 	else
 		wt_status_collect_changes_index(s);
+
+	trace_performance_since(start, "wt_status_collect_changes_index");
+	start = getnanotime();
+
 	wt_status_collect_untracked(s);
+
+	trace_performance_since(start, "wt_status_collect_untracked");
 }
 
 static void wt_status_print_unmerged(struct wt_status *s)
-- 
1.9.4.msysgit.0.1.gc8a51b4
