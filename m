From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 22/44] fetch.c: clear errno before calling functions
 that might set it
Date: Fri, 16 May 2014 11:33:48 -0700
Message-ID: <20140516183348.GC12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-23-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 20:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlMxA-0006oA-Bm
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294AbaEPSdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 14:33:52 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:38796 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbaEPSdv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 14:33:51 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so2896139pad.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/DA8Q28ELEuuM1C41iba4cydnHIyO+66EwO1ZB2teDk=;
        b=o9fOdoH7NvOXDOPtR7gFRBdHJEJdJaIu1milUJN+41OqUTbgbY7Tkuyw+ziE8NxxkD
         QuQI/w4HYAoHHlN1Z5IXauLwxmt+O1kB8Om97sjrwjd4Qzr6Y0OZdxaurZRvw/dl4I1T
         luCw//T7TWdWMrjXxDOmvAunFHsEOmrOVYIT8CcXFmQclU8TZJGI7RiQ0oqjQ9YSJ8Dn
         VpcBFt7UCJuzYug+0ZRrFbU2aFF1/inQsxLpG9xN1vp5h8m6oHVEQ05/59TleRV8lo3K
         6K2Ao2Qm94j311272UnDI3IbVlS7fV7HEFmfVmpqKRjlBxygwfZxuHZLYxFvvgv58WEe
         AyFw==
X-Received: by 10.68.237.228 with SMTP id vf4mr22935088pbc.131.1400265231176;
        Fri, 16 May 2014 11:33:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iv2sm15806257pbc.19.2014.05.16.11.33.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 11:33:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-23-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249407>

(cc-ing peff, who may remember this STORE_REF_ERROR_DF_CONFLICT case
 from long ago)
Ronnie Sahlberg wrote:

> In s_update_ref there are two calls that when they fail we return an error
> based on the errno value. In particular we want to return a specific error
> if ENOTDIR happened. Both these functions do have failure modes where they
> may return an error without updating errno

That's a bug.  Any function for which errno is supposed to be
meaningful when it returns an error should always set errno.
Otherwise errno may be set to ENOTDIR within the function by an
unrelated system call.

Functions that fail and lead callers to check errno, based on a quick
search with 'git grep -e 'errno *[!=]=':

 fopen
 lstat
 builtin/apply.c::try_create_file (= mkdir, symlink, or open)
 rmdir
 open
 mkdir
 unlink
 lock_any_ref_for_update 
 write_ref_sha1
 strtol
 kill
 odb_pack_keep
 opendir
 fgets
 read
 poll
 pread
 strtoimax
 strtoumax
 git_parse_int
 git_parse_int64
 git_parse_ulong
 write_in_full
 credential-cache.c::send_request
 fstat
 run_command_v_opt
 git.c::run_argv
 readlink
 resolve_ref_unsafe
 hold_lock_file_for_update
 unlink_or_warn
 rename
 execvp
 waitpid
 execv_git_cmd
 execv_shell_cmd
 sane_execvp
 stat
 read_object
 git_mkstemp_mode
 create_tmpfile
 start_command
 xwrite
 iconv
 fast_export_ls
 fast_export_ls_rev
 delete_ref

lock_any_ref_for_update has failure paths
 * check_ref_format [!]
 * lock_ref_sha1_basic

lock_ref_sha1_basic has failure paths
 * remove_empty_directories
 * resolve_ref_unsafe
 * safe_create_leading_directories
 * verify_lock

remove_empty_directories has one failure path
 * remove_dir_recursively
but could be more explicit about the need to preserve errno.

errno from remove_dir_recursively is meaningful.

resolve_ref_unsafe has failure paths
 * check_refname_format [!]
 * too much recursion [!]
 * lstat, readlink, open
 * handle_missing_loose_ref
 * read_in_full, but errno gets clobbered
 * invalid ref [!]
 * invalid symref [!]

verify_lock has failure paths
 * read_ref_full, but errno gets clobbered
 * old_sha1 didn't match [!]
 
write_ref_sha1 has failure paths
 * !lock [!]
 * missing object [!]
 * non-commit object [!]
 * write_in_full, close_ref, but errno gets clobbered
 * log_ref_write
 * commit_ref

log_ref_write has failure paths
 * log_ref_setup
 * write_in_full, close.  errno gets clobbered

commit_ref just calls commit_lock_file.

log_ref_setup has failure paths
 * safe_create_leading_directories, but errno gets clobbered
 * remove_empty_directories, but errno gets clobbered
 * open, but errno gets clobbered

safe_create_leading_directories doesn't set errno for SCLD_EXISTS
but otherwise its errno is useful.

That should cover the cases affecting the code path in fetch.c you
mentioned (I haven't checked the others).

How about something like this?

It's also tempting to teach vreportf and vwritef to save errno, which
would handle some of these cases automatically.

diff --git i/refs.c w/refs.c
index 82a8d4e..f98acf0 100644
--- i/refs.c
+++ w/refs.c
@@ -1333,8 +1333,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	if (flag)
 		*flag = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
 		return NULL;
+	}
 
 	for (;;) {
 		char path[PATH_MAX];
@@ -1342,8 +1344,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		char *buf;
 		int fd;
 
-		if (--depth < 0)
+		if (--depth < 0) {
+			errno = ELOOP;
 			return NULL;
+		}
 
 		git_snpath(path, sizeof(path), "%s", refname);
 
@@ -1405,9 +1409,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 				return NULL;
 		}
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
-		close(fd);
-		if (len < 0)
+		if (len < 0) {
+			int save_errno = errno;
+			close(fd);
+			errno = save_errno;
 			return NULL;
+		}
+		close(fd);
 		while (len && isspace(buffer[len-1]))
 			len--;
 		buffer[len] = '\0';
