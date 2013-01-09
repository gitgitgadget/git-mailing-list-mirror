From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/19] reset.c: finish entire cmd_reset() whether or not
 pathspec is given
Date: Wed, 09 Jan 2013 11:59:11 -0800
Message-ID: <7v8v825drk.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-16-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:59:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1oO-0005xf-Qh
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568Ab3AIT7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:59:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932551Ab3AIT7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:59:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F13D0BF96;
	Wed,  9 Jan 2013 14:59:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tu96ku7qG5xUldu/VyhH+2fnH2Q=; b=XYF341
	YFwlczPF+iszDYGBSR1pX0umwRoyw/Y3D+gXBRHYR934dOdWAKo5aJ4K+YPxXRLA
	g8YwJowrEv6iHhq7khT6f0dJueMVhjA/qKXrIWEFAnvacpTW5WPZmWZFYtTEcK5R
	HHKWaHoQoop/haLjVbWBZbGmHuLnEh9Jpy6iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jPTJqQxUM6htrHcoa7AdBFA9uS2zExyZ
	l9fmN9aEGRZXK1mhtltaKx1hdrM/tG3B8+11s7uaGWXe4CLvobr3tDdEo6R6MMz7
	ATE9XzKGGul+yPDn0uZuFhCN/S3Auo0JWMN9ESd4RRXZqzT0cMGWaTTW7AUPz/Ev
	wL0gZLK8Wl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E54FABF94;
	Wed,  9 Jan 2013 14:59:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26211BF8C; Wed,  9 Jan 2013
 14:59:13 -0500 (EST)
In-Reply-To: <1357719376-16406-16-git-send-email-martinvonz@gmail.com>
 (Martin von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A32F750-5A97-11E2-BEA9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213095>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> By not returning from inside the "if (pathspec)" block, we can let the
> pathspec-aware and pathspec-less code share a bit more, making it
> easier to make future changes that should affect both cases. This also
> highlights the similarity between read_from_tree() and reset_index().
> ---
> Should error reporting be aligned too? Speaking of which,
> do_diff_cache() never returns anything by 0. Is the return value for
> future-proofing?

Perhaps, and yes.

>
>  builtin/reset.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 254afa9..9bcad29 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -308,19 +308,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		die(_("%s reset is not allowed in a bare repository"),
>  		    _(reset_type_names[reset_type]));
>  
> -	if (pathspec) {
> -		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
> -		int index_fd = hold_locked_index(lock, 1);
> -		if (read_from_tree(pathspec, sha1))
> -			return 1;
> -		update_index_refresh(
> -			quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
> -		if (write_cache(index_fd, active_cache, active_nr) ||
> -		    commit_locked_index(lock))
> -			return error("Could not write new index file.");
> -		return 0;
> -	}
> -
>  	/* Soft reset does not touch the index file nor the working tree
>  	 * at all, but requires them in a good order.  Other resets reset
>  	 * the index file to the tree object we are switching to. */
> @@ -330,11 +317,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	if (reset_type != SOFT) {
>  		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
>  		int newfd = hold_locked_index(lock, 1);
> -		int err = reset_index(sha1, reset_type, quiet);
> -		if (reset_type == KEEP && !err)
> -			err = reset_index(sha1, MIXED, quiet);
> -		if (err)
> -			die(_("Could not reset index file to revision '%s'."), rev);
> +		if (pathspec) {
> +			if (read_from_tree(pathspec, sha1))
> +				return 1;
> +		} else {
> +			int err = reset_index(sha1, reset_type, quiet);
> +			if (reset_type == KEEP && !err)
> +				err = reset_index(sha1, MIXED, quiet);
> +			if (err)
> +				die(_("Could not reset index file to revision '%s'."), rev);
> +		}
>  
>  		if (reset_type == MIXED) /* Report what has not been updated. */
>  			update_index_refresh(
> @@ -345,14 +337,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  			die(_("Could not write new index file."));
>  	}
>  
> -	/* Any resets update HEAD to the head being switched to,
> -	 * saving the previous head in ORIG_HEAD before. */
> -	update_ref_status = update_refs(rev, sha1);
> +	if (!pathspec) {
> +		/* Any resets without paths update HEAD to the head being
> +		 * switched to, saving the previous head in ORIG_HEAD before. */
> +		update_ref_status = update_refs(rev, sha1);
>  
> -	if (reset_type == HARD && !update_ref_status && !quiet)
> -		print_new_head_line(commit);
> +		if (reset_type == HARD && !update_ref_status && !quiet)
> +			print_new_head_line(commit);
>  
> -	remove_branch_state();
> +		remove_branch_state();
> +	}
>  
>  	return update_ref_status;
>  }
