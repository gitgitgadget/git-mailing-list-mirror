From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: do not reuse_worktree_file for submodules
Date: Mon, 24 Feb 2014 09:39:21 -0800
Message-ID: <xmqq4n3obeba.fsf@gitster.dls.corp.google.com>
References: <CAC_01E0Pu+_UeSniFVhaqfu90d=iaFDqLrKZ1zjM6GMA4BvcGQ@mail.gmail.com>
	<d08b7e5a36ee13226d1ad56a731016762ae89938.1392569505.git.tr@thomasrast.ch>
	<xmqqy518cezh.fsf@gitster.dls.corp.google.com>
	<8738jbtmji.fsf@thomasrast.ch> <87bnxyq9n6.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Gr=C3=A9gory?= Pakosz <gregory.pakosz@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:39:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzV6-0005wJ-CX
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbaBXRj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:39:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbaBXRjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:39:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B796E6B5C4;
	Mon, 24 Feb 2014 12:39:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IQ+PjXo0dFFMVSKyN1PMwt178gI=; b=SWli+i
	c5oInzVNY4tbkwoBw12GBgW3XywDJZGtxx3eNc5PO5qIvL55ech8AKZtDh99sI6P
	eskn+cQGNqxxHQee6FV6zuuAztHqb1gL8qvV5I6skAN7SdlvjbzHF+x2K6SnV0GL
	xr3TmhgSTuOLEJUnjctKJMIFuV3gbwzzOpOiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CmN5yC2m96/VsXnHGc1TttEwhgAMSJ41
	QoVGYhSiFGIdbxK+B13RGxsw6bZtOC2VvSQiOgoSlCHueAgmTv8+YOjs28BdLGK0
	bDBSstrmiRUsApv6v1mMaSstVKfLO9zWr/YxPk0b8qpGw+cTwO5DUkI06Plvf7rE
	qJK+ea4Hmpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 858016B5C3;
	Mon, 24 Feb 2014 12:39:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9FEE6B5BA;
	Mon, 24 Feb 2014 12:39:23 -0500 (EST)
In-Reply-To: <87bnxyq9n6.fsf@thomasrast.ch> (Thomas Rast's message of "Sun, 23
	Feb 2014 13:46:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 996F7458-9D7A-11E3-A454-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242618>

Thomas Rast <tr@thomasrast.ch> writes:

> I spoke too soon; it breaks the test I wrote to cover this case, for a
> reason that gives me a headache.
>
> When we hit the conditional
>
>>>> -	if (!one->sha1_valid ||
>>>> -	    reuse_worktree_file(name, one->sha1, 1)) {
>>>> +	if (!S_ISGITLINK(one->mode) &&
>>>> +	    (!one->sha1_valid ||
>>>> +	     reuse_worktree_file(name, one->sha1, 1))) {
>
> sha1_valid=0 for the submodule on the worktree side of the diff.  The
> reason is that we start out with sha1_valid=0 and sha1=000..000 for the
> worktree side of all dirty entries, which makes sense at that point.  We
> later set the sha1 by looking inside the submodule in
> diff_fill_sha1_info(), but we never set sha1_valid.  So the above
> conditional will now trigger on the !one->sha1_valid arm, completely
> defeating the change to reuse_worktree_file().
>
> We can fix it like below, but it feels a bit wrong to me.  Are
> submodules the only case where it makes sense to set sha1_valid when we
> fill the sha1?

The meaning of filespec->sha1_valid is "Is it known that the
filespec->sha1 and filespec->mode field should be used?"; I agree
that this feels wrong.

Which means that the previous one was wrong, and your original was
the right approach.  I'll drop the update.

Thanks.

>
>  diff.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git i/diff.c w/diff.c
> index dabf913..cf7281d 100644
> --- i/diff.c
> +++ w/diff.c
> @@ -3081,6 +3082,8 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
>  				die_errno("stat '%s'", one->path);
>  			if (index_path(one->sha1, one->path, &st, 0))
>  				die("cannot hash %s", one->path);
> +			if (S_ISGITLINK(one->mode))
> +				one->sha1_valid = 1;
>  		}
>  	}
>  	else
