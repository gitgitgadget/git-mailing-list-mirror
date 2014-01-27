From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] setup: Don't dereference in-tree symlinks for absolute paths
Date: Mon, 27 Jan 2014 08:31:37 -0800
Message-ID: <xmqqd2jdpes6.fsf@gitster.dls.corp.google.com>
References: <52E5439D.7060002@web.de>
	<1390781250-20389-1-git-send-email-martinerikwerner@gmail.com>
	<1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tboegi@web.de, git@vger.kernel.org, richih@debian.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 17:31:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7p6D-0003wu-2y
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 17:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbaA0Qbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 11:31:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753584AbaA0Qbp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 11:31:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68ACF6720A;
	Mon, 27 Jan 2014 11:31:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K10/Kne1K8mD/ob6hI0XkYxZsv8=; b=v+KfIZ
	S4NX2+Z4BphBfiRXzGEiiBC0+0Mtp5gVYNjU+y1iopq6mkB7N3F8+PZAciIKtuf4
	ali3OwlEb8nO7SesBRh6awQEZFbpAUvgc4E67hlRxF+YMzlQ1MGq7hd8SefQzgD1
	F9anAP9wp5d4pzosOrjl3qXOYqcNfH+l5WaHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T/3FT6743FXh18cvYK0Tn1t0vARgF+XP
	zlQfMRR0N5MSzRwY04JDn3wAmN5B9Jr54tjmhwV19t4EtXkvLXa3lJAM55m6xfTP
	DJklp5bP65UV3BPkHYcSB0r8ZAHjcUsdqTt1VUyUofnVkBbRgY8f+VT/JMhfC/X4
	ZJXWYtkreQs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC6167209;
	Mon, 27 Jan 2014 11:31:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 134E867206;
	Mon, 27 Jan 2014 11:31:41 -0500 (EST)
In-Reply-To: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
	(Martin Erik Werner's message of "Mon, 27 Jan 2014 01:07:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 80F57F46-8770-11E3-BDF1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241146>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> In order to manipulate symliks in the
> work tree using absolute paths, symlinks should only be dereferenced
> outside the work tree.

I agree 100% with this reasoning (modulo s/symliks/symlinks/).

As to the implementation, it looks a bit overly complicated,
though.  I haven't tried writing the same myself, but 

 * I suspect that strbuf would help simplifying the allocation and
   deallocation;

 * Also I suspect that use of string-list to split and then join is
   making the code unnecessarily complex. In Python/Perl, that would
   be a normal approach, but in C, it would be a lot simpler if you
   prepare a writable temporary in wtpart[], walk from left to right
   finding '/' and replacing it temporarily with NUL to terminate in
   order to check with real_path(), restore the NUL back to '/' to
   check deeper, and rinse and repeat.

   Having said that, I am not absolutely sure if the repeated
   calls to real_path() are doing the right thing, though ;-)

> diff --git a/setup.c b/setup.c
> index 5432a31..0789a96 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -22,11 +22,51 @@ char *prefix_path_gently(const char *prefix, int len,
>  	const char *orig = path;
>  	char *sanitized;
>  	if (is_absolute_path(orig)) {
> -		const char *temp = real_path(path);
> -		sanitized = xmalloc(len + strlen(temp) + 1);
> -		strcpy(sanitized, temp);
> +		int i, match;
> +		size_t wtpartlen;
> +		char *npath, *wtpart;
> +		struct string_list list = STRING_LIST_INIT_DUP;
> +		const char *work_tree = get_git_work_tree();
> +		if (!work_tree)
> +			return NULL;
> +		npath = xmalloc(strlen(path) + 1);
>  		if (remaining_prefix)
>  			*remaining_prefix = 0;
> +		if (normalize_path_copy_len(npath, path, remaining_prefix)) {
> +			free(npath);
> +			return NULL;
> +		}
> +
> +		string_list_split(&list, npath, '/', -1);
> +		wtpart = xmalloc(strlen(npath) + 1);
> +		i = 0;
> +		match = 0;
> +		strcpy(wtpart, list.items[i++].string);
> +		strcat(wtpart, "/");
> +		if (strcmp(real_path(wtpart), work_tree) == 0) {
> +			match = 1;
> +		} else {
> +			while (i < list.nr) {
> +				strcat(wtpart, list.items[i++].string);
> +				if (strcmp(real_path(wtpart), work_tree) == 0) {
> +					match = 1;
> +					break;
> +				}
> +				strcat(wtpart, "/");
> +			}
> +		}
> +		string_list_clear(&list, 0);
> +		if (!match) {
> +			free(npath);
> +			free(wtpart);
> +			return NULL;
> +		}
> +
> +		wtpartlen = strlen(wtpart);
> +		sanitized = xmalloc(strlen(npath) - wtpartlen);
> +		strcpy(sanitized, npath + wtpartlen + 1);
> +		free(npath);
> +		free(wtpart);
>  	} else {
>  		sanitized = xmalloc(len + strlen(path) + 1);
>  		if (len)
> @@ -34,26 +74,10 @@ char *prefix_path_gently(const char *prefix, int len,
>  		strcpy(sanitized + len, path);
>  		if (remaining_prefix)
>  			*remaining_prefix = len;
> -	}
> -	if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix))
> -		goto error_out;
> -	if (is_absolute_path(orig)) {
> -		size_t root_len, len, total;
> -		const char *work_tree = get_git_work_tree();
> -		if (!work_tree)
> -			goto error_out;
> -		len = strlen(work_tree);
> -		root_len = offset_1st_component(work_tree);
> -		total = strlen(sanitized) + 1;
> -		if (strncmp(sanitized, work_tree, len) ||
> -		    (len > root_len && sanitized[len] != '\0' && sanitized[len] != '/')) {
> -		error_out:
> +		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
>  			free(sanitized);
>  			return NULL;
>  		}
> -		if (sanitized[len] == '/')
> -			len++;
> -		memmove(sanitized, sanitized + len, total - len);
>  	}
>  	return sanitized;
>  }
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 3a0677a..03a12ac 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -190,7 +190,7 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
>  	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
>  '
>  
> -test_expect_failure SYMLINKS 'prefix_path works with work tree symlinks' '
> +test_expect_success SYMLINKS 'prefix_path works with work tree symlinks' '
>  
>  	ln -s target symlink &&
>  	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
