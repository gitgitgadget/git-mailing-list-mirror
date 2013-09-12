From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/4] pathspec: use is_dir_sep() to check for trailing
 slashes
Date: Thu, 12 Sep 2013 22:17:13 +0200
Message-ID: <52322149.7050201@kdbg.org>
References: <cover.1379013786.git.john@keeping.me.uk> <88455dac2dce36135c070cff01215e9ae0259635.1379013786.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Sep 12 22:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKDKN-00075u-PN
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 22:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab3ILURT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 16:17:19 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:13589 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753803Ab3ILURT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 16:17:19 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DCAC11300A7;
	Thu, 12 Sep 2013 22:17:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8EA0819F601;
	Thu, 12 Sep 2013 22:17:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <88455dac2dce36135c070cff01215e9ae0259635.1379013786.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234689>

Am 12.09.2013 21:24, schrieb John Keeping:
> This allows us to correctly removing trailing backslashes on Windows
> when checking for submodules.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  pathspec.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/pathspec.c b/pathspec.c
> index ad1a9f5..7c6963b 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -252,7 +252,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  	item->prefix = prefixlen;
>  
>  	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
> -	    (item->len >= 1 && item->match[item->len - 1] == '/') &&
> +	    (item->len >= 1 && is_dir_sep(item->match[item->len - 1])) &&
>  	    (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
>  	    S_ISGITLINK(active_cache[i]->ce_mode)) {
>  		item->len--;
> @@ -267,7 +267,8 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  			if (!S_ISGITLINK(ce->ce_mode))
>  				continue;
>  
> -			if (item->len <= ce_len || match[ce_len] != '/' ||
> +			if (item->len <= ce_len ||
> +			    !is_dir_sep(match[ce_len]) ||
>  			    memcmp(ce->name, match, ce_len))
>  				continue;
>  			if (item->len == ce_len + 1) {

A design decisions to keep in mind:

Paths in the index *ALWAYS* use the slash, even on Windows. On Windows,
pathspec that are user input must undergo backslash-to-slash
transformation at a very early stage so that later processing that
compares the user input to index contents need not do it on the fly. The
backslash-to-slash transformation used to happen in get_pathspec() via
prefix_path() and normalize_path_copy().

If, at this point, the contents of 'match' is still being parsed for
pathspec magic, then it is likely correct to use is_dir_sep().

On the other hand, if at this point the contents of 'match' are used to
execute pathspec magic, then it is not correct to use is_dir_sep(); the
conversion of backslash to slash should have happened earlier, and no
backslashes should be present anymore.

(Yes, this means that on Windows we cannot escape glob characters
because, e.g., 'a\*.c' was turned into 'a/*.c'.)

-- Hannes
