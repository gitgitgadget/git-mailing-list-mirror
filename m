From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] introduce strbuf_addpath()
Date: Fri, 18 Nov 2011 08:42:35 +0700
Message-ID: <20111118014235.GA10917@tre>
References: <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
 <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
 <20111116085944.GA18781@elie.hsd1.il.comcast.net>
 <20111116215004.GA29872@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 02:38:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRDPs-0005lH-7W
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 02:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab1KRBio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 20:38:44 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42941 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab1KRBin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 20:38:43 -0500
Received: by yenq3 with SMTP id q3so1893471yen.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 17:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B1miT4IENjMkfHtDyaqd+ybh6qG8MNye3h4XGCiqVBA=;
        b=sqdlbFsbqINIJJrG8jEZeihqObFFLjV1gch+DH+ekQawfGQLR+0EjFk6LpF3m3oP1/
         uQKwMRj5nPkPqSkLd8Nev+aYnUHfA4hfwARpKWBB3acQtzXuAbfalzufvZ1VNVkG95RU
         KgzDrB/US9LEJTp6GNmS4SRxEoGBHHLdAnqZk=
Received: by 10.50.194.229 with SMTP id hz5mr992219igc.36.1321580322313;
        Thu, 17 Nov 2011 17:38:42 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id ai7sm27016062igc.0.2011.11.17.17.38.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 17:38:41 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 18 Nov 2011 08:42:35 +0700
Content-Disposition: inline
In-Reply-To: <20111116215004.GA29872@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185619>

On Wed, Nov 16, 2011 at 03:50:04PM -0600, Jonathan Nieder wrote:
> strbuf_addpath() is like git_path_unsafe(), except instead of
> returning its own buffer, it appends its result to a buffer provided
> by the caller.
> 
> Benefits:
> 
>  - Since it uses a caller-supplied buffer, unlike git_path_unsafe(),
>    there is no risk that one call will clobber the result from
>    another.
> 
>  - Unlike git_pathdup(), it does not need to waste time allocating
>    memory in the middle of your tight loop over refs.
> 
>  - The size of the result is not limited to PATH_MAX.
> 
> Caveat: the size of its result is not limited to PATH_MAX.  Existing
> code might be relying on git_path*() to produce a result that is safe
> to copy to a PATH_MAX-sized buffer.  Be careful.
> 
> This patch introduces the strbuf_addpath() function and converts a few
> existing users of the strbuf_addstr(git_path(...)) idiom to
> demonstrate the API.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jonathan Nieder wrote:
> 
> > I think if I ran the world, the fundamental operation would be
> > strbuf_addpath().
> 
> Like this, maybe.
> 


If I ran the world, I would change get_pathname() to return "struct
strbuf *" instead and change "char *git_path(..)" to "const char *git_path(...)".
Code paths that want to modify git_path() return value could
just use strbuf_addpath()

I did try to turn git_path to return const char *, the following patch
seems to make it build without any warnings

-- 8< --
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c6bc8eb..fd7c682 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1041,7 +1041,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	if (args.depth > 0) {
 		struct cache_time mtime;
 		struct strbuf sb = STRBUF_INIT;
-		char *shallow = git_path("shallow");
+		const char *shallow = git_path("shallow");
 		int fd;
 
 		mtime.sec = st.st_mtime;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 91731b9..261f1a0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -367,7 +367,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
-	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
+	const char *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
+	char *url;
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -647,7 +648,7 @@ static void check_not_current_branch(struct ref *ref_map)
 
 static int truncate_fetch_head(void)
 {
-	char *filename = git_path("FETCH_HEAD");
+	const char *filename = git_path("FETCH_HEAD");
 	FILE *fp = fopen(filename, "w");
 
 	if (!fp)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0e0e17a..f9624d7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -215,12 +215,12 @@ static void check_unreachable_object(struct object *obj)
 		printf("dangling %s %s\n", typename(obj->type),
 		       sha1_to_hex(obj->sha1));
 		if (write_lost_and_found) {
-			char *filename = git_path("lost-found/%s/%s",
+			const char *filename = git_path("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
 				sha1_to_hex(obj->sha1));
 			FILE *f;
 
-			if (safe_create_leading_directories(filename)) {
+			if (safe_create_leading_directories_const(filename)) {
 				error("Could not create lost-found");
 				return;
 			}
diff --git a/builtin/remote.c b/builtin/remote.c
index 583eec9..0662d37 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -587,7 +587,7 @@ static int migrate_file(struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int i;
-	char *path = NULL;
+	const char *path = NULL;
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url_nr; i++)
diff --git a/fast-import.c b/fast-import.c
index 8d8ea3c..4293a9f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -403,7 +403,7 @@ static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
 
 static void write_crash_report(const char *err)
 {
-	char *loc = git_path("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
+	const char *loc = git_path("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
 	FILE *rpt = fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
diff --git a/notes-merge.c b/notes-merge.c
index e33c2c9..8da2e0a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -288,7 +288,7 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 				    "(%s exists).", git_path("NOTES_MERGE_*"));
 		}
 
-		if (safe_create_leading_directories(git_path(
+		if (safe_create_leading_directories_const(git_path(
 				NOTES_MERGE_WORKTREE "/.test")))
 			die_errno("unable to create directory %s",
 				  git_path(NOTES_MERGE_WORKTREE));
@@ -303,8 +303,8 @@ static void write_buf_to_worktree(const unsigned char *obj,
 				  const char *buf, unsigned long size)
 {
 	int fd;
-	char *path = git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
-	if (safe_create_leading_directories(path))
+	const char *path = git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
+	if (safe_create_leading_directories_const(path))
 		die_errno("unable to create directory for '%s'", path);
 	if (file_exists(path))
 		die("found existing file at '%s'", path);
diff --git a/refs.c b/refs.c
index 62d8a37..7469cf1 100644
--- a/refs.c
+++ b/refs.c
@@ -1189,7 +1189,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1, int flags, int *type_p)
 {
-	char *ref_file;
+	const char *ref_file;
 	const char *orig_ref = ref;
 	struct ref_lock *lock;
 	int last_errno = 0;
@@ -1250,7 +1250,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
 		lock->force_write = 1;
 
-	if (safe_create_leading_directories(ref_file)) {
+	if (safe_create_leading_directories_const(ref_file)) {
 		last_errno = errno;
 		error("unable to create directory for %s", ref_file);
 		goto error_return;
@@ -1411,7 +1411,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		}
 	}
 
-	if (log && safe_create_leading_directories(git_path("logs/%s", newref))) {
+	if (log && safe_create_leading_directories_const(git_path("logs/%s", newref))) {
 		error("unable to create directory for %s", newref);
 		goto rollback;
 	}
-- 8< --
