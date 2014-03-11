From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Tue, 11 Mar 2014 14:45:59 -0700
Message-ID: <xmqqfvmoo1d4.fsf@gitster.dls.corp.google.com>
References: <20140308183501.GH18371@serenity.lan>
	<1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNUV6-0005Uj-Lv
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbaCKVqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:46:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755642AbaCKVqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 17:46:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D47871BF1;
	Tue, 11 Mar 2014 17:46:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3KW3PviIv+9d2sN4+Hb4UUf9YQg=; b=QxPuk6
	h+syrXDJ9Vv5B0n56UkSFIjiYgz/n2eka1+GSfv8v6Tl6CGCcwSQ95jYT9lbQxgq
	A0PCd4AA+Hwbou/gAZQ4PcTmXRugY8xR+QKEovOVe2zBrPBV7vEpSfivHDZCqFIh
	r0NVAvLy5zpzlqvAz4QnYrWC8woQMGdjOJksk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iqOiQgOP2Rab17HbcoSlS0W9ANnWCk1Y
	SrBJEA8EeHMjP3tP+tuZmkwIMth8vMMmpQbeQFXCrJsfBuOPWDjS5ofj4omosz4P
	/hNQ72heUcXad8wJNA4ahbDAR0AVHpt6r2qK1Ovhi8rDqVUu4xFAC1Ky+IohTe93
	Y8mq261Bvgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B1271BF0;
	Tue, 11 Mar 2014 17:46:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E63871BED;
	Tue, 11 Mar 2014 17:46:06 -0400 (EDT)
In-Reply-To: <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sat, 8 Mar 2014 19:21:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8CD8A8D4-A966-11E3-9507-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243903>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We shrink the source and destination arrays, but not the modes or
> submodule_gitfile arrays, resulting in potentially mismatched data.  Shrink
> all the arrays at the same time to prevent this.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/mv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index f99c91e..b20cd95 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -230,6 +230,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  					memmove(destination + i,
>  						destination + i + 1,
>  						(argc - i) * sizeof(char *));
> +					memmove(modes + i, modes + i + 1,
> +						(argc - i) * sizeof(char *));
> +					memmove(submodule_gitfile + i,
> +						submodule_gitfile + i + 1,
> +						(argc - i) * sizeof(char *));
>  					i--;
>  				}
>  			} else

Thanks.  Neither this nor John's seems to describe the user-visible
way to trigger the symptom.  Can we have tests for them?
