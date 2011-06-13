From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Add new function die_with_status
Date: Mon, 13 Jun 2011 11:07:03 -0700
Message-ID: <7vd3ihobaw.fsf@alter.siamese.dyndns.org>
References: <1307605623-2831-1-git-send-email-iveqy@iveqy.com>
 <1307605623-2831-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hvoigt@hvoigt.net, jens.lehmann@web.de, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 20:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWBXn-00078R-6H
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 20:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab1FMSHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 14:07:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab1FMSHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 14:07:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53F305321;
	Mon, 13 Jun 2011 14:09:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=asyFSi1UHur252+H6ASqjDrpyIg=; b=oVslHQ
	CAfpfC4i54xKVm4/ySXY0/Y5la74yyZ2xOT2odIsFgdmobIH0G8IChryt2SNle/B
	9f7EKyg76+38ElhXbZqmznSHDFuzGre+gQqpNvtcSTn3v1PaIhfq9Edlh+C5BExy
	JIJkTWuRQvC+y2KZqXWBPDvhWGUz0Nd3qmEW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=agwUNCinfBksmWg8JyLoebUlG//I2MxG
	auo22lqPvZ06fvrbWdrD60Z8NNhcBpq1F/O5dvpDTcPA8LTnDex9oE+BnP7W2HwZ
	Tj5RBII9ahJYBEACJArkWaEkzDNS2D74+b3OLpyEmT58rbOrj0NFiJLEETZDItIQ
	KtE8wGGzFE8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0973E531E;
	Mon, 13 Jun 2011 14:09:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5756B5313; Mon, 13 Jun 2011
 14:09:15 -0400 (EDT)
In-Reply-To: <1307605623-2831-2-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Thu, 9 Jun 2011 09:47:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42F1CDF2-95E8-11E0-833B-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175725>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> die no longer prints empty die messages, this is a changed behavior.

That is what we we usually call a regression, but I think the original is
not correct to begin with.  It should have used "$*" not "$@".

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 94e26ed..1a91f6e 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -40,8 +40,16 @@ git_broken_path_fix () {
>  # @@BROKEN_PATH_FIX@@
>  
>  die() {
> -	echo >&2 "$@"
> -	exit 1
> +	die_with_status 1 $@

Make it a habit to always quote "$@" when relaying what was given to you,
so that when somebody sends a parameter with IFS in it, you won't split it
while passing it down. I.e.

	die () {
        	die_with_status 1 "$@"
	}

> +}

Blank line here after the closing brace and the beginning of next function.

> +die_with_status() {
> +	stat=$1
> +	shift
> +	if test ${#@} -gt 0
> +	then
> +		echo >&2 "$@"
> +	fi

I think an unconditional

	echo >&2 "$*"

is good enough here.

> +	exit $stat
>  }
>  
>  GIT_QUIET=
