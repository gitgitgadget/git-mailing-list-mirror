From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/3] sequencer: Signal failed ff as an aborted, not a conflicted merge
Date: Tue, 27 May 2014 11:42:22 -0700
Message-ID: <xmqqvbsrf4hd.fsf@gitster.dls.corp.google.com>
References: <533C913C.20106@cisco.com> <5383BDE4.9000704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <hordp@cisco.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:42:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMKV-0002HL-O1
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbaE0Sm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:42:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55659 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbaE0Sm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:42:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBA531A498;
	Tue, 27 May 2014 14:42:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dw1niPLNlFte+Aa5qUieU4q7u+U=; b=aUncYy
	R+LmRdIMVnP1Dw84Wcuf5tyOdZjH+UiWg7NHBaJuShaV7fZRKqoOqn8P+ATdBwqF
	pIaxW1NFxRxoN0e8aYXavl3z32ZQ54yVq9WmZmRMD0y/jESukf3+VJEynUqn7MQO
	fmGJbg2KuwgvW+slbwrzqrPUBpiuykJi33umM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LSQYdeIkh1wgqtjxHcfTr88hVUJUV7y6
	lKBvjnkXMcy7pKoIBmaCBShEGwmkwBn/LBUfNHl80ZnTHwIC4hjuneXpkwZaymBK
	ldtvW8TLORnvvn1bLdtYmso6alKbRCZ4JueBomAHxIL+/whzkc2OkedL6prF8/Yw
	aEBsJ30/ltU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1FB41A497;
	Tue, 27 May 2014 14:42:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 72C771A493;
	Tue, 27 May 2014 14:42:23 -0400 (EDT)
In-Reply-To: <5383BDE4.9000704@gmail.com> (Fabian Ruch's message of "Tue, 27
	May 2014 00:19:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A45CE73C-E5CE-11E3-8DB1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250185>

Fabian Ruch <bafain@gmail.com> writes:

> `do_pick_commit` handles three situations if it is not fast-forwarding.
> In order for `do_pick_commit` to identify the situation, it examines the
> return value of the selected merge command.
>
> 1. return value 0 stands for a clean merge
> 2. 1 is passed in case of a failed merge due to conflict
> 3. any other return value means that the merge did not even start
>
> So far, the sequencer returns 1 in case of a failed fast-forward, which
> would mean "failed merge due to conflict". However, a fast-forward
> either starts and succeeds or does not start at all. In particular, it
> cannot fail in between like a merge with a dirty index due to conflicts.
>
> In order to signal the three possible situations (not only success and
> failure to complete) after a pick through porcelain commands such as
> `cherry-pick`, exit with a return value that is neither 0 nor 1. -1 was
> chosen in line with the other situations in which the sequencer
> encounters an error.

Hmph... do we still pass negative to exit() anywhere in our codebase?

>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 90cac7b..97cecca 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -278,7 +278,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  
>  	read_cache();
>  	if (checkout_fast_forward(from, to, 1))
> -		exit(1); /* the callee should have complained already */
> +		exit(-1); /* the callee should have complained already */
>  	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
>  					   0, NULL);
>  	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
