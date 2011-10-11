From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make is_gitfile a non-static generic function
Date: Tue, 11 Oct 2011 16:45:59 -0700
Message-ID: <7vipnvccso.fsf@alter.siamese.dyndns.org>
References: <4E94C70E.3080003@cisco.com> <4E94C8AB.3040807@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 01:46:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDm1W-0005I4-E2
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 01:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab1JKXqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 19:46:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab1JKXqD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 19:46:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21EBF5632;
	Tue, 11 Oct 2011 19:46:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7LhfzYH+aiGzJLaYgQ3YWlRjnHg=; b=ou7DEs
	VdoRqPy4nCzF3h/DUjxLxtIF3jPN+FqSofHUX3RAMwSH0kylFs3M6m3ypW5pU6em
	fPZhRqvYTgn9/JHIm1irVAnNDzJkIbZGqynp8+3J+GrnfjqSZzm/cpMuBWnMYQVz
	oyMGLse6jVUWtEWFOJcyiskkkd2/L2LdXXpOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wDcN2M+7ymr3En7Mm8QwYPSxhdDwVPh1
	9+omhYvhvQprv6+lS9N9UCrTzfIGAP9nHATsJkfcnuWQOQHR7BaCx24FdyPnrWhr
	lIETn1uErpWgeKw0strVX2c+ZsKagQObXXH+mUV/y5irxFD3hOJHDG6Qomt6edvv
	pT/OXsHmlik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 199ED5631;
	Tue, 11 Oct 2011 19:46:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82DD95623; Tue, 11 Oct 2011
 19:46:01 -0400 (EDT)
In-Reply-To: <4E94C8AB.3040807@cisco.com> (Phil Hord's message of "Tue, 11
 Oct 2011 18:52:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D06B94C-F463-11E0-94C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183348>

Phil Hord <hordp@cisco.com> writes:

> The new is_gitfile is an amalgam of similar functional checks
> from different places in the code....

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 488f48e..5110399 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -120,13 +120,7 @@ static char *get_repo_path(const char *repo, int
> *is_bundle)
>  			return xstrdup(absolute_path(path));
>  		} else if (S_ISREG(st.st_mode) && st.st_size > 8) {
>  			/* Is it a "gitfile"? */
> -			char signature[8];
> -			int len, fd = open(path, O_RDONLY);
> -			if (fd < 0)
> -				continue;
> -			len = read_in_full(fd, signature, 8);
> -			close(fd);
> -			if (len != 8 || strncmp(signature, "gitdir: ", 8))
> +			if (!is_gitfile(path))
>  				continue;
>  			path = read_gitfile(path);
>  			if (path) {
> diff --git a/cache.h b/cache.h
> index 601f6f6..7a8d9f9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -441,6 +441,7 @@ extern const char *get_git_work_tree(void);
>  extern const char *read_gitfile(const char *path);
>  extern const char *resolve_gitdir(const char *suspect);
>  extern void set_git_work_tree(const char *tree);
> +extern int is_gitfile(const char *path);
>   #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>  diff --git a/transport.c b/transport.c
> index f3195c0..d08a826 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -859,7 +859,11 @@ static int is_local(const char *url)
>  		has_dos_drive_prefix(url);
>  }
>  -static int is_gitfile(const char *url)
> +/*
> + * See if the referenced file looks like a 'gitfile'.
> + * Does not try to determine if the referenced gitdir is actually valid.
> + */
> +int is_gitfile(const char *url)
>  {
>  	struct stat st;
>  	char buf[9];

After looking at this patch and the way the other caller in transport.c
uses it, I am more and more convinced that "is_gitfile()" is a stupid and
horrible mistake.

The caller in transport.c says "I am about to read from a regular file,
and usually I would treat it as a bundle, but I want to avoid that
codepath if that regular file is not a bundle. So I use the codepath only
when that file is not a gitfile".

It should be saying "Is it a bundle? Then I'd use the codepath to read
from the bundle" to begin with. Otherwise the code will break when we add
yet another regular file we can fetch from that is not a bundle nor a
gitfile.

I think the hand-crafted check in builtin/clone.c you removed originated
from laziness to avoid teaching read_gitfile() to read potential gitfile
silently (and signal errors by simply returning NULL). I also suspect the
codepath may become simpler if we had a way to ask "Is this a bundle?".

I think read_bundle_header() in bundle.c can be refactored to a silent
interface that allows us to ask "Is this a bundle?" question properly.
