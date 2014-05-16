From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 22/44] fetch.c: clear errno before calling functions
 that might set it
Date: Fri, 16 May 2014 13:26:23 -0700
Message-ID: <CAL=YDWknwYDLCRUzev6BVvfaYnnHLKoVsNaC2uJd-dTBy5QMEA@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-23-git-send-email-sahlberg@google.com>
	<20140516183348.GC12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 22:26:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlOi6-0006dO-Nh
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 22:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbaEPU0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 16:26:25 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:59427 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbaEPU0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 16:26:25 -0400
Received: by mail-vc0-f171.google.com with SMTP id lc6so6894090vcb.30
        for <git@vger.kernel.org>; Fri, 16 May 2014 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gujKVCv79Jv0KfHPFrPbQpzKyGmni5C+dKvcjuhpobg=;
        b=fPkDkKYPAHn10PToNFWYVskQkF2lh8BN7EgSWO3u/eUlBeHUaeSlR5oeLqO8Ve8JCW
         qql8fvvw8CdV63yo2JPB6peeQV3glYmliaYrseGm+HXObQnMSGWngbOa1HFFhihp9nhi
         hkmdKLDZKVq8AIZI7/s4JPAGr/Oes0sjC7Y+Q90eX6XfDRhBef56esX/WMMy6xzStOY1
         Fj0NUfBSk2oe4iWJN3plq4hcrMyFqQBFIyHrQ9TLQvDJVDqVgK1mNctnfAnZjsyl8ucr
         AVvxChfDzgwbppULJ9WU8xIS3NBoxLXVwlAFygrbPAaUqJEGPQH06A1TyDXnL/VayxgH
         4o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gujKVCv79Jv0KfHPFrPbQpzKyGmni5C+dKvcjuhpobg=;
        b=LAhOiLwPoUcbXzbX1oSuUY85vus9RaGUWNbVas41/4P87fe1G4UbJGm6/2zrAAdjoQ
         LLw5bJpsqUebOG/W6eqNDLOI5gNs147O0XBJa6qiTjiJNtk2RN5/xBTbNC3vmeLDwI7s
         Gxmb00SeUVuItRnXw8dyUWIeNO0gnFOPaqxxifXmYtkesc6wFe5aHDIXj++A6+YhC0qW
         k0yryFp/tbBwzl7hvT6q2/usmfYhS2j5v+eM7lGqzeiwgVE0SFrWDWPySs1FYInfyX63
         d4+ByUFwfS8p3szMkXASNQ8gaatreC3E6kI5Jqdt7wjDlB+j5y0DeuSWkXw29Tz37N8a
         kjbg==
X-Gm-Message-State: ALoCoQlNVA+FtJaqMFwN3WP0DAfqgVTeGjEq6NOoBwQ2MMLbGZcGnm4r4GR53UWYQzivlcuDjttI
X-Received: by 10.58.66.195 with SMTP id h3mr2085238vet.57.1400271983743; Fri,
 16 May 2014 13:26:23 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Fri, 16 May 2014 13:26:23 -0700 (PDT)
In-Reply-To: <20140516183348.GC12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249416>

errno is hairy :-(


You probably also want something like this :
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4603cb6..55e7dd8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -426,7 +426,7 @@ static int update_local_ref(struct ref *ref,
                            _("! %-*s %-*s -> %s  (can't fetch in current branch
                            TRANSPORT_SUMMARY(_("[rejected]")),
                            REFCOL_WIDTH, remote, pretty_ref);
-               return 1;
+               return STORE_REF_ERROR_OTHER;
        }

        if (!is_null_sha1(ref->old_sha1) &&
@@ -513,7 +513,7 @@ static int update_local_ref(struct ref *ref,
                            TRANSPORT_SUMMARY(_("[rejected]")),
                            REFCOL_WIDTH, remote, pretty_ref,
                            _("(non-fast-forward)"));
-               return 1;
+               return STORE_REF_ERROR_OTHER;
        }
 }


