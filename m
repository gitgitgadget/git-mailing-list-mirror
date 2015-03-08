From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [GSoC Microproject]Adding "-" shorthand for "@{-1}" in RESET command
Date: Sat, 07 Mar 2015 23:34:29 -0800
Message-ID: <xmqqfv9gt01m.fsf@gitster.dls.corp.google.com>
References: <1425693456-21163-1-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 08:34:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUVjR-0000GP-PP
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbbCHHec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:34:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751210AbbCHHeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:34:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B83683749A;
	Sun,  8 Mar 2015 03:34:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rHkcoiQ1jPiRH1bPivga8TDzUVU=; b=g70aXn
	A64rkmX5uSVRGmGGFarwiNG3OK1McIV+h/Z5aSMaCdcCEcUuEVSpivZmg8ZgVoII
	Q4DZtKIrjJoWzywW+w3OlXe7b1wF/TT/MWLxryUqNS1bZW36kG/hbb55nuz3+hBZ
	6HGhSthyooqXqXnielld6j+gxHGrdDUi4DH8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qUM9TgS3Rm0Rz6l2VIYzizPwM7du0/80
	CwOa5YTmAmGFexAGOj7fkUSQlYH+fA+KIh/i27y+xm0h6kuFXDwPfe+oQ0EEUEvq
	kh1Iawu6kR7NSqoz3zE8nhvyvYOITWMCVqLxWEizANkBg1uhDPuxEqfqvswUb7AT
	vS7h/F15vLw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B146037499;
	Sun,  8 Mar 2015 03:34:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37B2F37498;
	Sun,  8 Mar 2015 03:34:30 -0400 (EDT)
In-Reply-To: <1425693456-21163-1-git-send-email-dyoucme@gmail.com>
	(Sundararajan R.'s message of "Sat, 7 Mar 2015 07:27:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E94D6FE-C565-11E4-ABA6-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265035>

Sundararajan R <dyoucme@gmail.com> writes:

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4c08ddc..62764d4 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -203,8 +203,16 @@ static void parse_args(struct pathspec *pathspec,
>  	 *
>  	 * At this point, argv points immediately after [-opts].
>  	 */
> -
> +	int flag=0; /* 
> +		     *  "-" may refer to filename in which case we should be giving more precedence 
> +		     *  to filename than equating argv[0] to "@{-1}" 
> +		     */

Comment on a separate line.  More importantly, think if you can give
the variable a more meaningful name so that you do not have to
explain.

You are missing SPs requested by the coding guideline everywhere in
your patch.


>  	if (argv[0]) {
> +		if (!strcmp(argv[0], "-") && !argv[1])  /* "-" is the only argument */
> +		{
> +			argv[0]="@{-1}";
> +			flag=1;
> +		}
>  		if (!strcmp(argv[0], "--")) {
>  			argv++; /* reset to HEAD, possibly with paths */
>  		} else if (argv[1] && !strcmp(argv[1], "--")) {
> @@ -226,6 +234,8 @@ static void parse_args(struct pathspec *pathspec,

Around here not shown by this patch there are a few uses of argv[0],
and the most important one is

			verify_non_filename(prefix, argv[0]);

just before the line below (see below).

>  			rev = *argv++;
>  		} else {
>  			/* Otherwise we treat this as a filename */
> +			if(flag)
> +				argv[0]="-";
>  			verify_filename(prefix, argv[0], 1);
>  		}
>  	}

By the way, do you understand the intent of the existing checks in
this codepath that uses verify_filename() and verify_non_filename()?

The idea is to allow users to write "git reset X" and "git reset Y
Z" safely in an unambiguous way.

 * X could be a commit (e.g. "git reset master"), to update the
   current branch to point at the same commit as 'master' and update
   the index to match.

 * X could be a pathspec (e.g. "git reset hello.c"), to grab the
   blob object for X out of the HEAD and put it in the index.

 * Y could be a tree-ish and Z a pathspec (e.g. "git reset HEAD^
   hello.c"), to grab the blob object for Z out of tree-ish Y and
   put it to the index.

 * Both Y and Z could be pathspecs (e.g. "git reset hello.c
   goodbye.c"), to revert the index entries for these two paths to
   what the HEAD records.

If you happen to have a file whose name is 'master', and if you are
working on your 'topic' branch, what would this do?

    $ git reset master

Is this a request to revert the index entry for path 'master' from
the HEAD?  Or is it a request to update the current branch to be the
same as the 'master' branch and repopulate the index from there?

What does the existing code try to do, and how does it do it?  It
detects the ambiguity and refuses to do either, to make sure it
causes no harm.

Now, with your change, does the result still honor this "when
ambiguous, stop without causing harm to the user" principle?  What
happens when your user has a file whose name is "-" in the working
tree?  What happens when your user has a file whose name is "@{-1}"
in the working tree?
