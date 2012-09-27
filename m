From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] longest_ancestor_length(): resolve symlinks before
 comparing paths
Date: Thu, 27 Sep 2012 15:51:53 -0700
Message-ID: <7vipaznkom.fsf@alter.siamese.dyndns.org>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
 <1348688090-13648-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:52:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THMw9-0001HL-Td
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 00:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab2I0Wv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 18:51:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756071Ab2I0Wvz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 18:51:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 679BA8B46;
	Thu, 27 Sep 2012 18:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RHHQQSmKzQqJTRMdI3ikp4TS0Zk=; b=ZsMbyv
	7wd+Yl+x5ZIq767bB7Ncz4uMZq5AsWeLenYRVWNROMBrlZl5fm4fjtJldvmbFxyF
	eoBRizws3bVpecTHmLlWgthr173MIJ4Uhxzi/xGr3p+wK57EGtjboGOLuGmNAH0i
	AD/Hp5ZULjjMcF+MGWaNw/S1MB+x89du3bMPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fu2bRnldwsMLXfLOs3BFyav+Z3RPRWep
	JfhBZwI+nOs9gZz0sY1lp+j+X4oqIyFU8sOr9w/lCqOZx39cfixCseq1ygChFgnl
	AsH8x58xc0tQw+kqIABxVroXsBHDnhgQzgeAwWhmwoYUaPZ4KHaBPovlmsmhCeED
	jIDyaN0Ik+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 543DC8B45;
	Thu, 27 Sep 2012 18:51:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9B668B42; Thu, 27 Sep 2012
 18:51:54 -0400 (EDT)
In-Reply-To: <1348688090-13648-8-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 26 Sep 2012 21:34:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF29A83E-08F5-11E2-A59E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206528>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> longest_ancestor_length() relies on a textual comparison of directory
> parts to find the part of path that overlaps with one of the paths in
> prefix_list.  But this doesn't work if any of the prefixes involves a
> symbolic link, because the directories will look different even though
> they might logically refer to the same directory.  So canonicalize the
> paths listed in prefix_list using real_path_if_valid() before trying
> to find matches.
>
> path is already in canonical form, so doesn't need to be canonicalized
> again.
>
> This fixes some problems with using GIT_CEILING_DIRECTORIES that
> contains paths involving symlinks, including t4035 if run with --root
> set to a path involving symlinks.
>
> Remove a number of tests of longest_ancestor_length().  It is awkward
> to test longest_ancestor_length() now, because its new path
> normalization behavior depends on the contents of the whole
> filesystem.  But we can live without the tests, because
> longest_ancestor_length() is now built of reusable components that are
> themselves tested separately: string_list_split(),
> string_list_longest_prefix(), and real_path_if_valid().

Errr, components may be correct but the way to combine and construct
could go faulty, so...

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  path.c                | 17 ++++++++------
>  t/t0060-path-utils.sh | 64 ---------------------------------------------------
>  2 files changed, 10 insertions(+), 71 deletions(-)
>
> diff --git a/path.c b/path.c
> index 5cace83..981bb06 100644
> --- a/path.c
> +++ b/path.c
> @@ -570,22 +570,25 @@ int normalize_path_copy(char *dst, const char *src)
>  
>  static int normalize_path_callback(struct string_list_item *item, void *cb_data)
>  {
> -	char buf[PATH_MAX+2];
> +	char *buf;
>  	const char *ceil = item->string;
> -	int len = strlen(ceil);
> +	const char *realpath;
> +	int len;
>  
> -	if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
> +	if (!*ceil || !is_absolute_path(ceil))
>  		return 0;
> -	memcpy(buf, ceil, len+1);
> -	if (normalize_path_copy(buf, buf) < 0)
> +	realpath = real_path_if_valid(ceil);
> +	if (!realpath)
>  		return 0;
> -	len = strlen(buf);
> +	len = strlen(realpath);
> +	buf = xmalloc(len + 2); /* Leave space for possible trailing slash */
> +	strcpy(buf, realpath);
>  	if (len == 0 || buf[len-1] != '/') {
>  		buf[len++] = '/';
>  		buf[len++] = '\0';
>  	}

Nice.
