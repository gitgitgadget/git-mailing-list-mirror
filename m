From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/19] reset [--mixed] --quiet: don't refresh index
Date: Wed, 09 Jan 2013 12:05:41 -0800
Message-ID: <7v4niq5dgq.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-17-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:06:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1uY-0003eR-KV
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 21:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640Ab3AIUFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 15:05:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932466Ab3AIUFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 15:05:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9D99AA93;
	Wed,  9 Jan 2013 15:05:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hnZwdIq39Lkn3gQysLVaJ3L2+bw=; b=Hs1W0i
	BFhW1qveMyj1PVvVZz8WaTXJQBJ0dh3Qp1Qthlauzf4L7pMA5ctSemafUGM/BgZf
	ZN9c8tPD97jvppCnmjyzjIqOUEhfXhdfbfuQwQZUKuWBEuuiuUJPbjws5lgosjp8
	VHs5ouJfjeE3hwiMSGlKALMjnTnoZjIu3GFxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E9u8cLM8nmuXXHafD6tpFoh0hCwWX+5P
	ELvA+LCtaHKV5m+SD8o4QdVn0KBQcOPVY+HBgwjton+WPI70GS2nqZ6IZpWaq1nJ
	1oAnbk9/GqFszEAuZ6MEgzjyYf3gfb93ZtGWcYN/6cFNthax/aJacul8cXHk35Fl
	Mp5sVIwze30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A70CFAA92;
	Wed,  9 Jan 2013 15:05:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A087AA8E; Wed,  9 Jan 2013
 15:05:43 -0500 (EST)
In-Reply-To: <1357719376-16406-17-git-send-email-martinvonz@gmail.com>
 (Martin von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F29817BE-5A97-11E2-ABDA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213096>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> There is a test case in t7102 called '--mixed refreshes the index',
> but it only checks that right output it printed.

I think that comes from 620a6cd (builtin-reset: avoid forking
"update-index --refresh", 2007-11-03).  Before that commit, we
refreshed the index with --mixed, and the test tries to make sure we
continue to do so after the change.  Even though it is not testing
if the index has stat only changes (which is rather cumbersome to
write---you need to futz with timestamp or something) and using the
output from refresh machinery as a substitute, I think the intent of
that commit is fairly clear.

>  builtin/reset.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 9bcad29..a2e69eb 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -109,12 +109,6 @@ static void print_new_head_line(struct commit *commit)
>  		printf("\n");
>  }
>  
> -static void update_index_refresh(int flags)
> -{
> -	refresh_index(&the_index, (flags), NULL, NULL,
> -		      _("Unstaged changes after reset:"));
> -}
> -
>  static void update_index_from_diff(struct diff_queue_struct *q,
>  		struct diff_options *opt, void *data)
>  {
> @@ -328,9 +322,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  				die(_("Could not reset index file to revision '%s'."), rev);
>  		}
>  
> -		if (reset_type == MIXED) /* Report what has not been updated. */
> -			update_index_refresh(
> -				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
> +		if (reset_type == MIXED && !quiet) /* Report what has not been updated. */
> +			refresh_index(&the_index, REFRESH_IN_PORCELAIN, NULL, NULL,
> +				      _("Unstaged changes after reset:"));
>  
>  		if (write_cache(newfd, active_cache, active_nr) ||
>  		    commit_locked_index(lock))
