From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] create_symref: use existing ref-lock code
Date: Mon, 28 Dec 2015 10:45:19 +0100
Message-ID: <568104AF.102@alum.mit.edu>
References: <20151220072637.GA22102@sigill.intra.peff.net>
 <20151220073414.GD30662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 10:52:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDUU6-0008Fd-F5
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 10:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbbL1Jw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 04:52:26 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49274 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994AbbL1JwY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2015 04:52:24 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2015 04:52:24 EST
X-AuditID: 1207440d-f79136d00000402c-24-568104b19a5d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DA.2D.16428.1B401865; Mon, 28 Dec 2015 04:45:21 -0500 (EST)
Received: from [192.168.69.130] (p4FC97751.dip0.t-ipconnect.de [79.201.119.81])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBS9jJuU015873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 28 Dec 2015 04:45:21 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <20151220073414.GD30662@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1N3I0hhmMPGNgUXXlW4mix8tPcwO
	TB7PevcwenzeJBfAFMVtk5RYUhacmZ6nb5fAnXFmp1/BR4uKlRO+sTUw/tHpYuTkkBAwkVgx
	5wsrhC0mceHeerYuRi4OIYHLjBJnts5ihXDOM0m0nGoGcjg4hAWcJL7tEgZpEBEwkrjx4Rsb
	iC0kkC3RvXQP2CA2AV2JRT3NTBBD5SR6uyexgNi8AuoSx/YuA6tnEVCVaNn3GaxeVCBEYu/O
	DqgaQYmTM5+A2ZwC1hK7DpxhBrGZgXr/zLsEZctLNG+dzTyBUWAWkpZZSMpmISlbwMi8ilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkTHl3MP5fJ3OIUYCDUYmHt6OpIUyI
	NbGsuDL3EKMkB5OSKO/CH0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrymb4ByvCmJlVWpRfkw
	KWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3lbmxjAhwaLU9NSKtMycEoQ0EwcnyHAu
	KZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO0txaknbe4IDEXKArReopRUUqc9yhIQgAkkVGaBzcW
	lnxeMYoDfSnMew2kigeYuOC6XwENZgIaPHNqPcjgkkSElFQDY6HCtBM3mSfPmJld9sbF89H7
	sO1HV2zUZrxzODPjp9rNe5POH+HnrTnJtelG2D072/tPVBJ7T6yWmbfddaP/R5ao0/f3ZR12
	FpRrFVZZcI5l3YIPE7/MMyurX3Vumu7ZeY/bwgLe1ca909zTlKPma7DtVr1q7dTo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283032>

On 12/20/2015 08:34 AM, Jeff King wrote:
> The create_symref() function predates the existence of
> "struct lock_file", let alone the more recent "struct
> ref_lock". Instead, it just does its own manual dot-locking.
> Besides being more code, this has a few downsides:
> 
>  - if git is interrupted while holding the lock, we don't
>    clean up the lockfile
> 
>  - we don't do the usual directory/filename conflict check.
>    So you can sometimes create a symref "refs/heads/foo/bar",
>    even if "refs/heads/foo" exists (namely, if the refs are
>    packed and we do not hit the d/f conflict in the
>    filesystem).
> 
> This patch refactors create_symref() to use the "struct
> ref_lock" interface, which handles both of these things.
> There are a few bonus cleanups that come along with it:
> 
>  - we leaked ref_path in some error cases
> 
>  - the symref contents were stored in a fixed-size buffer,
>    putting an artificial (albeit large) limitation on the
>    length of the refname. We now write through fprintf, and
>    handle refnames of any size.
> 
>  - we called adjust_shared_perm only after the file was
>    renamed into place, creating a potential race with
>    readers in a shared repository. Now we fix the
>    permissions first, and commit only if that succeeded.
>    This also makes the update atomic with respect to our
>    exit code (whereas previously, we might report failure
>    even though we updated the ref).
> 
>  - the legacy prefer_symlink_refs path did not do any
>    locking at all. Admittedly, it is not atomic from a
>    reader's perspective (and it cannot be; it has to unlink
>    and then symlink, creating a race), but at least it
>    cannot conflict with other writers now.
> 
>  - the result of this patch is hopefully more readable. It
>    eliminates three goto labels. Two were for error checking
>    that is now simplified, and the third was to reach shared
>    code that has been pulled into its own function.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  refs/files-backend.c    | 113 +++++++++++++++++++++++++-----------------------
>  t/t1401-symbolic-ref.sh |   8 ++++
>  2 files changed, 66 insertions(+), 55 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6bfa139..3d53c42 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2811,74 +2811,77 @@ static int commit_ref_update(struct ref_lock *lock,
>  	return 0;
>  }
>  
> -int create_symref(const char *ref, const char *target, const char *logmsg)
> +static int create_ref_symlink(struct ref_lock *lock, const char *target)
>  {
> -	char *lockpath = NULL;
> -	char buf[1000];
> -	int fd, len, written;
> -	char *ref_path = git_pathdup("%s", ref);
> -	unsigned char old_sha1[20], new_sha1[20];
> -	struct strbuf err = STRBUF_INIT;
> -
> -	if (logmsg && read_ref(ref, old_sha1))
> -		hashclr(old_sha1);
> -
> -	if (safe_create_leading_directories(ref_path) < 0)
> -		return error("unable to create directory for %s", ref_path);
> -
> +	int ret = -1;
>  #ifndef NO_SYMLINK_HEAD
> -	if (prefer_symlink_refs) {
> -		unlink(ref_path);
> -		if (!symlink(target, ref_path))
> -			goto done;
> +	char *ref_path = get_locked_file_path(lock->lk);
> +	unlink(ref_path);
> +	ret = symlink(target, ref_path);
> +	free(ref_path);
> +
> +	if (ret)
>  		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
> -	}
>  #endif
> +	return ret;
> +}