@@ -1424,6 +1432,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
 				if (flag)
 					*flag |= REF_ISBROKEN;
+				errno = EINVAL;
 				return NULL;
 			}
 			return refname;
@@ -1436,6 +1445,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flag)
 				*flag |= REF_ISBROKEN;
+			errno = EINVAL;
 			return NULL;
 		}
 		refname = strcpy(refname_buffer, buf);
@@ -1908,14 +1918,17 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
 	if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
+		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
+		errno = save_errno;
 		return NULL;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_name,
 			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
+		errno = EBUSY;
 		return NULL;
 	}
 	return lock;
@@ -1928,15 +1941,17 @@ static int remove_empty_directories(const char *file)
 	 * only empty directories), remove them.
 	 */
 	struct strbuf path;
-	int result;
+	int result, save_errno;
 
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
 	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
+	save_errno = errno;
 
 	strbuf_release(&path);
 
+	errno = save_errno;
 	return result;
 }
 
@@ -2137,8 +2152,10 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
 		return NULL;
+	}
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
@@ -2734,9 +2751,12 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(logfile) < 0)
-			return error("unable to create directory for %s",
-				     logfile);
+		if (safe_create_leading_directories(logfile) < 0) {
+			int save_errno = errno;
+			error("unable to create directory for %s", logfile);
+			errno = save_errno;
+			return -1;
+		}
 		oflags |= O_CREAT;
 	}
 
@@ -2747,15 +2767,21 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				return error("There are still logs under '%s'",
-					     logfile);
+				int save_errno = errno;
+				error("There are still logs under '%s'", logfile);
+				errno = save_errno;
+				return -1;
 			}
 			logfd = open(logfile, oflags, 0666);
 		}
 
-		if (logfd < 0)
-			return error("Unable to append to %s: %s",
+		if (logfd < 0) {
+			int save_errno = errno;
+			error("Unable to append to %s: %s",
 				     logfile, strerror(errno));
+			errno = save_errno;
+			return -1;
+		}
 	}
 
 	adjust_shared_perm(logfile);
@@ -2795,8 +2821,19 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 		len += copy_msg(logrec + len - 1, msg) - 1;
 	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
-	if (close(logfd) != 0 || written != len)
-		return error("Unable to append to %s", log_file);
+	if (written != len) {
+		int save_errno = errno;
+		close(logfd);
+		error("Unable to append to %s", log_file);
+		errno = save_errno;
+		return -1;
+	}
+	if (close(logfd)) {
+		int save_errno = errno;
+		error("Unable to append to %s", log_file);
+		errno = save_errno;
+		return -1;
+	}
 	return 0;
 }
 
@@ -2811,8 +2848,10 @@ int write_ref_sha1(struct ref_lock *lock,
 	static char term = '\n';
 	struct object *o;
 
-	if (!lock)
+	if (!lock) {
+		errno = EINVAL;
 		return -1;
+	}
 	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
 		unlock_ref(lock);
 		return 0;
@@ -2822,26 +2861,32 @@ int write_ref_sha1(struct ref_lock *lock,
 		error("Trying to write ref %s with nonexistent object %s",
 			lock->ref_name, sha1_to_hex(sha1));
 		unlock_ref(lock);
+		errno = EINVAL;
 		return -1;
 	}
 	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 		error("Trying to write non-commit object %s to branch %s",
 			sha1_to_hex(sha1), lock->ref_name);
 		unlock_ref(lock);
+		errno = EINVAL;
 		return -1;
 	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full(lock->lock_fd, &term, 1) != 1
-		|| close_ref(lock) < 0) {
+	    write_in_full(lock->lock_fd, &term, 1) != 1 ||
+	    close_ref(lock) < 0) {
+		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename);
 		unlock_ref(lock);
+		errno = save_errno;
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
+		int save_errno = errno;
 		unlock_ref(lock);
+		errno = save_errno;
 		return -1;
 	}
 	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
@@ -2866,8 +2911,10 @@ int write_ref_sha1(struct ref_lock *lock,
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
 	}
 	if (commit_ref(lock)) {
+		int save_errno = errno;
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
+		errno = save_errno;
 		return -1;
 	}
 	unlock_ref(lock);
diff --git i/sha1_file.c w/sha1_file.c
index 3e9f55f..a7bbba7 100644
--- i/sha1_file.c
+++ w/sha1_file.c
@@ -136,8 +136,10 @@ enum scld_error safe_create_leading_directories(char *path)
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
-			if (!S_ISDIR(st.st_mode))
+			if (!S_ISDIR(st.st_mode)) {
+				errno = EEXIST;
 				ret = SCLD_EXISTS;
+			}
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
