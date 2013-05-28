From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] rebase: fix cherry-pick invocations
Date: Tue, 28 May 2013 15:46:13 -0700
Message-ID: <7vzjvewwne.fsf@alter.siamese.dyndns.org>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
	<1369747757-10192-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 00:46:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhSeu-0007YW-T7
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 00:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757968Ab3E1WqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 18:46:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757092Ab3E1WqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 18:46:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F9382361D;
	Tue, 28 May 2013 22:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5JGznEE/bR1ZNkwVaAr4bJkU7+0=; b=XduvYn
	2xhkuKnBWCOhCvarMumIalymYJ94m9hdFbi+GvNOHfBqMUASaMWrhS+gGokbvjuC
	HvasBZPA886ik5X1Pm8cbaluqYGOnX6cXOHOLJSjXcHbfARui6kuskJfP8FyEaJh
	S7D2SaZEhH2WUv+lfEfgJvA96QQVSZHTqyO2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h1R6BXbRDonHB/SPRtaSFGqcUsC6KdaV
	cTs9tWJKDwpN6pCAaORfW1FbNQJCLszzDJCn98UQgTp0iJeoUxQ18cMODr167lpX
	D1mwIZFC6Q16mmsZUpbbt/00862JrvT9Txlx2Rsq0MKpizh/ij3TZTxayHShoAgd
	kAghQlTr5EQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 135C32361C;
	Tue, 28 May 2013 22:46:16 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 699592361B;
	Tue, 28 May 2013 22:46:15 +0000 (UTC)
In-Reply-To: <1369747757-10192-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 08:29:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6754238C-C7E8-11E2-A42D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225694>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So that all the tests pass.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-rebase--cherry.sh | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
> index ca78b1b..c3a2ac9 100644
> --- a/git-rebase--cherry.sh
> +++ b/git-rebase--cherry.sh
> @@ -23,11 +23,26 @@ test -n "$rebase_root" && root_flag=--root
>  mkdir "$state_dir" || die "Could not create temporary $state_dir"
>  : > "$state_dir"/cherry || die "Could not mark as cherry"
>  
> +if test -n "$rebase_root"
> +then
> +	revisions="$onto...$orig_head"
> +else
> +	revisions="$upstream...$orig_head"
> +fi

"So that all the tests pass" needs a bit more explanation to say for
cherry-pick codepath why and how two-dot range fails and why and how
three-dot variant with --right-only fixes it.  What are the problematic
cases?

>  # we have to do this the hard way.  git format-patch completely squashes
>  # empty commits and even if it didn't the format doesn't really lend
>  # itself well to recording empty patches.  fortunately, cherry-pick
>  # makes this easy
> -git cherry-pick --allow-empty "$revisions"
> +if test -n "$keep_empty"
> +then
> +	extra="--allow-empty"
> +else
> +	extra="--skip-empty --cherry-pick"
> +fi
> +test -n "$GIT_QUIET" && extra="$extra -q"
> +test -z "$force_rebase" && extra="$extra --ff"
> +git cherry-pick --no-merges --right-only --topo-order --do-walk --copy-notes $extra "$revisions"
>  ret=$?
>  
>  if test 0 != $ret
