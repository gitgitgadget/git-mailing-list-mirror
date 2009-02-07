From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] More friendly message when locking the index fails.
Date: Fri, 06 Feb 2009 16:37:46 -0800
Message-ID: <7v63jn13qd.fsf@gitster.siamese.dyndns.org>
References: <1233930966-17022-1-git-send-email-Matthieu.Moy@imag.fr>
 <1233932964-22969-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Feb 07 01:39:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVbE8-00086J-KT
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 01:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbZBGAhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 19:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbZBGAhx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 19:37:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbZBGAhx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 19:37:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C5D12A973;
	Fri,  6 Feb 2009 19:37:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 54C382A972; Fri, 
 6 Feb 2009 19:37:48 -0500 (EST)
In-Reply-To: <1233932964-22969-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri, 6 Feb 2009 16:09:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D1327F0-F4AF-11DD-8F68-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108804>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Just saying that index.lock exists doesn't tell the user _what_ to do
> to fix the problem. We should give an indication that it's normally
> safe to delete index.lock after making sure git isn't running here.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Oops, I hadn't noticed, but the previous version triggered a warning
> because of lack of braces on the if. Sorry.

Perhaps it is a good idea to introduce

NORETURN void unable_to_lock_index_die(const char *path, int err)
{
	if (err == EEXIST)
	        die(...);
 	else
        	die(...);
}

in lockfile.c and call it from these two places you are touching?

>  builtin-update-index.c |   12 ++++++++++--
>  lockfile.c             |   13 +++++++++++--
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-update-index.c b/builtin-update-index.c
> index 5604977..23b97db 100644
> --- a/builtin-update-index.c
> +++ b/builtin-update-index.c
> @@ -742,8 +742,16 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		if (newfd < 0) {
>  			if (refresh_flags & REFRESH_QUIET)
>  				exit(128);
> -			die("unable to create '%s.lock': %s",
> -			    get_index_file(), strerror(lock_error));
> +			if (lock_error == EEXIST) {
> +				die("Unable to create '%s.lock': %s.\n\n"
> +				    "If no other git process is currently running, this probably means a\n"
> +				    "git process crashed in this repository earlier. Make sure no other git\n"
> +				    "process is running and remove the file manually to continue.",
> +				    get_index_file(), strerror(lock_error));
> +			} else {
> +				die("Unable to create '%s.lock': %s",
> +				    get_index_file(), strerror(lock_error));
> +			}
>  		}
>  		if (write_cache(newfd, active_cache, active_nr) ||
>  		    commit_locked_index(lock_file))
> diff --git a/lockfile.c b/lockfile.c
> index 021c337..c812596 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -158,8 +158,17 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
>  {
>  	int fd = lock_file(lk, path, flags);
> -	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
> -		die("unable to create '%s.lock': %s", path, strerror(errno));
> +	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR)) {
> +		if (errno == EEXIST) {
> +			die("Unable to create '%s.lock': %s.\n\n"
> +			    "If no other git process is currently running, this probably means a\n"
> +			    "git process crashed in this repository earlier. Make sure no other git\n"
> +			    "process is running and remove the file manually to continue.",
> +			    path, strerror(errno));
> +		} else {
> +			die("Unable to create '%s.lock': %s", path, strerror(errno));
> +		}
> +	}
>  	return fd;
>  }
>  
> -- 
> 1.6.1.2.351.g80eb2.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
