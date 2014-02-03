From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/5] setup: Add 'abspath_part_inside_repo' function
Date: Mon, 03 Feb 2014 13:00:48 -0800
Message-ID: <xmqq1tzjewsf.fsf@gitster.dls.corp.google.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-5-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, richih@debian.org, tboegi@web.de,
	pclouds@gmail.com, dak@gnu.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 22:01:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAQdY-0000oP-PG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 22:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbaBCVAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 16:00:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbaBCVAx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 16:00:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3222D69F5A;
	Mon,  3 Feb 2014 16:00:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IidkUqxQCeGLvwA4CMgdHy8JkNs=; b=uehege+Zfoyy7rerOjXW
	9J/a6NrzGBJWRV1zYyyfCRLD4lR+XpSO9kDffGfvpQfU1snRzjUBuu4InCYs6Ks6
	xH5NtSLEva8BEPzQZBzNrdbhcGEYMjm6346H/WGlybBq/97i5zEc/ti6O12XQ4aR
	euCXX+lX+9fmCAZN0+SI86s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VWXJDwGkS6HBh8mgO0fSVKiDE8xS27xZllaROU/bXkCwce
	Wl1qVnwOCG3SXHW3RlSJbiLqOHBnbdkLENfZF0w4j8O8lkUgApXnL23H9shHLL7i
	sJgdNzgs6NRxpZK7avfwkMBwA/tz4e1rXKnAZUNizaJARUe2ZARWF23OKW09k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C92B769F59;
	Mon,  3 Feb 2014 16:00:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DEF369F56;
	Mon,  3 Feb 2014 16:00:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42D777EA-8D16-11E3-B75E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241478>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> The path being exactly equal to the work tree is handled separately,
> since then there is no directory separator between the work tree and
> in-repo part.

What is an "in-repo part"?  Whatever it is, I am not sure if I
follow that logic.  After the while (*path) loop checks each level,
you check the whole path---wouldn't that code handle that special
case already?

Because it is probably the normal case not to have any symbolic link
in the leading part (hence not having to dereference them), I think
checking "is work_tree[] a prefix of path[]" early is justified from
performance point of view, though.

>  /*
> + * No checking if the path is in fact an absolute path is done, and it must
> + * already be normalized.

This is not quite parsable to me.

> + * Find the part of an absolute path that lies inside the work tree by
> + * dereferencing symlinks outside the work tree, for example:
> + * /dir1/repo/dir2/file   (work tree is /dir1/repo)      -> dir2/file
> + * /dir/file              (work tree is /)               -> dir/file
> + * /dir/symlink1/symlink2 (symlink1 points to work tree) -> symlink2
> + * /dir/repolink/file     (repolink points to /dir/repo) -> file
> + * /dir/repo              (exactly equal to work tree)   -> (empty string)
> + */
> +static inline int abspath_part_inside_repo(char *path)

It looks a bit too big to be marked "inline"; better leave it to the
compiler to notice that there is only a single callsite and decide
to (or not to) inline it.

> +{
> +	size_t len;
> +	size_t wtlen;
> +	char *path0;
> +	int off;
> +
> +	const char* work_tree = get_git_work_tree();
> +	if (!work_tree)
> +		return -1;
> +	wtlen = strlen(work_tree);
> +	len = strlen(path);

I expect that this is called from a callsite that _knows_ how long
path[] is.  Shouldn't len be a parameter to this function instead?

> +	off = 0;
> +
> +	/* check if work tree is already the prefix */
> +	if (strncmp(path, work_tree, wtlen) == 0) {

I wonder if we want to be explicit and compare wtlen and len before
even attempting strncmp().  If work_tree is longer than path, it
cannot be a prefix of path, right?

In other words, also with a style-fix to prefer !XXcmp() over
XXcmp() == 0:

	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {

perhaps?  That would make it clear why referring to path[wtlen] on
the next line is permissible (it is obvious that it won't access
past the end of path[]):

> +		if (path[wtlen] == '/') {
> +			memmove(path, path + wtlen + 1, len - wtlen);
> +			return 0;
> +		} else if (path[wtlen - 1] == '/' || path[wtlen] == '\0') {
> +			/* work tree is the root, or the whole path */
> +			memmove(path, path + wtlen, len - wtlen + 1);

If work_tree[] == "/", path[] == "/a", then len == 2, wtlen == 1,
path[wtlen - 1] == '/' and this shifts path[] to the left by one,
leaving path[] = "a", which is what we want.  OK.

If work_tree[] == path[] == "/a", then len == wtlen == 2,
path[wtlen] == '\0', and this becomes equivalent to path[0] = '\0'.
Hmph....  How do our callers treat an empty path?  In other words,
should these three be equivalent?

	cd /a && git ls-files /a
	cd /a && git ls-files ""
	cd /a && git ls-files .

> +			return 0;
> +		}
> +		/* work tree might match beginning of a symlink to work tree */
> +		off = wtlen;
> +	}
> +	path0 = path;
> +	path += offset_1st_component(path) + off;
> +
> +	/* check each level */
> +	while (*path) {
> +		path++;
> +		if (*path == '/') {
> +			*path = '\0';
> +			if (strcmp(real_path(path0), work_tree) == 0) {
> +				memmove(path0, path + 1, len - (path - path0));
> +				return 0;
> +			}
> +			*path = '/';
> +		}
> +	}
> +
> +	/* check whole path */
> +	if (strcmp(real_path(path0), work_tree) == 0) {
> +		*path0 = '\0';
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
> +/*
>   * Normalize "path", prepending the "prefix" for relative paths. If
>   * remaining_prefix is not NULL, return the actual prefix still
>   * remains in the path. For example, prefix = sub1/sub2/ and path is
