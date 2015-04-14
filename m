From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] refs.c: remove lock_fd from struct ref_lock
Date: Tue, 14 Apr 2015 16:12:03 -0700
Message-ID: <xmqq8udu1f0c.fsf@gitster.dls.corp.google.com>
References: <1429050308-9617-1-git-send-email-sbeller@google.com>
	<1429050308-9617-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 01:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiA0A-0005JG-AN
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 01:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbbDNXMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 19:12:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932103AbbDNXMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 19:12:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42FB34A082;
	Tue, 14 Apr 2015 19:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CBIGFBZP9cISCg0qt5LKaE1MYqw=; b=REO2rM
	4gQLslwXlvVVeZa0dTRAKEbXAcs+LqxBmNZbkS06XMd2UmNyHmuFSCYbkZyxjrf4
	FZROgNUdY4dJtHsrss/ba+yyQUi9/dmxWReSMMCnSG7vsNo6AN1IYIqBlAGc2Oi9
	04ZplTLh2lJHelycSX9ScevcNBlqYmYaYjzj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llUTSxRMxMwnPRzbxZfOZZGw/TwYxFCV
	yrgNexMamjQGaoATEfak5Na/glbacYehlgpVm9ZDu5Lp9f5v15152shXox9W0fca
	GPHP3WOoqFIJow/pa5Y7if2JskrjzRwJAr5IMOfTv//xdAtHTvXQI9b4CyYRcIMt
	cPwn5n7Vupg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AD2C4A081;
	Tue, 14 Apr 2015 19:12:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4AF74A080;
	Tue, 14 Apr 2015 19:12:04 -0400 (EDT)
In-Reply-To: <1429050308-9617-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 14 Apr 2015 15:25:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA2AAB56-E2FB-11E4-952C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267174>

Stefan Beller <sbeller@google.com> writes:

> The 'lock_fd' is the same as 'lk->fd'. No need to store it twice so remove
> it. You may argue this introduces more coupling as we need to know more
> about the internals of the lock file mechanism, but this will be solved in
> a later patch.
>
> No functional changes intended.

It is somewhat strange to hear "in a later patch" in [PATCH 3/3] of
a 3-patch series ;-), but I think this makes sense.  Whenever
we take a ref-lock, and we are going to actually write something
into the filesystem, we would go thru the lock_file API, so we can
depend on lk to have its own file descriptor field.




>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 14e52ca..4066752 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -11,7 +11,6 @@ struct ref_lock {
>  	char *orig_ref_name;
>  	struct lock_file *lk;
>  	unsigned char old_sha1[20];
> -	int lock_fd;
>  	int force_write;
>  };
>  
> @@ -2259,7 +2258,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	int attempts_remaining = 3;
>  
>  	lock = xcalloc(1, sizeof(struct ref_lock));
> -	lock->lock_fd = -1;
>  
>  	if (mustexist)
>  		resolve_flags |= RESOLVE_REF_READING;
> @@ -2335,8 +2333,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  		goto error_return;
>  	}
>  
> -	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
> -	if (lock->lock_fd < 0) {
> +	if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
> +		last_errno = errno;
>  		if (errno == ENOENT && --attempts_remaining > 0)
>  			/*
>  			 * Maybe somebody just deleted one of the
> @@ -2904,7 +2902,6 @@ static int close_ref(struct ref_lock *lock)
>  {
>  	if (close_lock_file(lock->lk))
>  		return -1;
> -	lock->lock_fd = -1;
>  	return 0;
>  }
>  
> @@ -2912,7 +2909,6 @@ static int commit_ref(struct ref_lock *lock)
>  {
>  	if (commit_lock_file(lock->lk))
>  		return -1;
> -	lock->lock_fd = -1;
>  	return 0;
>  }
>  
> @@ -3090,8 +3086,8 @@ static int write_ref_sha1(struct ref_lock *lock,
>  		errno = EINVAL;
>  		return -1;
>  	}
> -	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
> -	    write_in_full(lock->lock_fd, &term, 1) != 1 ||
> +	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
> +	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
>  	    close_ref(lock) < 0) {
>  		int save_errno = errno;
>  		error("Couldn't write %s", lock->lk->filename.buf);
> @@ -4047,9 +4043,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>  			status |= error("couldn't write %s: %s", log_file,
>  					strerror(errno));
>  		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
> -			(write_in_full(lock->lock_fd,
> +			(write_in_full(lock->lk->fd,
>  				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
> -			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
> +			 write_str_in_full(lock->lk->fd, "\n") != 1 ||
>  			 close_ref(lock) < 0)) {
>  			status |= error("couldn't write %s",
>  					lock->lk->filename.buf);
