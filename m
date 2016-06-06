From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: allow to pick to unborn branches
Date: Mon, 06 Jun 2016 13:06:48 -0700
Message-ID: <xmqq7fe2w087.fsf@gitster.mtv.corp.google.com>
References: <afafa51c-f950-594e-7142-5b28b1182add@drmicha.warpmail.net>
	<69f7973e353f52a62157ca59af5027c9617506a4.1465219182.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Fabrizio Cucci <fabrizio.cucci@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:06:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA0nZ-0005Oy-B6
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 22:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbcFFUGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 16:06:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751190AbcFFUGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 16:06:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ED11E22DCD;
	Mon,  6 Jun 2016 16:06:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SYa2GQg0oCbvy2CqkXZwt8R58dk=; b=I7IGyI
	nM33JxQlloOmDcmByLWQaqF/wTGrzAjbOzyYoy8a+YeGcskgHj0aPP0SbQXQNoHq
	Id2UJof0rlYNc0Z3cHlX7PjTE6kTDQi1vHYx9nrd+/L/KYw4GQaOCdkaJB0ybJ06
	QDuORvE95tXIvsohJD15BPiMQokG1PN+7A5kI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gPQaLfRZJl/f4GgfGy6QplkIWa7unubH
	KBwQAJyhWs9M8rPV7whEnY96m863quWbn/c7jlyYC4ed6HkxwqfZxfNuiXTgig5s
	/BtcH0RB5+NHoLkgeG89Bjwpbn16nl7aoXuyYJBzbOg9TwPB4pJlsPJH7bOZaieB
	CpG2/Vydp8A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E5B4F22DCC;
	Mon,  6 Jun 2016 16:06:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 730BA22DCB;
	Mon,  6 Jun 2016 16:06:50 -0400 (EDT)
In-Reply-To: <69f7973e353f52a62157ca59af5027c9617506a4.1465219182.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 6 Jun 2016 15:23:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34A07778-2C22-11E6-A30B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296560>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, cherry-pick allows tp pick single commits to an empty HEAD
> but not multiple commits.
>
> Allow the multiple commit case, too.
>
> Reported-by: Fabrizio Cucci <fabrizio.cucci@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  sequencer.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Thanks; we'd probably want a few tests in somewhere near 3503 or
3505.

> diff --git a/sequencer.c b/sequencer.c
> index 4687ad4..c6362d6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -888,6 +888,10 @@ static int sequencer_rollback(struct replay_opts *opts)
>  			git_path_head_file());
>  		goto fail;
>  	}
> +	if (is_null_sha1(sha1)) {
> +		error(_("cannot abort from a branch yet to be born"));
> +		goto fail;
> +	}

Is this error-fail desirable?  How do we get here?  Did a user start
a cherry-pick on an unborn branch and then told us to abort that?
Shouldn't we be taking the user back to the "orphan" state if that
is the case?

>  	if (reset_for_rollback(sha1))
>  		goto fail;
>  	remove_sequencer_state();
> @@ -1086,11 +1090,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	walk_revs_populate_todo(&todo_list, opts);
>  	if (create_seq_dir() < 0)
>  		return -1;
> -	if (get_sha1("HEAD", sha1)) {
> -		if (opts->action == REPLAY_REVERT)
> -			return error(_("Can't revert as initial commit"));
> -		return error(_("Can't cherry-pick into empty head"));
> -	}
> +	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
> +		return error(_("Can't revert as initial commit"));

Not a new issue, but I cannot quite fathom what this error message
wants to say.  "Can't revert an initial commit"?

>  	save_head(sha1_to_hex(sha1));
>  	save_opts(opts);
>  	return pick_commits(todo_list, opts);
