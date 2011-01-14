From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix git-parse-remote.sh for remotes that contain slashes
Date: Fri, 14 Jan 2011 11:55:20 -0800
Message-ID: <7vd3nzntuf.fsf@alter.siamese.dyndns.org>
References: <20110114090645.GA13060@pengutronix.de>
 <1295005000-11562-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 20:55:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdpkG-0000jc-NC
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 20:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032Ab1ANTza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 14:55:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab1ANTz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 14:55:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09AF33E51;
	Fri, 14 Jan 2011 14:56:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFxkYSDJzM+3uHpRgwwK5Xx5zPA=; b=i2GUW0
	qBCv9W8diTlReZUupG4vMVM/llyovOelGnWnc8Jdsem+N+AyEGgbXftGQvFeBW5k
	b4JVDbNSrn3ZZNvV+68cw/JFpM1NOD9I0Q9cO0GRgwjdmQyPOdRjqjm26MzNLJ1x
	01NsEb9UNlVQijCjqx6yDpGhawyimwCooZW2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H4s2y2dMYzyl9CyOik1ukku41vZLmm24
	96EBmpSyo52RLrtitCG24jgYinoJLKXqP9l5g6qLrCkAKfIolQxHoMf5WhZe6Q/o
	ObVhl4xoozKbanTGSNT4K2u1+oMfWyVJpu20+POEhIdL8Gs3IObrB4l+bWlNkkMy
	eFx3dIEIraE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8EF23E4F;
	Fri, 14 Jan 2011 14:56:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7C2873E49; Fri, 14 Jan 2011
 14:56:04 -0500 (EST)
In-Reply-To: <1295005000-11562-1-git-send-email-stefan.naewe@gmail.com>
 (Stefan Naewe's message of "Fri\, 14 Jan 2011 12\:36\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53C3B6CC-2018-11E0-B6D8-C83E909A2CA0-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165119>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---

Thanks, but no explanation?

Imagine somebody who weren't reading this thread (especially the article
you responded to with this patch) sees this in "git log" output stream.
For that matter, imagine yourself doing that in 2012 when the motivation
of this change you all forgot already.

Do you think it is obvious what the problem the patch tried to fix was?
I don't.  "fix" on the subject line gives you 0-bit information for that
purpose.

> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 5f47b18..7cf204e 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -7,8 +7,12 @@ GIT_DIR=$(git rev-parse -q --git-dir) || :;
>  get_data_source () {
>  	case "$1" in
>  	*/*)
> -		echo ''
> -		;;
> +		if test "$(git config --get "remote.$1.url")"
> +		then
> +			echo config
> +		else
> +			echo ''
> +		fi ;;

I suspect that making this case arm trigger not on */* but only on /* and
../* would be a lot more sensible solution.  Otherwise you would still
have the same issue in repositories that use remotes/ and branches/
mechanism.

 git-parse-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 1cc2ba6..8ec33e3 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -6,7 +6,7 @@ GIT_DIR=$(git rev-parse -q --git-dir) || :;
 
 get_data_source () {
 	case "$1" in
-	*/*)
+	../* | /*)
 		echo ''
 		;;
 	.)
