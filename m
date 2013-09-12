From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] Use simpler relative_path when set_git_dir
Date: Thu, 12 Sep 2013 19:36:02 +0200
Message-ID: <5231FB82.5010107@kdbg.org>
References: <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com> <121215a0837321e57c3918784d3de9597c9fc292.1378977052.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 19:36:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKAoM-0005LR-Px
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 19:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab3ILRgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 13:36:06 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:41478 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754529Ab3ILRgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 13:36:04 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3856D10019;
	Thu, 12 Sep 2013 19:36:03 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C678819F601;
	Thu, 12 Sep 2013 19:36:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <121215a0837321e57c3918784d3de9597c9fc292.1378977052.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234662>

Am 12.09.2013 11:12, schrieb Jiang Xin:
> Using a relative_path as git_dir first appears in v1.5.6-1-g044bbbc.
> It will make git_dir shorter only if git_dir is inside work_tree,
> and this will increase performance. But my last refactor effort on
> relative_path function (commit v1.8.3-rc2-12-ge02ca72) changed that.
> Always use relative_path as git_dir may bring troubles like
> $gmane/234434.
> 
> Because new relative_path is a combination of original relative_path
> from path.c and original path_relative from quote.c, so in order to
> restore the origin implementation, save the original relative_path
> to simple_relative_path, and call it in setup.c.
> 
> Suggested-by: Karsten Blees <karsten.blees@gmail.com>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  cache.h |  1 +
>  path.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  setup.c |  5 +----
>  3 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 8e42256..ab17f1d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -738,6 +738,7 @@ const char *real_path(const char *path);
>  const char *real_path_if_valid(const char *path);
>  const char *absolute_path(const char *path);
>  const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
> +const char *simple_relative_path(const char *in, const char *prefix);
>  int normalize_path_copy(char *dst, const char *src);
>  int longest_ancestor_length(const char *path, struct string_list *prefixes);
>  char *strip_path_suffix(const char *path, const char *suffix);
> diff --git a/path.c b/path.c
> index ffcdea1..0f0c92f 100644
> --- a/path.c
> +++ b/path.c
> @@ -558,6 +558,51 @@ const char *relative_path(const char *in, const char *prefix,
>  }
>  
>  /*
> + * A simpler implementation of relative_path

So we have a heavy-duty function relative_path(), but it is not capable
of doing the "simple" operations that this function does?

There must be something wrong.

This function were easier to sell if it were named
remove_optional_prefix() or something.

> + *
> + * Get relative path by removing "prefix" from "in". This function
> + * first appears in v1.5.6-1-g044bbbc, and makes git_dir shorter
> + * to increase performance when traversing the path to work_tree.
> + */
> +const char *simple_relative_path(const char *in, const char *prefix)
> +{
> +	static char buf[PATH_MAX + 1];
> +	int i = 0, j = 0;
> +
> +	if (!prefix || !prefix[0])
> +		return in;
> +	while (prefix[i]) {
> +		if (is_dir_sep(prefix[i])) {
> +			if (!is_dir_sep(in[j]))
> +				return in;
> +			while (is_dir_sep(prefix[i]))
> +				i++;
> +			while (is_dir_sep(in[j]))
> +				j++;
> +			continue;
> +		} else if (in[j] != prefix[i]) {
> +			return in;
> +		}
> +		i++;
> +		j++;
> +	}
> +	if (
> +	    /* "/foo" is a prefix of "/foo" */
> +	    in[j] &&
> +	    /* "/foo" is not a prefix of "/foobar" */
> +	    !is_dir_sep(prefix[i-1]) && !is_dir_sep(in[j])
> +	   )
> +		return in;
> +	while (is_dir_sep(in[j]))
> +		j++;
> +	if (!in[j])
> +		strcpy(buf, ".");
> +	else
> +		strcpy(buf, in + j);
> +	return buf;
> +}
> ...
