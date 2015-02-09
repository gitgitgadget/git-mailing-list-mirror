From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/completion: suppress stderror in bash completion of git remotes
Date: Mon, 09 Feb 2015 13:09:31 -0800
Message-ID: <xmqqy4o6aj1w.fsf@gitster.dls.corp.google.com>
References: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matt Korostoff <mkorostoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:09:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvaO-0000mr-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761036AbbBIVJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:09:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760531AbbBIVJf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:09:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 050D8357DB;
	Mon,  9 Feb 2015 16:09:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHP9TowwWCrBaL/7AygeDOPBotE=; b=Ttoayl
	NTDfmUSRj+MSVI2b+Ph8m1fsTPYLgNnKq9YjPpfWERVH+kv1uEt9heVLbwm46SLz
	E6b+97ARydesHPWYdDaALRxZrqw4Bw4Uwo+m7t/ugzQi6qNfJrTyJDSsdpd0sg4u
	AAybxJR2HrHJ17HsVseIlVo+xQdqgQILX4jdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RtSWoZN6xmj8zGiwLmPDRby6QP3INYz1
	LFPEvOylOLLxY1hZxKdR2w3wxygjMJOUlJxn6UGICzYxCInzcWvB7XIcTpG789nR
	QHfPK076S+7FflK4+RhPfN5tBkr5OOibaypQS4AVAIGZ/b3WS7kB32wW7teR2ILq
	Zk9sHt1R6jo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE662357D8;
	Mon,  9 Feb 2015 16:09:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6788F357D3;
	Mon,  9 Feb 2015 16:09:33 -0500 (EST)
In-Reply-To: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com> (Matt
	Korostoff's message of "Mon, 9 Feb 2015 15:58:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F1FFE4CA-B09F-11E4-AE21-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263600>

Matt Korostoff <mkorostoff@gmail.com> writes:

> In some system configurations there is a bug with the
> __git_remotes function.  Specifically, there is a problem
> with line 415, `test -d "$d/remotes" && ls -1 "$d/remotes"`.
> While `test -d` is meant to prevent listing the remotes
> directory if it does not exist, in some system, `ls` will
> run regardless.

What's "some system"?

Is this a platform's bug (e.g. "test -d" does not work correctly)?

Is this an configuration error of user's Git repository?

Is this something else?

I _think_ you would see the problem if $d/remotes is a directory
whose contents cannot be listed (e.g. "chmod a= $d/remotes"), and
that would not be a platform's bug (i.e. "test -d" would happily say
"Yes there is a directory", and "ls" would fail with "Permission
denied").  But I wonder if we rather want the user to notice that
misconfiguration so that the user can correct it, instead of hiding
the error message from "ls".

> This results in an error in which typing `git push or` + `tab`
> prints out `ls: .git/remotes: No such file or directory`.
> This can be fixed by simply directing stderror of this line
> to /dev/null.
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2fece98..72251cc 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -412,7 +412,7 @@ __git_refs_remotes ()
>  __git_remotes ()
>  {
>  	local i IFS=$'\n' d="$(__gitdir)"
> -	test -d "$d/remotes" && ls -1 "$d/remotes"
> +	test -d "$d/remotes" && ls -1 "$d/remotes" 2>/dev/null
>  	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
>  		i="${i#remote.}"
>  		echo "${i/.url*/}"
