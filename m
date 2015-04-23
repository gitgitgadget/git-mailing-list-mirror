From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Thu, 23 Apr 2015 10:56:21 -0700
Message-ID: <xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, git@vger.kernel.org, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 19:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlLMY-0003Ct-Ru
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 19:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbbDWR4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 13:56:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966537AbbDWR43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 13:56:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C3EB4A9D7;
	Thu, 23 Apr 2015 13:56:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LxmIOFR9UfT1Dui0MW0FKKVrQ18=; b=ohagYu
	VjwzB5mfHAcLlA8KpJvUkR4qoYI+w7TWnnFHGNhzPnGSksdJ7CXr81pqiii1KSjC
	U9I3jyerfbWZ2z8ztkTF39PG47Fvxj5QPh5JbPzr0Wxe3xWJQI+21xnx54JyXea0
	C54bPfursVXlA+cKT8Wt4DC9zN1xWMfjfOsUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUUJaJVM1tvTqhquTqpwgs3BxObzxlkx
	tJV3DIR9CIcrSL/Z7C7oBwiPcvaXEdS//ClDBSnfvpl0blHr58HzkzapSx83o4kL
	SmGT/8xpFrlDIJlprioaLudpFFMQsSpHJBHK3qpUpIPD+snyeLpZqyHJOlbmJL39
	LtIy/w+zaTc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 951854A9D6;
	Thu, 23 Apr 2015 13:56:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A3BB4A9D5;
	Thu, 23 Apr 2015 13:56:23 -0400 (EDT)
In-Reply-To: <1429738227-2985-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 22 Apr 2015 14:30:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0DCAF2B4-E9E2-11E4-ACF2-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267695>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/refs.c b/refs.c
> index 4f495bd..7ce7b97 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3041,6 +3041,13 @@ static int write_ref_sha1(struct ref_lock *lock,
>  		errno = EINVAL;
>  		return -1;
>  	}
> +	if (lock->lk->fd == -1 && reopen_lock_file(lock->lk) == -1) {

Granted, we explicitly assign -1 to lk->fd when we know it is
closed, and the return value from reopen_lock_file() can come only
from the return value from open(2), which is defined to return -1
(i.e. not just any negative value) upon failure, but still, isn't it
customary to check with "< 0" rather than "== -1" for errors?

> +		int save_errno = errno;
> +		error("Couldn't reopen %s", lock->lk->filename.buf);

No need to change this line, but I noticed that we might want to do
something about the first one of the following two:

    $ git grep -e '[ 	]error(_*"[A-Z]' | wc -l
    146
    $ git grep -e '[ 	]error(_*"[a-z]' | wc -l
    390

> +		unlock_ref(lock);
> +		errno = save_errno;
> +		return -1;
> +	}

Is this the only place in the entire codebase where a lockfile,
which may have been closed to save number of open file descriptors,
needs to be reopened?  If I understand correctly, lockfile API is
not for sole use of refs (don't the index and the pack codepaths use
it, too?), so it may give us a better abstraction to have a helper
function in lockfile.[ch] that takes a lock object, i.e.

	int make_lock_fd_valid(struct lock_file *lk)
        {
		if (lk->fd < 0 && reopen_lock_file(lk) < 0) {
			... error ...
                        return -1;
		}
                return 0;
	}

and to call it at this point, i.e.

	if (make_lock_fd_valid(lock->lk) < 0)
        	return -1;

perhaps?

> @@ -3733,6 +3741,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		return 0;
>  	}
>  
> +	/*
> +	 * We need to open many files in a large transaction, so come up with
> +	 * a reasonable maximum. We still keep some spares for stdin/out and
> +	 * other open files. Experiments determined we need more fds when
> +	 * running inside our test suite than directly in the shell. It's
> +	 * unclear where these fds come from. 25 should be a reasonable large
> +	 * number though.
> +	 */

> +	remaining_fds = get_max_fd_limit();
> +	if (remaining_fds > 25)
> +		remaining_fds -= 25;
> +	else
> +		remaining_fds = 0;

Is the value of pack_open_fds visible from here? I am wondering if
we might want "scratch fds Git can use for its own use" accounting
so that the two subsystems can collectively say "it is still safe
to use one more fd and leave 25 for other people". With the code
structure proposed here, the pack reader can grab all but 25 fds,
which would leave the rest of Git including this code only 25,
and the value in remaining_fds would become totally meaningless.

It certainly can wait to worry about that and we do not have to do
anything about it in this patch, but it may still be a good idea to
leave "NEEDSWORK:" comment here (and point at open_packed_git_1() in
sha1_file.c in the comment).

I do not think the other side needs to know about the fd consumption
in this function, as what is opened in here will be closed before
this function returns.

> @@ -3762,6 +3784,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  				    update->refname);
>  			goto cleanup;
>  		}
> +		if (!(flags & REF_HAVE_NEW) ||
> +		    is_null_sha1(update->new_sha1) ||
> +		    remaining_fds == 0)
> +			close_lock_file(update->lock->lk);
> +		else
> +			remaining_fds--;
>  	}
