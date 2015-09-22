From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] worktree: add 'list' command
Date: Tue, 22 Sep 2015 12:42:12 -0700
Message-ID: <xmqq37y644x7.fsf@gitster.mtv.corp.google.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
	<1442583027-47653-5-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTSa-0004ZQ-N4
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363AbbIVTmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 15:42:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36205 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758838AbbIVTmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 15:42:15 -0400
Received: by pablk4 with SMTP id lk4so2036128pab.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KgZ++3HE3MjvVeKHZ8wGym3XLEuO+w+VOUbDIrcJJbY=;
        b=jVl5Ta3SS1i7QYkQpxRWs3zZID170kqHcIMKP80WUlBQbfHIL9cL5cIY2Vt6BkJbb4
         6ytPDMiFP2yLLbLa4b8PTzd3G2pMVtjt66fd97/x+elrVjvKcDlc6Fhksh2q6drbMhLM
         SM3Pa8oc2QhDCuT11RJWnPopUF6uFSMEsncKX3fmt+K34isX5hjFEbtum+cxjSqPAsY1
         PLQLOLDh37nWikDS39Bhd9aVoveAW7i2pVZpBz5bD5riz/dYcQAvVqcgbKHrBEcxF+b4
         Q6O5ip56EQszqBuDG7myoaCf5pF4uDxZlxCXwMyPjBdVxJfc5zYNxLHDpHfUjfxJB+Ih
         aTdw==
X-Received: by 10.66.232.102 with SMTP id tn6mr33064093pac.47.1442950934825;
        Tue, 22 Sep 2015 12:42:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id vw7sm3816413pab.15.2015.09.22.12.42.13
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 12:42:13 -0700 (PDT)
In-Reply-To: <1442583027-47653-5-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 18 Sep 2015 09:30:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278422>

Michael Rappazzo <rappazzo@gmail.com> writes:

>  
> +--porcelain::
> +	With `list`, output in an easy-to-parse format for scripts.
> +	This format will remain stable across Git versions and regardless of user
> +	configuration.

... and exactly what does it output?  That would be the first
question a reader of this documentation would ask.


> @@ -93,6 +106,7 @@ OPTIONS
>  --expire <time>::
>  	With `prune`, only expire unused working trees older than <time>.
>  
> +

?

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 71bb770..e6e36ac 100644
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
> @@ -359,6 +362,79 @@ static int add(int ac, const char **av, const char *prefix)
>  	return add_worktree(path, branch, &opts);
>  }
>  
> +static void show_worktree_porcelain(struct worktree *worktree)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_addf(&sb, "worktree %s\n", worktree->path);
> +	if (worktree->is_bare)
> +		strbuf_addstr(&sb, "bare");
> +	else {
> +		if (worktree->is_detached)
> +			strbuf_addf(&sb, "detached at %s", find_unique_abbrev(worktree->head_sha1, DEFAULT_ABBREV));
> +		else
> +			strbuf_addf(&sb, "branch %s", shorten_unambiguous_ref(worktree->head_ref, 0));
> +	}

Writing the above like this:

	if (worktree->is_bare)
        	...
	else if (worktree->is_detached)
		...
	else
                ...

would make it a lot more clear that there are three cases.

Also, I doubt --porcelain output wants shorten or abbrev.

Human-readability is not a goal.  Reproducibility is.  When you run
"worktree list" today and save the output, you want the output from
"worktree list" taken tomorrow to exactly match it, even after
creating many objects and tags with conflicting names with branches,
as long as you didn't change their HEADs in the meantime.

> +
> +	printf("%s\n\n", sb.buf);
> +
> +	strbuf_release(&sb);

I am not sure what the point of use of a strbuf is in this function,
though.  Two printf's for each case (one for the common "worktree
%s", the other inside if/elseif/else cascade) should be sufficient.

> +static void show_worktree(struct worktree *worktree, int path_maxlen)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +

Remove this blank line.  You are still declaring variables.

> +	int cur_len = strlen(worktree->path);
> +	int utf8_adj = cur_len - utf8_strwidth(worktree->path);

Have a blank line here, instead, as now you start your statements.

> +	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + utf8_adj, worktree->path);
> +	if (worktree->is_bare)
> +		strbuf_addstr(&sb, "(bare)");
> +	else {
> +		strbuf_addf(&sb, "%s ", find_unique_abbrev(worktree->head_sha1, DEFAULT_ABBREV));

Personally I am not a big fan of the the alignment and use of
utf8_strwidth(), but by using find_unique_abbrev() here, you are
breaking the alignment, aren't you?  " [branchname]" that follows
the commit object name would not start at the same column, when
you have many objects that default-abbrev is not enough to uniquely
identify them.

And it can easily be fixed by computing the unique-abbrev length for
all the non-bare worktree's HEADs in the same loop you computed
path_maxlen() in the caller, passing that to this function, and use
that as mininum abbrev length when computing the unique-abbrev.

> +		if (!worktree->is_detached)
> +			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(worktree->head_ref, 0));
> +		else
> +			strbuf_addstr(&sb, "(detached HEAD)");
> +	}
> +	printf("%s\n", sb.buf);


> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> new file mode 100755
> index 0000000..b68dfb4
> --- /dev/null
> +++ b/t/t2027-worktree-list.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +
> +test_description='test git worktree list'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit init
> +'
> +
> +test_expect_success '"list" all worktrees from main' '
> +	echo "$(git rev-parse --show-toplevel)       $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&

Are the number of SPs here significant and if so in what way?  Does
it depend on your environment or will there always be six of them?
Either way feels like an indication of a problem.

> +	git worktree add --detach here master &&
> +	test_when_finished "rm -rf here && git worktree prune" &&

Aren't these two the other way around?  When "add" fails in the
middle, you would want it to be removed to proceed to the next test
without leaving 'here' in the list of worktrees, no?
