From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/32] Split index mode for very large indexes
Date: Thu, 1 May 2014 07:09:05 +0700
Message-ID: <20140501000905.GA2107@lanh>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
 <53616185.9000208@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu May 01 02:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfeXN-0008Gn-BQ
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 02:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbaEAAHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 20:07:37 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:65388 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbaEAAHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 20:07:36 -0400
Received: by mail-ie0-f177.google.com with SMTP id rp18so2816874iec.22
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/m9/FYs4ouva5Ez/c5xvdpLzSE3UVqq16pLXb+4kHDw=;
        b=ofOhwQGjvFlarFKespxnwDLDvLDrXBduJDbYcjIDdL5PTwlPiZ3R+TAZpSlp7grYdd
         hG4M2bMPSdQ1poSjliQlqPUJ0HkmpbtLv7MZ4plwoMrUTecB2dPSNCYASC08VypxieH8
         mH3qwx1fTL0Nru5bHKsePThSG3r/2onjFBBShPxy4tTgsSIG2gL3EykTC3Ir+BXu4vTV
         +XbM9a4FHpZOU0jscHolyKNkQZdDQVWuIGdzUYphgrBFkM0oSbbY+Sxw8odq/QDTpiys
         ocFgDVVhFlt+v39Q7BngEIUprMSpyRIVtXlcx+rPsZp7UWbCatmyCSyFY78kYD4f5Z38
         ZjpA==
X-Received: by 10.50.143.104 with SMTP id sd8mr8710687igb.18.1398902855643;
        Wed, 30 Apr 2014 17:07:35 -0700 (PDT)
Received: from lanh ([115.73.216.45])
        by mx.google.com with ESMTPSA id rt10sm140494igb.15.2014.04.30.17.07.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 17:07:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 01 May 2014 07:09:05 +0700
Content-Disposition: inline
In-Reply-To: <53616185.9000208@bbn.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247802>

On Wed, Apr 30, 2014 at 04:48:05PM -0400, Richard Hansen wrote:
> I played around with these changes a bit and have some questions:
> 
>   * These changes should only affect performance when the index is
>     updated, right?  In other words, if I do "git status; git status"
>     the second "git status" shouldn't update the index and therefore
>     shouldn't have a noticeable performance improvement relative to Git
>     without these patches.  Right?

Yes, provided that other factors in "git status" give stable numbers
too.

>   * Do you have any before/after benchmark results you can share?

I did not pay much attention to benchmarking because the index size is
pretty much the deciding factor to write performance (of course too
much computation could add up to that..). But here it is with the 14MB
webkit index, about 182k files. The lines of interest are the first
one (read_cache) and forth (update_index_if_able).

With normal index

