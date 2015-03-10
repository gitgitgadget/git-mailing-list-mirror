From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3/GSoC/MICRO] revision: forbid combining --graph and --no-walk
Date: Tue, 10 Mar 2015 14:39:38 -0700
Message-ID: <xmqqegowzg4l.fsf@gitster.dls.corp.google.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
	<297580e4cf8a1152224394ce27f67e2457657615.1425865346.git.dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, l.s.r@web.de
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 22:40:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVRsl-0004El-DA
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 22:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbbCJVkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 17:40:01 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752691AbbCJVkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 17:40:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E41263EF56;
	Tue, 10 Mar 2015 17:39:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ovTyehFlDtGPvdrMFAmCQs9UeRg=; b=jSkKH2
	tM/yIGGr9Y8dcd1TCJGBZ1ObeX44rClSNoDSJMggJtMj+AmP3HjiKAM93UgHuAwg
	1vZpPt8oUOYuPgEXuFHojwMhrLH/BcICeboNFY56GwpTtozTAA7Qii8esryBxQ48
	/fd67LLkeRfsZAyFwnG5D0O6hsjsNfxURZ9Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I3b8c9tQHxfHHQAeNJlXC8NO1HQBEBCF
	DxgSjzgu3sSveMVH47/pmpDgLb3zjaIE9RUsmmTRliHUvjPfQIIU0kEyBI07SKqn
	ywSnl2xI/A1Cub/FFM2cCXThCyrlDwIqNx46PkkdJ6in+Yzpgk7zLY9exSBKKFLX
	rGKvwSNSWHU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB42D3EF55;
	Tue, 10 Mar 2015 17:39:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C3523EF34;
	Tue, 10 Mar 2015 17:39:40 -0400 (EDT)
In-Reply-To: <297580e4cf8a1152224394ce27f67e2457657615.1425865346.git.dongcan.jiang@gmail.com>
	(Dongcan Jiang's message of "Mon, 9 Mar 2015 12:09:54 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4DC013A-C76D-11E4-8D13-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265265>

Dongcan Jiang <dongcan.jiang@gmail.com> writes:

> Because "--graph" is about connected history while --no-walk
> is about discrete points, it does not make sense to allow
> giving these two options at the same time. [1]
>
> This change allows git-show to have such options' combination
> as a special case, because git-show itself has underlying
> --no-walk option, while "git show --graph" is a legal and
> useful operation which is tested in t4052. [2,3]

Hmph, I actually was hoping to see that you would either (1) explain
why this special case is not useful, fix t4052 and do without
cmd_is_show bit, or (2) explain why this special case _is_ useful in
a more concrete terms.

"X is legal and tested" does not automatically imply that whatever
random thing the implementation does, and the test whose expectation
matches what it does, is a well-thought-out and a useful operation.
If you are going in the direction (2), it would have been better if
the reason why "git show --graph one_commit" is useful is given here
in your own words.

You do not want to force those who are reading this log message 6
months down the road to visit [2,3] for more details.

> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..5b5d028 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -524,6 +524,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  
>  	memset(&match_all, 0, sizeof(match_all));
>  	init_revisions(&rev, prefix);
> +	rev.cmd_is_show = 1;
>  	rev.diff = 1;
>  	rev.always_show_header = 1;
>  	rev.no_walk = REVISION_WALK_NO_WALK_SORTED;

OK.

> diff --git a/revision.c b/revision.c
> index 66520c6..5d6fbef 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1399,6 +1399,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
>  
>  	revs->commit_format = CMIT_FMT_DEFAULT;
>  
> +	revs->cmd_is_show = 0;
> +

The new assignment and a blank line shouldn't be necessary; the
memset() at the beginning is there so that you do not have to do
this.

> diff --git a/revision.h b/revision.h
> index 0ea8b4e..378c3bf 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -146,6 +146,9 @@ struct rev_info {
>  			track_first_time:1,
>  			linear:1;
>  
> +	/* cmd type */
> +	unsigned int  cmd_is_show:1;

If you are going to comment, imagine that somebody will want to add
a new subcommand in "git log" family in the future, and try to help
him decide if he wants to flip this bit for his subcommand with that
comment.  He would scratch his head, reading "cmd type?", and wonder
"Hmmmm, what makes 'show' special?  Is my new command also special
like 'show' is?  What makes my new command the same cmd type as
'show' (or different)?"  The comment does not help him answer these
questions very much.

An alternative is to not to add the misleading comment; cmd_is_show
is clear enough indication for such a person that he does not want
the bit set because whatever new subcommand he is adding is not
'show'.

This is becoming to appear more and more that cmd_is_show is "allow
combined use of graph and no-walk only to avoid breaking a few
tests", not "in the context of show, graph and no-walk is useful",
at least to me.  Perhaps the comment should say

	/*
         * special case to prevent 'git show --graph' that does not
         * walk from triggering the usual "--no-walk and --graph cannot
         * be used together" error.
         */
	unsigned int cmd_is_show:1;

or even name the variable more explicitly, i.e.

	unsigned int allow_graph_and_no_walk:1;

I dunno.

The tests look fine.  Thanks.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 5f2b290..f111705 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -887,4 +887,8 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
>  	grep "^| | gpg: Good signature" actual
>  '
>  
> +test_expect_success 'log --graph --no-walk is forbidden' '
> +	test_must_fail git log --graph --no-walk
> +'
> +
>  test_done
> diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
> index 991ab4a..c9bedd2 100755
> --- a/t/t6014-rev-list-all.sh
> +++ b/t/t6014-rev-list-all.sh
> @@ -35,4 +35,8 @@ test_expect_success 'repack does not lose detached HEAD' '
>  
>  '
>  
> +test_expect_success 'rev-list --graph --no-walk is forbidden' '
> +	test_must_fail git rev-list --graph --no-walk HEAD
> +'
> +
>  test_done
