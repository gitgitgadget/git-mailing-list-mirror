From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-prompt: preserve value of $? inside shell prompt
Date: Mon, 22 Dec 2014 11:58:41 -0800
Message-ID: <xmqqsig78nim.fsf@gitster.dls.corp.google.com>
References: <xmqqa92fbo0j.fsf@gitster.dls.corp.google.com>
	<alpine.LSU.2.00.1412221808110.2546@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Mon Dec 22 20:58:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y397x-00067p-JL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 20:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbaLVT6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 14:58:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754702AbaLVT6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 14:58:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C59F28487;
	Mon, 22 Dec 2014 14:58:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bd4hN7INoPKzP0DqlGlTty9HY/o=; b=YzEQs/
	/faGOdofsBa5wmqz8CAr/Ohq/RqVTkmmv7V3HirtA1q5v2ynGhOrFnzc0RJ1Zgjo
	IH8nrHgLHOnbyCfi9NLGqnQRrLrP5E2PigHKA8MJTvw74SCuWtjnISNEYjvcQbtZ
	1HVy38enwhOcqu7lFHXoHQpa23dSTinAlTP60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aZKhho/DDJILamPSbYKNTYIiyfU2s0Wx
	YNYj0TylVx0SD64yt5HOBXZeJcOCkp36JzZJuyf1exaZ9FitxHEXd+NH1cypqwhT
	FMmDRQSF5rFIBzJgjFZx7YiDOW03MZ+XkMt33kWrt3ARmXUsmBkZsu2dbdSwocIx
	TYIjmYDQHig=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 229CF28486;
	Mon, 22 Dec 2014 14:58:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9596928484;
	Mon, 22 Dec 2014 14:58:42 -0500 (EST)
In-Reply-To: <alpine.LSU.2.00.1412221808110.2546@hermes-1.csi.cam.ac.uk> (Tony
	Finch's message of "Mon, 22 Dec 2014 18:09:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE144696-8A14-11E4-83D4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261669>

Tony Finch <dot@dotat.at> writes:

> If you have a prompt which displays the command exit status,
> __git_ps1 without this change corrupts it, although it has
> the correct value in the parent shell:
>
> 	~/src/git (master) 0 $ set | grep ^PS1
> 	PS1='\w$(__git_ps1) $? \$ '
> 	~/src/git (master) 0 $ false
> 	~/src/git (master) 0 $ echo $?
> 	1
> 	~/src/git (master) 0 $
>
> There is a slightly ugly workaround:
>
> 	~/src/git (master) 0 $ set | grep ^PS1
> 	PS1='\w$(x=$?; __git_ps1; exit $x) $? \$ '
> 	~/src/git (master) 0 $ false
> 	~/src/git (master) 1 $
>
> This change makes the workaround unnecessary.
>
> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>  contrib/completion/git-prompt.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> I hope that explains it properly :-)

Yes.  I wouldn't have spent 20 minutes experimenting with various
hypothetical use cases if the above were there in the first place.

Thanks.  Will queue.

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
