From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Mon, 22 Apr 2013 12:49:23 -0700
Message-ID: <7vzjwqny64.fsf@alter.siamese.dyndns.org>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org>
	<1366658602-12254-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMkO-0007WI-7p
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab3DVTt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:49:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927Ab3DVTt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 15:49:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBFEB18C40;
	Mon, 22 Apr 2013 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=//nHmr4bh3ydMJgZeSR6Q3nd5xo=; b=xHaU2Z
	zhPxEgEGkaVPCfn17lDpG3Xmuyd1IwqzcWZEgoHdzm1htAkUO4BDM7juq89z08vG
	7hCOtXwO4gh/PINo5dhsEkC1nE/03TZrzERHaVIy8F0AeMDaalKZ4S9wvdCNt1SP
	Tq1M/42wSbZNUeTcNehq9J0zD73EjC556Ut7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XfjwaNCdiJSYAMMTUzjANPbqWOMFZa85
	eSW6GXtc2qCuppzZdeEv+OFeiNFzwt59oNvK067Acn2zkIrOYt9MSiBDrqYwbbf8
	brDDpTr+IyfW5t46FogPCPu6rE82rT6J00wX5ZQbh+dcFe/0fW86OmExGoafgFtV
	Xjyulz8WEdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D020918C3F;
	Mon, 22 Apr 2013 19:49:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DD0C18C3E;
	Mon, 22 Apr 2013 19:49:25 +0000 (UTC)
In-Reply-To: <1366658602-12254-1-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Mon, 22 Apr 2013 22:23:22 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC4BECB4-AB85-11E2-BA7B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222049>

Kevin Bracey <kevin@bracey.fi> writes:

> diff --git a/revision.c b/revision.c
> index eb98128..96fe3f5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -516,8 +516,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  		}
>  		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
>  	}
> -	if (tree_changed && !tree_same)
> -		return;
> +
> +	if (tree_changed) {
> +		if (!tree_same)
> +			return;
> +
> +		if (!revs->simplify_history && !revs->simplify_merges)
> +			return;

So in addition to "have some change and there is no same parent"
case, under _some_ condition we avoid marking a merge not worth
showing (i.e. TREESAME) if there is any change.

And the condition is !simplify_history and !simplify_merges, which
would cover --full-history, but I am not sure if requiring
!simplify_merges is correct.

Do you need it and if so why?  The --simplify-merges option is
defined as a post-processing operation over what full-history
produces in the list limiting code (which involves the logic the
patch is touching).  The --ancestry-path option works the same way
but its post-processing is done inside the limit_list() function.

So it feels more natural if the patch were ignoring simplify_merges
and paid attention only to simplify_history.

> +	}
>  	commit->object.flags |= TREESAME;
>  }
