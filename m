From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: ignore chpwd_functions when cding
Date: Wed, 08 Oct 2014 11:12:41 -0700
Message-ID: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com>
References: <1412740394-34061-1-git-send-email-bt@brandonturner.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Brandon Turner <bt@brandonturner.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 20:12:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbvjF-0000HC-0R
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 20:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbaJHSMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 14:12:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55368 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753800AbaJHSMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 14:12:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF8E312EF4;
	Wed,  8 Oct 2014 14:12:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QArPSmrYgLn2BKkyVTeTVg2xfJU=; b=kzJJla
	sQKxP05dz9oAtcbCwEmBIkz5vAoduCKRvaBmeUfZkCTNla9S55mKBlulUJiDazup
	x5m47g1q0yQqZQj9FHEaP6XC+1ENp3ZUQxGwJh80nDpfSMBTH06O37y/et9/XSKp
	DSBiCDcJkayldsplt2flX8VOL1V1kQddnRyOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U2Afk7fogpaqE1LLOxxg8Zqfu6WkJbLJ
	i3BIPnAjA/B/4QLoi5eVPVVWbsTFH/Nt78ZIZjs+0haO50AB9Jko1pYgGgM6qJng
	2hal/DZvugnDSVEgZUI21rLusHRNQa1jrDQZFqD+ZXbbU7NvpTJoa0H6Y2omPPi/
	OGbwiOmWAJI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6F7412EF3;
	Wed,  8 Oct 2014 14:12:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09BB312EEE;
	Wed,  8 Oct 2014 14:12:42 -0400 (EDT)
In-Reply-To: <1412740394-34061-1-git-send-email-bt@brandonturner.net> (Brandon
	Turner's message of "Tue, 7 Oct 2014 22:53:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B27F5C12-4F16-11E4-9886-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Turner <bt@brandonturner.net> writes:

> Software, such as RVM (ruby version manager), may set chpwd functions
> that result in an endless loop when cding.  chpwd functions should be
> ignored.
>
> Signed-off-by: Brandon Turner <bt@brandonturner.net>
> ---

Can you mention that this is abomination limited only to zsh
somewhere in the log message?  Or does bash share the same glitch?

If this is limited to zsh, I wonder if we can take advantage of the
fact that we have git-completion.bash and git-completion.zsh to
avoid contaminating shared part of the code.

Thanks.

> For an example of this bug, see:
> https://github.com/wayneeseguin/rvm/issues/3076
>
>  contrib/completion/git-completion.bash | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 06bf262..996de31 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -283,7 +283,8 @@ __git_ls_files_helper ()
>  {
>  	(
>  		test -n "${CDPATH+set}" && unset CDPATH
> -		cd "$1"
> +		(( ${#chpwd_functions} )) && chpwd_functions=()
> +		builtin cd "$1"
>  		if [ "$2" == "--committable" ]; then
>  			git diff-index --name-only --relative HEAD
>  		else
