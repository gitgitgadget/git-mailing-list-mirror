From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/20] raceproof_create_file(): new function
Date: Wed, 17 Feb 2016 11:38:26 -0800
Message-ID: <xmqqvb5ni0ul.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<338201e98a16f6c53ed1ee447de10c206f2acc33.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:38:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7vm-0002dx-Rt
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 20:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965366AbcBQTia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 14:38:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965237AbcBQTi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 14:38:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC86B42A78;
	Wed, 17 Feb 2016 14:38:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H3m1JF7yarEnOuNslHVa8Xzc5P8=; b=QOJGSZ
	zykILX/djrHphaMevvyaKK7EwGV3VrqRdVELwAwTlgjvpuQw09jGHoW+ZR8EalQH
	pIcbdVAYSHUwac8LY3ebXYyx6zciFr1x8zIbMFfe7XuOrymk0LR+KeZGZ447Xa53
	A+Ida6CmNdBpYTRCf51A9SXUSeYYaawLj984Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=akPXYSTWybn+YD0X0nxX3H6LcIv3vhrq
	Vo0N+zFZQ0dxnFnLYx7HoegJAYXTiQ3b0rZ5+KQDHKn4HsSnGRhmzqSD/xdwYmnh
	a/+Zlkug1Y2UARV3NXwwAmSWhA+ngvrxUl6DOth7hkua1D92G9BwiyE6x7BVi7O8
	GGdU9zoNOUA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A31F042A77;
	Wed, 17 Feb 2016 14:38:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C70A342A76;
	Wed, 17 Feb 2016 14:38:27 -0500 (EST)
In-Reply-To: <338201e98a16f6c53ed1ee447de10c206f2acc33.1455626201.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Tue, 16 Feb 2016 14:22:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0454268E-D5AE-11E5-9911-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286542>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I was thinking about moving this function, along with
> safe_create_leading_directories() and
> safe_create_leading_directories_const(), to a more general module like
> path.c. But it didn't seem worth the code churn.

I think it would be a better longer-term endgame state, but let's
not do that within this 20-patch series until it stabilizes.

> diff --git a/cache.h b/cache.h
> index 7d3f80c..6e53cc8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -976,6 +976,22 @@ enum scld_error {
>  enum scld_error safe_create_leading_directories(char *path);
>  enum scld_error safe_create_leading_directories_const(const char *path);
>  
> +typedef int create_file_fn(const char *path, void *cb);

What kind of guarantee is a callback function of this type expected
to give to the caller?  Is being idempotent necessary?  etc.

What is the callback function expected to signal the caller and how?
How is its return value used?  I am guessing that returning zero
signals success and any non-zero means a failure?

> +/*
> + * Create a file at path using fn, creating leading directories if
> + * necessary. If fn fails with errno==ENOENT, then try to create the
> + * containing directory and call fn again. If fn fails with
> + * errno==EISDIR, then delete the directory that is in the way if it
> + * is empty and call fn again. Retry a few times in case we are racing
> + * with another process that is trying to clean up the directory
> + * that contains path.
> + *
> + * In any case, the return value of this function and the errno that
> + * it sets are those resulting from the last call of fn.
> + */
> +int raceproof_create_file(const char *path, create_file_fn fn, void *cb);

Neat-o.  As long as the error comes from filesystem atomic system
calls, the approach sounds like a good way to go.

> diff --git a/sha1_file.c b/sha1_file.c
> index a1ac646..31dcfe8 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -177,6 +177,75 @@ enum scld_error safe_create_leading_directories_const(const char *path)
>  	return result;
>  }
>  
> +int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
> +{
> +	/*
> +	 * The number of times we will try to remove empty directories
> +	 * in the way of path. This is only 1 because if another
> +	 * process is racily creating directories that conflict with
> +	 * us, we don't want to fight against them.
> +	 */
> +	int remove_directories_remaining = 1;
> +
> +	/*
> +	 * The number of times that we will try to create the
> +	 * directories containing path. We are willing to attempt this
> +	 * more than once, because another process could be trying to
> +	 * clean up empty directories at the same time as we are
> +	 * trying to create them.
> +	 */
> +	int create_directories_remaining = 3;
> +
> +	/* A scratch copy of path, filled lazily if we need it: */
> +	struct strbuf path_copy = STRBUF_INIT;
> +
> +	int save_errno;
> +	int ret;
> +
> +retry_fn:
> +	ret = fn(path, cb);
> +	save_errno = errno;
> +	if (!ret)
> +		goto out;
> +
> +	if (errno == EISDIR && remove_directories_remaining > 0) {
> +		/*
> +		 * A directory is in the way. Maybe it is empty; try
> +		 * to remove it:
> +		 */
> +		if (!path_copy.len)

Perhaps assert(path[0]) is needed at the beginning of this function?


> +			strbuf_addstr(&path_copy, path);
> +
> +		if (!remove_dir_recursively(&path_copy, REMOVE_DIR_EMPTY_ONLY)) {

We do want to pass empty-only, but are there cases where the caller
may want to pass more flags, e.g. keep-toplevel?

> +			remove_directories_remaining--;
> +			goto retry_fn;
> +		}
> +	} else if (errno == ENOENT && create_directories_remaining > 0) {
> +		/*
> +		 * Maybe the containing directory didn't exist, or
> +		 * maybe it was just deleted by a process that is
> +		 * racing with us to clean up empty directories. Try
> +		 * to create it:
> +		 */
> +		enum scld_error scld_result;
> +
> +		if (!path_copy.len)
> +			strbuf_addstr(&path_copy, path);
> +
> +		do {
> +			create_directories_remaining--;
> +			scld_result = safe_create_leading_directories(path_copy.buf);
> +			if (scld_result == SCLD_OK)
> +				goto retry_fn;
> +		} while (scld_result == SCLD_VANISHED && create_directories_remaining > 0);
> +	}
> +
> +out:
> +	strbuf_release(&path_copy);
> +	errno = save_errno;
> +	return ret;
> +}
> +
>  static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
>  {
>  	int i;
