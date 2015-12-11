From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/16] refs: add do_for_each_per_worktree_ref
Date: Fri, 11 Dec 2015 15:52:22 -0800
Message-ID: <xmqqio44czm1.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 00:52:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7XUE-0001MH-1L
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 00:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbbLKXw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 18:52:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752748AbbLKXwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 18:52:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E8D233D6F;
	Fri, 11 Dec 2015 18:52:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yXEzVPwxiuvGjL/7G6EVFyf4JfU=; b=FQ4mu2
	cgViPlimhSQBYbsovGXaM87Cbr9N6TSxAV/NtudTe09Z+GfDUulKYGm3KzU4hgs7
	uC7k7nqWYC/HAFzzApQ9+vumGD3+31f8MjmBmYs0+6j9/Xng57+9VJdh5H4kc850
	/v3CObx1IUkMFYEoHeacdbHixvqY9NQWZzWgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fjxozVKrbKFD/DLMXPtu5MLJ2GPeK2pX
	DfUDeZ1ovpn8UY3gOT+QXxxrmejdA3LsJw9ljE4f0K3ONUa9M0irSUy4fgaBwp5q
	py+kE1k7ohsu741GnLJvy6teH/TESIDpfnIwcDszVWdzrwYarAZbILIw+BrEK+1L
	v04bKE91SBQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65DB733D6E;
	Fri, 11 Dec 2015 18:52:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC33233D6D;
	Fri, 11 Dec 2015 18:52:23 -0500 (EST)
In-Reply-To: <1449102921-7707-5-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 2 Dec 2015 19:35:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39A6C8CC-A062-11E5-A03B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282290>

David Turner <dturner@twopensource.com> writes:

> Alternate refs backends might still use files to store per-worktree
> refs.  So the files backend's ref-loading infrastructure should be
> available to those backends, just for use on per-worktree refs.  Add
> do_for_each_per_worktree_ref, which iterates over per-worktree refs.

Is this "might still use"?  I am instead getting an impression that,
we are declaring that the recommended way to store per-worktree refs
is with filesystem backend.

Not complaining against either such a design decision (if that is
what is made here) or the above description in the log message--just
want to understand the intention better.

I also wonder if it is cleaner to have a single interface that lets
anybody ask a pointer to the backend struct by name.  With such an
interface, a new backend that wants to delegate per-worktree refs to
files backend could

	static int DB_for_each_ref(...)
        {
		struct ref_be *files = locate_ref_backend("files");
		files->for_each_ref(... | WORKTREE_ONLY, ...);
		... do its own enumeration of non-per-worktree refs ...
	}

and such a delegation does not need to be limited to per-worktree
iteration.

Or is that a road to expose too much implementation details of
a backend to other backends?

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs/files-backend.c | 15 ++++++++++++---
>  refs/refs-internal.h | 10 ++++++++++
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index d4bd6cf..bde4892 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -518,9 +518,6 @@ static void sort_ref_dir(struct ref_dir *dir)
>  	dir->sorted = dir->nr = i;
>  }
>  
> -/* Include broken references in a do_for_each_ref*() iteration: */
> -#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
> -
>  /*
>   * Return true iff the reference described by entry can be resolved to
>   * an object in the database.  Emit a warning if the referred-to
> @@ -568,6 +565,10 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
>  	struct ref_entry *old_current_ref;
>  	int retval;
>  
> +	if (data->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
> +	    ref_type(entry->name) != REF_TYPE_PER_WORKTREE)
> +		return 0;
> +
>  	if (!starts_with(entry->name, data->base))
>  		return 0;
>  
> @@ -1738,6 +1739,14 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
>  	return do_for_each_entry(refs, base, do_one_ref, &data);
>  }
>  
> +int do_for_each_per_worktree_ref(const char *submodule, const char *base,
> +				 each_ref_fn fn, int trim, int flags,
> +				 void *cb_data)
> +{
> +	return do_for_each_ref(get_ref_cache(submodule), base, fn, trim,
> +			       flags | DO_FOR_EACH_PER_WORKTREE_ONLY, cb_data);
> +}
> +
>  static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
>  	struct object_id oid;
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index ad683df..433d0fe 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -42,6 +42,16 @@
>   * value to ref_update::flags
>   */
>  
> +/* Include broken references in a do_for_each_ref*() iteration */
> +#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
> +
> +/* Only include per-worktree refs in a do_for_each_ref*() iteration */
> +#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
> +
> +int do_for_each_per_worktree_ref(const char *submodule, const char *base,
> +				 each_ref_fn fn, int trim, int flags,
> +				 void *cb_data);
> +
>  /*
>   * Return true iff refname is minimally safe. "Safe" here means that
>   * deleting a loose reference by this name will not do any damage, for
