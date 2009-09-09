From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] push: make non-fast-forward help message
 configurable
Date: Wed, 09 Sep 2009 12:06:21 -0700
Message-ID: <7vr5ugszte.fsf@alter.siamese.dyndns.org>
References: <20090909112623.GA30765@coredump.intra.peff.net>
 <20090909113858.GA31051@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 09 21:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlSVA-0006SP-5U
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 21:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbZIITGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 15:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbZIITGe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 15:06:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbZIITGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 15:06:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EA41486E7;
	Wed,  9 Sep 2009 15:06:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yMUcyfZ6M75nuxdftg1tTAwIMMc=; b=bFugaI
	xBSX/89CJwCg+uwmU4Alc9haYD48zKxaMqImrj8PVeeX9truPI7TYRjUdCg5OmsC
	wWrQ9XuhrG+L3hUgrG6SZgNrdEMR8Ig+1Yg8ubnnqWvt+8H+lr7SEMwuE/6uezKt
	CdZXbALLzMYBrNq95Noqjr1EKhwxrSOi64cSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Elq9LqBHkDZu6iwP21SU1ruo4+Wfs6ZJ
	cZg3iRsNBuc26uuOIlCqF3ZntdRG8tTkxC6go4lDu7eC9ewcUH1r/BCUKdBaiHZX
	gLTd85yJp5Vfj6pTJsat+aq1rbAiqd2vPnYUGcfCjBMYweZx9X3PSunUPGqQneln
	P/JUdANhjH4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9420486E5;
	Wed,  9 Sep 2009 15:06:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C1E87486DF; Wed,  9 Sep 2009
 15:06:22 -0400 (EDT)
In-Reply-To: <20090909113858.GA31051@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 9 Sep 2009 07\:38\:58 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E18A5B92-9D73-11DE-84CD-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128076>

Jeff King <peff@peff.net> writes:

> diff --git a/advice.c b/advice.c
> new file mode 100644
> index 0000000..b5216a2
> --- /dev/null
> +++ b/advice.c
> @@ -0,0 +1,25 @@
> +#include "cache.h"
> +
> +int advice_push_nonfastforward = 1;
> +
> +static struct {
> +	const char *name;
> +	int *preference;
> +} advice_config[] = {
> +	{ "pushnonfastforward", &advice_push_nonfastforward },
> +};

Can we have the value inside this struct, instead of having a pointer
to another variable, and get rid of that variable altogether?

> diff --git a/builtin-push.c b/builtin-push.c
> index 787011f..6eda372 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -157,7 +157,7 @@ static int do_push(const char *repo, int flags)
>  			continue;
>  
>  		error("failed to push some refs to '%s'", url[i]);
> -		if (nonfastforward) {
> +		if (nonfastforward && advice_push_nonfastforward) {

If we did so, this part needs to become

	if (nonfastforward && check_advice("pushnonfastforward")) {

which would be less efficient, but by definition advices are on the slow
path, right?

And check_advice() implementation can find programming errors by barfing
when the given string token does not exist in the table.
