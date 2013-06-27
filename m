From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] rebase should desambiguate abbreviated hashes before starting
Date: Thu, 27 Jun 2013 10:16:06 -0700
Message-ID: <7vhagjtqy1.fsf@alter.siamese.dyndns.org>
References: <20130627105513.6bf84060@chalon.bertin.fr>
	<CAMPXz=pSseQKebNVPVYogTZ2FUc1LqubgmS+pN76sveV=eqC0A@mail.gmail.com>
	<vpq1u7n3jdh.fsf@anie.imag.fr>
	<7vppv7trls.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David <bouncingcats@gmail.com>, Yann Dirson <dirson@bertin.fr>,
	git list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 19:16:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsFnr-0002jH-6b
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab3F0RQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 13:16:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab3F0RQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 13:16:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C11F29DDC;
	Thu, 27 Jun 2013 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q64LRRwJnlb+VCqIS4W/MEJ8Tj0=; b=Q0u9ph
	ybD/gg4HUmj8MJ+QF03p0gP9SAdFd4/wm0n47RWeDluCE8mtNiuf4xeZo3Qv7wVY
	z5FsAYHcWHqmmFJow4BYyx0GETGA/AlrqMkWQc5C9mzfJ15mm6oNTRinj54V9TyC
	a9VUF/Da0bdomwCJebur2gsA/sbtXghBRNXRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MWQl6mrzHA5Wn4Ju5cG8Kzwj1Sb71QUp
	ocK1uFsT/RgO1asZ1JqPlolgh3icyPNxm3BgwKeOV1bLxONEUozwtRRqDkEZbst5
	m3R/1LPGt/y6PdhLtj4UzUuKSsr78POls4LNvXmr60x5vFQ6ZkwiOHJHx0LT0tqx
	pWxLQzt8hbM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FB1429DDA;
	Thu, 27 Jun 2013 17:16:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1848E29DD9;
	Thu, 27 Jun 2013 17:16:08 +0000 (UTC)
In-Reply-To: <7vppv7trls.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 27 Jun 2013 10:01:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41A1396E-DF4D-11E2-B7D9-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229121>

Junio C Hamano <gitster@pobox.com> writes:

> It could be something as simple like this (not tested).
>
>  git-rebase--interactive.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f953d8d..6766b44 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -678,6 +678,23 @@ skip_unnecessary_picks () {
>  	die "Could not skip unnecessary pick commands"
>  }
>  
> +# expand shortened commit object name to the full form
> +expand_todo_commit_names () {
> +	while read -r command rest
> +	do
> +		case "$command" in
> +		'#'*)
> +			;;
> +		*)
> +			sha1=$(git rev-parse --verify --quiet ${rest%% *})
> +			rest="$sha1 ${rest#* }"
> +			;;

In case somebody wants to polish it to a real patch, this part
should at least be:

		case "$command" in
		'#'* | exec)
			# Be careful for oddball commands like 'exec'
			# that do not have a short-SHA-1 at the beginning
			# of $rest.
			;;
		*)
			sha1=$(git rev-parse --verify --quiet ${rest%% *}) &&
			rest="$sha1 ${rest#* }"
			;;
