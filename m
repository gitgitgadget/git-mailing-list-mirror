From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 3/3] worktree: add 'list' command
Date: Fri, 11 Sep 2015 15:02:13 -0700
Message-ID: <xmqq7fnwzkbe.fsf@gitster.mtv.corp.google.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-4-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 00:02:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaWOm-0001sj-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 00:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbbIKWCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 18:02:18 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36592 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbbIKWCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 18:02:16 -0400
Received: by padhk3 with SMTP id hk3so85553580pad.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MXaDtL1j9CD01Jvgj98n8sJIK3MJtOJ5/MafXoJpv2Q=;
        b=mTLj8PaZdYkGMUgtzkyO532TJKmVFZs0Skw6tYUMgcJrenvJX/7ANGmhv3G2bET8Nm
         HxspPuq8ph8ciiIGTMEBanmxRonHKhsKQTqTqYkIMp+owkfBER5tjfBO0ByvsFiNmOOy
         oagrhPwPX07Gh/SWvqaTs4kZA+Yad1snlG3Ho4tKZFxiELqfZWzXmqoei08CQQma2VHw
         fpd88axnote+C2VACr3OLhFflWLZrhGLmuGN+fmIvy8fW8CayziQjdqgj/p0u1VASfSO
         R9ysl8CCWEHIWEIw86MhyOkMfFb8NUExINqYEsqhXchRJO7+ok5QmRU+tZKdFlgiwjgs
         TWow==
X-Received: by 10.67.10.101 with SMTP id dz5mr2261048pad.13.1442008936030;
        Fri, 11 Sep 2015 15:02:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id x10sm1478386pas.12.2015.09.11.15.02.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 15:02:14 -0700 (PDT)
In-Reply-To: <1441402769-35897-4-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 4 Sep 2015 17:39:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277701>

Michael Rappazzo <rappazzo@gmail.com> writes:

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 71bb770..a0c0fe8 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -8,10 +8,13 @@
>  #include "run-command.h"
>  #include "sigchain.h"
>  #include "refs.h"
> +#include "utf8.h"
> +#include "worktree.h"
>  
>  static const char * const worktree_usage[] = {
>  	N_("git worktree add [<options>] <path> <branch>"),
>  	N_("git worktree prune [<options>]"),
> +	N_("git worktree list [<options>]"),
>  	NULL
>  };
>  
> @@ -359,6 +362,64 @@ static int add(int ac, const char **av, const char *prefix)
>  	return add_worktree(path, branch, &opts);
>  }
>  
> +static int list(int ac, const char **av, const char *prefix)
> +{
> +	int no_bare = 0;
> +
> +	struct option options[] = {
> +		OPT_BOOL(0, "skip-bare", &no_bare,  N_("exclude bare worktrees from the list")),
> +		OPT__VERBOSE(&verbose, N_("include more worktree details")),
> +		OPT_END()
> +	};
> +
> +	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
> +	if (ac)
> +		usage_with_options(worktree_usage, options);
> +	else {
> +		struct worktree_list *worktree_list = get_worktree_list();

Call that variable just "list"; you are not dealing with any other
kind of list in this code anyway.

> +		struct worktree_list *orig = worktree_list;
> +		struct strbuf sb = STRBUF_INIT;
> +		int path_maxlen = 0;
> +
> +		if (verbose) {
> +			while (worktree_list) {
> +				int cur_len = strlen(worktree_list->worktree->path);
> +				if (cur_len > path_maxlen)
> +					path_maxlen = cur_len;
> +				worktree_list = worktree_list->next ? worktree_list->next : NULL;

Ehh, (A ? A : NULL), when A is a pointer value, is equivalent to A, no?

		struct worktree_list *orig = get_worktree_list();
		struct worktree_list *list;

		for (list = orig; list; list = list->next) {
			struct worktree *worktree = list->worktree;
			int len = strlen(worktree->path);
                        if (maxlen < len)
                        	maxlen = len;
		}

It seems that "do we really need callback interface?" suggestion
really made the code simple and straight-forward.

> +		while (worktree_list) {
> +			/* if this work tree is not bare OR if bare repos are to be shown (default) */
> +			if (!worktree_list->worktree->is_bare || !no_bare) {
> +				strbuf_reset(&sb);
> +				if (!verbose)
> +					strbuf_addstr(&sb, worktree_list->worktree->path);
> +				else {
> +					int cur_len = strlen(worktree_list->worktree->path);
> +					int utf8_adj = cur_len - utf8_strwidth(worktree_list->worktree->path);
> +					strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + utf8_adj, worktree_list->worktree->path);
> +					if (worktree_list->worktree->is_bare)
> +						strbuf_addstr(&sb, "(bare)");
> +					else {
> +						strbuf_addf(&sb, "%s ", find_unique_abbrev(worktree_list->worktree->head_sha1, DEFAULT_ABBREV));
> +						if (!worktree_list->worktree->is_detached)
> +							strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(worktree_list->worktree->head_ref, 0));
> +						else
> +							strbuf_addstr(&sb, "(detached HEAD)");
> +					}
> +				}
> +				printf("%s\n", sb.buf);
> +			}
> +			worktree_list = worktree_list->next ? worktree_list->next : NULL;

Would it help reduce the indentation level if you inroduced a helper
function that takes a single worktree object and does all the above?

	for (list = orig; list; list = list->next) {
		struct worktree *worktree = list->worktree;
		if (!no_bare || !worktree->is_bare)
	        	show_worktree(worktree);
	}

or something?
