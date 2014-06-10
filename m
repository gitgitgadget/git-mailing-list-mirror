From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/3] sequencer: Signal failed ff as an aborted, not a conflicted merge
Date: Tue, 10 Jun 2014 10:56:44 -0700
Message-ID: <xmqq8up4abs3.fsf@gitster.dls.corp.google.com>
References: <xmqqvbsrf4hd.fsf@gitster.dls.corp.google.com>
	<5395CD04.2050303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <hordp@cisco.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 19:56:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuQI4-0004a1-6W
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 19:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbaFJR4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 13:56:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62968 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbaFJR4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 13:56:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E6691DCF5;
	Tue, 10 Jun 2014 13:56:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ffS1yBVwH100WZTZyxT0oHEwqzg=; b=K/V71Y
	blpCb32XzBKOutW7rtRykQb1c2O/OHiPSjTXvU2FKSjN2NVu8nysc//wWyDC+DYf
	8sOUK5dDcXiXdu3EULCUZun3+M1FTYEa6gckoiv3/nGJ9Yf/vG5EM2xKUJ4MirY/
	Qo2h3Bhc/5DhnIrUP7oV8Wef2j4EDIWD9enLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pTX7J5B92G8EglQeazJY/ajX/a2q3k+6
	w7r7LMKFUtrDrqh4qix54DJkbr9v4MyiEVU9XFIQsp8bGBiiTQ2zgO3ILWwUiMpG
	yKLuGcZZtme5BD/eke45Me3sa3SlY+uXaO/8NjGeN1PS45KMlhjGv/mTKkIcjpnf
	vV+KJGhDtM4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 411FB1DCF3;
	Tue, 10 Jun 2014 13:56:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2FBEB1DCF2;
	Tue, 10 Jun 2014 13:56:46 -0400 (EDT)
In-Reply-To: <5395CD04.2050303@gmail.com> (Fabian Ruch's message of "Mon, 09
	Jun 2014 17:04:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 969A8690-F0C8-11E3-BCCE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251207>

Fabian Ruch <bafain@gmail.com> writes:

> On 05/27/2014 08:42 PM, Junio C Hamano wrote:
>> Fabian Ruch <bafain@gmail.com> writes:
>>> [..]
>>>
>>> In order to signal the three possible situations (not only success and
>>> failure to complete) after a pick through porcelain commands such as
>>> `cherry-pick`, exit with a return value that is neither 0 nor 1. -1 was
>>> chosen in line with the other situations in which the sequencer
>>> encounters an error.
>> 
>> Hmph... do we still pass negative to exit() anywhere in our codebase?
>
> No, but I thought `cmd_cherry_pick` would just forward the `return -1` from the
> sequencer to the shell. I had another look and found that `cmd_cherry_pick`
> calls `die` instead. Now, the commit inserts 128 as exit status in
> `fast_forward_to`.
>
> Would it be appropriate to mention the choice of exit status in the coding
> guidelines? I didn't know that the int-argument to exit(3) gets truncated and
> that this is why it is a general rule to only use values in the range from 0 to
> 255 with exit(3).

I personally do not think of a reason why it is necessary to mention
how the argument to exit(3) is expected to be used by the system, but
if it is common not to know it, I guess it would not hurt to have a
single paragraph with at most two lines.

In any case, I agree that exiting with 1 that signals "failed with
conflict" can be confusing to the caller.  Can we have a test to
demonstrate when this fix matters?

Thanks.

> -- >8 --
> Subject: sequencer: Signal failed ff as an aborted, not a conflicted merge
>
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
> `cherry-pick`, exit with a return value that is neither 0 nor 1. 128 was
> chosen in line with the other situations in which the sequencer
> encounters an error. In such situations, the sequencer returns a
> negative value and `cherry-pick` translates this into a call to `die`.
> `die` then terminates the process with exit status 128.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 90cac7b..225afcb 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -278,7 +278,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  
>  	read_cache();
>  	if (checkout_fast_forward(from, to, 1))
> -		exit(1); /* the callee should have complained already */
> +		exit(128); /* the callee should have complained already */
>  	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
>  					   0, NULL);
>  	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
