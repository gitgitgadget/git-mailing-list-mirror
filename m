From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] checkout: reorder check_filename conditional
Date: Wed, 10 Feb 2016 13:31:53 -0800
Message-ID: <xmqq8u2sz1yu.fsf@gitster.mtv.corp.google.com>
References: <20160210211206.GA5755@sigill.intra.peff.net>
	<20160210211234.GA5799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:32:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTcMj-0002ae-0S
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbcBJVb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:31:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbcBJVb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:31:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 959CE43056;
	Wed, 10 Feb 2016 16:31:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MFkYelZG29tdjJzCYHQVN74/Ml4=; b=vtcl43
	BcDPHsXvbTgWOXCHOY6yADr1aVzviD0GORcjLtsargf8Mfikrs++Hn1n5lDZAG9S
	pWfFbMNQe1PrhjYL7HhiRB4w6BjbkhxYxVg5ouWoRL4YvvDE4LcfNp1FwWbGTw6o
	JTF01evHwGTv71aR7Y6i3fOkqe53gJYoR9xp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L4G/5a+btepJjTTZLjhwnlWe3z1IoyXC
	YQdwvUhrHywcdod9DwfuR8atoOo2bTMNjYIhNCdJzaXbooXIm0xFOjAbQtBjNIOe
	itK4wqxpzc08+Pk/Hg/ef+MVvK/MK8XAnvzzs686l0XKsjoEa5CHK8ZYk9G0FM2g
	uWFoxf8pzgI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D8DE43055;
	Wed, 10 Feb 2016 16:31:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1102143054;
	Wed, 10 Feb 2016 16:31:54 -0500 (EST)
In-Reply-To: <20160210211234.GA5799@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Feb 2016 16:12:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B4E01218-D03D-11E5-A815-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285933>

Jeff King <peff@peff.net> writes:

> If we have a "--" flag, we should not be doing DWIM magic
> based on whether arguments can be filenames. Reorder the
> conditional to avoid the check_filename() call entirely in
> this case. The outcome is the same, but the short-circuit
> makes the dependency more clear.

It also allows check_filename() to die(), and lets the user to
prevent it with "--"---"Don't check when we do not have to" is the
right thing to do.

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5af84a3..f6a2809 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -982,7 +982,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>  		 */
>  		int recover_with_dwim = dwim_new_local_branch_ok;
>  
> -		if (check_filename(NULL, arg) && !has_dash_dash)
> +		if (!has_dash_dash && check_filename(NULL, arg))
>  			recover_with_dwim = 0;
>  		/*
>  		 * Accept "git checkout foo" and "git checkout foo --"
