From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: catch mkdtemp errors
Date: Thu, 26 Jun 2014 13:42:04 -0700
Message-ID: <xmqq8uoj4d43.fsf@gitster.dls.corp.google.com>
References: <1403146394-9589-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 22:42:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0GUq-0000Wk-IE
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbaFZUmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 16:42:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58472 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbaFZUmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 16:42:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B12423E76;
	Thu, 26 Jun 2014 16:42:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dtCuv7l3+2B3e36XkyLyn1Xm2lw=; b=MqT6Oh
	/V5IUt9rjyBiNn48JFCl5Q8qfMU78p1OG7uL6KXTeqzKA3rwsXeeARDvSMSCJqCO
	a6GJI5n1soh/dHFZbOmHLqAqpONp93y8ZF3dtS0gM0IK/ZJfkkzBw/dYcegqYeVl
	slWY2Wq0U8fAul8INj7MufbdYk5xElZ7hdOiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J42TwEI5zSKHJ5ZlwppCrQ8EpcfYI4Gt
	Piqv6V8lrvEH5fNHReFpJkDzf/HzemV9UxCAL7ES7CnICQpFNzQ3U55GnNEp2lVl
	WWj6cTDI7xKkyjbqibyhtZu3jsDOJuEVEIFrnif7WQ1QfSAukucKbYDFq+ikoMDM
	ngjq6KBp4xc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EE1723E75;
	Thu, 26 Jun 2014 16:42:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DDE6723E71;
	Thu, 26 Jun 2014 16:41:59 -0400 (EDT)
In-Reply-To: <1403146394-9589-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 18 Jun 2014 19:53:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 523F6EFA-FD72-11E3-9892-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252523>

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

Does this still need to be applied before I can pull from Paulus?

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
