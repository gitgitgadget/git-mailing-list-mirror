From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: do not lose SQUASH_MSG contents
Date: Mon, 14 Mar 2016 11:19:18 -0700
Message-ID: <xmqqpouwapnd.fsf@gitster.mtv.corp.google.com>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
	<xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
	<xmqqfuvzil3y.fsf@gitster.mtv.corp.google.com>
	<xmqqziu7h01f.fsf@gitster.mtv.corp.google.com>
	<56E5B3F9.6070404@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:19:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afX5h-0007Uu-BM
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 19:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbcCNSTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 14:19:39 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932250AbcCNSTW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 14:19:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83EAE4B6B2;
	Mon, 14 Mar 2016 14:19:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gWbf212NelyzSGEoWWbxZgHBY8o=; b=FulBvy
	rIgLZtEVYx+FpO+cYaNHKNZgtPp2FldF/7oThOw1CRzdq1XXRf6lON7Co0/ynlag
	OSbGyyA8YSN1mFbUtOuv6wK+A8zHwudIW0ebcslnS4x8Rvl3G+kuuawAZKcXbaUF
	6YSpzHi7kAN3ZWFZi3BscrgUyVZGbE56m+/UE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iauv6PAfgqeZJPvrtNmHttv/QgQk50g5
	3ncvXquqJ/9uBaa4o+fHmauHvg119GgvwQ9+ga5+YLs0lH/n9IgWqtvs7GyaaKRV
	Q732F8kHVMXaUixZ1htpB46yp3ZJscZRxbhoIsEliWw5dB6U8vrBMFptAtcM2Tgz
	SXSk69nJJko=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BD864B6B1;
	Mon, 14 Mar 2016 14:19:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F10764B6B0;
	Mon, 14 Mar 2016 14:19:19 -0400 (EDT)
In-Reply-To: <56E5B3F9.6070404@cs-ware.de> (Sven Strickroth's message of "Sun,
	13 Mar 2016 19:39:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4523E902-EA11-11E5-9CA7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288797>

Sven Strickroth <sven@cs-ware.de> writes:

> When concluding a conflicted "git merge --squash", the command
> failed to read SQUASH_MSG that was prepared by "git merge", and
> showed only the "# Conflicts:" list of conflicted paths.
>
> Place the contents from SQUASH_MSG at the beginning, just like we
> show the commit log skeleton first when concluding a normal merge,
> and then show the "# Conflicts:" list, to help the user write the
> log message for the resulting commit.
>
> Signed-off-by: Sven Strickroth <sven@cs-ware.de>
> ---
>  builtin/commit.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

The updated code looks good to me; sorry for misleading you with
fuzzy comments earlier.

We may want to have a test to prevent this from getting broken in
the future updates.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index d054f84..d40b788 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -726,9 +726,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				      &sb, &ctx);
>  		hook_arg1 = "message";
>  	} else if (!stat(git_path_merge_msg(), &statbuf)) {
> +		/*
> +		 * prepend SQUASH_MSG here if it exists and a
> +		 * "merge --squash" was originally performed
> +		*/
> +		if (!stat(git_path_squash_msg(), &statbuf)) {
> +			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
> +				die_errno(_("could not read SQUASH_MSG"));
> +			hook_arg1 = "squash";
> +		} else
> +			hook_arg1 = "merge";
>  		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
>  			die_errno(_("could not read MERGE_MSG"));
> -		hook_arg1 = "merge";
>  	} else if (!stat(git_path_squash_msg(), &statbuf)) {
>  		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
>  			die_errno(_("could not read SQUASH_MSG"));
