From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] submodule update --init: correct path handling in recursive submodules
Date: Mon, 28 Mar 2016 22:50:53 -0700
Message-ID: <xmqqwpolzvb6.fsf@gitster.mtv.corp.google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 07:51:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akmYP-000834-E1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 07:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbcC2Fu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 01:50:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751596AbcC2Fu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 01:50:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8105545691;
	Tue, 29 Mar 2016 01:50:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3eQj51cien/NNxGovuHPfEXDTOA=; b=Eof2NT
	1RSCbXdn1OQI1U/XWVYg7ch0bKLZquKB9zda2MzuARJ16jgpX1s+eUi2339XIxXu
	PumtDgsNxIEL4SBbvGk6VnY+P3y3rnG2NpgfJbDifxonflj74g4V0xPhsWNjgkZj
	8721HYJnsd3FZX3uevF2Te0P0t/5MhUcEQvUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aOECM48+4xp5i375j+xdtGiBgDEMapYl
	8XtWnS/aL0Ps06gSXthShKdi7g3z7o/vZFQTFreln+mzON+qLmmPA7XI+wZkri59
	xKgKtR0X2J/pde3JEfKjzhqKRt8X9zYirg9/GTf0IJiSoEqAAiqNfj48LC/NjEJ5
	3ACeAF0xCyw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7930145690;
	Tue, 29 Mar 2016 01:50:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F2AAE4568F;
	Tue, 29 Mar 2016 01:50:54 -0400 (EDT)
In-Reply-To: <1459207703-1635-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 28 Mar 2016 16:28:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33E0B0DC-F572-11E5-8CDF-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290103>

Stefan Beller <sbeller@google.com> writes:

> This fixes the test introduced by the parent commit.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>

Unlike 2/7, this is kinda on the thin side in the explanation
department, it looks.

> ---
>  git-submodule.sh            | 5 +++--
>  t/t7406-submodule-update.sh | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2838069..a7c8599 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -474,7 +474,7 @@ cmd_init()
>  		die_if_unmatched "$mode"
>  		name=$(git submodule--helper name "$sm_path") || exit
>  
> -		displaypath=$(relative_path "$sm_path")
> +		displaypath=$(relative_path "$prefix$sm_path")
>  
>  		# Copy url setting when it is not set yet
>  		if test -z "$(git config "submodule.$name.url")"
> @@ -826,8 +826,9 @@ Maybe you want to use 'update --init'?")"
>  		if test -n "$recursive"
>  		then
>  			(
> -				prefix="$prefix$sm_path/"
> +				prefix="$(relative_path $prefix$sm_path)/"

Same here as 2/7 (see the above hunk which does this correctly).

>  				clear_local_git_env
> +				wt_prefix=
>  				cd "$sm_path" &&
>  				eval cmd_update
>  			)
