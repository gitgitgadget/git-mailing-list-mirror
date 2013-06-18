From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: write useful reflog message for fast-forward
Date: Tue, 18 Jun 2013 11:53:52 -0700
Message-ID: <7vzjun45dr.fsf@alter.siamese.dyndns.org>
References: <1371580518-32455-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:54:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up12V-0000DG-GY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025Ab3FRSxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:53:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932968Ab3FRSxz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:53:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 561FE297B6;
	Tue, 18 Jun 2013 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WBA20QOs2OUthFOkko/qqS+4row=; b=AtnwLD
	RtIkIFRM/AKOgRaJK0y/D/zWFV/Xup9lAx5EDsHHBAc0Cn8qArHZzaaE31Mblr5C
	1oGamMDiy0NGmhrkH057Y0XDwW/zPuA2iyBgybA1mXlLcv37omzkoSJQ4fGf9js/
	y53ZeEMn499PJ9xpuwjBGrHUjd6AwHBiICJVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p9WODY4yF/XBxKyZZJIcOciIPcPk/5F1
	529PrREJ6HmnXVWvCV+a4ZguYMnqZ6oKJd68/Ko7sZOwhpWs09vG8bEgV5V1D8EZ
	W1SQZZIZKNrmup4m/7hezflWDY9VWxztPgl0lpnqfvzLWQxLrGatP5OR40FMudfM
	T+ugpC2Sjuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C9E5297B5;
	Tue, 18 Jun 2013 18:53:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAC5C297B1;
	Tue, 18 Jun 2013 18:53:53 +0000 (UTC)
In-Reply-To: <1371580518-32455-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 00:05:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C14ED46-D848-11E2-BE03-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228295>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The following command
>
>   $ git cherry-pick --ff b8bb3f
>
> writes the following uninformative message to the reflog
>
>   cherry-pick
>
> Improve it to
>
>   cherry-pick: fast-forward to b8bb3f
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Perhaps, but a few questions in general (i.e. not limited to the
difference the patch brings in, but because you are touching the
codepath anyway).

 - Is this limited to cherry-pick?  do_pick_commit() which is the
   caller of fast_forward_to() is called not just for cherry-pick
   but also for revert, and I do not see anything that makes sure
   that it is called only when (opts->action == REPLAY_CHERRY_PICK).

 - Do we want to abbreviate?  For that matter, why even say "to
   $commit", which can be seen in the "from to" part of the reflog
   record anyway?

In other words:

	strbuf_addf(&sb, "%s: fast-forward", action_name(opts))

might be sufficient, and when sequencer learns to handle more than
cherry-pick and revert, we won't have to remember that we need to
change this part.

>  sequencer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index ab6f8a7..ae63ff3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -273,12 +273,14 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  			   int unborn)
>  {
>  	struct ref_lock *ref_lock;
> +	struct strbuf sb = STRBUF_INIT;
>  
>  	read_cache();
>  	if (checkout_fast_forward(from, to, 1))
>  		exit(1); /* the callee should have complained already */
>  	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from, 0);
> -	return write_ref_sha1(ref_lock, to, "cherry-pick");
> +	strbuf_addf(&sb, "cherry-pick: fast-forward to %s", find_unique_abbrev(to, DEFAULT_ABBREV));
> +	return write_ref_sha1(ref_lock, to, sb.buf);
>  }
>  
>  static int do_recursive_merge(struct commit *base, struct commit *next,