pclouds@lanh ~/d/webkit $ time ~/w/git/git status >/dev/null
   278.382ms gitmodules_config:199 if (read_cache() < 0) die("index file
     0.004ms cmd_status:1294 read_cache_preload(&s.pathspec);
   489.275ms cmd_status:1295 refresh_index(&the_index, REFRESH_QUIE
     6.191ms cmd_status:1299 update_index_if_able(&the_index, &inde
    12.321ms wt_status_collect:616 wt_status_collect_changes_worktree(s)
    12.733ms wt_status_collect:621 wt_status_collect_changes_index(s)
    98.043ms lazy_init_name_hash:136 { int nr; if (istate->name_hash_initia
   915.331ms wt_status_collect:622 wt_status_collect_untracked(s)

real    0m1.727s
user    0m0.809s
sys     0m0.915s
pclouds@lanh ~/d/webkit $ touch wscript
pclouds@lanh ~/d/webkit $ time ~/w/git/git status >/dev/null
   276.307ms gitmodules_config:199 if (read_cache() < 0) die("index file
     0.004ms cmd_status:1294 read_cache_preload(&s.pathspec);
   504.034ms cmd_status:1295 refresh_index(&the_index, REFRESH_QUIE
   356.122ms cmd_status:1299 update_index_if_able(&the_index, &inde
    11.870ms wt_status_collect:616 wt_status_collect_changes_worktree(s)
    10.077ms wt_status_collect:621 wt_status_collect_changes_index(s)
    96.205ms lazy_init_name_hash:136 { int nr; if (istate->name_hash_initia
   899.425ms wt_status_collect:622 wt_status_collect_untracked(s)

real    0m2.071s
user    0m1.115s
sys     0m0.953s
pclouds@lanh ~/d/webkit $ time ~/w/git/git status >/dev/null
   279.424ms gitmodules_config:199 if (read_cache() < 0) die("index file
     0.004ms cmd_status:1294 read_cache_preload(&s.pathspec);
   484.303ms cmd_status:1295 refresh_index(&the_index, REFRESH_QUIE
     5.288ms cmd_status:1299 update_index_if_able(&the_index, &inde
    13.927ms wt_status_collect:616 wt_status_collect_changes_worktree(s)
    12.507ms wt_status_collect:621 wt_status_collect_changes_index(s)
    98.220ms lazy_init_name_hash:136 { int nr; if (istate->name_hash_initia
   920.985ms wt_status_collect:622 wt_status_collect_untracked(s)

real    0m1.731s
user    0m0.830s
sys     0m0.897s

And with split index:

pclouds@lanh ~/d/webkit $ time ~/w/git/git update-index --split-index

real    0m0.660s
user    0m0.601s
sys     0m0.058s
pclouds@lanh ~/d/webkit $ time ~/w/git/git status >/dev/null
   281.211ms gitmodules_config:199 if (read_cache() < 0) die("index file
     0.003ms cmd_status:1294 read_cache_preload(&s.pathspec);
   479.629ms cmd_status:1295 refresh_index(&the_index, REFRESH_QUIE
     5.489ms cmd_status:1299 update_index_if_able(&the_index, &inde
    12.611ms wt_status_collect:616 wt_status_collect_changes_worktree(s)
    11.235ms wt_status_collect:621 wt_status_collect_changes_index(s)
    96.086ms lazy_init_name_hash:136 { int nr; if (istate->name_hash_initia
   894.489ms wt_status_collect:622 wt_status_collect_untracked(s)

real    0m1.697s
user    0m0.813s
sys     0m0.881s
pclouds@lanh ~/d/webkit $ touch wscript
pclouds@lanh ~/d/webkit $ time ~/w/git/git status >/dev/null
   291.411ms gitmodules_config:199 if (read_cache() < 0) die("index file
     0.003ms cmd_status:1294 read_cache_preload(&s.pathspec);
   475.144ms cmd_status:1295 refresh_index(&the_index, REFRESH_QUIE
    24.348ms cmd_status:1299 update_index_if_able(&the_index, &inde
    12.440ms wt_status_collect:616 wt_status_collect_changes_worktree(s)
    10.400ms wt_status_collect:621 wt_status_collect_changes_index(s)
    97.147ms lazy_init_name_hash:136 { int nr; if (istate->name_hash_initia
   907.240ms wt_status_collect:622 wt_status_collect_untracked(s)

real    0m1.734s
user    0m0.842s
sys     0m0.888s
pclouds@lanh ~/d/webkit $ time ~/w/git/git status >/dev/null
   281.119ms gitmodules_config:199 if (read_cache() < 0) die("index file
     0.004ms cmd_status:1294 read_cache_preload(&s.pathspec);
   479.702ms cmd_status:1295 refresh_index(&the_index, REFRESH_QUIE
     5.061ms cmd_status:1299 update_index_if_able(&the_index, &inde
    12.220ms wt_status_collect:616 wt_status_collect_changes_worktree(s)
    11.408ms wt_status_collect:621 wt_status_collect_changes_index(s)
    95.374ms lazy_init_name_hash:136 { int nr; if (istate->name_hash_initia
   896.931ms wt_status_collect:622 wt_status_collect_untracked(s)

real    0m1.700s
user    0m0.809s
sys     0m0.888s

>   * Are there any benchmark scripts I can use to test it out in my own
>     repositories?

You could use the patch I used to generate the timing above. Patch at
the bottom of this mail.

>   * Is there a debug utility I can use to examine the contents of the
>     index and sharedindex.* files in a more human-readable way?

test-dump-split-index <path-to-$GIT_DIR/index>

will show you the content of "index". Entries without names are
replaced entries. Entries with them are added. They are followed by
replace/delete bitmaps printed out. So pretty much everything stored
in $GIT_DIR/index in human-readable format.

git rev-parse --shared-index-path will give you the path to
sharedindex. ls-files --stage can be used to show that.

> I'm asking because in my (very basic) tests I noticed that with the
> following command:
> 
>     git status; time git status
> 
> the second "git status" had an unexpected ~20% performance improvement
> in my repo relative to a build without your patches.  The second "git
> status" in the following command also had about a ~20% performance
> improvement:
> 
>     git status; touch file-in-index; time git status
> 
> So it seems like the patches did improve performance somewhat, but in
> ways I wasn't expecting.  (I'm not entirely certain my benchmark method
> is sound.)

git-status is a complex operation. If you want to focus on this
writing part only, "git update-index" may be better.

And the timing patch:

-- 8< --
diff --git a/builtin/commit.c b/builtin/commit.c
index 243b0c3..d680a44 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1291,12 +1291,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
-	read_cache_preload(&s.pathspec);
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
+	TIME(read_cache_preload(&s.pathspec););
+	TIME(refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL););
 
 	fd = hold_locked_index(&index_lock, 0);
 	if (0 <= fd)
-		update_index_if_able(&the_index, &index_lock);
+		TIME(update_index_if_able(&the_index, &index_lock));
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.ignore_submodule_arg = ignore_submodule_arg;
diff --git a/cache.h b/cache.h
index 6ad2595..99854c7 100644
--- a/cache.h
+++ b/cache.h
@@ -1480,4 +1480,21 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 
 int versioncmp(const char *s1, const char *s2);
 
+#define TIME(x) {						\
+	extern int time_level__;				\
+	struct timeval	tv1, tv2;				\
+	int current_level = time_level__;		\
+	gettimeofday(&tv1, NULL);				\
+	time_level__++;						\
+	x;							\
+	time_level__--;						\
+	gettimeofday(&tv2, NULL);				\
+	fprintf(stderr, "% 10.3fms%*s%s:%d %.*s\n",		\
+		tv2.tv_sec * 1000.0 + tv2.tv_usec / 1000.0 -	\
+		tv1.tv_sec * 1000.0 - tv1.tv_usec / 1000.0,	\
+		current_level, " ",				\
+		__FUNCTION__, __LINE__, 38, #x			\
+		);						\
+	}
+
 #endif /* CACHE_H */
diff --git a/environment.c b/environment.c
index 5c4815d..5dcbc6b 100644
--- a/environment.c
+++ b/environment.c
@@ -63,6 +63,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+int time_level__;
 
 /*
  * The character that begins a commented line in user-editable file
diff --git a/name-hash.c b/name-hash.c
index 97444d0..b9121d1 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -122,7 +122,7 @@ static int cache_entry_cmp(const struct cache_entry *ce1,
 }
 
 static void lazy_init_name_hash(struct index_state *istate)
-{
+	TIME({
 	int nr;
 
 	if (istate->name_hash_initialized)
@@ -133,7 +133,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized = 1;
-}
+		})
 
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 {
diff --git a/submodule.c b/submodule.c
index b80ecac..1947f20 100644
--- a/submodule.c
+++ b/submodule.c
@@ -195,8 +195,8 @@ void gitmodules_config(void)
 		int pos;
 		strbuf_addstr(&gitmodules_path, work_tree);
 		strbuf_addstr(&gitmodules_path, "/.gitmodules");
-		if (read_cache() < 0)
-			die("index file corrupt");
+		TIME(if (read_cache() < 0)
+			die("index file corrupt"););
 		pos = cache_name_pos(".gitmodules", 11);
 		if (pos < 0) { /* .gitmodules not found or isn't merged */
 			pos = -1 - pos;
diff --git a/wt-status.c b/wt-status.c
index ec7344e..0141856 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -613,13 +613,13 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
-	wt_status_collect_changes_worktree(s);
+	TIME(wt_status_collect_changes_worktree(s));
 
 	if (s->is_initial)
 		wt_status_collect_changes_initial(s);
 	else
-		wt_status_collect_changes_index(s);
-	wt_status_collect_untracked(s);
+		TIME(wt_status_collect_changes_index(s));
+	TIME(wt_status_collect_untracked(s));
 }
 
 static void wt_status_print_unmerged(struct wt_status *s)
-- 8< --
