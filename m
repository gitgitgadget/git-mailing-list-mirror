From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] reset: Print a warning when user uses "git reset" during a merge
Date: Mon, 17 Mar 2014 14:54:02 -0700
Message-ID: <xmqqwqfsbif9.fsf@gitster.dls.corp.google.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
	<1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 22:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfUA-00063E-RG
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbaCQVyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:54:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbaCQVyL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:54:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6593E76D31;
	Mon, 17 Mar 2014 17:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kE5w+/6spWV/P42072kgocUTGno=; b=r6mdRx
	nQkMk572+gbiCVdl9odFr7Wmo+Idx1b9jWh6sbmQyPGXFKw/65NNcGusWSWJLhpb
	zVw9m8A6DtTaacCvTDP4XpfQEktPLj3WcxFVtSG82qx32g751ORW8jAbQC1189JZ
	up7+VQwAIMa8Bd/knXZReqfDUUNXWkpYAgyfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DQiD3c3vL/7HXHroHQed89lGPljMY628
	YtYEhfv2MZ6KCjb8QJ9E4py8KALSMGere9QHRRg04Em0I5m97RzQDkiCEANbWYJR
	AFaeGzw5PkCdW6QQSLkbzX99aX9PDlSn5lOkn3KtoHsh9xsjuXo01SDXa2DtS2Ji
	zlg1zoYUvp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 488B776D30;
	Mon, 17 Mar 2014 17:54:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3539276D2D;
	Mon, 17 Mar 2014 17:54:09 -0400 (EDT)
In-Reply-To: <1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com> (Andrew
	Wong's message of "Fri, 14 Mar 2014 00:37:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AAFEFFA4-AE1E-11E3-82A8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244294>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> During a merge, "--mixed" is most likely not what the user wants. Using
> "--mixed" during a merge would leave the merged changes and new files
> mixed in with the local changes. The user would have to manually clean
> up the work tree, which is non-trivial. In future releases, we want to
> make "git reset" error out when used in the middle of a merge. For now,
> we simply print out a warning to the user.
>
> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> ---
>  builtin/reset.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4fd1c6c..04e8103 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -331,8 +331,29 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  					_(reset_type_names[reset_type]));
>  	}
>  	if (reset_type == NONE)
> +	{
>  		reset_type = MIXED; /* by default */
>  
> +		/* During a merge, "--mixed" is most likely not what the user

Two style niggles here.

> +		 * wants. Using "--mixed" during a merge would leave the merged
> +		 * changes and new files mixed in with the local changes. The
> +		 * user would have to manually clean up the work tree, which is
> +		 * non-trivial. In future releases, we want to make "git reset"

"we want"?  Has any of us decided on that?

> +		 * error out when used in the middle of a merge. For now, we
> +		 * simply print out a warning to the user. */
> +		if (is_merge())
> +			warning(_("You have used 'git reset' in the middle of a merge. 'git reset' defaults to\n"
> +				  "'git reset --mixed', which means git will not clean up any merged changes and\n"
> +				  "new files that were created in the work tree. It also becomes impossible for\n"
> +				  "git to automatically clean up the work tree later, so you would have to clean\n"
> +				  "up the work tree manually. To avoid this next time, you may want to use 'git\n"
> +				  "reset --merge', or equivalently 'git merge --abort'.\n"
> +				  "\n"
> +				  "In future releases, using 'git reset' in the middle of a merge will result in\n"
> +				  "an error."
> +				 ));
> +	}
> +
>  	if (reset_type != SOFT && reset_type != MIXED)
>  		setup_work_tree();