This function is racy. A reader might see no reference at all in the
moment between the `unlink()` and the `symlink()`. Moreover, if this
process is killed at that moment, the symbolic ref would be gone forever.

I think that the semantics of `rename()` would allow this race to be
fixed, though, since `symlink()` doesn't have the analogue of
`O_CREAT|O_EXCL`, one would need a lockfile *and* a second temporary
filename under which the new symlink is originally created.

However, this race has always been here, and symlink-based symrefs are
obsolete, so it's probably not worth fixing.

> -	len = snprintf(buf, sizeof(buf), "ref: %s\n", target);
> -	if (sizeof(buf) <= len) {
> -		error("refname too long: %s", target);
> -		goto error_free_return;
> -	}
> -	lockpath = mkpathdup("%s.lock", ref_path);
> -	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
> -	if (fd < 0) {
> -		error("Unable to open %s for writing", lockpath);
> -		goto error_free_return;
> -	}
> -	written = write_in_full(fd, buf, len);
> -	if (close(fd) != 0 || written != len) {
> -		error("Unable to write to %s", lockpath);
> -		goto error_unlink_return;
> -	}
> -	if (rename(lockpath, ref_path) < 0) {
> -		error("Unable to create %s", ref_path);
> -		goto error_unlink_return;
> -	}
> -	if (adjust_shared_perm(ref_path)) {
> -		error("Unable to fix permissions on %s", lockpath);
> -	error_unlink_return:
> -		unlink_or_warn(lockpath);
> -	error_free_return:
> -		free(lockpath);
> -		free(ref_path);
> -		return -1;
> -	}
> -	free(lockpath);
> -
> -#ifndef NO_SYMLINK_HEAD
> -	done:
> -#endif
> +static void update_symref_reflog(struct ref_lock *lock, const char *ref,
> +				 const char *target, const char *logmsg)
> +{
> +	struct strbuf err = STRBUF_INIT;
> +	unsigned char new_sha1[20];
>  	if (logmsg && !read_ref(target, new_sha1) &&
> -		log_ref_write(ref, old_sha1, new_sha1, logmsg, 0, &err)) {
> +	    log_ref_write(ref, lock->old_oid.hash, new_sha1, logmsg, 0, &err)) {
>  		error("%s", err.buf);
>  		strbuf_release(&err);
>  	}
> +}
>  
> -	free(ref_path);
> +static int create_symref_locked(struct ref_lock *lock, const char *ref,
> +				const char *target, const char *logmsg)
> +{
> +	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
> +		update_symref_reflog(lock, ref, target, logmsg);
> +		return 0;
> +	}
> +
> +	if (!fdopen_lock_file(lock->lk, "w"))
> +		return error("unable to fdopen %s: %s",
> +			     lock->lk->tempfile.filename.buf, strerror(errno));
> +
> +	if (adjust_shared_perm(lock->lk->tempfile.filename.buf))
> +		return error("unable to fix permissions on %s: %s",
> +			     lock->lk->tempfile.filename.buf, strerror(errno));

You can skip this step. lock_file() already calls adjust_shared_perm().

> +	/* no error check; commit_ref will check ferror */
> +	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
> +	if (commit_ref(lock) < 0)
> +		return error("unable to write symref for %s: %s", ref,
> +			     strerror(errno));
> +	update_symref_reflog(lock, ref, target, logmsg);

Here is another problem that didn't originate with your changes:

The reflog should be written while holding the reference lock, to
prevent two processes' trying to write new entries at the same time.

I think the problem would be solved if you move the call to
update_symref_reflog() above the call to commit_ref().

Granted, this could case a reflog entry to be written for a reference
update whose commit fails, but that's also a risk for non-symbolic
references. Fixing this residual problem would require the ability to
roll back reflog changes.

>  	return 0;
>  }
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
