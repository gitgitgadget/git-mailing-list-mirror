From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] completion: filter sources of git scripts from available commands
Date: Thu, 19 Mar 2015 10:51:28 -0700
Message-ID: <xmqqbnjokh9b.fsf@gitster.dls.corp.google.com>
References: <1426452348-6304-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:51:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYebY-000801-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 18:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbbCSRvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2015 13:51:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751511AbbCSRva convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2015 13:51:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4010E40182;
	Thu, 19 Mar 2015 13:51:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ix5LTjnXW2xr
	dnREGKFqghDSQZY=; b=VMsr1NguaNI4uj1UCOR3TJCSaEeuL2wMDgsA7axJ+AuJ
	Bs99niJlL9MmAt0X/pJBtXPFIiGjK8zgfeYfjUeNkoH+ZFMsuzkbXw50DYNBq3eC
	UlaUPTupQ8Bl/WQSbymQOGGmrTQyKgNwXkGwF2980TJykqayeAiKfjsCkzkpRZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CYkFpd
	STHHmRZ/WspGnzL63kLJZl5/aZx8NQMh39cEfJGOBJpWSsqQ6cfhzVEYG8dyh/Pq
	P381XOGY5GnyPP3MzWrXI17RUkNY6+MYLlhv7YnzBeW3g5YIv3uB4oh/7wbs/+Fw
	/xwPMEfZ78EmK6SEEQOhU8lbEST97u2QDC4wo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D2CF40181;
	Thu, 19 Mar 2015 13:51:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0F1340180;
	Thu, 19 Mar 2015 13:51:29 -0400 (EDT)
In-Reply-To: <1426452348-6304-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Sun, 15 Mar 2015 21:45:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 926CB644-CE60-11E4-85CD-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265813>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Possible solutions to avoid this issue are:
>
> - Strip the current working directory from $PATH temporarily while we=
 run
>   'git help -a' to get all the available commands.  Care must be take=
n,
>   because '.' can appear at the very beginning, end, or in the middle=
 of
>   $PATH, not to mention that on unixes it's unlikely but possible to =
have
>   a directory containing e.g. ':.:' in the $PATH.
>
> - Filter out scripts from the output of 'git help -a'.  This can be d=
one
>   by either
>   * listing all possible script extensions, but this list will most l=
ikely
>     never be complete, or
>   * filtering out all commands containing a filename extension, i.e.
>     anything with a '.' in it.
>   This will bite users whose custom git commands have filename extens=
ions,
>   i.e. who put 'git-mycmd.sh' in '~/bin'.
>
> Since this is an RFC, it goes with the last option, because that's th=
e
> shortest and simplest.

Would it be another option to re-evaluate the list upon chdir (we
can trap an attempt to "cd", can't we?) _and_ if $PATH might contain
".".  It is OK if the latter criterion is not precise as long as it
does not say "$PATH does not have '.' in it" when it does.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index c21190d..9173c41 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -637,6 +637,7 @@ __git_list_all_commands ()
>  	do
>  		case $i in
>  		*--*)             : helper pattern;;
> +		*.*)              : script sources;;
>  		*) echo $i;;
>  		esac
>  	done
