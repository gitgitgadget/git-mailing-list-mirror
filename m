From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt: preserve command exit status
Date: Mon, 22 Dec 2014 09:19:40 -0800
Message-ID: <xmqqa92fbo0j.fsf@gitster.dls.corp.google.com>
References: <alpine.LSU.2.00.1412221429490.28934@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y36e4-000567-C5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089AbaLVRTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:19:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754868AbaLVRTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:19:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3776027DFD;
	Mon, 22 Dec 2014 12:19:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Dys4UrPVw6jl+e0PB7mvBBMfJk=; b=C6/U1L
	reWjlNpejmjlGifbRu9OxTc7dpwsZ3R/DtFtCUisWw1iVBg9yNb6H5IdKOa2esuL
	2QyJ1BqkTTx9A0teTwHuITozMYig0vnOHSHhJuwte4v0R+ZgkSLqZXqhtuqQ9h3n
	tI4y5K53QP0S0alvRWjMwJKzcUObangzhkdRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hctG7xm44b30PWedbFQdb+Q+rUrHgeu6
	mWhDsiJuTDB3nUGkx24k3GiYbjWHJuocICKkD1uTJo31PNGyZQE3tcZpj8rKObIb
	am05P6YF//usx+qbIommrcg5C38NZuv2KFKD1Pz8TMCOPFnnaOAwqmuwVB3ux34l
	1y9Uv38CB0I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E2F327DFC;
	Mon, 22 Dec 2014 12:19:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7B4E27DFB;
	Mon, 22 Dec 2014 12:19:41 -0500 (EST)
In-Reply-To: <alpine.LSU.2.00.1412221429490.28934@hermes-1.csi.cam.ac.uk>
	(Tony Finch's message of "Mon, 22 Dec 2014 14:30:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B73F33BC-89FE-11E4-B68D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261653>

Tony Finch <dot@dotat.at> writes:

> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>  contrib/completion/git-prompt.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c5473dc..5fe69d0 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -288,6 +288,7 @@ __git_eread ()
>  # In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
>  __git_ps1 ()
>  {
> +	local exit=$?
>  	local pcmode=no
>  	local detached=no
>  	local ps1pc_start='\u@\h:\w '
> @@ -511,4 +512,7 @@ __git_ps1 ()
>  	else
>  		printf -- "$printf_format" "$gitstring"
>  	fi
> +
> +	# preserve exit status
> +	return $exit
>  }

Hmmmm.  I thought "The patch trivially makes sense!  Why didn't
anybody notice this before?!?", but then noticed that I never
suffered from an obvious consequence from the current lack of the
exit-code-preserving:

    : gitster git.git/master; echo "<$PS1>"
    <: \h \W$(__git_ps1 "/%s"); >
    : gitster git.git/master; false
    : gitster git.git/master; echo $?
    1

And it does not seem that it is needed, at least for my use
pattern:

    : gitster git.git/master; ps1func () { echo "What Now: "; exit 8; }
    : gitster git.git/master; PS1='$(ps1func)'
    What Now: echo $?
    0
    What Now: (exit 6)
    What Now: echo $?
    6

Also it does not seem that it is needed for the other style to use
PROMPT_COMMAND:

    : gitster git.git/master; sh
    $ . contrib/completion/git-prompt.sh
    $ PROMPT_COMMAND='__git_ps1 "\h \W" "; "'
    gitster git.git (master); (exit 13)
    gitster git.git (master); echo $?
    13
    gitster git.git (master); true
    gitster git.git (master); echo $?
    0

So, what are you fixing?  In other words, please describe how it
fails in the log message.

Puzzled...
