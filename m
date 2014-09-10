From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs: write packed_refs file using stdio
Date: Wed, 10 Sep 2014 13:21:27 +0200
Message-ID: <54103437.2090305@alum.mit.edu>
References: <20140910100352.GA12164@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 13:28:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRg4j-000628-5b
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 13:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbaIJL2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 07:28:33 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47149 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751283AbaIJL2c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2014 07:28:32 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Sep 2014 07:28:32 EDT
X-AuditID: 1207440d-f797f6d000000a4a-8f-54103439d08b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 57.8A.02634.93430145; Wed, 10 Sep 2014 07:21:29 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1DEC.dip0.t-ipconnect.de [93.219.29.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8ABLReF030261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Sep 2014 07:21:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <20140910100352.GA12164@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1LU0EQgxWL7HxKLrSjeTxY+WHmYH
	Jo9nvXsYPT5vkgtgiuK2SUosKQvOTM/Tt0vgztg14xlrwW+9iplH/jI3ME5S7WLk4JAQMJF4
	vN68i5ETyBSTuHBvPVsXIxeHkMBlRokdDQ9YIZzzTBJ9V3qZQKp4BbQl1m86wwpiswioSkw6
	dosNxGYT0JVY1NMMViMqECQx+/M8doh6QYmTM5+wgNgiAkYSNz58A6sXFrCV2HjqDliNEFDv
	kkfnwOKcAnoSq2bcZQM5jllAXWL9PCGQMLOAvMT2t3OYJzDyz0IydRZC1SwkVQsYmVcxyiXm
	lObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQj7w7G/+tkDjEKcDAq8fDuqOIPEWJN
	LCuuzD3EKMnBpCTK+9hIIESILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG8aSI43JbGyKrUoHyYl
	zcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMFrZwzUKFiUmp5akZaZU4KQZuLgBBnOJSVS
	nJqXklqUWFqSEQ+KxvhiYDyCpHiA9n4H21tckJgLFIVoPcWoy7Gu81s/kxBLXn5eqpQ4LyPI
	DgGQoozSPLgVsNTzilEc6GNhXiOQKh5g2oKb9ApoCRPQkoPG/CBLShIRUlINjLZ7GrjmKAaJ
	KUV3bdo6+VuyomRv6tcobWPx9dt37WSuu/vRmuU3y99U4cCCp/cs7K3n+Jv43lx5rfiq24xW
	Z1MxIw6t2fcmh118tOjfuiV/pu7L4bosOvmEE1PtwhRfc5v7sy9+CVhmFp0WX2F0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256734>

On 09/10/2014 12:03 PM, Jeff King wrote:
> We write each line of a new packed-refs file individually
> using a write() syscall (and sometimes 2, if the ref is
> peeled). Since each line is only about 50-100 bytes long,
> this creates a lot of system call overhead.
> 
> We can instead open a stdio handle around our descriptor and
> use fprintf to write to it. The extra buffering is not a
> problem for us, because nobody will read our new packed-refs
> file until we call commit_lock_file (by which point we have
> flushed everything).
> 
> On a pathological repository with 8.5 million refs, this
> dropped the time to run `git pack-refs` from 20s to 6s.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously that repo is ridiculous (but a sad reality for me).
> 
> However, I think the benefits extend to smaller files, too. And it's
> pretty easy to do (and I actually think the resulting write_packed_entry
> is a lot easier to read, as well as lifting some arbitrary limits).
> 
>  cache.h        |  2 ++
>  refs.c         | 39 ++++++++++++++++-----------------------
>  write_or_die.c | 15 +++++++++++++++
>  3 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 4d5b76c..bc286ce 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1395,6 +1395,8 @@ extern const char *git_mailmap_blob;
>  
>  /* IO helper functions */
>  extern void maybe_flush_or_die(FILE *, const char *);
> +__attribute__((format (printf, 2, 3)))
> +extern void fprintf_or_die(FILE *, const char *fmt, ...);
>  extern int copy_fd(int ifd, int ofd);
>  extern int copy_file(const char *dst, const char *src, int mode);
>  extern int copy_file_with_time(const char *dst, const char *src, int mode);
> diff --git a/refs.c b/refs.c
> index 27927f2..f08faed 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2191,25 +2191,12 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
>   * Write an entry to the packed-refs file for the specified refname.
>   * If peeled is non-NULL, write it as the entry's peeled value.
>   */
> -static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
> +static void write_packed_entry(FILE *fh, char *refname, unsigned char *sha1,
>  			       unsigned char *peeled)
>  {
> -	char line[PATH_MAX + 100];
> -	int len;
> -
> -	len = snprintf(line, sizeof(line), "%s %s\n",
> -		       sha1_to_hex(sha1), refname);
> -	/* this should not happen but just being defensive */
> -	if (len > sizeof(line))
> -		die("too long a refname '%s'", refname);
> -	write_or_die(fd, line, len);
> -
> -	if (peeled) {
> -		if (snprintf(line, sizeof(line), "^%s\n",
> -			     sha1_to_hex(peeled)) != PEELED_LINE_LENGTH)
> -			die("internal error");
> -		write_or_die(fd, line, PEELED_LINE_LENGTH);
> -	}
> +	fprintf_or_die(fh, "%s %s\n", sha1_to_hex(sha1), refname);
> +	if (peeled)
> +		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
>  }
>  
>  /*
> @@ -2217,13 +2204,12 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
>   */
>  static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>  {
> -	int *fd = cb_data;
>  	enum peel_status peel_status = peel_entry(entry, 0);
>  
>  	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
>  		error("internal error: %s is not a valid packed reference!",
>  		      entry->name);
> -	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
> +	write_packed_entry(cb_data, entry->name, entry->u.value.sha1,
>  			   peel_status == PEEL_PEELED ?
>  			   entry->u.value.peeled : NULL);
>  	return 0;
> @@ -2259,15 +2245,22 @@ int commit_packed_refs(void)
>  		get_packed_ref_cache(&ref_cache);
>  	int error = 0;
>  	int save_errno = 0;
> +	FILE *out;
>  
>  	if (!packed_ref_cache->lock)
>  		die("internal error: packed-refs not locked");
> -	write_or_die(packed_ref_cache->lock->fd,
> -		     PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
>  
> +	out = fdopen(packed_ref_cache->lock->fd, "w");
> +	if (!out)
> +		die_errno("unable to fdopen packed-refs descriptor");
> +
> +	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
>  	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
> -				 0, write_packed_entry_fn,
> -				 &packed_ref_cache->lock->fd);
> +				 0, write_packed_entry_fn, out);
> +	if (fclose(out))
> +		die_errno("write error");
> +	packed_ref_cache->lock->fd = -1;

It might be a minuscule bit safer to set `lock->fd = -1` *before*
calling `fclose()`.

TBH, it makes me uncomfortable having code outside of `lockfile.c`
having this level of intimacy with lockfile objects. I think it would be
better to have a

    FILE *fopen_lock_file(struct *lock_file, const char *mode);

that records the `FILE *` inside the `lockfile` instance, and to teach
`commit_lock_file()` and its friends to call `fclose()` if the `FILE *`
was created. I think that such a feature would encourage other lockfile
users to use the more convenient and readable stdio API.

But there is precedent for what you are doing so I will add
`fopen_lock_file()` to my mythical todo list and not bother you further
with the idea.

> +
>  	if (commit_lock_file(packed_ref_cache->lock)) {
>  		save_errno = errno;
>  		error = -1;
> diff --git a/write_or_die.c b/write_or_die.c
> index b50f99a..e7afe7a 100644
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -49,6 +49,21 @@ void maybe_flush_or_die(FILE *f, const char *desc)
>  	}
>  }
>  
> +void fprintf_or_die(FILE *f, const char *fmt, ...)
> +{
> +	va_list ap;
> +	int ret;
> +
> +	va_start(ap, fmt);
> +	ret = vfprintf(f, fmt, ap);
> +	va_end(ap);
> +
> +	if (ret < 0) {
> +		check_pipe(errno);
> +		die_errno("write error");
> +	}
> +}
> +
>  void fsync_or_die(int fd, const char *msg)
>  {
>  	if (fsync(fd) < 0) {
> 

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
