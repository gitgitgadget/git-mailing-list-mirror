From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: catch mkdtemp errors
Date: Thu, 26 Jun 2014 13:47:36 -0700
Message-ID: <xmqq4mz74cuv.fsf@gitster.dls.corp.google.com>
References: <1403146394-9589-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 22:47:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0GaB-00047b-FY
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 22:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbaFZUro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 16:47:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55302 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbaFZUrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 16:47:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F94123F8A;
	Thu, 26 Jun 2014 16:47:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9pQh93QJ+QDW0bU9IMly5HoI2Zk=; b=b+T8tA
	pQruATQ+8dd6ud2WnJZX6JJR/T0mUva+rLGOmKxIaO1/R0p8E8EUB6ED4ffOlHmb
	tDiC0IupnDnw/vhvPDu6Kez8n8GKO2SGSq6FqXB8SPIUVIAPcRwtZBd6dxBems1f
	STtVNPQ9LhI2QF2Q26cEJ2ISSApjQ7NkOEcn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eZI/3cV2aKFcz1xfB7QlZs7L1Jy9/EBe
	lZ/SbTahFH5uZjyaHjucMmBrxZ2GsfNW1i6KE8pHibfzb52ZObAxds5QoXALUBx7
	p6lbRM68mKV1B2KT8WpCer9hglxWda8sDb1TRoOw7fv3eu7xRALyFxVtnTXYjkdA
	+EfCGHa01kQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0EDAA23F89;
	Thu, 26 Jun 2014 16:47:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 368BB23F87;
	Thu, 26 Jun 2014 16:47:31 -0400 (EDT)
In-Reply-To: <1403146394-9589-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 18 Jun 2014 19:53:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 17B9EE8A-FD73-11E3-A215-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252524>

David Aguilar <davvid@gmail.com> writes:

> 105b5d3fbb1c00bb0aeaf9d3e0fbe26a7b1993fc introduced a dependency
> on mkdtemp, which is not available on Windows.
>
> Use the original temporary directory behavior when mkdtemp fails.
> This makes the code use mkdtemp when available and gracefully
> fallback to the existing behavior when it is not available.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

In the meantime, I've fetched from you and merged up to your
master~2 aka 17f9836c (gitk: Show staged submodules regardless of
ignore config, 2014-04-08).

Thanks.

>  gitk | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/gitk b/gitk
> index 41e5071..9237830 100755
> --- a/gitk
> +++ b/gitk
> @@ -3504,7 +3504,9 @@ proc gitknewtmpdir {} {
>  	    set tmpdir $gitdir
>  	}
>  	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
> -	set gitktmpdir [exec mktemp -d $gitktmpformat]
> +	if {[catch {set gitktmpdir [exec mktemp -d $gitktmpformat]}]} {
> +	    set gitktmpdir [file join $gitdir [format ".gitk-tmp.%s" [pid]]]
> +	}
>  	if {[catch {file mkdir $gitktmpdir} err]} {
>  	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
>  	    unset gitktmpdir
