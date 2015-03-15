From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/completion: escape the forward slash in __git_match_ctag
Date: Sat, 14 Mar 2015 18:58:26 -0700
Message-ID: <xmqq7fujvx6l.fsf@gitster.dls.corp.google.com>
References: <1426340439-7171-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Sun Mar 15 02:59:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWxqP-0006vF-Vx
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 02:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbbCOB63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 21:58:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751249AbbCOB63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 21:58:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AF82410BC;
	Sat, 14 Mar 2015 21:58:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vvHlg0U+m2+A3x0I6XGuBbgrrNo=; b=SWha14
	usjTc4pCvjGhWk4By9l9373c8qn4i+L1j19zbczvolP3DKTp/iJdzzKeWDo0W2tx
	sG1146kW/KSN86IaM7Dllwz2yBPtWzmy67SRqeuooteiGKwyCaj5YL04DgxqO2Vz
	1cFhJv7WFnY7fd3sCKp77UAAMZQwh2zmp/JSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SbHer024DtMWeVyYK8avuJ0k9aKwYNeP
	TdoEHW2kLw8V+I4FDQRzv1AXm7jygS6zzHVUXZ83m4Pp03AM5oig2ChhGbJn8Ry1
	gi9C17SUdoVOJUbG8DMwRSRqUUcvM+pL1VtWl5XrKLbX0WIKdXxzq0IycZXD5BYI
	q+9ORaawT/M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52C88410BB;
	Sat, 14 Mar 2015 21:58:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8DC3410BA;
	Sat, 14 Mar 2015 21:58:27 -0400 (EDT)
In-Reply-To: <1426340439-7171-1-git-send-email-john@szakmeister.net> (John
	Szakmeister's message of "Sat, 14 Mar 2015 09:40:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5BDDD28-CAB6-11E4-A78D-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265476>

John Szakmeister <john@szakmeister.net> writes:

> The current definition results in an incorrect expansion of the term under zsh.
> For instance "/^${1////\\/}/" under zsh with the argument "hi" results in:
>     /^/\/h/\/i/
>
> This results in an output similar to this when trying to complete `git grep
> chartab` under zsh:
>
>     :: git grep chartabawk: cmd. line:1: /^/\/c/\/h/\/a/\/r/\/t/\/a/\/b/ { print $1 }
>     awk: cmd. line:1:    ^ backslash not last character on line
>     awk: cmd. line:1: /^/\/c/\/h/\/a/\/r/\/t/\/a/\/b/ { print $1 }
>     awk: cmd. line:1:    ^ syntax error
>
> Leaving the prompt in a goofy state until the user hits a key.
>
> Escaping the literal / in the parameter expansion (using "/^${1//\//\\/}/")
> results in:
>     /^chartab/
>
> allowing the completion to work correctly.
>
> This formulation also works under bash.
>
> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
>
> I've been bit by this bug quite a bit, but didn't have time to track it down
> until today.  I hope the proposed solution is acceptable.
>
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c21190d..a899234 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1305,7 +1305,7 @@ _git_gitk ()
>  }
>  
>  __git_match_ctag() {
> -	awk "/^${1////\\/}/ { print \$1 }" "$2"
> +	awk "/^${1//\//\\/}/ { print \$1 }" "$2"

The updated pattern look sensible to me. / to start the pattern
part, extra / to say "repeatedly replace all", \/ to say "a single
slash is what is to be replaced, / to say "here is where the pattern
ends", and then \\/ to say "replace with backslash-slash".

In fact, I have to suspect that the original working by pure
accident or a bug.

Thanks.

>  }
>  
>  _git_grep ()