To make it more clear that this function returns a specific error and
not just a generic not-zero.


On Fri, May 16, 2014 at 11:33 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (cc-ing peff, who may remember this STORE_REF_ERROR_DF_CONFLICT case
>  from long ago)
> Ronnie Sahlberg wrote:
>
>> In s_update_ref there are two calls that when they fail we return an error
>> based on the errno value. In particular we want to return a specific error
>> if ENOTDIR happened. Both these functions do have failure modes where they
>> may return an error without updating errno
>
> That's a bug.  Any function for which errno is supposed to be
> meaningful when it returns an error should always set errno.
> Otherwise errno may be set to ENOTDIR within the function by an
> unrelated system call.
>
> Functions that fail and lead callers to check errno, based on a quick
> search with 'git grep -e 'errno *[!=]=':
>
>  fopen
>  lstat
>  builtin/apply.c::try_create_file (= mkdir, symlink, or open)
>  rmdir
>  open
>  mkdir
>  unlink
>  lock_any_ref_for_update
>  write_ref_sha1
>  strtol
>  kill
>  odb_pack_keep
>  opendir
>  fgets
>  read
>  poll
>  pread
>  strtoimax
>  strtoumax
>  git_parse_int
>  git_parse_int64
>  git_parse_ulong
>  write_in_full
>  credential-cache.c::send_request
>  fstat
>  run_command_v_opt
>  git.c::run_argv
>  readlink
>  resolve_ref_unsafe
>  hold_lock_file_for_update
>  unlink_or_warn
>  rename
>  execvp
>  waitpid
>  execv_git_cmd
>  execv_shell_cmd
>  sane_execvp
>  stat
>  read_object
>  git_mkstemp_mode
>  create_tmpfile
>  start_command
>  xwrite
>  iconv
>  fast_export_ls
>  fast_export_ls_rev
>  delete_ref
>
> lock_any_ref_for_update has failure paths
>  * check_ref_format [!]
>  * lock_ref_sha1_basic
>
> lock_ref_sha1_basic has failure paths
>  * remove_empty_directories
>  * resolve_ref_unsafe
>  * safe_create_leading_directories
>  * verify_lock
>
> remove_empty_directories has one failure path
>  * remove_dir_recursively
> but could be more explicit about the need to preserve errno.
>
> errno from remove_dir_recursively is meaningful.
>
> resolve_ref_unsafe has failure paths
>  * check_refname_format [!]
>  * too much recursion [!]
>  * lstat, readlink, open
>  * handle_missing_loose_ref
>  * read_in_full, but errno gets clobbered
>  * invalid ref [!]
>  * invalid symref [!]
>
> verify_lock has failure paths
>  * read_ref_full, but errno gets clobbered
>  * old_sha1 didn't match [!]
>
> write_ref_sha1 has failure paths
>  * !lock [!]
>  * missing object [!]
>  * non-commit object [!]
>  * write_in_full, close_ref, but errno gets clobbered
>  * log_ref_write
>  * commit_ref
>
> log_ref_write has failure paths
>  * log_ref_setup
>  * write_in_full, close.  errno gets clobbered
>
> commit_ref just calls commit_lock_file.
>
> log_ref_setup has failure paths
>  * safe_create_leading_directories, but errno gets clobbered
>  * remove_empty_directories, but errno gets clobbered
>  * open, but errno gets clobbered
>
> safe_create_leading_directories doesn't set errno for SCLD_EXISTS
> but otherwise its errno is useful.
>
> That should cover the cases affecting the code path in fetch.c you
> mentioned (I haven't checked the others).
>
> How about something like this?
>
> It's also tempting to teach vreportf and vwritef to save errno, which
> would handle some of these cases automatically.
>
> diff --git i/refs.c w/refs.c
> index 82a8d4e..f98acf0 100644
> --- i/refs.c
> +++ w/refs.c
> @@ -1333,8 +1333,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>         if (flag)
>                 *flag = 0;
>
> -       if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> +       if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +               errno = EINVAL;
>                 return NULL;
> +       }
>
>         for (;;) {
>                 char path[PATH_MAX];
> @@ -1342,8 +1344,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>                 char *buf;
>                 int fd;
>
> -               if (--depth < 0)
> +               if (--depth < 0) {
> +                       errno = ELOOP;
>                         return NULL;
> +               }
>
>                 git_snpath(path, sizeof(path), "%s", refname);
>
> @@ -1405,9 +1409,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>                                 return NULL;
>                 }
>                 len = read_in_full(fd, buffer, sizeof(buffer)-1);
> -               close(fd);
> -               if (len < 0)
> +               if (len < 0) {
> +                       int save_errno = errno;
> +                       close(fd);
> +                       errno = save_errno;
>                         return NULL;
> +               }
> +               close(fd);
>                 while (len && isspace(buffer[len-1]))
>                         len--;
>                 buffer[len] = '\0';
> @@ -1424,6 +1432,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>                             (buffer[40] != '\0' && !isspace(buffer[40]))) {
>                                 if (flag)
>                                         *flag |= REF_ISBROKEN;
> +                               errno = EINVAL;
>                                 return NULL;
>                         }
>                         return refname;
> @@ -1436,6 +1445,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>                 if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
>                         if (flag)
>                                 *flag |= REF_ISBROKEN;
> +                       errno = EINVAL;
>                         return NULL;
>                 }
>                 refname = strcpy(refname_buffer, buf);
> @@ -1908,14 +1918,17 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
>         const unsigned char *old_sha1, int mustexist)
>  {
>         if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
> +               int save_errno = errno;
>                 error("Can't verify ref %s", lock->ref_name);
>                 unlock_ref(lock);
> +               errno = save_errno;
>                 return NULL;
>         }
>         if (hashcmp(lock->old_sha1, old_sha1)) {
>                 error("Ref %s is at %s but expected %s", lock->ref_name,
>                         sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
>                 unlock_ref(lock);
> +               errno = EBUSY;
>                 return NULL;
>         }
>         return lock;
> @@ -1928,15 +1941,17 @@ static int remove_empty_directories(const char *file)
>          * only empty directories), remove them.
>          */
>         struct strbuf path;
> -       int result;
> +       int result, save_errno;
>
>         strbuf_init(&path, 20);
>         strbuf_addstr(&path, file);
>
>         result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
> +       save_errno = errno;
>
>         strbuf_release(&path);
>
> +       errno = save_errno;
>         return result;
>  }
>
> @@ -2137,8 +2152,10 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
>                                          const unsigned char *old_sha1,
>                                          int flags, int *type_p)
>  {
> -       if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> +       if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +               errno = EINVAL;
>                 return NULL;
> +       }
>         return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
>  }
>
> @@ -2734,9 +2751,12 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
>              starts_with(refname, "refs/remotes/") ||
>              starts_with(refname, "refs/notes/") ||
>              !strcmp(refname, "HEAD"))) {
> -               if (safe_create_leading_directories(logfile) < 0)
> -                       return error("unable to create directory for %s",
> -                                    logfile);
> +               if (safe_create_leading_directories(logfile) < 0) {
> +                       int save_errno = errno;
> +                       error("unable to create directory for %s", logfile);
> +                       errno = save_errno;
> +                       return -1;
> +               }
>                 oflags |= O_CREAT;
>         }
>
> @@ -2747,15 +2767,21 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
>
>                 if ((oflags & O_CREAT) && errno == EISDIR) {
>                         if (remove_empty_directories(logfile)) {
> -                               return error("There are still logs under '%s'",
> -                                            logfile);
> +                               int save_errno = errno;
> +                               error("There are still logs under '%s'", logfile);
> +                               errno = save_errno;
> +                               return -1;
>                         }
>                         logfd = open(logfile, oflags, 0666);
>                 }
>
> -               if (logfd < 0)
> -                       return error("Unable to append to %s: %s",
> +               if (logfd < 0) {
> +                       int save_errno = errno;
> +                       error("Unable to append to %s: %s",
>                                      logfile, strerror(errno));
> +                       errno = save_errno;
> +                       return -1;
> +               }
>         }
>
>         adjust_shared_perm(logfile);
> @@ -2795,8 +2821,19 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
>                 len += copy_msg(logrec + len - 1, msg) - 1;
>         written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
>         free(logrec);
> -       if (close(logfd) != 0 || written != len)
> -               return error("Unable to append to %s", log_file);
> +       if (written != len) {
> +               int save_errno = errno;
> +               close(logfd);
> +               error("Unable to append to %s", log_file);
> +               errno = save_errno;
> +               return -1;
> +       }
> +       if (close(logfd)) {
> +               int save_errno = errno;
> +               error("Unable to append to %s", log_file);
> +               errno = save_errno;
> +               return -1;
> +       }
>         return 0;
>  }
>
> @@ -2811,8 +2848,10 @@ int write_ref_sha1(struct ref_lock *lock,
>         static char term = '\n';
>         struct object *o;
>
> -       if (!lock)
> +       if (!lock) {
> +               errno = EINVAL;
>                 return -1;
> +       }
>         if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
>                 unlock_ref(lock);
>                 return 0;
> @@ -2822,26 +2861,32 @@ int write_ref_sha1(struct ref_lock *lock,
>                 error("Trying to write ref %s with nonexistent object %s",
>                         lock->ref_name, sha1_to_hex(sha1));
>                 unlock_ref(lock);
> +               errno = EINVAL;
>                 return -1;
>         }
>         if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
>                 error("Trying to write non-commit object %s to branch %s",
>                         sha1_to_hex(sha1), lock->ref_name);
>                 unlock_ref(lock);
> +               errno = EINVAL;
>                 return -1;
>         }
>         if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
> -           write_in_full(lock->lock_fd, &term, 1) != 1
> -               || close_ref(lock) < 0) {
> +           write_in_full(lock->lock_fd, &term, 1) != 1 ||
> +           close_ref(lock) < 0) {
> +               int save_errno = errno;
>                 error("Couldn't write %s", lock->lk->filename);
>                 unlock_ref(lock);
> +               errno = save_errno;
>                 return -1;
>         }
>         clear_loose_ref_cache(&ref_cache);
>         if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
>             (strcmp(lock->ref_name, lock->orig_ref_name) &&
>              log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
> +               int save_errno = errno;
>                 unlock_ref(lock);
> +               errno = save_errno;
>                 return -1;
>         }
>         if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
> @@ -2866,8 +2911,10 @@ int write_ref_sha1(struct ref_lock *lock,
>                         log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
>         }
>         if (commit_ref(lock)) {
> +               int save_errno = errno;
>                 error("Couldn't set %s", lock->ref_name);
>                 unlock_ref(lock);
> +               errno = save_errno;
>                 return -1;
>         }
>         unlock_ref(lock);
> diff --git i/sha1_file.c w/sha1_file.c
> index 3e9f55f..a7bbba7 100644
> --- i/sha1_file.c
> +++ w/sha1_file.c
> @@ -136,8 +136,10 @@ enum scld_error safe_create_leading_directories(char *path)
>                 *slash = '\0';
>                 if (!stat(path, &st)) {
>                         /* path exists */
> -                       if (!S_ISDIR(st.st_mode))
> +                       if (!S_ISDIR(st.st_mode)) {
> +                               errno = EEXIST;
>                                 ret = SCLD_EXISTS;
> +                       }
>                 } else if (mkdir(path, 0777)) {
>                         if (errno == EEXIST &&
>                             !stat(path, &st) && S_ISDIR(st.st_mode))
